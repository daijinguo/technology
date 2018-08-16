#include <gst/gst.h>

int main(int argc, char *argv[])
{

    GstElementFactory *factory;
    GList             *elementlist;
    int                result;

    gst_init(&argc, &argv);

    factory = gst_element_get_factory();
    if(!factory)
    {
        g_printerr("can not found any factory.\n");
        result = -1;
        goto error;
    }

    elementlist = factory->gst_element_factory_list_get_elements();
    if(!elementlist)
    {
        result = -2;
        goto error;
    }

error:
    if(factory)
    {
        g_object_unref(GST_OBJECT(factory));
    }

    if(!elementlist)
    {
        g_object_unref(GST_OBJECT(elementlist));
    }

    return result;
}