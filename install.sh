#!/bin/bash

# AL Development Collection - Installation Script
# Version: 2.0
# Author: javiarmesto
# Date: 2025-01-15

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored message
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_header() {
    echo ""
    print_message "$BLUE" "╔════════════════════════════════════════════════╗"
    print_message "$BLUE" "║   AL Development Collection Installer v2.0    ║"
    print_message "$BLUE" "╚════════════════════════════════════════════════╝"
    echo ""
}

print_success() {
    print_message "$GREEN" "✅ $1"
}

print_error() {
    print_message "$RED" "❌ $1"
}

print_warning() {
    print_message "$YELLOW" "⚠️  $1"
}

print_info() {
    print_message "$BLUE" "ℹ️  $1"
}

# Check if target directory is provided
if [ -z "$1" ]; then
    print_error "No target directory specified"
    echo ""
    echo "Usage: ./install.sh /path/to/your/al/project"
    echo ""
    echo "Example:"
    echo "  ./install.sh ~/Projects/MyALExtension"
    exit 1
fi

TARGET_DIR="$1"

print_header

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    print_error "Target directory does not exist: $TARGET_DIR"
    exit 1
fi

print_info "Installing AL Development Collection to: $TARGET_DIR"
echo ""

# Check if this looks like an AL project
if [ ! -f "$TARGET_DIR/app.json" ]; then
    print_warning "No app.json found in target directory"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled"
        exit 0
    fi
fi

# Create directory structure
print_info "Creating directory structure..."

mkdir -p "$TARGET_DIR/.github/instructions"
mkdir -p "$TARGET_DIR/.github/copilot-prompts"
mkdir -p "$TARGET_DIR/chatmodes"
mkdir -p "$TARGET_DIR/collections"

print_success "Directory structure created"

# Copy instruction files
print_info "Installing instruction files..."

if [ -d ".github/instructions" ]; then
    cp .github/instructions/*.instructions.md "$TARGET_DIR/.github/instructions/" 2>/dev/null || true
    INSTRUCTION_COUNT=$(ls -1 .github/instructions/*.instructions.md 2>/dev/null | wc -l)
    print_success "Installed $INSTRUCTION_COUNT instruction files"
else
    print_warning "No instruction files found to install"
fi

# Copy prompt files
print_info "Installing prompt files..."

if [ -d ".github/copilot-prompts" ]; then
    cp .github/copilot-prompts/*.prompt.md "$TARGET_DIR/.github/copilot-prompts/" 2>/dev/null || true
    PROMPT_COUNT=$(ls -1 .github/copilot-prompts/*.prompt.md 2>/dev/null | wc -l)
    print_success "Installed $PROMPT_COUNT prompt files"
else
    print_warning "No prompt files found to install"
fi

# Copy chat mode files
print_info "Installing chat mode files..."

if [ -d "chatmodes" ]; then
    cp chatmodes/*.chatmode.md "$TARGET_DIR/chatmodes/" 2>/dev/null || true
    CHATMODE_COUNT=$(ls -1 chatmodes/*.chatmode.md 2>/dev/null | wc -l)
    print_success "Installed $CHATMODE_COUNT chat mode files"
else
    print_warning "No chat mode files found to install"
fi

# Copy collection manifest
print_info "Installing collection manifest..."

if [ -f "collections/al-development.collection.yml" ]; then
    cp collections/al-development.collection.yml "$TARGET_DIR/collections/"
    print_success "Collection manifest installed"
else
    print_warning "Collection manifest not found"
fi

# Copy documentation
print_info "Installing documentation..."

if [ -f "copilot-instructions.md" ]; then
    # Check if file already exists
    if [ -f "$TARGET_DIR/copilot-instructions.md" ]; then
        print_warning "copilot-instructions.md already exists"
        read -p "Overwrite? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cp copilot-instructions.md "$TARGET_DIR/"
            print_success "copilot-instructions.md installed"
        else
            print_info "Skipped copilot-instructions.md"
        fi
    else
        cp copilot-instructions.md "$TARGET_DIR/"
        print_success "copilot-instructions.md installed"
    fi
fi

if [ -f "al-development.md" ]; then
    cp al-development.md "$TARGET_DIR/"
    print_success "al-development.md installed"
fi

if [ -f "COLLECTION-SUMMARY.md" ]; then
    cp COLLECTION-SUMMARY.md "$TARGET_DIR/"
    print_success "COLLECTION-SUMMARY.md installed"
fi

# Copy optional files
print_info "Installing optional files..."

if [ -f "README.md" ]; then
    if [ ! -f "$TARGET_DIR/README.md" ]; then
        cp README.md "$TARGET_DIR/README-AL-COLLECTION.md"
        print_success "README copied as README-AL-COLLECTION.md"
    fi
fi

if [ -f "CONTRIBUTING.md" ]; then
    cp CONTRIBUTING.md "$TARGET_DIR/"
    print_success "CONTRIBUTING.md installed"
fi

# Summary
echo ""
print_message "$BLUE" "═══════════════════════════════════════════════"
print_message "$BLUE" "   INSTALLATION COMPLETE"
print_message "$BLUE" "═══════════════════════════════════════════════"
echo ""

print_success "AL Development Collection installed successfully!"
echo ""
print_info "Next steps:"
echo "  1. Reload VS Code window (Ctrl+Shift+P > 'Reload Window')"
echo "  2. Open any .al file to see auto-applied instructions"
echo "  3. Try a prompt: @workspace use al-workspace"
echo "  4. Or ask: 'Use al-orchestrator mode'"
echo ""
print_info "Documentation:"
echo "  - User Guide: $TARGET_DIR/al-development.md"
echo "  - Integration: $TARGET_DIR/copilot-instructions.md"
echo "  - Reference: $TARGET_DIR/COLLECTION-SUMMARY.md"
echo ""
print_message "$GREEN" "Happy AL Development! 🚀"
echo ""