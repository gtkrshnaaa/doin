# DOIN: Command-Line Task Automator

DOIN is a minimalist, high-performance command-line utility written in C, specifically designed for Termux and Linux environments. It serves as a centralized execution engine for custom shell scripts, allowing users to build their own command-line toolkit with ease.

## Table of Contents
1. [Core Philosophy](#core-philosophy)
2. [Technical Architecture](#technical-architecture)
3. [Key Features](#key-features)
4. [Prerequisites](#prerequisites)
5. [Installation](#installation)
6. [Usage](#usage)
7. [Bash Completion](#bash-completion)
8. [Default Monitoring Commands](#default-monitoring-commands)
9. [Customization & Extensibility](#customization--extensibility)
10. [Development](#development)
11. [License](#license)

---

## Core Philosophy
The fundamental goal of `doin` is to simplify the execution of personal automation scripts. Instead of managing complex aliases or long file paths, `doin` acts as an intelligent wrapper:
- **Transparent Mapping:** When you run `doin <cmd>`, the tool automatically looks for a corresponding shell script named `<cmd>.sh` inside the `~/.doin/availsh/` directory.
- **Extension Abstraction:** It strips the need to type the `.sh` extension, making custom scripts feel like native system commands.
- **Full User Control:** Every user is encouraged to modify, delete, or add new scripts to the collection. `doin` provides the infrastructure; you provide the logic.

## Technical Architecture
`doin` is built with a focus on low overhead and reliability:
- **Core Engine:** Written in C for near-instant execution.
- **Process Management:** Utilizes the `execv` system call to replace the `doin` process with the target script, ensuring no unnecessary process nesting.
- **Environment Awareness:** Respects the `$HOME` environment variable for portability.

## Key Features
- **Global Accessibility:** Once installed, `doin` is accessible from any path.
- **Native Tab Completion:** Supports bash completion for all custom scripts in real-time.
- **Optimized for Termux:** Default monitoring scripts use a vertical layout designed specifically for narrow mobile screens.

## Installation
```bash
make install
```
*Note: This installs the binary to your `$PREFIX/bin`, initializes `~/.doin/availsh/`, and configures bash completion.*

## Usage
- `doin -v`, `doin --version` : Show version information.
- `doin -h`, `doin --help`    : Show help message.
- `doin -l`, `doin --list`    : List all available custom commands.

## Customization & Extensibility
To create your own command:
1. Create a `.sh` file in `~/.doin/availsh/`:
   ```bash
   nano ~/.doin/availsh/hello.sh
   ```
2. Write your script:
   ```bash
   #!/bin/bash
   echo "Hello from my custom command!"
   ```
3. Make it executable:
   ```bash
   chmod +x ~/.doin/availsh/hello.sh
   ```
4. Run it: `doin hello`

## License
MIT License. Open-source and free for everyone.
