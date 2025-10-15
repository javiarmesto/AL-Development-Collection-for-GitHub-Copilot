# AL Development Collection for GitHub Copilot

> Comprehensive toolkit for Microsoft Dynamics 365 Business Central AL development with 25 specialized tools across 4 intelligent layers.

[![Validation Status](https://img.shields.io/badge/validation-passing-brightgreen)](./validate-al-collection.js)
[![Version](https://img.shields.io/badge/version-2.0-blue)](./al-development.collection.yml)
[![Tools](https://img.shields.io/badge/tools-25-orange)](./al-development.md)
[![License](https://img.shields.io/badge/license-MIT-green)](./LICENSE)

## 🚀 Quick Start

### Installation

1. **Clone or download this collection**
   ```bash
   git clone https://github.com/javiarmesto/al-development-collection.git
   cd al-development-collection
   ```

2. **Install the collection in your AL workspace**
   ```bash
   # Copy files to your AL project
   cp -r .github/instructions your-al-project/.github/
   cp -r .github/copilot-prompts your-al-project/.github/
   cp -r chatmodes your-al-project/
   cp -r collections your-al-project/
   cp copilot-instructions.md your-al-project/
   ```

3. **Reload VS Code**
   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
   - Run: `Developer: Reload Window`

4. **Verify installation**
   ```bash
   npm install
   npm run validate
   ```

### First Use

Open any `.al` file and start coding. The auto-applied instructions will guide Copilot automatically.

**Try your first prompt:**
```
@workspace use al-workspace
```

**Or ask the orchestrator:**
```
Switch to al-orchestrator mode and ask: "I need to build a sales approval workflow"
```

## 📦 What's Included

### 🔧 Layer 1: Auto-Applied Instructions (7 files)
Always active when working with AL code:
- **al-guidelines** - Core development principles
- **al-code-style** - Formatting and structure
- **al-naming-conventions** - Naming standards
- **al-performance** - Optimization patterns
- **al-error-handling** - Error patterns (contextual)
- **al-events** - Event-driven development (contextual)
- **al-testing** - Testing guidelines (contextual)

### 📝 Layer 2: Task-Specific Prompts (10 files)
Invoke with `@workspace use [name]`:
- **al-workspace** - Project setup
- **al-build** - Build & deployment
- **al-events** - Event implementation
- **al-debug** - Debugging sessions
- **al-performance** - Performance analysis
- **al-permissions** - Permission management
- **al-troubleshoot** - Problem solving
- **al-migrate** - Version migration
- **al-pages** - Page designer
- **al-workflow** - Complete guidance

### 💬 Layer 3: Role-Based Chat Modes (6 files)
Specialized consultants:
- **al-orchestrator** 🎯 - Smart router
- **al-architect** 🏗️ - Solution design
- **al-debugger** 🐛 - Issue diagnosis
- **al-tester** ✅ - Testing strategy
- **al-api** 🌐 - API development
- **al-copilot** 🤖 - AI features

## 🎯 Common Workflows

### Building a New Feature
```
1. al-orchestrator → Analyze requirements
2. al-architect → Design solution
3. @workspace use al-workspace → Setup
4. Code (auto-guidelines active)
5. @workspace use al-events → Add events
6. al-tester → Test strategy
7. @workspace use al-permissions → Security
8. @workspace use al-build → Deploy
```

### Debugging Issues
```
1. al-debugger → Diagnose
2. @workspace use al-debug → Debug tools
3. @workspace use al-performance → Profile
4. Fix (auto-guidelines active)
5. al-tester → Regression tests
```

### API Development
```
1. al-architect → Design API
2. al-api → Implement
3. @workspace use al-permissions → Security
4. al-tester → API tests
5. @workspace use al-build → Deploy
```

## 📚 Documentation

- **[Collection Overview](./al-development.md)** - User-facing documentation
- **[Complete Reference](./COLLECTION-SUMMARY.md)** - Internal documentation
- **[Integration Guide](./copilot-instructions.md)** - Copilot setup

## 🛠️ Requirements

- Visual Studio Code (latest version)
- AL Language extension for Business Central
- GitHub Copilot extension (active subscription)
- Business Central development environment (sandbox recommended)
- Node.js 14+ (for validation script)

## ✅ Validation

Validate the collection before contributing:

```bash
# Install dependencies
npm install

# Run validation
npm run validate
```

Expected output:
```
✅ Collection is fully compliant and ready for contribution!
```

## 📖 Usage Examples

### Example 1: New Developer
```markdown
User: "I'm new to AL. How do I start?"

Response from al-orchestrator:
"Let's get you set up. Use @workspace use al-workspace
to initialize your project. The auto-applied guidelines
will help you code correctly from day one."
```

### Example 2: Complex Task
```markdown
User: "Build AI-powered API for sales forecasting"

Response from al-orchestrator:
"This needs 4 phases:
1. al-architect - Design architecture (3-4 hours)
2. al-api + al-copilot - Build in parallel (1 day)
3. Integration - Connect layers (1-2 days)
4. al-tester - Comprehensive testing (1 day)"
```

### Example 3: Performance Issue
```markdown
User: "My report is slow"

Response from al-debugger:
"Let's profile it systematically:
1. @workspace use al-performance
2. Identify bottleneck
3. Apply optimizations
4. Re-profile to verify"
```

## 🤝 Contributing

Found an issue or have a suggestion?

1. **Report Issues**
   - Use GitHub Issues
   - Provide specific examples
   - Include error messages

2. **Suggest Improvements**
   - New prompts for common tasks
   - New modes for specialized scenarios
   - Better patterns and examples

3. **Contribution Guidelines**
   - Follow file naming conventions
   - Include proper frontmatter
   - Update manifest file
   - Run validation before submitting

See [CONTRIBUTING.md](./CONTRIBUTING.md) for detailed guidelines.

## 📋 File Structure

```
al-development-collection/
├── .github/
│   ├── instructions/              # 7 auto-applied instruction files
│   └── copilot-prompts/           # 10 task-specific prompts
├── chatmodes/                     # 6 role-based chat modes
├── collections/
│   └── al-development.collection.yml  # Collection manifest
├── al-development.md              # Collection documentation
├── COLLECTION-SUMMARY.md          # Internal reference
├── copilot-instructions.md        # Integration guide
├── validate-al-collection.js      # Validation script
├── package.json                   # Dependencies
└── README.md                      # This file
```

## 🏷️ Version History

### 2.0.0 (2025-01-15)
- ✅ Full compliance with contribution guidelines
- ✅ All files renamed to proper extensions
- ✅ Collection manifest created
- ✅ Validation script added
- ✅ Complete documentation

### 1.0.0 (2025-01-15)
- Initial release
- 7 instructions, 10 prompts, 6 modes
- Multi-layer architecture

## 📄 License

MIT License - see [LICENSE](./LICENSE) file for details.

## 👤 Author

**javiarmesto**
- GitHub: [@javiarmesto](https://github.com/javiarmesto)
- Created: 2025-01-15

## 🙏 Acknowledgments

- Microsoft Business Central team for AL language
- GitHub Copilot team for extensibility
- AL development community for patterns and best practices

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/javiarmesto/al-development-collection/issues)
- **Discussions**: [GitHub Discussions](https://github.com/javiarmesto/al-development-collection/discussions)
- **Documentation**: [al-development.md](./al-development.md)

---

**Status**: ✅ Ready for contribution  
**Last Updated**: 2025-01-15 08:19:35 UTC  
**Collection ID**: `al-development`  
**Total Tools**: 25