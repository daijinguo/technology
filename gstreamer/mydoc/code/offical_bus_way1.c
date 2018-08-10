
//
// how to compile this file
// pkg-config --cflags --libs gstreamer-1.0
//

#include <gst/gst.h>

static GMainLoop *loop;

static gboolean
my_bus_callback(GstBus *bus, GstMessage *message, gpointer data)
{
    g_print("Got %s message\n", GST_MESSAGE_TYPE_NAME(message));

    switch(GST_MESSAGE_TYPE(message))
    {
        case GST_MESSAGE_ERROR:
            {
                GError *error;
                gchar  *debug;

                gst_message_parse_error(message, &error, &debug);
                g_print("ERROR: %s\n", error->message);
                g_error_free(error);
                g_free(debug);

                g_main_loop_quit(loop);
                break;
            }

        case GST_MESSAGE_EOS:
            {
                g_main_loop_quit(loop);
                break;
            }

        default:
            break;
    }

    return TRUE;
}

gint main(gint argc, gchar *argv[])
{
    GstElement *pipeline;
    GstBus     *bus;
    guint       bus_watch_id;

    gst_init(&argc, &argv);

    pipeline     = gst_pipeline_new("my-pipeline");
    bus          = gst_pipeline_get_bus(GST_PIPELINE(pipeline));
    bus_watch_id = gst_bus_add_watch(bus, my_bus_callback, NULL);

    gst_object_unref(GST_OBJECT(bus));

    // .....

    loop = g_main_loop_new(NULL, FALSE);
    g_main_loop_run(loop);

    /* clean up */
    gst_element_set_state (pipeline, GST_STATE_NULL);
    gst_object_unref (pipeline);
    g_source_remove (bus_watch_id);
    g_main_loop_unref (loop);

    return 0;
}
