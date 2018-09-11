#include <gst/gst.h>

int main(gint argc, gchar *argv[])
{
    GstElementFactory *factory;

    gst_init(&argc, &argv);

    factory = gst_element_factory_find("fakesrc");
    if (!factory)
    {
        g_print("You do not have the 'fakesrc' element installed.\n");
        return -1;
    }

    /* display information */
    g_print("The '%s' element is a member of the category %s.\n"
            "Description: %s\n",
            gst_plugin_feature_get_name(GST_PLUGIN_FEATURE(factory)),
            gst_element_factory_get_metadata(factory, GST_ELEMENT_METADATA_KLASS),
            gst_element_factory_get_metadata(factory, GST_ELEMENT_METADATA_DESCRIPTION));

    gst_object_unref(GST_OBJECT(factory));

    return 0;
}
