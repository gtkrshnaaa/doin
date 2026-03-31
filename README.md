# DOIN: Command-Line Task Automator

DOIN is a minimalist, high-performance command-line utility written in C, specifically designed for Termux and Linux environments. It serves as a centralized entry point for custom shell scripts, allowing users to execute complex automation tasks through simple, memorable commands from any directory.

## Table of Contents
1. [Overview](#overview)
2. [Technical Architecture](#technical-architecture)
3. [Key Features](#key-features)
4. [Prerequisites](#prerequisites)
5. [Installation](#installation)
6. [Usage](#usage)
7. [Adding Custom Commands](#adding-custom-commands)
8. [Development](#development)
9. [Project Structure](#project-structure)
10. [License](#license)

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
   *Note: This will install the binary to `/data/data/com.termux/files/usr/bin/` and initialize the scripts directory at `~/.doin/availsh/`.*

## Usage
### Check Version
```bash
doin -v
# or
doin --version
```

### Run a Command
```bash
doin <command_name> [optional_arguments]
```

### Example (Pre-installed)
```bash
doin ramcheck
```

## Adding Custom Commands
To add your own automation to `doin`, simply follow these steps:
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
4. Run it instantly:
   ```bash
   doin mytool
   ```

## Development
The project uses a structured build system:
- `make build`: Prepares the environment and directories.
- `make clean`: Removes all compiled binaries and build artifacts.
- `make uninstall`: Removes the `doin` binary and all scripts from the system.

## Project Structure
```text
doin/
├── bin/                # Compiled binaries (ignored by git)
├── build/              # Object files (ignored by git)
├── scripts/            # Default sample scripts
│   └── ramcheck.sh     # System memory utility
├── doin.c              # Core C source code
├── Makefile            # Advanced build system
├── .gitignore          # Version control exclusions
└── README.md           # Documentation
```

## License
This project is open-source and available under the MIT License.
