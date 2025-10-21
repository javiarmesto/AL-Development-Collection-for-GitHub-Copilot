# AL Development for Business Central

**AI Native AL Development** toolkit for Microsoft Dynamics 365 Business Central implementing the **[AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)** framework. Transform ad-hoc AI usage into systematic engineering through **28 Agent Primitives** across **3 framework layers**.

## Framework Architecture

This collection implements the **AI Native-Instructions Architecture** with three systematic layers:

### Layer 1: Markdown Prompt Engineering
**Foundation** - Structured instructions using semantic markdown (headers, lists, links) that guide AI reasoning for predictable, repeatable results.

### Layer 2: Agent Primitives  
**Implementation** - 28 configurable tools that deploy your prompt engineering systematically:
- **📋 Instructions** (7) - Auto-applied coding rules via `applyTo` patterns
- **🎯 Agentic Workflows** (14) - Complete task execution processes
- **💬 Chat Modes** (6) - Role-based specialists with tool boundaries
- **📖 Integration Guide** (1) - Master coordination document

### Layer 3: Context Engineering
**Strategic Management** - Optimized LLM context windows through modular loading, `applyTo` patterns, and AGENTS.md compilation readiness.

## What's Included: The 28 Agent Primitives

### 📋 Instructions Files (7 primitives)

**Auto-applied persistent rules** via `applyTo` patterns for optimal **Context Engineering**:

**Always Active** (`applyTo: **/*.al`):
- **al-guidelines** - Master hub referencing all development patterns
- **al-code-style** - Feature-based organization, 2-space indentation, XML docs
- **al-naming-conventions** - PascalCase, 26-character limits, descriptive names
- **al-performance** - Early filtering, SetLoadFields, temporary tables, set-based ops

**Context-Activated** (trigger on specific contexts):
- **al-error-handling** - TryFunctions, error labels, telemetry patterns
- **al-events** - Event subscribers, integration events, handled patterns
- **al-testing** - AL-Go structure, test generation rules, Given/When/Then

> 💡 **Context Engineering in Action**: Instructions load only when relevant via `applyTo` frontmatter, preserving context window space for code understanding.

### 🎯 Agentic Workflows (14 primitives)

**Complete systematic processes** as `.prompt.md` files with validation gates:

Invoke with `@workspace use [prompt-name]`:
- **al-setup** - AI-assisted environment configuration
- **al-workspace** - Project initialization with symbol download
- **al-build** - Build, package, publish workflows with AL tools
- **al-events** - Event subscriber/publisher implementation
- **al-debug** - Debugging with snapshot support
- **al-performance** - Profiling and bottleneck analysis
- **al-permissions** - Permission set generation from objects
- **al-troubleshoot** - Systematic problem resolution workflows
- **al-migrate** - BC version upgrade assistance
- **al-pages** - Page Designer integration workflows
- **al-workflow** - Complete feature lifecycle from design to deploy
- **al-spec.create** - Functional-technical specification generation
- **al-performance.triage** - Performance bottleneck prioritization
- **al-pr.prepare** - Pull request preparation with documentation

> 💡 **Agentic Workflows**: Prompts orchestrate all primitives (instructions, modes, tools) into end-to-end processes with human validation checkpoints.

### 💬 Chat Modes (6 primitives)

**Role-based specialists** with MCP tool boundaries preventing cross-domain security breaches:

- **al-orchestrator** 🎯 - Smart router, workflow coordinator (START HERE)
- **al-architect** 🏗️ - Solution architecture design (cannot execute builds)
- **al-debugger** 🐛 - Deep systematic diagnosis and troubleshooting
- **al-tester** ✅ - Testing strategy, TDD methodology, quality assurance
- **al-api** 🌐 - RESTful API design and implementation
- **al-copilot** 🤖 - AI-powered Copilot feature development

> 💡 **Tool Boundaries**: Like professional licensing, each mode has explicit CAN/CANNOT lists preventing dangerous cross-domain operations.

### 📖 Integration Guide (1 primitive)

- **copilot-instructions.md** - Master document coordinating all 27 primitives with comprehensive usage guidance and workflow examples

## Quick Start

### For New AL Developers

1. **Start with the orchestrator**

   ```markdown
   Switch to al-orchestrator mode and ask:
   "I need to build a sales approval workflow. Where should I start?"
   ```

2. **Let auto-instructions work**
   - As you code, Layer 1 & 2 instructions apply automatically
   - Code suggestions follow all standards without asking

3. **Use prompts for tasks**

   ```bash
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

```text
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

```text
1. al-debugger → Systematic diagnosis
2. @workspace use al-debug → Debug tools
3. @workspace use al-performance → Profile (if slow)
4. Fix (auto-guidelines active)
5. al-tester → Regression tests
```

### API Development

```text
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

## Best Practices: AI Native Development

### Understanding the Framework Layers

**Layer 1: Markdown Prompt Engineering**

- Structured instructions embedded in all primitives
- Semantic markdown (headers, lists, links) guides AI reasoning
- Context loading via links to relevant files
- Precision language eliminates ambiguity

**Layer 2: Agent Primitives Usage**

📋 **Instructions** (auto-active background enforcement):

- Load automatically via `applyTo` patterns
- No manual invocation needed
- Maintain standards without cognitive overhead
- Trust the system - it's working silently

🎯 **Agentic Workflows** (explicit task execution):
- Use for specific development tasks
- Access to AL tools (build, debug, profile)
- Step-by-step systematic processes
- Built-in human validation checkpoints

💬 **Chat Modes** (strategic consulting):
- Switch for architecture and design work
- Complex problem diagnosis and analysis
- Expert consultation on approaches
- Use when you need to think, not execute

**Layer 3: Context Engineering**
- Instructions use `applyTo` for selective loading
- Preserves context window for code understanding
- Ready for AGENTS.md compilation for universal portability
- Modular architecture scales with project complexity

### Getting Maximum Value

1. **Start with al-orchestrator** - Routes you to right primitive
2. **Provide rich context** - More information = better guidance
3. **Trust instruction primitives** - They work automatically
4. **Combine primitives** - Modes recommend workflows, workflows use instructions
5. **Leverage framework layers** - Right tool for right situation

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

## Framework Compliance

**Framework**: [AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)  
**Version**: 2.2.0  
**Last Updated**: 2025-10-19  
**Author**: javiarmesto  
**Total Primitives**: 28 (7 instructions + 14 workflows + 6 modes + 1 guide)  
**Status**: ✅ Fully compliant with AI Native-Instructions Architecture

### Framework Implementation
- ✅ **Layer 1: Markdown Prompt Engineering** - Structured semantic markdown
- ✅ **Layer 2: Agent Primitives** - 28 configurable tools
- ✅ **Layer 3: Context Engineering** - Modular `applyTo` patterns
- ✅ **AGENTS.md Ready** - Prepared for universal context compilation
- ✅ **Validation Passing** - All 34 compliance checks

## Related Resources

### Framework & Standards
- [AI Native-Instructions Architecture Guide](https://danielmeppiel.github.io/awesome-ai-native/)
- [AGENTS.md Standard](https://agents.md)
- [Context Engineering Patterns](https://danielmeppiel.github.io/awesome-ai-native/docs/concepts/)

### Microsoft Business Central
- [AL Language Documentation](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/)
- [Business Central Development](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)