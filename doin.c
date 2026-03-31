#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

#define VERSION "v0.1.1"

/**
 * doin: A simple command-line utility to run custom scripts.
 * It looks for scripts in ~/.doin/availsh/ based on the first argument.
 */
int main(int argc, char *argv[]) {
    // Check if at least one argument is provided
    if (argc < 2) {
        fprintf(stderr, "Usage: doin <command> [args...] or doin -v/--version\n");
        return 1;
    }

    // Handle version flags
    if (strcmp(argv[1], "-v") == 0 || strcmp(argv[1], "--version") == 0) {
        printf("doin version %s\n", VERSION);
        return 0;
    }

    // Handle help flags
    if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0) {
        printf("Usage: doin <command> [args...]\n\n");
        printf("Options:\n");
        printf("  -v, --version    Show version information\n");
        printf("  -h, --help       Show this help message\n\n");
        printf("Commands are scripts located in ~/.doin/availsh/<command>.sh\n");
        return 0;
    }

    // Get the HOME directory for script lookup
    const char *home = getenv("HOME");
    if (home == NULL) {
        fprintf(stderr, "Error: HOME environment variable not set.\n");
        return 1;
    }

    // Construct the path to the script: ~/.doin/availsh/<command>.sh
    char script_path[1024];
    snprintf(script_path, sizeof(script_path), "%s/.doin/availsh/%s.sh", home, argv[1]);

    // Check if the script file exists
    struct stat st;
    if (stat(script_path, &st) != 0) {
        fprintf(stderr, "Error: Command '%s' not found (script: %s).\n", argv[1], script_path);
        return 1;
    }

    // Ensure it's a regular file and executable
    if (!S_ISREG(st.st_mode) || access(script_path, X_OK) != 0) {
        fprintf(stderr, "Error: Script '%s' is not executable.\n", script_path);
        return 1;
    }

    // Prepare arguments for execv: the script path followed by any additional arguments
    char **new_argv = malloc((argc + 1) * sizeof(char *));
    if (new_argv == NULL) {
        perror("malloc");
        return 1;
    }

    new_argv[0] = script_path;
    for (int i = 2; i < argc; i++) {
        new_argv[i - 1] = argv[i];
    }
    new_argv[argc - 1] = NULL;

    // Execute the script, replacing the current process
    if (execv(script_path, new_argv) == -1) {
        perror("execv");
        free(new_argv);
        return 1;
    }

    // Should never reach here if execv is successful
    free(new_argv);
    return 0;
}
