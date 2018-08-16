
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

| 参数类型                | 说明                                                              |
|:------------------------|:------------------------------------------------------------------|
| GOptionContext *context | gst_init_check 函数中创建出来的对象，有一些上下文                 |
| GOptionGroup * group    | gst_init_get_option_group 出来的，其实在 context 中存在的         |
| gpointer data           | 可以从 函数中看到 g_option_context_parse, 内容为 group->user_data |
| GError ** error         | 外带错误信息， init_pre 其实没有用到                              |





# `init_post`







