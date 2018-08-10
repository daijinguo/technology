//
// pkg-config --cflags --libs gstreamer-1.0
//

#include <gst/gst.h>

static gboolean
cb_message_error(gpointer data)
{
    g_print("an error happen");
    return FALSE;
}

static gboolean
cb_message_eos(gpointer data)
{
    g_print("run at eos\n");
    return FALSE;
}

int main(int argc, char *argv[])
{
    GstBus     *bus;
    GstElement *pipeline;

    gst_init(&argc, &argv);

    pipeline = gst_pipeline_new("my-pipeline");
    bus      = gst_pipeline_get_bus(GST_PIPELINE(pipeline));
    gst_bus_add_signal_watch(bus);
    g_signal_connect(bus, "message::error", G_CALLBACK(cb_message_error), NULL);
    g_signal_connect(bus, "message::eos",   G_CALLBACK(cb_message_eos), NULL);

    g_object_unref(G_OBJECT(bus));
    g_object_unref(G_OBJECT(pipeline));

    return 0;
}
