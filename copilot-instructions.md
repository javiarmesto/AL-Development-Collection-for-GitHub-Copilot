<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# GitHub Copilot Instructions for AL Development

## Overview
This workspace contains AL (Application Language) code for Microsoft Dynamics 365 Business Central. GitHub Copilot is configured with a **comprehensive suite of guidelines, prompts, and specialized modes** to assist with AL development following Microsoft's best practices and this project's specific standards.

## 🎯 Complete Toolset Available

This workspace provides **four layers** of Copilot assistance:

### Layer 1: Auto-Applied Guidelines (Always Active)
Located in `.github/instructions/` - These apply automatically based on file type:

- **al-guidelines.instructions.md** - Master hub referencing all guidelines
- **al-code-style.instructions.md** - Code formatting & structure (applies to `*.al`)
- **al-naming-conventions.instructions.md** - Naming rules (applies to `*.al`)
- **al-performance.instructions.md** - Performance optimization (applies to `*.al`)

### Layer 2: Contextual Guidelines (Auto-Activate When Relevant)
Located in `.github/instructions/` - These activate based on context:

- **al-error-handling.instructions.md** - Error patterns, TryFunctions, telemetry
- **al-events.instructions.md** - Event-driven development patterns
- **al-testing.instructions.md** - Testing guidelines, AL-Go structure

### Layer 3: Task-Specific Prompts (Explicit Invocation)
Located in `.github/copilot-prompts/` - Invoke with `@workspace use [prompt-name]`:

- `al-workspace` - Project setup & configuration
- `al-build` - Build & deployment workflows
- `al-events` - Event implementation
- `al-debug` - Debugging sessions
- `al-performance` - Performance analysis
- `al-permissions` - Permission management
- `al-troubleshoot` - Common problem solving
- `al-migrate` - Version migration
- `al-pages` - Page designer & UI
- `al-workflow` - End-to-end guidance

### Layer 4: Role-Based Chat Modes (Strategic Consulting)
Located in `modes/` - Specialized consultant personalities:

- **al-orchestrator** - Smart router, guides you to the right tool
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
   - As you code, Layer 1 & 2 guidelines apply automatically
   - Copilot will suggest code that follows all rules

3. **Use prompts for specific tasks**
   - Setting up a project? → `@workspace use al-workspace`
   - Debugging? → `@workspace use al-debug`

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

## 📋 Common Scenarios & How to Use the Toolset

### Scenario 1: "I'm starting a new AL project"

```markdown
Step 1: Use al-orchestrator (if unsure) OR go directly to:
Step 2: @workspace use al-workspace
  → Guides through project initialization
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

Step 2: @workspace use al-debug
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

#### al-workspace
**When**: Setting up new projects, configuring environments
**Tools**: al_new_project, al_go, al_download_symbols, al_get_package_dependencies

#### al-build
**When**: Building, packaging, deploying extensions
**Tools**: al_build, al_package, al_publish, al_incremental_publish

#### al-events
**When**: Implementing event-driven logic
**Tools**: al_insert_event, al_open_Event_Recorder

#### al-debug
**When**: Debugging issues
**Tools**: al_debug_without_publish, al_initalize_snapshot_debugging, al_snapshots

#### al-performance
**When**: Optimizing code, profiling
**Tools**: al_generate_cpu_profile_file, al_clear_profile_codelenses

#### al-permissions
**When**: Generating permission sets
**Tools**: al_generate_permissionset_for_extension_objects

#### al-troubleshoot
**When**: Solving authentication, symbol, build issues
**Tools**: al_clear_credentials_cache, al_download_symbols, al_download_source

#### al-migrate
**When**: Upgrading BC versions
**Tools**: al_download_source, al_get_package_dependencies, al_generate_manifest

#### al-pages
**When**: Designing pages with Page Designer
**Tools**: al_open_Page_Designer, al_build, al_incremental_publish

#### al-workflow
**When**: Need end-to-end guidance for complete features
**Tools**: Multiple tools across the development lifecycle

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
3. @workspace use al-workspace → Setup (if needed)
4. Implement (auto-guidelines active)
5. @workspace use al-events → Add events
6. al-tester → Design tests
7. @workspace use al-permissions → Security
8. @workspace use al-build → Deploy
```

### Workflow 2: Bug Investigation
```markdown
1. al-debugger → Diagnose issue
2. @workspace use al-debug → Debug session
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
- [Collection Summary](./COLLECTION-SUMMARY.md) - Complete tool overview
- [AL Guidelines](./.github/instructions/al-guidelines.instructions.md) - Master guidelines
- [All Instructions](./.github/instructions/) - Detailed rule sets

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
- `@workspace use al-workspace` - Setup project
- `@workspace use al-build` - Build/deploy
- `@workspace use al-events` - Work with events
- `@workspace use al-debug` - Debug tools
- `@workspace use al-performance` - Optimize
- `@workspace use al-permissions` - Security
- `@workspace use al-troubleshoot` - Fix issues
- `@workspace use al-migrate` - Upgrade version
- `@workspace use al-pages` - Design UI
- `@workspace use al-workflow` - Complete guidance

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

## 📝 Feedback & Iteration

This workspace configuration evolves based on usage. If you find:
- Suggestions don't meet expectations → Try rephrasing or use a different mode
- Missing functionality → Suggest new prompts or modes
- Conflicting guidance → Report for clarification

Remember: **You have 24 specialized tools working together to make AL development easier, faster, and better!**

---

**Version**: 2.0  
**Last Updated**: 2025-01-15  
**Workspace**: AL Development for Business Central  
**Total Tools**: 24 (1 guide + 7 instructions + 10 prompts + 6 modes)