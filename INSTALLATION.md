# 🚀 AL Development Collection - Installation Guide

**For AL and Business Central Developers & Architects**

> Complete guide to install and configure the AL Development Collection in your VS Code workspace.

## 📋 Prerequisites

Before starting, make sure you have:

- ✅ **Visual Studio Code** installed (version 1.80 or higher)
- ✅ **AL Language Extension** installed in VS Code
- ✅ **GitHub Copilot** active (valid subscription required)
- ✅ **Node.js** 14+ (optional, only for validation)
- ✅ An **AL project** (existing or new)

## 🎯 Installation Options

Choose the method that best suits your needs:

- **Option 1**: [Automatic Installation](#option-1-automatic-installation-recommended) ⭐ Recommended
- **Option 2**: [Manual Installation](#option-2-manual-installation)
- **Option 3**: [Single Project Only](#option-3-single-project-only)

---

## 🎯 Option 1: Automatic Installation (Recommended)

### Step 1: Get the Collection

**From GitHub:**
```bash
# Navigate to your projects folder
cd ~/Projects

# Clone the repository
git clone https://github.com/microsoft/copilot-instructions.git
cd copilot-instructions/collections/al-development
```

**Or download as ZIP:**
1. Go to https://github.com/microsoft/copilot-instructions
2. Navigate to `collections/al-development`
3. Download as ZIP
4. Extract to your projects folder

### Step 2: Run the Installer

```bash
# Make the installer executable
chmod +x install.sh

# Run installer pointing to your AL project
./install.sh /path/to/your/AL/project
```

**Real example:**
```bash
# If your project is in ~/Projects/MyBCExtension
./install.sh ~/Projects/MyBCExtension
```

**What the installer does:**
- ✅ Creates necessary directory structure
- ✅ Copies all instruction files (7 files)
- ✅ Copies all prompt files (10 files)
- ✅ Copies all chat mode files (6 files)
- ✅ Copies collection manifest and documentation
- ✅ Handles existing files gracefully

### Step 3: Reload VS Code

1. Open your AL project in VS Code
2. Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (Mac)
3. Type: `Developer: Reload Window`
4. Press Enter

### Step 4: Verify Installation

**Quick Test:**
1. Open any `.al` file
2. Start typing code - notice Copilot follows AL standards
3. Try a prompt:
   ```
   @workspace use al-workspace
   ```
4. You should see the workspace setup guide

**Detailed Test:**
```bash
# If you have Node.js installed
cd your-al-project
npm install
npm run validate
```

Expected output:
```
✅ Collection is fully compliant and ready for contribution!
```

---

## 🎯 Option 2: Manual Installation

### Step 1: Create Folder Structure

In your AL project root, create these folders:

```bash
mkdir -p .github/instructions
mkdir -p .github/copilot-prompts
mkdir -p chatmodes
mkdir -p collections
```

### Step 2: Copy Instruction Files

Copy all files from the downloaded collection:

**On Linux/Mac:**
```bash
# From the downloaded collection folder
cp -r .github/instructions/*.instructions.md YOUR_PROJECT/.github/instructions/
cp -r .github/copilot-prompts/*.prompt.md YOUR_PROJECT/.github/copilot-prompts/
cp -r chatmodes/*.chatmode.md YOUR_PROJECT/chatmodes/
cp collections/al-development.collection.yml YOUR_PROJECT/collections/
cp copilot-instructions.md YOUR_PROJECT/
```

**On Windows (PowerShell):**
```powershell
# From the downloaded collection folder
Copy-Item .github\instructions\*.instructions.md YOUR_PROJECT\.github\instructions\
Copy-Item .github\copilot-prompts\*.prompt.md YOUR_PROJECT\.github\copilot-prompts\
Copy-Item chatmodes\*.chatmode.md YOUR_PROJECT\chatmodes\
Copy-Item collections\al-development.collection.yml YOUR_PROJECT\collections\
Copy-Item copilot-instructions.md YOUR_PROJECT\
```

### Step 3: Verify Structure

Your project should look like this:

```
YourALProject/
├── .github/
│   ├── instructions/              ← 7 .instructions.md files
│   └── copilot-prompts/          ← 10 .prompt.md files
├── chatmodes/                    ← 6 .chatmode.md files
├── collections/
│   └── al-development.collection.yml
├── src/                          ← Your existing AL code
├── app.json                      ← Your project file
├── launch.json
└── copilot-instructions.md       ← Integration guide
```

### Step 4: Reload VS Code

Press `Ctrl+Shift+P` → `Developer: Reload Window`

---

## 🎯 Option 3: Single Project Only

Use this if you want to try the collection in ONE project without full installation:

### Using Workspace Settings

1. **Open your AL project in VS Code**

2. **Create/Edit `.vscode/settings.json`** in your project root:

```json
{
  "github.copilot.chat.codeGeneration.instructions": [
    {
      "file": "https://raw.githubusercontent.com/microsoft/copilot-instructions/main/collections/al-development/.github/instructions/al-guidelines.instructions.md"
    },
    {
      "file": "https://raw.githubusercontent.com/microsoft/copilot-instructions/main/collections/al-development/.github/instructions/al-code-style.instructions.md"
    },
    {
      "file": "https://raw.githubusercontent.com/microsoft/copilot-instructions/main/collections/al-development/.github/instructions/al-naming-conventions.instructions.md"
    },
    {
      "file": "https://raw.githubusercontent.com/microsoft/copilot-instructions/main/collections/al-development/.github/instructions/al-performance.instructions.md"
    }
  ]
}
```

3. **Reload VS Code**

> ⚠️ **Note**: This method is limited and doesn't include prompts or chat modes. For full functionality, use Option 1 or 2.

---

## ✅ Post-Installation Verification

### Test 1: Auto-Applied Instructions

1. Open any `.al` file
2. Start typing code:
```al
procedure CalculateTotal
```
3. Copilot should suggest code with:
   - PascalCase naming
   - 2-space indentation
   - XML documentation for public procedures

### Test 2: Try a Prompt

1. Open Copilot Chat (`Ctrl+I` or `Cmd+I`)
2. Type:
```
@workspace use al-workspace
```
3. You should see a guided workspace setup response

### Test 3: Try a Chat Mode

1. In Copilot Chat, type:
```
Use al-orchestrator mode
```
2. Then ask:
```
I need to build a sales approval workflow. Where should I start?
```
3. You should receive strategic analysis and recommendations

### Test 4: Full Validation (Optional)

If you installed Node.js:

```bash
cd your-al-project
npm install
npm run validate
```

Expected output:
```
✅ Collection is fully compliant and ready for contribution!
```

---

## 🎓 Getting Started After Installation

### For New AL Developers

**1. Read the user documentation:**
```bash
# Open in browser or VS Code
code al-development.md
```

**2. Start with the Orchestrator:**
```
Copilot Chat: "Use al-orchestrator mode"
Then: "I'm new to AL, how should I start?"
```

**3. Use the workspace prompt:**
```
@workspace use al-workspace
Answer the questions to set up your first project
```

### For Experienced AL Developers

**1. Review active instructions:**
```bash
# Read files in .github/instructions/
# These apply automatically while you code
code .github/instructions/al-code-style.instructions.md
```

**2. Explore available prompts:**
```bash
# View all prompts
ls .github/copilot-prompts/

# Try one relevant to your current task
@workspace use al-build    # For deployment
@workspace use al-debug    # For debugging
@workspace use al-api      # For APIs
```

**3. Use specialized modes:**
```
al-architect   → For solution design
al-debugger    → For troubleshooting
al-api         → For API development
al-copilot     → For AI features
```

### For Architects

**1. Start with architect mode:**
```
Chat: "Use al-architect mode"
Then: "I need to design a multi-company approval workflow"
```

**2. Combine with prompts as needed:**
```
@workspace use al-events      # For event design
@workspace use al-performance # For performance considerations
```

---

## 🔧 Advanced Configuration

### Customize for Your Team

If you want to adapt the collection to your team:

**1. Fork the repository**

**2. Modify instructions according to your standards:**
```bash
# Edit .github/instructions/al-code-style.instructions.md
# Add your team-specific rules
```

**3. Share the fork with your team:**
```bash
git clone https://your-org/al-development-collection.git
```

### Multi-Project Workspace

If you work with multiple AL projects:

**Option A: Install in each project**
```bash
for project in Project1 Project2 Project3; do
    ./install.sh ~/Projects/$project
done
```

**Option B: Use global VS Code configuration**

Edit `~/.config/Code/User/settings.json` (Linux/Mac) or `%APPDATA%/Code/User/settings.json` (Windows):

```json
{
  "github.copilot.chat.codeGeneration.useInstructionFiles": true
}
```

---

## 🆘 Troubleshooting

### Issue: Copilot doesn't show instruction-based suggestions

**Solution:**
1. Verify files are in correct locations
2. Reload VS Code (`Ctrl+Shift+P` > `Reload Window`)
3. Check Copilot is active (icon in bottom bar)
4. Confirm you're working with `.al` files

### Issue: Prompts don't work (@workspace use...)

**Solution:**
1. Verify files have `.prompt.md` extension
2. Check they're in `.github/copilot-prompts/`
3. Reload VS Code
4. Ensure correct syntax: `@workspace use al-[name]`

### Issue: Chat modes don't respond

**Solution:**
1. Verify files have `.chatmode.md` extension
2. Check they're in `chatmodes/` folder
3. Use exact name: `Use al-architect mode` (not `al-architect-mode`)
4. Reload VS Code

### Issue: Instructions don't seem to apply

**Solution:**
1. Verify `alwaysApply: true` in frontmatter
2. Check `globs` in frontmatter (must include `"*.al"`)
3. Completely reload VS Code
4. Close and reopen the `.al` file

### Issue: "File not found" error in validation

**Solution:**
```bash
# Verify all files are present
ls -la .github/instructions/
ls -la .github/copilot-prompts/
ls -la chatmodes/

# If files are missing, reinstall
./install.sh .
```

---

## 📚 Additional Resources

### Included Documentation

- **al-development.md** - Complete user guide
- **copilot-instructions.md** - Copilot integration
- **COLLECTION-SUMMARY.md** - Complete technical reference
- **CONTRIBUTING.md** - If you want to contribute improvements

### External Documentation

- [GitHub Copilot Docs](https://docs.github.com/en/copilot)
- [AL Language Docs](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/)
- [Business Central Development](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/)

### Support

- **Issues**: Report problems on GitHub
- **Discussions**: Ask the community
- **Updates**: Subscribe to the repository for updates

---

## 🎉 Ready to Start!

Now you're all set. Some suggested first steps:

### First Exercise: Create a Simple Table

```al
// Start typing and let Copilot guide you
table 50100 "My First Table"
{
    // Copilot will suggest correct structure
    // with DataClassification, proper fields, etc.
}
```

### First Complete Workflow

```
1. Chat: "Use al-orchestrator mode"
2. Ask: "I want to add a new field to Customer table"
3. Follow the recommendations
4. Use suggested prompts to implement
```

### Explore All Tools

```bash
# List all available prompts
ls .github/copilot-prompts/

# List all modes
ls chatmodes/

# Read documentation for each as needed
```

---

**Need help?** Use **al-orchestrator** - it's designed to guide you when you're unsure:

```
Chat: "Use al-orchestrator mode"
Then: "I'm not sure which tool to use for [your task]"
```

**Happy AL Development!** 🚀

---

**Installed**: 2025-10-15 08:35:16 UTC  
**User**: javiarmesto  
**Collection Version**: 2.0