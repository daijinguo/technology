#include <gst/gst.h>
#include <stdio.h>

int main( int argc, char* argv[] ){
    gboolean        silent = FALSE;
    gchar          *saveFile = NULL;
    GOptionContext *context;
    GError         *err = NULL;
    GOptionEntry    entries[] = {
        { "silent", 's', 0, G_OPTION_ARG_NONE, &silent, 
          "do not output status information", 
          NULL 
        },
        { "output", 'o', 0, G_OPTION_ARG_STRING, &saveFile,
          "save xml representation of pipeline to FILE and exit",
          "FILE"
        },
        { NULL }
    };

    context = g_option_context_new( "my appliction");
    g_option_context_add_main_entries(context, entries, NULL);
    g_option_context_add_group(context, gst_init_get_option_group());
    if( !g_option_context_parse(context, &argc, &argv, &err) ) {
        g_print("failed to initialize: %s\n", err->message);
        g_error_free(err);

        return 1;
    }

    printf("Run with --help to see the app option appended.\n");
    return 0;
}