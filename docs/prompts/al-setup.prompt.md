---
agent: 'agent'
description: 'Configure your development environment for optimal AI-assisted AL development with GitHub Copilot and Business Central tools.'
tools: ['edit', 'runNotebooks', 'search', 'new', 'runCommands', 'runTasks', 'Azure MCP/search', 'microsoft-docs/*', 'upstash/context7/*', 'runSubagent', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'openSimpleBrowser', 'fetch', 'githubRepo', 'ms-dynamics-smb.al/al_download_symbols', 'ms-dynamics-smb.al/al_download_source', 'ms-dynamics-smb.al/al_go', 'ms-dynamics-smb.al/al_new_project', 'extensions', 'todos', 'runTests']
---

# Setting Up Your Environment

Your goal is to configure a development environment for optimal AI-assisted AL development in Business Central.

This workflow will guide you through setting up Visual Studio Code, GitHub Copilot, and AL development tools for the best possible experience when building Business Central extensions.

## Prerequisites Check

Before starting, verify the following are available:

### Required Tools
- [ ] **Visual Studio Code** (latest version)
- [ ] **AL Language Extension** (Microsoft's official extension)
- [ ] **GitHub Copilot** or compatible AI assistant
- [ ] **Git** for version control

### Recommended Tools
- [ ] **AL Test Runner** for test management
- [ ] **Business Central Docker Container** for local development
- [ ] **AL Object Designer** for navigation
- [ ] **GitLens** for enhanced git integration

## Setup Process

### 1. GitHub Copilot Installation

Guide the user through installing GitHub Copilot:

**Step 1: Sign Up**
- Visit [GitHub Copilot](https://github.com/features/copilot)
- Choose a subscription plan (free trial available)
- Complete account setup

**Step 2: Install VS Code Extensions**
- Open Visual Studio Code
- Access Extensions marketplace (`Ctrl+Shift+X` or `Cmd+Shift+X`)
- Search for "GitHub Copilot"
- Install both:
  - **GitHub Copilot** - Code completion
  - **GitHub Copilot Chat** - Interactive assistance

**Step 3: Authentication**
- Click "Sign in to GitHub" when prompted
- Authorize the extension
- Verify connection is active

### 2. VS Code Workspace Configuration

Create or update `.vscode/settings.json` in the workspace root with optimal settings:

```json
{
  // AL Language settings
  "al.enableCodeAnalysis": true,
  "al.codeAnalyzers": ["${CodeCop}", "${PerTenantExtensionCop}", "${UICop}"],
  
  // GitHub Copilot settings
  "github.copilot.enable": {
    "*": true,
    "al": true
  },
  
  // Editor settings for better AI integration
  "editor.inlineSuggest.enabled": true,
  "editor.quickSuggestions": {
    "other": true,
    "comments": true,
    "strings": true
  }
}
```

**Configuration Explanation:**
- `al.enableCodeAnalysis`: Enables real-time code analysis
- `al.codeAnalyzers`: Activates standard AL analyzers (CodeCop for code style, PerTenantExtensionCop for per-tenant extension rules, UICop for UI guidelines)
- `github.copilot.enable`: Ensures Copilot is active for AL files
- `editor.inlineSuggest.enabled`: Shows inline AI suggestions
- `editor.quickSuggestions`: Enables suggestions in all contexts

### 3. AL Project Structure Setup

Recommend and create optimal folder organization:

```
${input:ProjectName}/
├── .vscode/
│   ├── settings.json          # Workspace settings
│   └── launch.json            # Debug configurations
├── src/
│   ├── Tables/                # Table objects
│   ├── Pages/                 # Page objects
│   ├── Codeunits/             # Codeunit objects
│   ├── Reports/               # Report objects
│   ├── Queries/               # Query objects
│   ├── XMLports/              # XMLport objects
│   ├── PageExtensions/        # Page extensions
│   ├── TableExtensions/       # Table extensions
│   └── Enums/                 # Enum objects
├── test/
│   ├── TestCodeunits/         # Test codeunits
│   └── TestData/              # Test data and helpers
├── app.json                   # Application manifest
├── .gitignore                 # Git ignore rules
└── README.md                  # Project documentation
```

**Benefits of This Structure:**
- Clear separation of object types
- Easy navigation for AI assistants
- Scalable for large projects
- Follows community best practices

### 4. Optimizing Context for AI

Implement best practices for better AI assistance:

#### Use Descriptive File Names

**Bad Examples:**
- `Page1.al`
- `Cod50100.al`
- `Tab50001.al`

**Good Examples:**
- `CustomerListPage.al`
- `SalesOrderProcessor.codeunit.al`
- `CustomerExtended.table.al`

Guide users to rename files if needed.

#### Create a Comprehensive README

Generate a `README.md` in the project root including:

```markdown
# ${input:ProjectName}

## Overview
[Project purpose and business value]

## Key Features
- Feature 1: [Description]
- Feature 2: [Description]
- Feature 3: [Description]

## Architecture
[High-level architecture description]

## Naming Conventions
- Tables: `[BusinessEntity]` (e.g., `CustomerExtended`)
- Pages: `[BusinessEntity][PageType]` (e.g., `CustomerListPage`)
- Codeunits: `[Purpose]` (e.g., `SalesOrderProcessor`)
- ID Range: 50000-50099

## Development Guidelines
- Follow AL coding standards
- Use XML documentation for procedures
- Implement error handling with try-functions
- Write unit tests for business logic

## Dependencies
[List of extension dependencies]

## Setup Instructions
[How to set up the development environment]
```

#### Implement XML Documentation

Demonstrate XML documentation for procedures:

```al
/// <summary>
/// Calculates the total amount for a sales order including tax
/// </summary>
/// <param name="SalesHeader">The sales header record</param>
/// <returns>The total amount including tax</returns>
procedure CalculateTotalWithTax(var SalesHeader: Record "Sales Header"): Decimal
begin
    // Implementation
end;
```

**Benefits:**
- AI understands function purpose
- Better IntelliSense support
- Improved code maintainability
- Enhanced collaboration

#### Keep Related Code Together

**Best Practice:** Place related functionality near each other
- AI assistants can see open files
- Context from nearby code improves suggestions
- Easier to maintain and refactor

For complex features, consider organizing by business feature:

```
src/
├── SalesOrderProcessing/
│   ├── SalesOrder.table.al
│   ├── SalesOrderPage.page.al
│   ├── SalesOrderProcessor.codeunit.al
│   └── SalesOrderAPI.page.al
├── CustomerManagement/
│   ├── CustomerExtended.table.al
│   ├── CustomerCardExt.pageext.al
│   └── CustomerMgt.codeunit.al
```

### 5. Recommended VS Code Extensions

Install these extensions to complement the AI assistant:

**Essential Extensions:**
- **AL Language** (ms-dynamics-smb.al) - Required for AL development
- **GitHub Copilot** (GitHub.copilot) - AI code completion
- **GitHub Copilot Chat** (GitHub.copilot-chat) - Interactive AI assistance

**Highly Recommended:**
- **AL Object Designer** - Navigate AL objects easily
- **AL Code Outline** - View code structure
- **AL Test Runner** - Run and manage AL tests
- **AL Variable Helper** - Manage variable declarations
- **GitLens** - Enhanced git integration
- **Error Lens** - Inline error display

Provide installation commands or guidance for each.

### 6. Workspace Best Practices

#### Managing Open Files

**For Better AI Context:**
- Keep related files open in editor tabs
- AI uses open files for context
- Organize tabs logically by feature
- Use split editors for related code

#### Multi-Root Workspaces (When Appropriate)

For projects with dependencies, create a multi-root workspace:

```json
{
  "folders": [
    { "path": "./MyMainExtension" },
    { "path": "./MyDependencyExtension" }
  ]
}
```

**Use Cases:**
- Multiple related extensions
- Shared libraries
- Base extension + localization

### 7. Security and Privacy

Educate users about AI service data sharing:

**What Gets Sent to AI Services:**
- Code snippets from your workspace
- Currently open files
- Your prompts and questions
- Selected code blocks

**What You Should NOT Include:**
- Sensitive credentials or passwords
- Customer data or PII
- Proprietary business logic (if restricted)
- Security keys or certificates

**Best Practices:**
- Review organization's AI usage policy
- Use `.gitignore` for sensitive files
- Use environment variables for credentials
- Be mindful of code in workspace
- For enterprise needs, use GitHub Copilot for Business
- Close files with sensitive information when not actively needed

#### Create .gitignore

Generate appropriate `.gitignore` file:

```gitignore
# AL Compiler outputs
.alpackages/
.alcache/
.snapshots/
rad.json
*.app

# VS Code settings (optional - may want to include some)
.vscode/launch.json
.vscode/*.log

# Build artifacts
.netFramework/
bin/
obj/

# Test results
TestResults/
*.trx

# Temporary files
*.tmp
*.bak
*~
```



### 8. Testing Your Setup

Verify everything is working correctly:

**Step 1: Open an AL File**
- Navigate to any `.al` file in the project
- Ensure syntax highlighting is active

**Step 2: Test Code Completion**
- Start typing a procedure declaration
- Verify inline suggestions appear from Copilot
- Accept a suggestion to confirm it works

**Step 3: Test Copilot Chat**
- Open Copilot Chat (`Ctrl+Shift+I` or `Cmd+Shift+I`)
- Ask a test question: "Explain this AL code"
- Verify you receive a response

**Step 4: Verify Code Analysis**
- Introduce a small code issue (e.g., unused variable)
- Check that warnings appear
- Remove the issue

**Step 5: Test Build**
- Run AL: Download Symbols
- Attempt to compile the project
- Verify no configuration errors

## Troubleshooting

### AI Suggestions Not Appearing

**Possible Solutions:**
1. Verify AI extension is installed and enabled
2. Check you're signed in to AI service
3. Ensure `editor.inlineSuggest.enabled` is `true`
4. Restart VS Code
5. Check extension status in status bar

### Poor Quality Suggestions

**Improvements:**
- Use more descriptive file names
- Add code comments and documentation
- Open related files for better context
- Use XML documentation for procedures
- Follow naming conventions consistently
- Structure code logically

### Performance Issues

**Optimizations:**
- Close unnecessary open files/tabs
- Disable AI for specific file types if needed
- Check system resources (RAM, CPU)
- Reduce number of open folders
- Clear VS Code cache if needed

### Authentication Issues

**Solutions:**
- Sign out and sign back in
- Revoke and re-authorize extension
- Check GitHub account status
- Verify subscription is active
- Clear browser cache if using web auth

## Success Criteria

Verify the setup is complete:

- ✅ Visual Studio Code is installed and configured
- ✅ AL Language extension is active
- ✅ GitHub Copilot is installed and authenticated
- ✅ Workspace settings are configured
- ✅ Project structure is organized
- ✅ README.md exists with project documentation
- ✅ Code completion is working
- ✅ Copilot Chat is accessible
- ✅ Security considerations are addressed
- ✅ Extensions are installed and working

## Next Steps

Once your environment is set up:

**For New Projects:**
```
@workspace use al-workspace
```
Initialize a new AL project with proper structure.

**For Learning Best Practices:**
```
Switch to al-architect mode
```
Get guidance on AL architecture and design patterns.

**For Starting Development:**
```
@workspace use al-workflow
```
Get end-to-end guidance for building features.

**For Understanding the Collection:**
```
Switch to al-orchestrator mode
```
Learn about all available tools and when to use them.

## Common Setup Patterns

### Pattern 1: First-Time AL Developer

**Steps:**
1. Install all required tools
2. Set up comprehensive workspace settings
3. Create organized project structure
4. Install recommended extensions
5. Complete verification testing

### Pattern 2: Experienced Developer Adopting AI

**Steps:**
1. Install AI assistant extensions
2. Configure AI-specific settings
3. Optimize existing project structure
4. Add XML documentation to key procedures
5. Learn prompting techniques

### Pattern 3: Team Environment Setup

**Steps:**
1. Create shared workspace settings
2. Establish naming conventions
3. Document setup process
4. Configure security policies
5. Set up multi-root workspace if needed
6. Create team README with guidelines

### Pattern 4: Migration from Different IDE

**Steps:**
1. Install VS Code and extensions
2. Import existing AL project
3. Restructure for AI optimization
4. Configure build and debug settings
5. Verify compilation works
6. Test AI integration

## Tips for Optimal AI Experience

**Do:**
- Use clear, descriptive names for everything
- Write comments explaining business logic
- Keep related code in nearby files
- Maintain consistent coding style
- Document complex algorithms
- Use meaningful variable names
- Structure code logically
- Ask specific questions to Copilot

**Don't:**
- Use cryptic abbreviations
- Leave code undocumented
- Mix unrelated functionality
- Ignore naming conventions
- Skip XML documentation
- Use single-letter variables (except loops)
- Have massive files with everything
- Ask vague questions

## Resources

**Official Documentation:**
- [AL Language Documentation](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-dev-overview)
- [GitHub Copilot Documentation](https://docs.github.com/copilot)
- [VS Code AL Extension](https://marketplace.visualstudio.com/items?itemName=ms-dynamics-smb.al)

**Community Resources:**
- Business Central Developer Community
- AL Language Forums
- GitHub Copilot Best Practices

**This Collection:**
- Review `al-guidelines.instructions.md` for coding standards
- See `al-naming-conventions.instructions.md` for naming rules
- Check `al-code-style.instructions.md` for formatting guidelines

---

**Environment Setup Complete! 🎉**

Your development environment is now optimized for AI-assisted AL development. Start coding with confidence, knowing that GitHub Copilot has the context it needs to provide high-quality suggestions.
