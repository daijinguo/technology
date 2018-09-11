
我们知道每个程序的开始都是 gst_init 的初始化整个进程的，这里我们来学习以下 gst_init

# gst_init

代码位置： gstreamer-1.14.2/gst/gst.h

```c
GST_API
void gst_init (int *argc, char **argv[]);
```

代码实现文件 gstreamer-1.14.2/gst/gst.c

```c
void
gst_init (int *argc, char **argv[])
{
  GError *err = NULL;

  if (!gst_init_check (argc, argv, &err)) {
    g_print ("Could not initialize GStreamer: %s\n",
        err ? err->message : "unknown error occurred");
    if (err) {
      g_error_free (err);
    }
    exit (1);
  }
}
```


# gst_init_check

读取该部分的代码存在干扰的部分就是宏 `GST_DISABLE_OPTION_PARSING`， 在整个编译过程中 `GST_DISABLE_OPTION_PARSING` 只存在与编译期间的产生的 ``config.h`` 文件中。 
```c
/* Define if option parsing is disabled */
/* #undef GST_DISABLE_OPTION_PARSING */
```

理论年上这就是没有定义 `GST_DISABLE_OPTION_PARSING`. 如何验证呢？修改代码进行编译：
```c
void
gst_init (int *argc, char **argv[])
{
  GError *err = NULL;

#ifndef GST_DISABLE_OPTION_PARSING
  // ##1 added by daijinguo 
  g_print("daijinguo- 'GST_DISABLE_OPTION_PARSING' not define");
#else
  // ## 2 added by daijinguo
  g_print("daijinguo- 'GST_DISABLE_OPTION_PARSING' define")
#endif

  if (!gst_init_check (argc, argv, &err)) {
    g_print ("Could not initialize GStreamer: %s\n",
        err ? err->message : "unknown error occurred");
    if (err) {
      g_error_free (err);
    }
    exit (1);
  }
}
```
在添加的代码中 ##2 中并出现编译报错，所以整个过程中 `GST_DISABLE_OPTION_PARSING` 并没有被定义，所以继续分析 `gst_init_check`, 需要初始化两个结构体:
+ `typedef struct _GOptionGroup   GOptionGroup;`
    ```c
    struct _GOptionGroup
    {
      gchar           *name;
      gchar           *description;
      gchar           *help_description;
    
      gint             ref_count;
    
      GDestroyNotify   destroy_notify;
      gpointer         user_data;
    
      GTranslateFunc   translate_func;
      GDestroyNotify   translate_notify;
      gpointer         translate_data;
    
      GOptionEntry    *entries;
      gint             n_entries;
    
      GOptionParseFunc pre_parse_func;
      GOptionParseFunc post_parse_func;
      GOptionErrorFunc error_func;
    };
    ```
    需要关注两个函数成员 `pre_parse_func`， `post_parse_func`

+ `typedef struct _GOptionContext GOptionContext;`
    ```c
    struct _GOptionContext
    {
      GList           *groups;
    
      gchar           *parameter_string;
      gchar           *summary;
      gchar           *description;
    
      GTranslateFunc   translate_func;
      GDestroyNotify   translate_notify;
      gpointer         translate_data;
    
      guint            help_enabled   : 1;
      guint            ignore_unknown : 1;
      guint            strv_mode      : 1;
      guint            strict_posix   : 1;
    
      GOptionGroup    *main_group;
    
      /* We keep a list of change so we can revert them */
      GList           *changes;
    
      /* We also keep track of all argv elements
       * that should be NULLed or modified.
       */
      GList           *pending_nulls;
    };
    ```

&emsp;&emsp;创建一个 GOptionContext 对象实例 ctx，设置  
ignore_unknown = TRUE  
help_enabled = FALSE  

函数 `gst_init_get_option_group` 主要是创建一个 `GOptionGroup * group` 对象，我们关注：  
pre_parse_func  = `init_pre`  
post_parse_func = `init_post`  


## g_option_context_parse
代码实现位置 glib-2.56.1/goption.c 中, 函数阅读起来很费解(本来的很简单的只有一个内容对象，却转化为数组的形式)， 主要是调用两个函数：  
``` static gboolean init_pre  (GOptionContext * context, GOptionGroup * group, gpointer data, GError ** error)```  
``` static gboolean init_post (GOptionContext * context, GOptionGroup * group, gpointer data, GError ** error) ```

按照先后顺序来进行的，那么下面我们就来具体分析一下。



# `init_pre`

函数的签名：  
`gboolean init_pre  (GOptionContext * context, GOptionGroup * group, gpointer data, GError ** error)`  
我们先来看看传递进去的参数：  

| 参数类型                | 说明                                                               |
|:------------------------|:------------------------------------------------------------------|
| GOptionContext *context | gst_init_check 函数中创建出来的对象，有一些上下文                    |
| GOptionGroup * group    | gst_init_get_option_group 出来的，其实在 context 中存在的           |
| gpointer data           | 可以从 函数中看到 g_option_context_parse, 内容为 group->user_data   |
| GError ** error         | 外带错误信息， init_pre 其实没有用到                                |

我们只讨论 linux(android 也是 linux 的一部分)

## ``find_executable_path``

该函数的实现逻辑代码位于 `glib-2.56.1/glib/gfileutils.c` 下 
主要是用到了linux 的 `readlink` 函数， 大致思想是找到对应的自己执行程序的路径。
将本成路径保存到全局变量 `_gst_executable_path` 中


继续我们的 init_pre：  

通过读取环境变量 `GST_REGISTRY_DISABLE` 如果是 `yes` 则设置全局变量 `_priv_gst_disable_registry` 为 1


# `init_post`

这个是 gst_init 最关键的部分，内容涉及比较多，可以通过阅读代码进行分析，我这里并不进行日志的相关说明。  


## `_priv_gst_mini_object_initialize()`

在 gstreamer-1.14.2/gst/gstminiobject.c 创建了一个 `weak_ref_quark` ：  
名称: `GstMiniObjectWeakRefQuark`
结构: `static GQuark weak_ref_quark;`

 :triangular_flag_on_post: 注意后面的作用是什么

点击 [GQuark](GQuark.md) 了解 `GQuark` 内容。


## `_priv_gst_quarks_initialize`

在 gstreamer-1.14.2/gst/gstquark.c 创建了一个 `GQuark` 数组 `_priv_gst_quark_table`, 大小为 `GST_QUARK_MAX = 189`  
数组各个键值内容如下:  
```c
/* These strings must match order and number declared in the GstQuarkId
 * enum in gstquark.h! */
static const gchar *_quark_strings[] = {
  "format", "current", "duration", "rate",
  "seekable", "segment-start", "segment-end",
  "src_format", "src_value", "dest_format", "dest_value",
  "start_format", "start_value", "stop_format", "stop_value",
  "gerror", "debug", "buffer-percent", "buffering-mode",
  "avg-in-rate", "avg-out-rate", "buffering-left",
  "estimated-total", "old-state", "new-state", "pending-state",
  "clock", "ready", "position", "reset-time", "live", "min-latency",
  "max-latency", "busy", "type", "owner", "update", "applied-rate",
  "start", "stop", "minsize", "maxsize", "async", "proportion",
  "diff", "timestamp", "flags", "cur-type", "cur", "stop-type",
  "latency", "uri", "object", "taglist", "GstEventSegment",
  "GstEventBufferSize", "GstEventQOS", "GstEventSeek", "GstEventLatency",
  "GstMessageError", "GstMessageWarning", "GstMessageInfo",
  "GstMessageBuffering", "GstMessageStateChanged", "GstMessageClockProvide",
  "GstMessageClockLost", "GstMessageNewClock", "GstMessageStructureChange",
  "GstMessageSegmentStart", "GstMessageSegmentDone",
  "GstMessageDurationChanged",
  "GstMessageAsyncDone", "GstMessageRequestState", "GstMessageStreamStatus",
  "GstQueryPosition", "GstQueryDuration", "GstQueryLatency", "GstQueryConvert",
  "GstQuerySegment", "GstQuerySeeking", "GstQueryFormats", "GstQueryBuffering",
  "GstQueryURI", "GstEventStep", "GstMessageStepDone", "amount", "flush",
  "intermediate", "GstMessageStepStart", "active", "eos", "sink-message",
  "message", "GstMessageQOS", "running-time", "stream-time", "jitter",
  "quality", "processed", "dropped", "buffering-ranges", "GstMessageProgress",
  "code", "text", "percent", "timeout", "GstBufferPoolConfig", "caps", "size",
  "min-buffers", "max-buffers", "prefix", "padding", "align", "time",
  "GstQueryAllocation", "need-pool", "meta", "pool", "GstEventCaps",
  "GstEventReconfigure", "segment", "GstQueryScheduling", "pull-mode",
  "allocator", "GstEventFlushStop", "options", "GstQueryAcceptCaps",
  "result", "GstQueryCaps", "filter", "modes", "GstEventStreamConfig",
  "setup-data", "stream-headers", "GstEventGap", "GstQueryDrain", "params",
  "GstEventTocSelect", "uid", "GstQueryToc", GST_ELEMENT_METADATA_LONGNAME,
  GST_ELEMENT_METADATA_KLASS, GST_ELEMENT_METADATA_DESCRIPTION,
  GST_ELEMENT_METADATA_AUTHOR, "toc", "toc-entry", "updated", "extend-uid",
  "uid", "tags", "sub-entries", "info", "GstMessageTag", "GstEventTag",
  "GstMessageResetTime",
  "GstMessageToc", "GstEventTocGlobal", "GstEventTocCurrent",
  "GstEventSegmentDone",
  "GstEventStreamStart", "stream-id", "GstQueryContext",
  "GstMessageNeedContext", "GstMessageHaveContext", "context", "context-type",
  "GstMessageStreamStart", "group-id", "uri-redirection",
  "GstMessageDeviceAdded", "GstMessageDeviceRemoved", "device",
  "uri-redirection-permanent", "GstMessagePropertyNotify", "property-name",
  "property-value", "streams", "GstEventSelectStreams",
  "GstMessageStreamCollection", "collection", "stream", "stream-collection",
  "GstMessageStreamsSelected", "GstMessageRedirect", "redirect-entry-locations",
  "redirect-entry-taglists", "redirect-entry-structures",
  "GstEventStreamGroupDone"
};
```

## `_priv_gst_allocator_initialize()`

在 gstream-1.14.2/gst/gstallocator.c 文件下创建了一个  
~~static GHashTable *~~ `allocators`  
~~static GstAllocator *~~ `_default_allocator`  
~~static GstAllocator *~~ `_sysmem_allocator`  


## `_priv_gst_memory_initialize()`

代码实现在 gstream-1.14.2/gst/gstmemory.c 中实现了：
```c
    [......]
GType _gst_memory_type = 0;

    [......]
void
_priv_gst_memory_initialize (void)
{
  _gst_memory_type = gst_memory_get_type ();
}
```

### `gst_memory_get_type()`

有必要说明一下 gst_memory_get_type:  
其实就是 GST_DEFINE_MINI_OBJECT_TYPE (GstMemory, gst_memory);

这个涉及到 glib 中内容，可以见 [GST_DEFINE_MINI_OBJECT_TYPE](GST_DEFINE_MINI_OBJECT_TYPE.md)









