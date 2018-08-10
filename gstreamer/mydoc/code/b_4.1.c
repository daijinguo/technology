#include <gst/gst.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    const gchar *nano_str;
    guint        major, minor, micro, nano;

    gst_init(&argc, &argv);

    gst_version(&major, &minor, &micro, &nano);

    if (nano == 1)
    {
        nano_str = "(CVS)";
    }

    else if (nano == 2)
    {
        nano_str = "(Prerelease)";
    }

    else
    {
        nano_str = "";
    }

    printf("This program is linked agains GSTREAMER %d %d %d %s\n",
           major, minor, micro, nano);
}
