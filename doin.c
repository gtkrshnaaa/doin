#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <dirent.h>
#include <limits.h>

#define VERSION "v0.1.5"

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
        printf("Description:\n");
        printf("  doin is a minimalist wrapper for custom shell scripts. It allows you to\n");
        printf("  execute any .sh file in ~/.doin/availsh/ without the .sh extension.\n\n");
        printf("Options:\n");
        printf("  -v, --version    Show version information\n");
        printf("  -h, --help       Show this help message\n");
        printf("  -l, --list       List all available custom commands\n\n");
        printf("Extensibility:\n");
        printf("  You can add or modify your own scripts in ~/.doin/availsh/.\n");
        printf("  Any executable script added there instantly becomes a doin command.\n");
        return 0;
    }

    // Get the HOME directory
    const char *home = getenv("HOME");
    if (home == NULL) {
        fprintf(stderr, "Error: HOME environment variable not set.\n");
        return 1;
    }

    // Handle list flags
    if (strcmp(argv[1], "-l") == 0 || strcmp(argv[1], "--list") == 0) {
        char dir_path[PATH_MAX];
        if (snprintf(dir_path, sizeof(dir_path), "%s/.doin/availsh", home) >= (int)sizeof(dir_path)) {
            fprintf(stderr, "Error: Directory path too long.\n");
            return 1;
        }

        DIR *d = opendir(dir_path);
        if (d == NULL) {
            perror("opendir");
            return 1;
        }

        printf("Available commands:\n");
        struct dirent *dir;
        while ((dir = readdir(d)) != NULL) {
            // Only list files ending in .sh
            size_t len = strlen(dir->d_name);
            if (len > 3 && strcmp(dir->d_name + len - 3, ".sh") == 0) {
                // Print filename without .sh extension
                printf("  - %.*s\n", (int)(len - 3), dir->d_name);
            }
        }
        closedir(d);
        return 0;
    }

    // Security check: ensure the command does not contain path separators
    if (strchr(argv[1], '/') != NULL) {
        fprintf(stderr, "Error: Invalid command name. Command name cannot contain '/'.\n");
        return 1;
    }

    // Construct the path to the script: ~/.doin/availsh/<command>.sh
    char script_path[PATH_MAX];
    if (snprintf(script_path, sizeof(script_path), "%s/.doin/availsh/%s.sh", home, argv[1]) >= (int)sizeof(script_path)) {
        fprintf(stderr, "Error: Script path too long.\n");
        return 1;
    }

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
    // Size: 1 (script_path) + (argc - 2) (original args from argv[2]) + 1 (NULL terminator) = argc
    char **new_argv = malloc(argc * sizeof(char *));
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
    execv(script_path, new_argv);

    // If execv returns, it means an error occurred
    perror("execv");
    free(new_argv);
    return 1;
}
