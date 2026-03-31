# DOIN: Command-Line Task Automator

DOIN is a minimalist, high-performance command-line utility written in C, specifically designed for Termux and Linux environments. It serves as a centralized entry point for custom shell scripts, allowing users to execute complex automation tasks through simple, memorable commands from any directory.

## Table of Contents
1. [Overview](#overview)
2. [Technical Architecture](#technical-architecture)
3. [Key Features](#key-features)
4. [Prerequisites](#prerequisites)
5. [Installation](#installation)
6. [Usage](#usage)
7. [Bash Completion](#bash-completion)
8. [Default Monitoring Commands](#default-monitoring-commands)
9. [Adding Custom Commands](#adding-custom-commands)
10. [Development](#development)
11. [Project Structure](#project-structure)
12. [License](#license)

---

## Overview
Automating repetitive tasks in a mobile terminal environment like Termux often requires managing numerous shell scripts scattered across various directories. `doin` solves this by providing a unified binary that maps command arguments to specific executable scripts stored in a secure, centralized location (`~/.doin/availsh/`).

## Technical Architecture
`doin` is built with a focus on low overhead and reliability:
- **Core Engine:** Written in C for near-instant execution.
- **Process Management:** Utilizes the `execv` system call to replace the `doin` process with the target script, ensuring no unnecessary process nesting or memory consumption.
- **Dynamic Mapping:** Automatically translates `doin <cmd>` to `~/.doin/availsh/<cmd>.sh`.
- **Environment Awareness:** Respects the `$HOME` environment variable to ensure portability across different Linux distributions and Android/Termux setups.

## Key Features
- **Global Accessibility:** Once installed, `doin` is accessible from any path in your terminal.
- **Tab Completion:** Supports native bash completion for all your custom commands.
- **Vertical Layout Philosophy:** All default scripts are optimized for narrow terminal screens (Termux) using a clean vertical "Label : Value" format.
- **Arguments Passing:** Supports passing an unlimited number of arguments from the `doin` command directly to the underlying script.
- **Elegant Output:** Features a color-coded Makefile for a clean and professional installation experience.
- **Minimalist Footprint:** Extremely small binary size with zero external dependencies beyond the standard C library.

## Prerequisites
To build and install `doin`, ensure you have the following packages installed:
- `clang` or `gcc` (C Compiler)
- `make` (Build automation tool)
- `git` (Version control)

In Termux, you can install these via:
```bash
pkg install clang make git -y
```

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/gtkrshnaaa/doin.git
   cd doin
   ```
2. Build and install:
   ```bash
   make install
   ```
   *Note: This will install the binary to your `$PREFIX/bin`, set up scripts at `~/.doin/availsh/`, and configure bash completion.*

## Usage
### Options
- `doin -v`, `doin --version` : Show version information.
- `doin -h`, `doin --help`    : Show help message.
- `doin -l`, `doin --list`    : List all available custom commands.

### Run a Command
```bash
doin <command_name> [optional_arguments]
```

## Bash Completion
`doin` supports automatic command completion. To activate it in your current session after installation, run:
```bash
source $PREFIX/etc/bash_completion.d/doin
```
*Note: This is usually handled automatically by the shell on new sessions if `bash-completion` is installed.*

## Default Monitoring Commands
The following commands are pre-installed and optimized for vertical display:
- `ramcheck`   : Memory usage statistics.
- `cpuusage`   : CPU load average monitoring.
- `diskusage`  : Storage space statistics.
- `battery`    : Battery status (requires `termux-api`).
- `sysinfo`    : Kernel and system information.
- `netstat`    : Network connection and IP info.
- `topmem`     : Top memory-consuming processes.
- `procsearch` : Search for running processes.
- `weather`    : Local weather report.
- `uptime`     : Detailed system uptime.

## Adding Custom Commands
To add your own automation to `doin`, simply follow ini steps:
1. Create a new shell script in `~/.doin/availsh/`:
   ```bash
   nano ~/.doin/availsh/mytool.sh
   ```
2. Add your logic and make it executable:
   ```bash
   #!/bin/bash
   echo "Running my custom tool..."
   # Your logic here
   ```
3. Save the file and ensure it has execution permissions:
   ```bash
   chmod +x ~/.doin/availsh/mytool.sh
   ```
4. Run it instantly with auto-completion:
   ```bash
   doin mytool
   ```

## Development
The project uses a structured build system:
- `make build`: Prepares the environment and directories.
- `make clean`: Removes all compiled binaries and build artifacts.
- `make uninstall`: Removes the `doin` binary, scripts, and completion config.

## Project Structure
```text
doin/
├── bin/                # Compiled binaries (ignored by git)
├── build/              # Object files (ignored by git)
├── scripts/            # Default sample scripts
├── doin.c              # Core C source code
├── doin-completion.sh  # Bash completion logic
├── Makefile            # Portable build system (using PREFIX)
├── .gitignore          # Version control exclusions
└── README.md           # Documentation
```

## License
This project is open-source and available under the MIT License.
