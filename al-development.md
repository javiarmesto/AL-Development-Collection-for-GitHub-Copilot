# AL Development for Business Central

A comprehensive toolkit for Microsoft Dynamics 365 Business Central AL development, providing multi-layered assistance through auto-applied coding standards, task-specific workflows, and specialized consultant modes.

## What's Included

This collection provides **25 specialized tools** organized in four layers:

### Layer 1: Auto-Applied Instructions (Always Active)
These instructions apply automatically when working with AL code:
- **al-guidelines** - Master development principles
- **al-code-style** - Code formatting and structure
- **al-naming-conventions** - Naming standards for objects and variables
- **al-performance** - Performance optimization patterns

### Layer 2: Contextual Instructions (Activate When Relevant)
These activate based on what you're doing:
- **al-error-handling** - Error patterns and TryFunctions
- **al-events** - Event-driven development
- **al-testing** - Testing guidelines and AL-Go structure

### Layer 3: Task-Specific Prompts (10 Workflow Guides)
Invoke with `@workspace use [prompt-name]`:
- **al-workspace** - Project setup and configuration
- **al-build** - Build and deployment workflows
- **al-events** - Event implementation
- **al-debug** - Debugging sessions
- **al-performance** - Performance analysis
- **al-permissions** - Permission management
- **al-troubleshoot** - Common problem solving
- **al-migrate** - Version migration
- **al-pages** - Page designer and UI
- **al-workflow** - End-to-end guidance

📖 **See [PROMPTS.md](./PROMPTS.md) for detailed parameter documentation and usage examples for each prompt.**

### Layer 4: Role-Based Chat Modes (6 Specialist Consultants)
Switch modes for strategic consulting:
- **al-orchestrator** 🎯 - Smart router and strategic guide
- **al-architect** 🏗️ - Solution architecture and design
- **al-debugger** 🐛 - Debugging and troubleshooting
- **al-tester** ✅ - Testing strategy and TDD
- **al-api** 🌐 - API development
- **al-copilot** 🤖 - AI/Copilot feature development

## Quick Start

### For New AL Developers

1. **Start with the orchestrator**
   ```
   Switch to al-orchestrator mode and ask:
   "I need to build a sales approval workflow. Where should I start?"
   ```

2. **Let auto-instructions work**
   - As you code, Layer 1 & 2 instructions apply automatically
   - Code suggestions follow all standards without asking

3. **Use prompts for tasks**
   ```
   @workspace use al-workspace  # Setup project
   @workspace use al-build      # Deploy
   ```

### For Experienced Developers

1. **Use modes for strategic work**
   - **al-architect** - Design new features
   - **al-debugger** - Investigate complex bugs
   - **al-api** - Build integrations

2. **Use prompts for execution**
   - Quick workflows for common tasks
   - Access to AL tools (al_build, al_publish, etc.)

3. **Trust the guidelines**
   - Auto-applied standards maintain quality
   - Focus on business logic, not formatting

## Common Workflows

### Building a New Feature
```
1. al-orchestrator → Analyze requirements
2. al-architect → Design architecture
3. @workspace use al-workspace → Setup (if needed)
4. Code (auto-guidelines active)
5. @workspace use al-events → Add events
6. al-tester → Test strategy
7. @workspace use al-permissions → Security
8. @workspace use al-build → Deploy
```

### Debugging Issues
```
1. al-debugger → Systematic diagnosis
2. @workspace use al-debug → Debug tools
3. @workspace use al-performance → Profile (if slow)
4. Fix (auto-guidelines active)
5. al-tester → Regression tests
```

### API Development
```
1. al-architect → Design API
2. al-api → Implement endpoints
3. @workspace use al-permissions → Security
4. al-tester → API tests
5. @workspace use al-build → Deploy
```

## Key Features

### Auto-Applied Code Standards
- **Feature-based organization** - Not by object type
- **PascalCase naming** - Enforced automatically
- **Performance patterns** - Early filtering, SetLoadFields
- **Event-driven** - Never modify standard objects
- **26-character limit** - For object names

### AL Tool Integration
All prompts have access to specialized AL tools:
- `al_new_project`, `al_go` - Project initialization
- `al_build`, `al_package`, `al_publish` - Build/deploy
- `al_debug_without_publish`, `al_snapshots` - Debugging
- `al_open_Page_Designer`, `al_insert_event` - Development
- `al_generate_cpu_profile_file` - Performance
- `al_generate_permissionset_for_extension_objects` - Security

### Intelligent Routing
The **al-orchestrator** mode analyzes your request and provides:
- Mode recommendations for your scenario
- Multi-phase workflows for complex tasks
- Time estimates and success criteria
- Alternative approaches with trade-offs

## Best Practices

### When to Use Each Layer

**Layer 1 & 2 (Auto-Instructions)**
- Always active in background
- No need to reference manually
- Enforces standards automatically

**Layer 3 (Prompts)**
- Specific tasks: setup, build, debug, etc.
- Access to AL tools
- Step-by-step workflows

**Layer 4 (Chat Modes)**
- Strategic planning and design
- Complex problem diagnosis
- Expert consultation
- When you need to think, not do

### Getting the Best Results

1. **Start with context** - More info = better help
2. **Use the right layer** - Tasks vs. strategy
3. **Trust auto-guidelines** - They work in background
4. **Combine tools** - Modes can recommend prompts
5. **Ask the orchestrator** - When unsure

## Examples

### Example 1: New Developer Starting

```markdown
User: "I'm new to AL. How do I start?"

al-orchestrator responds:
"Let's get you set up for AL development. Here's your path:

Phase 1: Environment Setup
- Use @workspace use al-workspace
- This will initialize your project and download symbols

Phase 2: Learn the Basics
- al-code-style.instructions.md teaches formatting (auto-applies)
- al-naming-conventions.instructions.md for naming rules
- Try creating a simple table extension

Phase 3: First Feature
- Use al-architect mode to plan it
- Code with auto-guidelines helping
- Use al-tester mode for tests

Would you like to start with Phase 1?"
```

### Example 2: Experienced Developer with Complex Task

```markdown
User: "Build AI-powered API for sales forecasting"

al-orchestrator analyzes:
"This is a complex multi-domain project requiring:
- Architecture planning
- API development
- AI integration
- Testing

Recommended 4-phase approach:

Phase 1: Architecture (al-architect mode)
- Design how AI and API layers interact
- Data flow and caching strategy
- Duration: 3-4 hours

Phase 2A & 2B: Parallel Development
- 2A: al-api mode (API endpoints)
- 2B: al-copilot mode (AI features)
- Duration: 1 day each

Phase 3: Integration (@workspace use al-build)
Phase 4: Testing (al-tester mode)

Ready to start with Phase 1 architecture?"
```

### Example 3: Debugging Performance Issue

```markdown
User: "My report is very slow with large datasets"

al-debugger mode:
"Let's diagnose this systematically.

Step 1: Profile the code
@workspace use al-performance
→ Generates CPU profile
→ Identifies bottleneck

Step 2: Analyze findings
Based on profile, likely causes:
- Inefficient query (missing keys)
- Nested loops with DB calls
- FlowField calculations

Step 3: Implement fixes
I'll suggest optimizations:
- Add appropriate table key
- Use temporary table for intermediate data
- SetLoadFields for partial records

Step 4: Verify improvement
Re-profile after changes
Compare before/after metrics

What does the CPU profile show?"
```

## Requirements

- Visual Studio Code with AL Language extension
- GitHub Copilot enabled
- Business Central development environment (sandbox recommended)
- Basic understanding of AL programming language

## Tips for Success

1. **Use al-orchestrator when stuck** - It routes you correctly
2. **Read auto-applied instruction files** - Understand the standards
3. **Combine modes and prompts** - They work together
4. **Provide file context** - Include relevant code
5. **Be specific in requests** - Better input = better output

## Contributing

Found an issue or have a suggestion? This collection improves through use:
- Report unclear guidance
- Suggest new prompts for common tasks
- Propose new modes for specialized scenarios
- Share successful patterns

## Version

**Version**: 2.0  
**Last Updated**: 2025-01-15  
**Author**: javiarmesto  
**Total Tools**: 25 (7 instructions + 10 prompts + 6 modes + integration docs)

## Related Resources

- [Microsoft AL Language Documentation](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/)
- [Business Central Development](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)