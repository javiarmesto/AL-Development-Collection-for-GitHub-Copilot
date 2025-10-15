#!/bin/bash

# AL Development Collection - Automated Tests
# Version: 1.0
# Date: 2025-10-15

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   AL Development Collection - Test Runner    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Test counters
TOTAL=0
PASSED=0
FAILED=0

# Test function
run_test() {
    local name=$1
    local command=$2
    
    TOTAL=$((TOTAL + 1))
    echo -e "${BLUE}[Test $TOTAL] $name${NC}"
    
    if eval "$command" > /dev/null 2>&1; then
        echo -e "${GREEN}✅ PASSED${NC}\n"
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}❌ FAILED${NC}\n"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

# File Structure Tests
echo -e "${YELLOW}═══ File Structure Tests ═══${NC}\n"

run_test "Instructions directory exists" "test -d .github/instructions"
run_test "Prompts directory exists" "test -d .github/copilot-prompts"
run_test "Chat modes directory exists" "test -d chatmodes"
run_test "Collections directory exists" "test -d collections"

run_test "7 instruction files present" "test $(ls -1 .github/instructions/*.instructions.md 2>/dev/null | wc -l) -eq 7"
run_test "10 prompt files present" "test $(ls -1 .github/copilot-prompts/*.prompt.md 2>/dev/null | wc -l) -eq 10"
run_test "6 chat mode files present" "test $(ls -1 chatmodes/*.chatmode.md 2>/dev/null | wc -l) -eq 6"

# Documentation Tests
echo -e "${YELLOW}═══ Documentation Tests ═══${NC}\n"

run_test "Collection documentation exists" "test -f al-development.md"
run_test "Summary documentation exists" "test -f COLLECTION-SUMMARY.md"
run_test "Copilot instructions exists" "test -f copilot-instructions.md"
run_test "English installation guide exists" "test -f INSTALLATION.md"
run_test "Spanish installation guide exists" "test -f INSTALACION.md"
run_test "README exists" "test -f README.md"
run_test "Contributing guide exists" "test -f CONTRIBUTING.md"
run_test "Collection manifest exists" "test -f collections/al-development.collection.yml"

# File Naming Tests
echo -e "${YELLOW}═══ File Naming Tests ═══${NC}\n"

run_test "All instructions end with .instructions.md" "ls .github/instructions/ | grep -v '.instructions.md$' | wc -l | grep -q '^0$'"
run_test "All prompts end with .prompt.md" "ls .github/copilot-prompts/ | grep -v '.prompt.md$' | wc -l | grep -q '^0$'"
run_test "All chat modes end with .chatmode.md" "ls chatmodes/ | grep -v '.chatmode.md$' | wc -l | grep -q '^0$'"

# Validation Test (if Node.js available)
echo -e "${YELLOW}═══ Validation Test ═══${NC}\n"

if command -v node &> /dev/null; then
    if [ -f "package.json" ]; then
        run_test "NPM dependencies install" "npm install"
        run_test "Collection validation passes" "npm run validate"
    else
        echo -e "${YELLOW}⚠️  package.json not found, skipping npm tests${NC}\n"
    fi
else
    echo -e "${YELLOW}⚠️  Node.js not found, skipping validation${NC}\n"
fi

# Summary
echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
echo -e "${BLUE}           TEST SUMMARY${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
echo ""
echo -e "Total Tests:  $TOTAL"
echo -e "${GREEN}Passed:       $PASSED${NC}"
echo -e "${RED}Failed:       $FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✅ All automated tests passed!${NC}"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Run manual tests from TEST-PLAN.md"
    echo "2. Test installation on different OS"
    echo "3. Test all prompts and chat modes in VS Code"
    echo "4. Verify documentation accuracy"
    exit 0
else
    echo -e "${RED}❌ Some tests failed. Please review and fix.${NC}"
    exit 1
fi