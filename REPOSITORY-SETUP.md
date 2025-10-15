# 🚀 AL Development Collection - Repository Setup Guide

**Date**: 2025-10-15 08:43:26 UTC  
**Author**: javiarmesto  
**Version**: 2.0

## 📋 Overview

This guide walks you through creating and configuring the GitHub repository for the AL Development Collection.

---

## 🎯 Option 1: Fork into Microsoft Copilot Instructions (Recommended)

If you want to contribute this collection to the official repository:

### Step 1: Fork the Repository

```bash
# Go to https://github.com/microsoft/copilot-instructions
# Click "Fork" button
# Create fork in your account
```

### Step 2: Clone Your Fork

```bash
git clone https://github.com/javiarmesto/copilot-instructions.git
cd copilot-instructions
```

### Step 3: Create Collection Directory

```bash
mkdir -p collections/al-development
cd collections/al-development
```

### Step 4: Copy All Files

```bash
# Copy from your working directory
cp -r /path/to/your/work/.github .
cp -r /path/to/your/work/chatmodes .
cp -r /path/to/your/work/collections .
cp /path/to/your/work/*.md .
cp /path/to/your/work/*.sh .
cp /path/to/your/work/*.js .
cp /path/to/your/work/package.json .
cp /path/to/your/work/.gitignore .
```

### Step 5: Commit and Push

```bash
git add .
git commit -m "Add AL Development Collection v2.0

- 7 auto-applied instruction files
- 10 task-specific prompt files
- 6 role-based chat modes
- Complete documentation (EN/ES)
- Installation scripts and validation
- 45 comprehensive tests

Collection ID: al-development
Total Tools: 25
"

git push origin main
```

### Step 6: Create Pull Request

1. Go to https://github.com/javiarmesto/copilot-instructions
2. Click "Contribute" → "Open pull request"
3. Fill in the PR template
4. Submit for review

---

## 🎯 Option 2: Create Standalone Repository

If you want to maintain this as a separate repository:

### Step 1: Create New Repository on GitHub

1. Go to https://github.com/new
2. Repository name: `al-development-collection`
3. Description: `Comprehensive AL Development toolkit for Business Central with GitHub Copilot - 25 specialized tools across 4 intelligent layers`
4. Public ✅
5. Add README: ❌ (we have our own)
6. Add .gitignore: ❌ (we have our own)
7. Choose a license: MIT ✅
8. Create repository

### Step 2: Initialize Local Repository

```bash
# Navigate to your collection directory
cd /path/to/al-development-collection

# Initialize git
git init

# Add remote
git remote add origin https://github.com/javiarmesto/al-development-collection.git
```

### Step 3: Verify File Structure

```bash
# Your directory should contain:
ls -la

# Expected structure:
.
├── .github/
│   ├── instructions/          (7 files)
│   └── copilot-prompts/      (10 files)
├── chatmodes/                (6 files)
├── collections/
│   └── al-development.collection.yml
├── .gitignore
├── al-development.md
├── COLLECTION-SUMMARY.md
├── CONTRIBUTING.md
├── INSTALLATION.md
├── INSTALACION.md
├── install.sh
├── package.json
├── README.md
├── REPOSITORY-SETUP.md
├── run-tests.sh
├── TEST-PLAN.md
├── TEST-TRACKING.md
├── validate-al-collection.js
└── copilot-instructions.md
```

### Step 4: Create Initial Commit

```bash
# Add all files
git add .

# Create initial commit
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
Pass Rate: Pending validation
License: MIT
"

# Push to GitHub
git branch -M main
git push -u origin main
```

---

## 📝 Step 5: Configure Repository Settings

### A. About Section

1. Go to repository → Settings → About (on right sidebar)
2. Fill in:
   - **Description**: `Comprehensive AL Development toolkit for Business Central with GitHub Copilot - 25 specialized tools across 4 intelligent layers`
   - **Website**: (optional)
   - **Topics**: `al`, `business-central`, `dynamics365`, `github-copilot`, `erp`, `microsoft`, `vscode`, `architecture`, `testing`, `api`, `copilot`, `debugging`, `development-tools`

### B. Repository Settings

1. Go to Settings → General
2. Features:
   - ✅ Wikis (optional)
   - ✅ Issues
   - ✅ Discussions
   - ✅ Projects (optional)
3. Pull Requests:
   - ✅ Allow squash merging
   - ✅ Allow rebase merging
   - ✅ Automatically delete head branches

### C. Branch Protection

1. Settings → Branches → Add rule
2. Branch name pattern: `main`
3. Protect matching branches:
   - ✅ Require pull request reviews before merging
   - ✅ Require status checks to pass
   - ✅ Require conversation resolution before merging

---

## 📄 Step 6: Add Repository Files

### A. Create GitHub Actions Workflow

Create `.github/workflows/validate.yml`:

```yaml
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
```

### B. Create Issue Templates

Create `.github/ISSUE_TEMPLATE/bug_report.md`:

```markdown
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
Steps to reproduce the behavior:
1. Go to '...'
2. Use prompt/mode '...'
3. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Environment:**
 - OS: [e.g. Windows, macOS, Linux]
 - VS Code Version: [e.g. 1.85.0]
 - AL Extension Version: [e.g. 12.0]
 - Copilot Extension Version: [e.g. 1.140.0]

**Additional context**
Add any other context about the problem here.
```

Create `.github/ISSUE_TEMPLATE/feature_request.md`:

```markdown
---
name: Feature request
about: Suggest an idea for this collection
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

**Is your feature request related to a problem? Please describe.**
A clear and concise description of what the problem is. Ex. I'm always frustrated when [...]

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

**What type of addition?**
- [ ] New instruction file
- [ ] New prompt
- [ ] New chat mode
- [ ] Documentation improvement
- [ ] Other

**Describe alternatives you've considered**
A clear and concise description of any alternative solutions or features you've considered.

**Additional context**
Add any other context or screenshots about the feature request here.
```

### C. Create Pull Request Template

Create `.github/PULL_REQUEST_TEMPLATE.md`:

```markdown
## Description
Please include a summary of the change and which issue is fixed.

Fixes # (issue)

## Type of change
- [ ] New instruction file
- [ ] New prompt file
- [ ] New chat mode
- [ ] Bug fix
- [ ] Documentation update
- [ ] Other (please describe)

## How Has This Been Tested?
Please describe the tests that you ran to verify your changes.

- [ ] Ran validation script (`npm run validate`)
- [ ] Tested in VS Code with Copilot
- [ ] Verified auto-applied instructions work
- [ ] Tested prompts function correctly
- [ ] Tested chat modes respond appropriately

## Checklist:
- [ ] My code follows the contribution guidelines
- [ ] I have performed a self-review of my own changes
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing tests pass locally with my changes
- [ ] File naming follows conventions (`.instructions.md`, `.prompt.md`, `.chatmode.md`)
- [ ] Frontmatter is complete and valid
- [ ] Updated collection manifest if needed
```

### D. Create License File

Create `LICENSE`:

```
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
```

---

## 🔖 Step 7: Create Release

### A. Tag the Release

```bash
git tag -a v2.0.0 -m "AL Development Collection v2.0.0

Initial public release of comprehensive AL development toolkit.

Features:
- 7 auto-applied instruction files
- 10 task-specific prompts  
- 6 role-based chat modes
- Bilingual documentation (EN/ES)
- Automated installation
- 45-test validation suite

Total Tools: 25
Collection ID: al-development
"

git push origin v2.0.0
```

### B. Create Release on GitHub

1. Go to repository → Releases → Create a new release
2. Choose tag: `v2.0.0`
3. Release title: `AL Development Collection v2.0.0`
4. Description:

```markdown
# 🚀 AL Development Collection v2.0.0

First public release of the comprehensive AL development toolkit for Business Central with GitHub Copilot.

## 🎯 What's Included

### 25 Specialized Tools Across 4 Intelligent Layers

**Layer 1: Auto-Applied Instructions** (7 files)
- `al-guidelines` - Core development principles
- `al-code-style` - Code formatting and structure
- `al-naming-conventions` - Naming standards
- `al-performance` - Performance optimization
- `al-error-handling` - Error patterns
- `al-events` - Event-driven development
- `al-testing` - Testing guidelines

**Layer 2: Task-Specific Prompts** (10 files)
- `al-workspace` - Project setup
- `al-build` - Build & deployment
- `al-events` - Event implementation
- `al-debug` - Debugging sessions
- `al-performance` - Performance analysis
- `al-permissions` - Permission management
- `al-troubleshoot` - Problem solving
- `al-migrate` - Version migration
- `al-pages` - Page designer
- `al-workflow` - Complete workflows

**Layer 3: Role-Based Chat Modes** (6 files)
- `al-orchestrator` - Smart router
- `al-architect` - Solution design
- `al-debugger` - Issue diagnosis
- `al-tester` - Testing strategy
- `al-api` - API development
- `al-copilot` - AI features

**Layer 4: Documentation & Tools**
- Bilingual installation guides (EN/ES)
- Automated installation script
- Validation script (45 tests)
- Comprehensive documentation

## 📦 Installation

### Quick Install
```bash
git clone https://github.com/javiarmesto/al-development-collection.git
cd al-development-collection
chmod +x install.sh
./install.sh /path/to/your/al/project
```

See [INSTALLATION.md](INSTALLATION.md) for detailed instructions.

## ✅ Validation

All files validated and tested:
```bash
npm install
npm run validate
```

## 📚 Documentation

- **[User Guide](al-development.md)** - Complete feature overview
- **[Installation (English)](INSTALLATION.md)** - Step-by-step setup
- **[Instalación (Español)](INSTALACION.md)** - Guía en español
- **[Contributing](CONTRIBUTING.md)** - How to contribute
- **[Test Plan](TEST-PLAN.md)** - Comprehensive testing

## 🎓 Requirements

- Visual Studio Code 1.80+
- AL Language Extension
- GitHub Copilot (active subscription)
- Business Central development environment

## 📄 License

MIT License - See [LICENSE](LICENSE) file

## 👤 Author

**javiarmesto**
- GitHub: [@javiarmesto](https://github.com/javiarmesto)

## 🙏 Acknowledgments

- Microsoft Business Central team
- GitHub Copilot team
- AL development community

---

**Full Changelog**: Initial release
```

5. Assets:
   - ✅ Attach source code (zip & tar.gz) automatically
6. Publish release

---

## 📊 Step 8: Post-Publication

### A. Update README Badges

Add to top of README.md:

```markdown
[![GitHub release](https://img.shields.io/github/v/release/javiarmesto/al-development-collection)](https://github.com/javiarmesto/al-development-collection/releases)
[![Validation](https://github.com/javiarmesto/al-development-collection/workflows/Validate%20Collection/badge.svg)](https://github.com/javiarmesto/al-development-collection/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Tools](https://img.shields.io/badge/tools-25-orange)](./al-development.md)
```

### B. Enable GitHub Pages (Optional)

1. Settings → Pages
2. Source: Deploy from a branch
3. Branch: main / docs (if you create a docs folder)
4. Save

### C. Set Up Discussions

1. Settings → Features → Enable Discussions
2. Create categories:
   - 💡 Ideas
   - 🙏 Q&A
   - 📣 Announcements
   - 🎉 Show and tell

### D. Create Project Board (Optional)

1. Projects → New project
2. Template: Team backlog
3. Create cards for:
   - Planned features
   - Known issues
   - In progress
   - Done

---

## 🔗 Step 9: Promotion

### Share Your Collection

**On GitHub:**
- [ ] Post in GitHub Discussions
- [ ] Share in AL/BC community repos
- [ ] Tag relevant topics

**On Social Media:**
- [ ] LinkedIn post (developer community)
- [ ] Twitter/X with hashtags: #BusinessCentral #GitHub #Copilot #AL
- [ ] Reddit r/dynamics365
- [ ] Dynamics 365 Community forums

**Blog Post Ideas:**
```markdown
Title: "Supercharge Your AL Development with GitHub Copilot"

Sections:
1. The Challenge of AL Development
2. Introducing the AL Development Collection
3. How the 4-Layer System Works
4. Real-World Examples
5. Getting Started
6. Future Roadmap
```

---

## 📋 Repository Checklist

Before announcing publicly:

### Essential
- [ ] All files committed and pushed
- [ ] README.md complete
- [ ] LICENSE file present
- [ ] CONTRIBUTING.md clear
- [ ] Installation guides (EN/ES) accurate
- [ ] Validation script passes
- [ ] GitHub Actions workflow configured
- [ ] Release created with tag
- [ ] Repository description set
- [ ] Topics/tags added

### Recommended
- [ ] Issue templates configured
- [ ] PR template created
- [ ] Branch protection enabled
- [ ] Discussions enabled
- [ ] At least 3 tests passed
- [ ] Documentation spell-checked
- [ ] Links verified
- [ ] Badges added to README

### Nice to Have
- [ ] GitHub Pages enabled
- [ ] Project board created
- [ ] Wiki created
- [ ] Social media promotion planned
- [ ] Blog post drafted

---

## 🚀 Quick Command Reference

```bash
# Clone and setup
git clone https://github.com/javiarmesto/al-development-collection.git
cd al-development-collection

# Validate
npm install
npm run validate

# Test
chmod +x run-tests.sh
./run-tests.sh

# Install in project
chmod +x install.sh
./install.sh /path/to/al/project

# Create new branch for changes
git checkout -b feature/my-improvement

# Commit changes
git add .
git commit -m "Description of changes"
git push origin feature/my-improvement

# Create release
git tag -a v2.0.1 -m "Release notes"
git push origin v2.0.1
```

---

## 📞 Support

After publication, monitor:
- GitHub Issues
- GitHub Discussions
- Pull Requests
- Stars and forks

Respond to community within 48 hours.

---

**Repository Setup Complete!** 🎉

Last Updated: 2025-10-15 08:43:26 UTC