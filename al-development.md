# AL Development for Business Central

**AI Native AL Development** toolkit for Microsoft Dynamics 365 Business Central implementing the **[AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)** framework. Transform ad-hoc AI usage into systematic engineering through **37 Agent Primitives** across **3 framework layers**.

## Framework Architecture

This collection implements the **AI Native-Instructions Architecture** with three systematic layers:

### Layer 1: Markdown Prompt Engineering
**Foundation** - Structured instructions using semantic markdown (headers, lists, links) that guide AI reasoning for predictable, repeatable results.

### Layer 2: Agent Primitives  
**Implementation** - 37 configurable tools that deploy your prompt engineering systematically:
- **📋 Instructions** (9) - Auto-applied coding rules via `applyTo` patterns
- **🎯 Agentic Workflows** (18) - Complete task execution processes
- **💬 Agents** (6) - Role-based specialists with tool boundaries
- **🎭 Orchestra System** (4) - Multi-agent TDD orchestration

**🎭 Orchestra System** (4 agents) - Multi-agent TDD orchestration for MEDIUM/HIGH complexity:
- **al-conductor** - Main orchestration agent coordinating Planning → Implementation → Review
- **al-planning-subagent** - AL-aware research specialist
- **al-implement-subagent** - TDD-focused implementation (Haiku 4.5 for cost optimization)
- **al-review-subagent** - Code review validation

### Layer 3: Context Engineering
**Strategic Management** - Optimized LLM context windows through modular loading, `applyTo` patterns, and AGENTS.md compilation readiness.

## What's Included: The 38 Agent Primitives

### 📋 Instructions Files (9 primitives - Layer 2)

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

**Integration & Documentation**:
- **copilot-instructions** - Master coordination document (auto-loaded as .github/copilot-instructions.md)
- **complete-development-flow** - Visual workflow guide with Mermaid diagrams

> 💡 **Context Engineering in Action**: Instructions load only when relevant via `applyTo` frontmatter, preserving context window space for code understanding.

### 🎯 Agentic Workflows (18 primitives - Layer 2)

**Complete systematic processes** as `.prompt.md` files with validation gates:

Invoke with `@workspace use [prompt-name]`:
- **al-initialize** - Complete environment & workspace setup (consolidated setup + workspace)
- **al-diagnose** - Runtime debugging & configuration troubleshooting (consolidated debug + troubleshoot)
- **al-build** - Build, package, publish workflows with AL tools
- **al-events** - Event subscriber/publisher implementation
- **al-performance** - Deep performance analysis with CPU profiling
- **al-performance.triage** - Quick performance diagnosis and static analysis
- **al-permissions** - Permission set generation from objects
- **al-migrate** - BC version upgrade assistance
- **al-pages** - Page Designer integration workflows
- **al-spec.create** - Functional-technical specification generation
- **al-pr-prepare** - Pull request preparation (streamlined template)
- **al-translate** - XLF translation file management
- **al-context.create** - Generate project context.md file for AI assistants
- **al-memory.create** - Generate/update memory.md for session continuity
- **al-copilot-capability** - Register Copilot capability with enum extension
- **al-copilot-promptdialog** - Create PromptDialog pages with all areas
- **al-copilot-test** - Comprehensive testing with AI Test Toolkit
- **al-copilot-generate** - Generate Copilot code from natural language

> 💡 **Agentic Workflows**: Prompts orchestrate all primitives (instructions, modes, tools) into end-to-end processes with human validation checkpoints.

### 💬 Agents (6 primitives - Layer 2)

**Role-based specialists** with MCP tool boundaries preventing cross-domain security breaches:

- **al-architect** 🏗️ - Solution architecture design, entry point for new features
- **al-developer** 💻 - Tactical implementation with full build tool access
- **al-debugger** 🐛 - Deep systematic diagnosis and troubleshooting
- **al-tester** ✅ - Testing strategy, TDD methodology, quality assurance
- **al-api** 🌐 - RESTful API design and implementation
- **al-copilot** 🤖 - AI-powered Copilot feature development

> 💡 **Tool Boundaries**: Like professional licensing, each mode has explicit CAN/CANNOT lists preventing dangerous cross-domain operations.

### 🎭 Orchestra System (4 primitives - Layer 2)

**Multi-agent TDD orchestration** for MEDIUM/HIGH complexity features (specialized feature of this repository):

- **al-conductor** 🎭 - Main orchestration agent coordinating Planning → Implementation → Review
- **al-planning-subagent** 🔍 - AL-aware research specialist (BC objects, events, patterns)
- **al-implement-subagent** 💻 - TDD-focused implementation with full AL MCP tools (Haiku 4.5)
- **al-review-subagent** ✅ - Code review validation against AL best practices

**Key Features**:
- Strict TDD cycle enforcement (RED → GREEN → REFACTOR)
- Event-driven validation (prevents base object modifications)
- Auto-documentation in `.github/plans/`
- Quality gates before each commit
- Cost-optimized (30-40% reduction vs full Sonnet)

> 💡 **When to Use**: MEDIUM complexity (2-3 phases) or HIGH complexity (4+ phases) features requiring systematic TDD approach.

### 📋 Agent Context & Memory System (NEW in v2.7 - Layer 3)

**Centralized documentation system** ensuring all agents share context and maintain consistency:

**Documentation Location**: `.github/plans/`

**Core Documents**:
- **`architecture.md`** - System architecture decisions and patterns
- **`spec.md`** - Functional and technical specifications
- **`test-plan.md`** - Test strategy and coverage requirements
- **`memory.md`** - Session history and decision rationale

**Agent Integration**:

**Orchestra Agents** (context-aware collaboration):
- **al-conductor**: Reads architecture/spec upfront, passes context to subagents
- **al-planning-subagent**: Documents research findings for conductor's plan creation
- **al-implement-subagent**: Aligns implementation with architecture/spec/test-plan
- **al-review-subagent**: Validates compliance against all context documents

**Specialist Agents** (context-aware design):
- **al-developer**: Reads all context docs before coding, ensures consistency
- **al-api**: Produces `<endpoint>-api-design.md` documenting contracts and integration
- **al-copilot**: Generates `<feature>-copilot-ux-design.md` covering AI prompts and UX

**Key Benefits**:
- ✅ **Consistency**: All agents reference the same architectural decisions
- 📚 **Knowledge Transfer**: New agents inherit project context automatically
- 🔄 **Session Continuity**: Memory system preserves decisions across interactions
- 🎯 **Quality Assurance**: Review validates against documented requirements
- 📖 **Auto-Documentation**: Design decisions captured for team reference

**Workflow Example**:
```markdown
1. Use al-architect mode → Creates architecture.md
2. @workspace use al-spec.create → Generates spec.md
3. Use al-conductor mode → Reads docs, implements with subagents
4. al-review-subagent → Validates against architecture.md + spec.md
5. Result: Consistent implementation aligned with design
```

> 💡 **Best Practice**: Always create architecture.md and spec.md before using al-conductor for medium/high complexity features.

### 📖 Integration Guide (1 primitive - Layer 2)

- **copilot-instructions.md** - Master document coordinating all 38 primitives with comprehensive usage guidance and workflow examples

## Quick Start

### For New AL Developers

1. **Start with al-architect**

   ```markdown
   Switch to al-architect mode and ask:
   "I need to build a sales approval workflow. How should I design it?"
   ```

2. **Let auto-instructions work**
   - As you code, Layer 1 & 2 instructions apply automatically
   - Code suggestions follow all standards without asking

3. **Use prompts for tasks**

   ```bash
   @workspace use al-initialize  # Setup project
   @workspace use al-build       # Deploy
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

**Simple (🟢 LOW)**:
```text
1. al-developer → Direct implementation
2. @workspace use al-build → Deploy
```

**Moderate (🟡 MEDIUM)**:
```text
1. al-architect → Design architecture
2. al-conductor → TDD orchestration (Planning → Implement → Review)
3. @workspace use al-permissions → Security
4. @workspace use al-build → Deploy
```

**Complex (🔴 HIGH)**:
```text
1. al-architect → Complete architecture design
2. al-api/al-copilot → Specialized design (if needed)
3. al-conductor → Multi-phase TDD implementation
4. @workspace use al-performance → Validation
5. @workspace use al-build → Deploy
```

### Debugging Issues

```text
1. al-debugger → Systematic diagnosis
2. @workspace use al-diagnose → Debug & troubleshoot
3. al-developer → Fix implementation (NEW)
4. al-tester → Regression tests
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
The **al-architect** mode analyzes your request and provides:
- Solution design recommendations for your scenario
- Multi-phase workflows for complex tasks
- Integration strategies and patterns
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

💬 **Agents** (strategic consulting):
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

1. **Start with al-architect** - Designs your solution architecture
2. **Provide rich context** - More information = better guidance
3. **Trust instruction primitives** - They work automatically
4. **Combine primitives** - Modes recommend workflows, workflows use instructions
5. **Leverage framework layers** - Right tool for right situation

## Examples

### Example 1: New Developer Starting

```markdown
User: "I'm new to AL. How do I start?"

al-architect responds:
"Let's get you set up for AL development. Here's your path:

Phase 1: Environment Setup
- Use @workspace use al-initialize
- This will initialize your project and download symbols

Phase 2: Learn the Basics
- al-code-style.instructions.md teaches formatting (auto-applies)
- al-naming-conventions.instructions.md for naming rules
- Try creating a simple table extension

Phase 3: First Feature
- I'll help you design it
- Code with auto-guidelines helping
- Use al-tester mode for tests

Would you like to start with Phase 1?"
```

### Example 2: Experienced Developer with MEDIUM Complexity Task

```markdown
User: "Build customer loyalty points system"

al-architect analyzes:
"Let me assess the complexity:

Scope Assessment:
- Scope: Moderate (Customer + Sales + Loyalty domains)
- Integration: Internal (OnAfterPostSalesDoc event)
- Logic: Moderate (calculations, redemptions)
- Phases: 6-7
- Impact: Medium

🚦 VALIDATION GATE:
📊 Inferred Complexity: 🟡 MEDIUM
Recommended Path: al-architect (design) → al-conductor (TDD)

Confirm classification? [Yes/Adjust]"

User confirms, then workflow:

Phase 1: Architecture (al-architect mode - 20 min)
- Event-driven design
- Data model (2 tables + extensions)
- Integration points

Phase 2: TDD Implementation (al-conductor mode - 90 min)
- Planning subagent: Researches BC objects
- Creates 6-phase plan
- Implement subagent executes each phase:
  * Phase 1: Core tables (RED → GREEN → REFACTOR)
  * Phase 2-6: Customer integration, calculations, UI
- Review subagent validates quality gates
- Auto-generates documentation

Result: 10 AL objects, 63 tests (100% passing), production-ready

Total time: 2 hours (vs 2 days manual)"
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
- Use temporary table for interMEDIUMte data
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

1. **Use al-architect for new features** - It designs your solution
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
**Version**: 2.8.0  
**Last Updated**: 2025-11-25  
**Author**: javiarmesto  
**Total Primitives**: 37 (9 instructions + 18 workflows + 6 agents + 4 orchestra)  
**Status**: ✅ Fully compliant with AI Native-Instructions Architecture

### Framework Implementation
- ✅ **Layer 1: Markdown Prompt Engineering** - Structured semantic markdown
- ✅ **Layer 2: Agent Primitives** - 37 configurable tools (9 instructions + 18 workflows + 6 agents + 4 orchestra)
- ✅ **Layer 3: Context Engineering** - Modular `applyTo` patterns + centralized context system
- ✅ **AGENTS.md Ready** - Prepared for universal context compilation
- ✅ **Orchestra System** - Multi-agent TDD orchestration with context awareness
- ✅ **Agent Context System** - Centralized documentation in `.github/plans/`
- ✅ **Validation Passing** - All compliance checks
- ✅ **Test Validated** - Customer Loyalty Points test (24/24 validations passed)

## Related Resources

### Framework & Standards
- [AI Native-Instructions Architecture Guide](https://danielmeppiel.github.io/awesome-ai-native/)
- [AGENTS.md Standard](https://agents.md)
- [Context Engineering Patterns](https://danielmeppiel.github.io/awesome-ai-native/docs/concepts/)

### Microsoft Business Central
- [AL Language Documentation](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/)
- [Business Central Development](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)