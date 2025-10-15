#!/bin/bash

# AL Development Collection - Repository Setup Script
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
echo -e "${BLUE}║   AL Development Collection Repository Setup  ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git is not installed. Please install Git first.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Git found${NC}"

# Get repository URL
echo ""
echo -e "${YELLOW}Enter your GitHub repository URL:${NC}"
echo "Example: https://github.com/javiarmesto/al-development-collection.git"
read -p "URL: " REPO_URL

if [ -z "$REPO_URL" ]; then
    echo -e "${RED}❌ Repository URL is required${NC}"
    exit 1
fi

# Initialize git if not already
if [ ! -d ".git" ]; then
    echo -e "${BLUE}Initializing git repository...${NC}"
    git init
    echo -e "${GREEN}✅ Git initialized${NC}"
else
    echo -e "${YELLOW}⚠️  Git repository already initialized${NC}"
fi

# Add remote
echo -e "${BLUE}Adding remote origin...${NC}"
git remote add origin "$REPO_URL" 2>/dev/null || git remote set-url origin "$REPO_URL"
echo -e "${GREEN}✅ Remote origin set${NC}"

# Create GitHub workflow directory
echo -e "${BLUE}Creating GitHub Actions workflow...${NC}"
mkdir -p .github/workflows

cat > .github/workflows/validate.yml << 'EOF'
name: Validate Collection

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  validate:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    
    - name: Install dependencies
      run: npm install
    
    - name: Run validation
      run: npm run validate
    
    - name: Run automated tests
      run: |
        chmod +x run-tests.sh
        ./run-tests.sh
EOF

echo -e "${GREEN}✅ GitHub Actions workflow created${NC}"

# Create issue templates
echo -e "${BLUE}Creating issue templates...${NC}"
mkdir -p .github/ISSUE_TEMPLATE

cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug report
about: Create a report to help us improve
title: '[BUG] '
labels: bug
assignees: ''
---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior.

**Expected behavior**
What you expected to happen.

**Environment:**
 - OS: [e.g. Windows]
 - VS Code Version: 
 - AL Extension Version:
EOF

cat > .github/ISSUE_TEMPLATE/feature_request.md << 'EOF'
---
name: Feature request
about: Suggest an idea for this collection
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

**Is your feature request related to a problem?**
A clear description of the problem.

**Describe the solution you'd like**
What you want to happen.

**Type of addition:**
- [ ] New instruction
- [ ] New prompt
- [ ] New chat mode
- [ ] Documentation
EOF

echo -e "${GREEN}✅ Issue templates created${NC}"

# Create PR template
cat > .github/PULL_REQUEST_TEMPLATE.md << 'EOF'
## Description
Summary of changes

## Type of change
- [ ] New instruction file
- [ ] New prompt file
- [ ] New chat mode
- [ ] Bug fix
- [ ] Documentation

## Checklist:
- [ ] Ran validation (`npm run validate`)
- [ ] Tested in VS Code
- [ ] Updated documentation
- [ ] Followed naming conventions
EOF

echo -e "${GREEN}✅ PR template created${NC}"

# Create LICENSE if not exists
if [ ! -f "LICENSE" ]; then
    echo -e "${BLUE}Creating MIT License...${NC}"
    cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2025 javiarmesto

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
    echo -e "${GREEN}✅ LICENSE created${NC}"
fi

# Stage all files
echo -e "${BLUE}Staging all files...${NC}"
git add .
echo -e "${GREEN}✅ Files staged${NC}"

# Create initial commit
echo -e "${BLUE}Creating initial commit...${NC}"
git commit -m "Initial commit: AL Development Collection v2.0

Complete AL development toolkit for Business Central with GitHub Copilot.

Features:
- 7 auto-applied instruction files for code standards
- 10 task-specific prompts for common workflows
- 6 role-based chat modes for strategic guidance
- Bilingual documentation (English/Spanish)
- Automated installation and validation
- Comprehensive test suite (45 tests)

Collection Structure:
- Layer 1: Auto-applied instructions (always active)
- Layer 2: Contextual instructions (activate when relevant)
- Layer 3: Task-specific prompts (explicit invocation)
- Layer 4: Role-based chat modes (strategic consulting)

Tools: 25 total
License: MIT
Author: javiarmesto
"

echo -e "${GREEN}✅ Initial commit created${NC}"

# Set main branch
echo -e "${BLUE}Setting main branch...${NC}"
git branch -M main
echo -e "${GREEN}✅ Main branch set${NC}"

# Push to GitHub
echo ""
echo -e "${YELLOW}Ready to push to GitHub!${NC}"
echo -e "${YELLOW}Run: git push -u origin main${NC}"
echo ""
echo -e "${GREEN}Next steps:${NC}"
echo "1. git push -u origin main"
echo "2. Go to GitHub and configure repository settings"
echo "3. Create release with tag v2.0.0"
echo "4. Enable GitHub Actions"
echo "5. Enable Discussions (optional)"
echo ""
echo -e "${BLUE}Setup complete! 🎉${NC}"