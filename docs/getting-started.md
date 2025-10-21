# Getting Started

Complete guide to installing and using the AL Development Collection for GitHub Copilot.

---

## Prerequisites

Before starting, ensure you have:

### Required Tools
- **Visual Studio Code** (latest version)
- **AL Language Extension** (Microsoft's official extension)
- **GitHub Copilot** or compatible AI assistant
- **Git** for version control

### Recommended Tools
- **AL Test Runner** for test management
- **Business Central Docker Container** for local development
- **AL Object Designer** for navigation
- **GitLens** for enhanced git integration

---

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/javiarmesto/AL_Copilot_Collection.git
cd AL_Copilot_Collection
```

### Step 2: Copy to Your AL Project

```bash
# Copy instruction files
cp -r instructions your-al-project/.github/copilot/

# Copy prompt files
cp -r prompts your-al-project/.github/copilot/

# Copy chat mode files
cp -r chatmodes your-al-project/.github/copilot/

# Copy collection manifest
cp -r collections your-al-project/.github/copilot/
```

### Step 3: Reload VS Code

1. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
2. Type: `Developer: Reload Window`
3. Press Enter

### Step 4: Verify Installation

```bash
npm install
npm run validate
```

Expected output:
```
✅ Collection is fully compliant and ready for contribution!
```

---

## First Use

### Try Your First Prompt

Open any `.al` file and use:

```
@workspace use al-workspace
```

This will initialize your AL workspace with proper configuration.

### Ask the Orchestrator

The orchestrator mode helps route you to the right primitive:

```
Switch to al-orchestrator mode and ask: 
"I need to build a sales approval workflow"
```

---

## Common Workflows

### Building a New Feature

1. **al-orchestrator** → Analyze requirements
2. **al-architect** → Design solution
3. `@workspace use al-workspace` → Setup
4. Code (auto-guidelines active)
5. `@workspace use al-events` → Add events
6. **al-tester** → Test strategy
7. `@workspace use al-permissions` → Security
8. `@workspace use al-build` → Deploy

### Debugging Issues

1. **al-debugger** → Diagnose
2. `@workspace use al-debug` → Debug tools
3. `@workspace use al-performance` → Profile
4. Fix (auto-guidelines active)
5. **al-tester** → Regression tests

### API Development

1. **al-architect** → Design API
2. **al-api** → Implement
3. `@workspace use al-permissions` → Security
4. **al-tester** → API tests
5. `@workspace use al-build` → Deploy

---

## Next Steps

- [Explore Instructions](../instructions/) - Learn about auto-applied guidelines
- [Browse Workflows](../prompts/) - See all available agentic workflows
- [Discover Chat Modes](../chatmodes/) - Meet the specialist modes
- [Read Contributing Guide](../CONTRIBUTING) - Help improve the collection

---

## Troubleshooting

### Collection Not Loading

1. Verify files are in `.github/copilot/` directory
2. Reload VS Code window
3. Check GitHub Copilot is enabled
4. Review VS Code output console for errors

### Validation Failing

1. Run `npm install` to ensure dependencies are installed
2. Check file naming conventions
3. Verify frontmatter in all files
4. Review validation output for specific errors

### Chat Modes Not Appearing

1. Ensure files end with `.chatmode.md`
2. Verify frontmatter includes `description` and `tools`
3. Reload VS Code
4. Check Copilot settings

---

## Getting Help

- **Issues**: [GitHub Issues](https://github.com/javiarmesto/AL_Copilot_Collection/issues)
- **Discussions**: [GitHub Discussions](https://github.com/javiarmesto/AL_Copilot_Collection/discussions)
- **Documentation**: [Full Documentation](../al-development)
