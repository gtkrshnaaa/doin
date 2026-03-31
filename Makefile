CC = gcc
CFLAGS = -Wall -O2
SRC = doin.c
OBJ_DIR = build
BIN_DIR = bin
TARGET = $(BIN_DIR)/doin
SCRIPTS_DIR = scripts
# Path configuration
PREFIX ?= /usr/local
INSTALL_DIR = $(PREFIX)/bin
DOIN_SCRIPTS_PATH = $(HOME)/.doin/availsh
COMP_DIR = $(PREFIX)/etc/bash_completion.d
VERSION = v0.1.1

# Colors for elegant output
BLUE = \033[1;34m
GREEN = \033[1;32m
RED = \033[1;31m
CYAN = \033[1;36m
RESET = \033[0m

.PHONY: all build clean install uninstall

all: build $(TARGET)

build:
	@echo "$(CYAN)[ BUILD ]$(RESET) Creating directories..."
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(BIN_DIR)

$(TARGET): $(SRC)
	@echo "$(CYAN)[ BUILD ]$(RESET) Compiling $(SRC)..."
	@$(CC) $(CFLAGS) -o $@ $<

install: all
	@echo "$(BLUE)[ INSTALL ]$(RESET) Deploying doin $(VERSION) to $(INSTALL_DIR)"
	@cp $(TARGET) $(INSTALL_DIR)/doin
	@chmod +x $(INSTALL_DIR)/doin
	@echo "$(GREEN)[ OK ]$(RESET) Binary installed successfully"
	
	@echo "$(BLUE)[ SETUP ]$(RESET) Preparing scripts directory at $(DOIN_SCRIPTS_PATH)"
	@mkdir -p $(DOIN_SCRIPTS_PATH)
	@echo "$(GREEN)[ OK ]$(RESET) Directory ready"
	
	@echo "$(BLUE)[ DEPLOY ]$(RESET) Installing scripts..."
	@cp $(SCRIPTS_DIR)/*.sh $(DOIN_SCRIPTS_PATH)/
	@chmod +x $(DOIN_SCRIPTS_PATH)/*.sh
	@echo "$(GREEN)[ OK ]$(RESET) Scripts deployed and permissions set"
	
	@echo "$(BLUE)[ COMP ]$(RESET) Setting up bash completion..."
	@mkdir -p $(COMP_DIR)
	@cp doin-completion.sh $(COMP_DIR)/doin
	@echo "$(GREEN)[ OK ]$(RESET) Completion script installed"
	
	@echo "--------------------------------------------------"
	@echo "$(GREEN)Installation of doin $(VERSION) completed successfully.$(RESET)"
	@echo "You can now use '$(CYAN)doin <command>$(RESET)' to run your scripts."

uninstall:
	@echo "$(RED)[ UNINSTALL ]$(RESET) Removing binary, scripts, and completion..."
	@rm -f $(INSTALL_DIR)/doin
	@rm -rf $(DOIN_SCRIPTS_PATH)
	@rm -f $(COMP_DIR)/doin
	@echo "$(GREEN)[ OK ]$(RESET) Uninstallation complete."

clean:
	@echo "$(RED)[ CLEAN ]$(RESET) Removing build artifacts..."
	@rm -rf $(OBJ_DIR) $(BIN_DIR)
	@echo "$(GREEN)[ OK ]$(RESET) Workspace is clean."
