//
// how to build this
// libtool --mode=link gcc -Wall mp3-player.c -o mp3-player $(pkg-config --cflags --libs gstreamer-1.0)
//

#include <gst/gst.h>
#include <glib.h>

static gboolean bus_call(GstBus     *bus,
                         GstMessage *message,
                         gpointer    data)
{
    GMainLoop  *loop = (GMainLoop *) data;

    switch(GST_MESSAGE_TYPE(message))
    {
        case GST_MESSAGE_EOS:
            {
                g_print("End of stream\n");
                g_main_loop_quit(loop);
                break;
            }

        case GST_MESSAGE_ERROR:
            {
                gchar  *debug;
                GError *error;
                gst_message_parse_error(message, &error, &debug);
                g_free(debug);

                g_printerr("Error: %s\n", error->message);
                g_error_free(error);

                g_main_loop_quit(loop);
                break;
            }

        default:
            break;
    }

    return TRUE;
}

int main( int argc, char *argv[])
{

    GMainLoop  *loop;

    GstElement *pipeline, *source, *decoder, *sink;
    GstBus     *bus;
    guint       bus_watch_id;

    gst_init(&argc, &argv);

    loop = g_main_loop_new(NULL, FALSE);

    if(argc != 2)
    {
        g_printerr("Usage: %s <mp3 filename>\n", argv[0]);
        return -1;
    }

    pipeline = gst_pipeline_new("audio-player");
    source   = gst_element_factory_make("filesrc",       "file-source");
    decoder  = gst_element_factory_make("mad",           "mad-decoder");
    sink     = gst_element_factory_make("autoaudiosink", "audio-output");

    if(!pipeline)
    {
        g_printerr("pipeline is null\n");
        goto exit_with_error;
    }

    if(!source)
    {
        g_printerr("source is null\n");
        goto exit_with_error;
    }


    if(!decoder)
    {
        g_printerr("decoder is null\n");
        goto exit_with_error;
    }

    if(!sink)
    {
        g_printerr("sink is null\n");
        goto exit_with_error;
    }

    g_object_set(G_OBJECT(source), "location", argv[1], NULL);

    bus          = gst_pipeline_get_bus(GST_PIPELINE(pipeline));
    bus_watch_id = gst_bus_add_watch(bus, bus_call, loop);
    g_object_unref(GST_OBJECT(bus));

    gst_bin_add_many(GST_BIN(pipeline), source, decoder, sink, NULL);
    gst_element_link_many(source, decoder, sink, NULL);

    g_print("Now playing: %s\n", argv[1]);
    gst_element_set_state(pipeline, GST_STATE_PLAYING);


    /* Iterate */
    g_print ("Running...\n");
    g_main_loop_run (loop);

    /* Out of the main loop, clean up nicely */
    g_print ("Returned, stopping playback\n");
    gst_element_set_state (pipeline, GST_STATE_NULL);

    g_print ("Deleting pipeline\n");
    gst_object_unref (GST_OBJECT (pipeline));
    g_source_remove (bus_watch_id);
    g_main_loop_unref (loop);

    return 0;

exit_with_error:
    g_printerr("One element could not be created. Exiting. \n");
    return -1;
}
