
# 

file loacal: gstreamer{}/gst/gst_private.h

```c
struct _GstPluginFeature {
  GstObject      object;

  /*< private >*/
  gboolean       loaded;
  guint          rank;

  const gchar   *plugin_name;
  GstPlugin     *plugin;      /* weak ref */

  /*< private >*/
  gpointer _gst_reserved[GST_PADDING];
};
```

```c
struct _GstElementFactory {
  GstPluginFeature      parent;

  GType                 type;                   /* unique GType of element or 0 if not loaded */

  gpointer              metadata;

  GList *               staticpadtemplates;     /* GstStaticPadTemplate list */
  guint                 numpadtemplates;

  /* URI interface stuff */
  GstURIType            uri_type;
  gchar **              uri_protocols;

  GList *               interfaces;             /* interface type names this element implements */

  /*< private >*/
  gpointer _gst_reserved[GST_PADDING];
};
```

GstElement 结构体：  

```c
struct _GstElement
{
  GstObject             object;

  /*< public >*/ /* with LOCK */
  GRecMutex             state_lock;

  /* element state */
  GCond                 state_cond;
  guint32               state_cookie;
  GstState              target_state;
  GstState              current_state;
  GstState              next_state;
  GstState              pending_state;
  GstStateChangeReturn  last_return;

  GstBus               *bus;

  /* allocated clock */
  GstClock             *clock;
  GstClockTimeDiff      base_time; /* NULL/READY: 0 - PAUSED: current time - PLAYING: difference to clock */
  GstClockTime          start_time;

  /* element pads, these lists can only be iterated while holding
   * the LOCK or checking the cookie after each LOCK. */
  guint16               numpads;
  GList                *pads;
  guint16               numsrcpads;
  GList                *srcpads;
  guint16               numsinkpads;
  GList                *sinkpads;
  guint32               pads_cookie;

  /* with object LOCK */
  GList                *contexts;

  /*< private >*/
  gpointer _gst_reserved[GST_PADDING-1];
};
```


## `gst_registry_get_type`
@gstreamer-1.14.2/gst/gstregistry.h
