<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# GitHub Copilot Instructions for AL Development

## Overview
This workspace contains AL (Application Language) code for Microsoft Dynamics 365 Business Central. This is an **AI Native AL Development** toolkit implementing the **[AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)** framework. GitHub Copilot is configured with **29 Agent Primitives** across **3 framework layers** to assist with AL development following Microsoft's best practices and this project's specific standards.

### Framework Architecture
This collection implements the **AI Native-Instructions Architecture** with three systematic layers:

**Layer 1: Markdown Prompt Engineering** - Structured instructions using semantic markdown (headers, lists, links) that guide AI reasoning for predictable, repeatable results.

**Layer 2: Agent Primitives** - 28 configurable tools (7 instructions + 14 workflows + 6 modes + 1 guide) that deploy your prompt engineering systematically.

**Layer 3: Context Engineering** - Strategic management of LLM context windows through modular loading, `applyTo` patterns, and optimized information retrieval.

> 💡 For detailed framework documentation, see [AI Native-Instructions Architecture](../references/AI%20Native-INSTRUCTIONS-ARCHITECTURE.md) and [Core Concepts](../references/ai%20native-concepts.md).

## 🎯 Complete Toolset Available

This workspace provides **29 Agent Primitives** organized into **four layers** of Copilot assistance leveraging the AI Native-Instructions Architecture:

### Layer 1: Auto-Applied Instructions (Always Active)
Located in `instructions/` - These **Agent Primitives** apply automatically based on file type via `applyTo` patterns:

- **al-guidelines.instructions.md** - Master hub referencing all guidelines (applies to `*.al`, `*.json`)
- **al-code-style.instructions.md** - Code formatting & structure (applies to `*.al`)
- **al-naming-conventions.instructions.md** - Naming rules (applies to `*.al`)
- **al-performance.instructions.md** - Performance optimization (applies to `*.al`)

### Layer 2: Contextual Instructions (Auto-Activate When Relevant)
Located in `instructions/` - These **Agent Primitives** activate based on context:

- **al-error-handling.instructions.md** - Error patterns, TryFunctions, telemetry (applies to `*.al`)
- **al-events.instructions.md** - Event-driven development patterns (applies to `*.al`)
- **al-testing.instructions.md** - Testing guidelines, AL-Go structure (applies to test files)

### Layer 3: Agentic Workflows (Explicit Invocation)
Located in `prompts/` - **Complete systematic processes** invoked with `@workspace use [prompt-name]`:

- `al-initialize` - Complete environment & workspace setup (consolidated setup + workspace)
- `al-diagnose` - Runtime debugging & configuration troubleshooting (consolidated debug + troubleshoot)
- `al-build` - Build & deployment workflows
- `al-events` - Event implementation
- `al-performance` - Deep performance analysis with CPU profiling
- `al-performance.triage` - Quick performance diagnosis and static analysis
- `al-permissions` - Permission management
- `al-migrate` - Version migration
- `al-pages` - Page designer & UI
- `al-spec.create` - Functional-technical specifications
- `al-pr-prepare` - Pull request preparation (streamlined template)
- `al-copilot-capability` - Register Copilot capability
- `al-copilot-promptdialog` - Create PromptDialog pages
- `al-copilot-test` - Test with AI Test Toolkit
- `al-translate` - XLF translation file management

### Layer 4: Chat Modes (Strategic Consulting)
Located in `chatmodes/` - **Role-based specialists** with MCP tool boundaries:

- **al-orchestrator** - Smart router, guides you to the right tool (ESSENTIAL)
- **al-architect** - Solution architecture & design
- **al-debugger** - Deep debugging & diagnosis
- **al-tester** - Testing strategy & TDD
- **al-api** - API development
- **al-copilot** - AI/Copilot feature development

## 🚀 Quick Start Guide

### For New AL Developers

1. **Start here**: Ask the **al-orchestrator** mode
   - It will analyze your request and route you to the right tool
   - Example: "I need to build a sales approval workflow"

2. **Let the auto-guidelines work**
   - As you code, auto-applied instructions (Layer 1 & 2) activate automatically
   - Copilot will suggest code that follows all rules

3. **Use prompts for specific tasks**
   - Setting up a project? → `@workspace use al-initialize`
   - Debugging? → `@workspace use al-diagnose`

### For Experienced AL Developers

1. **Modes for strategic work**
   - Designing architecture? → **al-architect** mode
   - Debugging complex issues? → **al-debugger** mode
   - Building APIs? → **al-api** mode

2. **Prompts for tactical execution**
   - Use task-specific prompts for workflows
   - They have access to AL tools (al_build, al_publish, etc.)

3. **Guidelines ensure quality**
   - Let auto-applied guidelines maintain standards
   - No need to remember all rules manually

## 🎓 Getting Started with Copilot

### Prerequisites
- Visual Studio Code with AL Language extension installed
- GitHub Copilot extension enabled
- Business Central sandbox environment for testing

### Setup Steps
1. Ensure Copilot is enabled in VS Code (View > Command Palette > GitHub Copilot: Enable)
2. Open an .al file to start receiving suggestions
3. Use the chat feature (Ctrl/Cmd + I) for complex queries
4. The AI Native-Instructions Architecture activates automatically as you work

### How the Layers Work Together

**While coding** (no action needed):
- Auto-applied instructions (Layer 1 & 2) activate automatically
- Code suggestions follow all standards
- Performance and naming conventions enforced

**For specific tasks** (explicit invocation):
```
@workspace use al-initialize   # Setup project
@workspace use al-diagnose     # Debug session
@workspace use al-build        # Deploy
```

**For strategic guidance** (mode switching):
```
Use al-architect mode          # Design solutions
Use al-debugger mode          # Investigate issues
Use al-orchestrator mode      # Route to right tool
```

## 💻 Code Generation Examples

### Creating AL Objects with Copilot

Copilot can generate complete AL objects following all layer guidelines automatically.

#### Example: Table with Validation
```al
// Ask Copilot: "Create a table for customer addresses with validation"
table 50100 "Customer Address"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
            NotBlank = true;
        }
        field(2; "Address Line 1"; Text[100])
        {
            Caption = 'Address Line 1';
        }
        field(3; "City"; Text[50])
        {
            Caption = 'City';
        }
        field(4; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
    }
    
    keys
    {
        key(PK; "Customer No.")
        {
            Clustered = true;
        }
    }
}
```
**Auto-applied**: al-code-style, al-naming-conventions, al-performance

#### Example: Event Subscriber
```al
// Ask: "Create event subscriber for customer validation"
[EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeValidateEvent', 'Email', false, false)]
local procedure ValidateCustomerEmail(var Rec: Record Customer)
begin
    if Rec.Email <> '' then
        if not Rec.Email.Contains('@') then
            Error('Email must contain @');
end;
```
**Auto-applied**: al-events.instructions.md, al-error-handling.instructions.md

#### Example: API Page
```al
// Ask: "Create API page for customer data"
page 50100 "Customer API"
{
    PageType = API;
    APIPublisher = 'contoso';
    APIGroup = 'sales';
    APIVersion = 'v1.0';
    EntityName = 'customer';
    EntitySetName = 'customers';
    SourceTable = Customer;
    DelayedInsert = true;
    
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(number; Rec."No.") { }
                field(name; Rec.Name) { }
                field(email; Rec.Email) { }
            }
        }
    }
}
```
**Suggested mode**: al-api for design, auto-guidelines for implementation

## 📝 Common Copilot Commands

Practical examples of what to ask Copilot:

### Object Creation
- "Create a codeunit for customer management with procedures for create, update, delete"
- "Generate a page extension for customer card adding address fields"
- "Create a list page for showing customer addresses"
- "Build a report for customer address labels"

### Logic Implementation
- "Implement validation for email field in customer table"
- "Add event subscriber for customer modification logging"
- "Create TryFunction for safe customer creation"
- "Implement field validation with Error() and FieldError()"

### Integration & APIs
- "Create API page for customer data exposure"
- "Implement webhook handler for external integrations"
- "Generate OAuth authentication for API"
- "Create API v2 page with OData annotations"

### Testing
- "Create test codeunit for customer validation"
- "Generate test data using Library - Sales codeunit"
- "Write Given/When/Then test for customer creation"

### Performance Optimization
- "Refactor this code to use SetLoadFields"
- "Optimize this loop to use set-based operations"
- "Add filtering before FindSet"

**Tip**: After asking, Copilot applies all 4 layers automatically!

## 📋 Common Scenarios & How to Use the Toolset

### Scenario 1: "I'm starting a new AL project"

```markdown
Step 1: Use al-orchestrator (if unsure) OR go directly to:
Step 2: @workspace use al-initialize
  → Guides through complete environment & workspace initialization
  → Downloads symbols
  → Configures dependencies
  
Auto-applied during setup:
  → al-code-style enforces structure
  → al-naming-conventions ensures proper names
```

### Scenario 2: "I need to design a new feature"

```markdown
Step 1: Switch to al-architect mode
  → Helps design solution architecture
  → Plans data model
  → Identifies integration points

Step 2: Implement with auto-guidelines active
  → al-code-style maintains formatting
  → al-performance suggests optimizations
  → al-events activates if using events

Step 3 (if needed): @workspace use al-events
  → Implements event subscribers/publishers
```

### Scenario 3: "I have a bug I can't figure out"

```markdown
Step 1: Use al-debugger mode
  → Systematic diagnosis
  → Root cause analysis

Step 2: @workspace use al-diagnose
  → Attaches debugger
  → Uses snapshot debugging if intermittent

Step 3 (if performance related): @workspace use al-performance
  → Generates CPU profile
  → Identifies bottlenecks
```

### Scenario 4: "I'm building an API"

```markdown
Step 1: al-architect mode (design API architecture)
Step 2: al-api mode (implement endpoints)
  → API page patterns
  → Authentication setup
  → Error handling

Auto-applied:
  → al-error-handling ensures proper error responses
  → al-naming-conventions for API objects
```

### Scenario 5: "I need to add tests"

```markdown
Step 1: al-tester mode (design test strategy)

Auto-applied:
  → al-testing.instructions.md activates
  → Enforces AL-Go structure (App vs Test separation)
  → Only generates tests when explicitly requested

Step 2: Implement tests with guidance
  → Use standard library codeunits
  → Follow Given/When/Then pattern
```

## 📖 Detailed Tool Reference

### Auto-Applied Guidelines

#### al-code-style.instructions.md
**Always active on `*.al` files**
- 2-space indentation
- PascalCase naming
- Feature-based folder organization
- XML documentation for public functions

#### al-naming-conventions.instructions.md
**Always active on `*.al` files**
- File naming: `ObjectName.ObjectType.al`
- Object names: Max 26 characters (+ 4 for prefix)
- Variables: PascalCase
- Event parameters: Descriptive names

#### al-performance.instructions.md
**Always active on `*.al` files**
- Early data filtering
- SetLoadFields usage
- Temporary tables/dictionaries/lists
- Avoid unnecessary loops

#### al-error-handling.instructions.md
**Activates when handling errors**
- TryFunctions for error handling
- Error labels (no hardcoded messages)
- Custom telemetry (when requested)
- Proper error propagation

#### al-events.instructions.md
**Activates when working with events**
- Event subscriber patterns
- Integration event creation
- Handler suffix naming
- Handled pattern implementation

#### al-testing.instructions.md
**Activates on test files and app.json**
- AL-Go workspace structure (App vs Test)
- Tests only generated when requested
- Standard library codeunit usage
- Given/When/Then naming

### Task-Specific Prompts

All prompts are invoked with: `@workspace use [prompt-name]`

#### al-initialize
**When**: Setting up new projects, configuring environments (consolidated al-setup + al-workspace)
**Tools**: al_new_project, al_go, al_download_symbols, al_get_package_dependencies

#### al-diagnose
**When**: Debugging issues, troubleshooting configurations (consolidated al-debug + al-troubleshoot)
**Tools**: al_debug_without_publish, al_initalize_snapshot_debugging, al_snapshots, al_clear_credentials_cache

#### al-build
**When**: Building, packaging, deploying extensions
**Tools**: al_build, al_package, al_publish, al_incremental_publish

#### al-events
**When**: Implementing event-driven logic
**Tools**: al_insert_event, al_open_Event_Recorder

#### al-performance
**When**: Deep performance analysis with CPU profiling
**Tools**: al_generate_cpu_profile_file, al_clear_profile_codelenses

#### al-performance.triage
**When**: Quick performance diagnosis and static analysis
**Tools**: Code analysis, FlowField optimization detection

#### al-permissions
**When**: Generating permission sets
**Tools**: al_generate_permissionset_for_extension_objects

#### al-migrate
**When**: Upgrading BC versions
**Tools**: al_download_source, al_get_package_dependencies, al_generate_manifest

#### al-pages
**When**: Designing pages with Page Designer
**Tools**: al_open_Page_Designer, al_build, al_incremental_publish

#### al-spec.create
**When**: Creating functional-technical specifications before development
**Tools**: Workspace analysis, requirements documentation

#### al-pr-prepare
**When**: Preparing pull requests with documentation and validation
**Tools**: Git analysis, test verification, documentation generation

#### al-copilot-capability
**When**: Registering new Copilot capability in BC
**Tools**: Enum extension, install codeunit, isolated storage setup

#### al-copilot-promptdialog
**When**: Creating PromptDialog pages for Copilot features
**Tools**: Page creation, Azure OpenAI integration

#### al-copilot-test
**When**: Testing Copilot features with AI Test Toolkit
**Tools**: Test creation, AI Test Toolkit integration

#### al-translate
**When**: Managing XLF translation files for multilingual support
**Tools**: XLF file manipulation, translation management

### Role-Based Chat Modes

#### al-orchestrator 🎯
**Your starting point when unsure**
- Analyzes your request
- Routes to appropriate mode or prompt
- Provides workflow roadmaps for complex tasks
- Acts as strategic guide

#### al-architect 🏗️
**Solution design specialist**
- Architecture planning
- Data model design
- Integration strategy
- Design pattern guidance
- Long-term maintainability

#### al-debugger 🐛
**Debugging & troubleshooting expert**
- Systematic issue diagnosis
- Root cause analysis
- Snapshot debugging for intermittent issues
- Performance bottleneck identification
- Evidence-based debugging

#### al-tester ✅
**Testing & quality assurance**
- Test-driven development (TDD)
- Test strategy design
- Coverage improvement
- Test pattern implementation
- Quality assurance practices

#### al-api 🌐
**API development specialist**
- RESTful API design
- OData endpoints
- API page implementation
- Authentication & security
- API versioning strategies

#### al-copilot 🤖
**AI feature development**
- Copilot experience design
- Azure OpenAI integration
- Prompt engineering
- Responsible AI implementation
- AI-powered user experiences

## 🎓 Best Practices for Copilot Interaction

### 1. Start with Context
✅ **Good**: "I'm building a customer approval workflow that needs to send notifications"
❌ **Avoid**: "Create a workflow"

### 2. Use the Right Tool for the Job

**For strategic questions** → Use modes (al-architect, al-debugger, etc.)
**For tactical tasks** → Use prompts (@workspace use al-[task])
**For normal coding** → Let auto-guidelines work in background

### 3. Be Specific with Prompts
✅ **Good**: "@workspace use al-events to create a subscriber for sales order posting"
❌ **Avoid**: "help with events"

### 4. Trust the Auto-Guidelines
The instruction files work automatically:
- You don't need to ask for proper naming (al-naming-conventions handles it)
- You don't need to request performance optimization (al-performance suggests it)
- Error handling patterns apply automatically (al-error-handling activates)

### 5. Leverage the Orchestrator
Not sure which tool to use?
```
User: "I need to build a feature but not sure how to start"
Copilot (orchestrator): "Let me analyze your needs and provide a roadmap..."
```

### 6. Review Generated Code
Always review Copilot suggestions:
- Verify compliance with project guidelines
- Test in sandbox environment
- Check security implications
- Validate performance impact

## 🔄 Common Workflows

### Workflow 1: Complete Feature Development
```markdown
1. al-orchestrator → Analyze requirements
2. al-architect → Design solution
3. @workspace use al-initialize → Setup (if needed)
4. Implement (auto-guidelines active)
5. @workspace use al-events → Add events
6. al-tester → Design tests
7. @workspace use al-permissions → Security
8. @workspace use al-build → Deploy
```

### Workflow 2: Bug Investigation
```markdown
1. al-debugger → Diagnose issue
2. @workspace use al-diagnose → Debug session
3. @workspace use al-performance → Profile (if slow)
4. Fix with auto-guidelines
5. al-tester → Regression tests
```

### Workflow 3: API Development
```markdown
1. al-architect → Design API architecture
2. al-api → Implement endpoints
3. @workspace use al-permissions → API security
4. al-tester → API testing
5. @workspace use al-build → Deploy
```

## 📚 Reference Documentation

### Microsoft Documentation
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [VS Code Copilot Guide](https://code.visualstudio.com/docs/copilot)
- [AL Language Reference](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-reference-overview)
- [Business Central Development](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/)

### This Project's Documentation
- [AL Development Overview](../al-development.md) - Framework architecture and overview
- [AI Native-Instructions Architecture](../references/AI%20Native-INSTRUCTIONS-ARCHITECTURE.md) - Implementation details
- [AI Native Structure](../references/ai%20native%20structure.md) - Getting started guide
- [AI Native Concepts](../references/ai%20native-concepts.md) - Core concepts and framework layers
- [Instructions Index](index.md) - Complete guide to all instruction files
- [AL Guidelines](al-guidelines.instructions.md) - Master guidelines

### Framework & Standards
- [AI Native-Instructions Architecture Guide](https://danielmeppiel.github.io/awesome-ai-native/)
- [AGENTS.md Standard](https://agents.md)
- [Context Engineering Patterns](https://danielmeppiel.github.io/awesome-ai-native/docs/concepts/)

## 🛠️ Troubleshooting Copilot

### No Suggestions Appearing
1. Check Copilot extension is enabled (View → Extensions)
2. Verify file type is `.al`
3. Check if guidelines are being applied (look for auto-formatting)
4. Try reloading VS Code window

### Suggestions Don't Follow Guidelines
1. Ensure instruction files are in correct locations
2. Check file glob patterns in instruction frontmatter
3. Try being more explicit in your request
4. Reference specific guidelines: "Follow al-code-style patterns"

### Performance Issues
1. Disable Copilot temporarily if causing lag
2. Use selective suggestion mode
3. Close unnecessary files
4. Reduce workspace size if very large

### Wrong Mode or Prompt Selected
- Use **al-orchestrator** to get routed correctly
- Be explicit: "Use al-architect mode for this"
- Reference prompts explicitly: "@workspace use al-debug"

## 📊 Tool Selection Decision Tree

```
Question or Task?
│
├─ Don't know where to start?
│  └─ al-orchestrator mode ✅
│
├─ Need to design/plan?
│  └─ al-architect mode
│
├─ Have a bug/error?
│  ├─ al-debugger mode (diagnosis)
│  └─ @workspace use al-debug (tools)
│
├─ Need tests?
│  ├─ al-tester mode (strategy)
│  └─ Auto: al-testing.instructions.md
│
├─ Building API?
│  └─ al-api mode
│
├─ Adding AI features?
│  └─ al-copilot mode
│
├─ Specific task?
│  └─ @workspace use al-[task]
│
└─ Just coding?
   └─ Auto-guidelines handle it ✨
```

## 🎯 Quick Commands Cheat Sheet

### Modes (Strategic)
- "Use al-orchestrator" - Route me to the right tool
- "Use al-architect" - Design my solution
- "Use al-debugger" - Help me debug
- "Use al-tester" - Testing strategy
- "Use al-api" - API development
- "Use al-copilot" - AI features

### Prompts (Tactical)
- `@workspace use al-initialize` - Setup project & environment
- `@workspace use al-diagnose` - Debug & troubleshoot
- `@workspace use al-build` - Build/deploy
- `@workspace use al-events` - Work with events
- `@workspace use al-performance` - Deep performance profiling
- `@workspace use al-performance.triage` - Quick performance check
- `@workspace use al-permissions` - Security
- `@workspace use al-migrate` - Upgrade version
- `@workspace use al-pages` - Design UI
- `@workspace use al-spec.create` - Create specifications
- `@workspace use al-pr-prepare` - Prepare pull request
- `@workspace use al-copilot-capability` - Register Copilot capability
- `@workspace use al-copilot-promptdialog` - Create PromptDialog
- `@workspace use al-copilot-test` - Test Copilot features
- `@workspace use al-translate` - Manage translations

### Auto-Active (Background)
- al-code-style ✅ Always
- al-naming-conventions ✅ Always
- al-performance ✅ Always
- al-error-handling ⚡ When handling errors
- al-events ⚡ When working with events
- al-testing ⚡ When in test files

## 💡 Tips for Maximum Productivity

1. **Start with the orchestrator** if you're ever unsure
2. **Let auto-guidelines work** - don't micromanage formatting
3. **Use modes for thinking**, prompts for doing
4. **Combine tools** - modes can recommend prompts
5. **Trust the system** - all layers work together
6. **Provide context** - the more Copilot knows, the better it helps

## � Workspace Structure

Understanding the folder organization helps you leverage the AI Native-Instructions Architecture:

```
AL-Development-Collection/
├── instructions/
│   ├── copilot-instructions.md          # This file - Master integration guide
│   ├── al-guidelines.instructions.md    # Master hub (applies to *.al, *.json)
│   ├── al-code-style.instructions.md    # Code formatting (applies to *.al)
│   ├── al-naming-conventions.instructions.md
│   ├── al-performance.instructions.md
│   ├── al-error-handling.instructions.md
│   ├── al-events.instructions.md
│   └── al-testing.instructions.md       # Testing (applies to test files)
├── prompts/                              # Agentic Workflows (15 primitives)
│   ├── al-initialize.prompt.md          # Environment & workspace setup (consolidated)
│   ├── al-diagnose.prompt.md            # Debug & troubleshoot (consolidated)
│   ├── al-build.prompt.md
│   ├── al-events.prompt.md
│   ├── al-performance.prompt.md
│   ├── al-performance.triage.prompt.md
│   ├── al-permissions.prompt.md
│   ├── al-migrate.prompt.md
│   ├── al-pages.prompt.md
│   ├── al-spec.create.prompt.md
│   ├── al-pr-prepare.prompt.md
│   ├── al-copilot-capability.prompt.md
│   ├── al-copilot-promptdialog.prompt.md
│   ├── al-copilot-test.prompt.md
│   └── al-translate.prompt.md
├── chatmodes/                            # Chat Modes with MCP tool boundaries
│   ├── al-orchestrator.chatmode.md      # Smart router (START HERE)
│   ├── al-architect.chatmode.md         # Architecture & design
│   ├── al-debugger.chatmode.md          # Deep debugging
│   ├── al-tester.chatmode.md            # Testing strategy
│   ├── al-api.chatmode.md               # API development
│   └── al-copilot.chatmode.md           # AI features
├── references/                           # Framework documentation
│   ├── AI Native-INSTRUCTIONS-ARCHITECTURE.md
│   ├── ai native structure.md
│   └── ai native-concepts.md
├── src/                                  # Your AL code here
│   ├── Tables/
│   ├── Pages/
│   ├── Codeunits/
│   └── ...
├── al-development.md                     # Framework overview
├── app.json
└── README.md
```

### How Agent Primitives Are Used

**Instructions** (`.instructions.md`):
- Auto-loaded based on file type via `applyTo` patterns
- Apply silently in the background (Context Engineering)
- No explicit invocation needed
- Form the foundation of Layer 1 & 2

**Agentic Workflows** (`.prompt.md`):
- Invoked with `@workspace use [name]`
- Provide complete systematic processes (Layer 3)
- Have access to AL tools
- Orchestrate multiple primitives into end-to-end solutions

**Chatmodes** (`.chatmode.md`):
- Switched via "Use [mode-name] mode"
- 6 role-based strategic specialists with MCP tool boundaries (Layer 4)
- Can recommend prompts and instructions
- Orchestrator is essential for routing

## �📝 Feedback & Iteration

This workspace configuration evolves based on usage. If you find:
- Suggestions don't meet expectations → Try rephrasing or use a different mode
- Missing functionality → Suggest new prompts or modes
- Conflicting guidance → Report for clarification

Remember: **You have 29 Agent Primitives working together to make AL development easier, faster, and better!**

---

**Framework**: [AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)  
**Version**: 2.2.0  
**Last Updated**: 2025-10-23  
**Workspace**: AL Development for Business Central  
**Total Primitives**: 28 (7 instructions + 14 workflows + 6 modes + 1 guide)  
**Status**: ✅ Fully compliant with AI Native-Instructions Architecture