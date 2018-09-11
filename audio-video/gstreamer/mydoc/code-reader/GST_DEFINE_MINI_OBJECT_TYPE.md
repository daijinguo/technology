
很多地方会用到 GST_DEFINE_MINI_OBJECT_TYPE，有必要进行说明一下:  
以 gstream-1.14.2/gst/gstmemory.c 中的 `GST_DEFINE_MINI_OBJECT_TYPE` 为例说明。

+ 01: `GST_DEFINE_MINI_OBJECT_TYPE (GstMemory, gst_memory);`
```c
#define GST_DEFINE_MINI_OBJECT_TYPE(TypeName,type_name) \
   G_DEFINE_BOXED_TYPE(TypeName,type_name,              \
       (GBoxedCopyFunc) gst_mini_object_ref,            \
       (GBoxedFreeFunc) gst_mini_object_unref)
```

替换后:
```c
#G_DEFINE_BOXED_TYPE(GstMemory, gst_memory, (GBoxedCopyFunc) gst_mini_object_ref, (GBoxedFreeFunc) gst_mini_object_unref))
```

+ 02: `G_DEFINE_BOXED_TYPE`
```c
#define G_DEFINE_BOXED_TYPE(TypeName, type_name, copy_func, free_func) G_DEFINE_BOXED_TYPE_WITH_CODE (TypeName, type_name, copy_func, free_func, {})

    [......]
#define G_DEFINE_BOXED_TYPE_WITH_CODE(TypeName, type_name, copy_func, free_func, _C_) _G_DEFINE_BOXED_TYPE_BEGIN (TypeName, type_name, copy_func, free_func) {_C_;} _G_DEFINE_TYPE_EXTENDED_END()
```

那最后是啥呢？ 简单替换：  
```c
GType gst_memory_get_type (void)
{
    static volatile gsize g_define_type_id__volatile = 0;
    if (g_once_init_enter (&g_define_type_id__volatile))
    {
        GType (* _g_register_boxed)
        (const gchar *,
         union
        {
            GstMemory * (*do_copy_type) (GstMemory *);
            GstMemory * (*do_const_copy_type) (const GstMemory *);
            GBoxedCopyFunc do_copy_boxed;
        } __attribute__((__transparent_union__)),
        union
        {
            void (* do_free_type) (GstMemory *);
            GBoxedFreeFunc do_free_boxed;
        } __attribute__((__transparent_union__))
        ) = g_boxed_type_register_static;

        GType g_define_type_id =
            _g_register_boxed (g_intern_static_string ("GstMemory"), (GBoxedCopyFunc) gst_mini_object_ref,  (GBoxedFreeFunc) gst_mini_object_unref));
        {
            /* custom code follows */
            //{_C_;}
            /* following custom code */
        }
        g_once_init_leave (&g_define_type_id__volatile, g_define_type_id);
    }
    return g_define_type_id__volatile;
}
```



