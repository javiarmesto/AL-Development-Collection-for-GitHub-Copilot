# GitHub Copilot Instructions - AL Development Collection

This is a **meta-collection** for AL (Application Language) development targeting Microsoft Dynamics 365 Business Central. It implements the [AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/) framework, providing 29 specialized Agent Primitives that guide AI coding assistants through structured markdown prompt engineering.

## Project Architecture

**This is NOT a Business Central extension** - it's a toolkit that teaches AI assistants how to build BC extensions correctly. The collection uses a three-layer architecture:

### Layer 1: Markdown Prompt Engineering
Structured instructions using semantic markdown (headers, lists, links) that guide AI reasoning predictably. All files use precise language patterns that LLMs parse effectively.

### Layer 2: Agent Primitives (37 tools)
- **Instructions** (7): Auto-applied via `applyTo` patterns - coding standards that activate based on file type
- **Agentic Workflows** (18): Complete processes invoked via `@workspace use [name]` - systematic execution with validation gates
- **Agents** (7): Role-based specialists switched via `Use [mode]` - strategic consulting and tactical execution with MCP tool boundaries
- **Orchestra System** (4): Multi-agent TDD orchestration (al-conductor + 3 subagents) for structured Planning → Implementation → Review → Commit cycles
- **Integration Guide** (1): Master coordination document (`instructions/copilot-instructions.md`)

### Layer 3: Context Engineering
Strategic LLM context management through:
- **Selective Loading**: Instructions use `applyTo` glob patterns to load only when relevant
- **Modular References**: Links between files instead of duplication
- **AGENTS.md Ready**: Prepared for universal AI context compilation

## Critical Development Patterns

### Event-Driven Development (Never Modify Base Objects)
AL extensions **cannot modify** standard Business Central objects. All customization happens through:
- **Table Extensions**: Add fields to existing tables
- **Page Extensions**: Add UI elements to existing pages  
- **Event Subscribers**: React to base app events (OnBefore/OnAfter patterns)
- **Integration Events**: Publish your own events for extensibility

**Example Pattern:**
```al
// ❌ WRONG - Cannot modify standard table
table 18 Customer { /* modifications */ }

// ✅ RIGHT - Extend via table extension
tableextension 50100 CustomerExt extends Customer {
    fields {
        field(50100; "Custom Field"; Text[50]) { }
    }
}

// ✅ RIGHT - React via event subscriber
[EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeValidateEvent', 'Email', false, false)]
local procedure ValidateCustomerEmail(var Rec: Record Customer)
begin
    // Custom validation logic
end;
```

### Feature-Based Organization (Not Object Type)
Organize by business capability, not AL object type:

```
src/
├── CustomerManagement/           # Feature
│   ├── Data/
│   │   ├── Customer.TableExt.al
│   │   └── CustomerAddress.Table.al
│   ├── Processing/
│   │   └── CustomerMgmt.Codeunit.al
│   └── UI/
│       └── CustomerCard.PageExt.al
└── SalesWorkflow/                # Feature
    ├── ApprovalEntry.Table.al
    └── ApprovalMgmt.Codeunit.al
```

**Why**: Features evolve together. A sales approval workflow change affects tables, pages, and codeunits simultaneously - grouping them reduces navigation overhead.

### AL Object Naming Constraints
AL imposes strict limits due to SQL Server backend:
- **Object names**: 30 characters max (26 recommended to allow 4-char prefix)
- **Field names**: 30 characters max
- **Variable names**: No limit, but use descriptive PascalCase

**AL has no namespaces** - object IDs and names must be globally unique per tenant. Use numeric ranges (50000-99999 for custom objects) and prefixed names.

### Performance-Critical Patterns

**Early Filtering** (reduce dataset before iteration):
```al
// ❌ WRONG - Loads all records then filters
Customer.FindSet();
repeat
    if Customer.Blocked = Customer.Blocked::" " then
        // process
until Customer.Next() = 0;

// ✅ RIGHT - Filter before FindSet
Customer.SetRange(Blocked, Customer.Blocked::" ");
if Customer.FindSet() then
    repeat
        // process
    until Customer.Next() = 0;
```

**SetLoadFields** (partial record loading):
```al
// Load only needed fields to reduce SQL traffic
Customer.SetLoadFields("No.", Name, "E-Mail");
if Customer.Get(CustomerNo) then
    // Use loaded fields
```

**Temporary Tables** for intermediate processing:
```al
procedure CalculateTotals(var TempResult: Record "Result Buffer" temporary)
// Temporary records exist in memory only - no database I/O
```

### AL-Go Workspace Structure
AL-Go (official BC DevOps) enforces strict separation:
- **App project**: All application code (tables, pages, codeunits, reports)
- **Test project**: All test code with `"test"` scope dependency on App
- **Never mix**: Tests must be separate to avoid deploying test code to production

Files must reference this when generating tests - create/modify test files only in Test project.

### Validation Script (`validate-al-collection.js`)
Node.js script checking:
- All manifest items exist
- Frontmatter completeness (`applyTo`, `description`, `tools`, `model`)
- File naming conventions (`.instructions.md`, `.prompt.md`, `.agent.md`)
- No orphaned files

**Run before committing**: `npm install && npm run validate`

## Essential File Locations

### Auto-Applied Guidelines
Located in `instructions/` - activate automatically via `applyTo` patterns:
- **al-guidelines.instructions.md**: Master hub linking all other instructions (`applyTo: **/*.{al,json}`)
- **al-code-style.instructions.md**: 2-space indent, PascalCase, feature folders (`applyTo: **/*.al`)
- **al-naming-conventions.instructions.md**: 26-char limits, descriptive names
- **al-performance.instructions.md**: SetLoadFields, early filtering, temp tables
- **al-error-handling.instructions.md**: TryFunctions, error labels, telemetry (context-activated)
- **al-events.instructions.md**: Event subscribers, integration events (context-activated)
- **al-testing.instructions.md**: AL-Go structure, test patterns (`applyTo: **/test/**/*.al`)

### Key Workflows
Invoked via `@workspace use [name]`:
- **al-initialize**: Environment setup (VS Code, extensions, symbols, dependencies) - consolidated from al-setup + al-workspace
- **al-diagnose**: Debug runtime issues (attach debugger, snapshot debugging, telemetry) - consolidated from al-debug + al-troubleshoot
- **al-build**: Build, package, publish via AL tools
- **al-performance**: Deep profiling with CPU profile generation
- **al-copilot-capability**: Register Copilot capability (enum extension, install codeunit)
- **al-copilot-promptdialog**: Create PromptDialog pages for AI features
- **al-copilot-test**: Test Copilot features with AI Test Toolkit
- **al-context.create**: Generate project context.md file for AI assistants (NEW)
- **al-memory.create**: Generate/update memory.md file for session continuity (NEW)

### Agents
Strategic specialists (not executors):
- **al-orchestrator**: ⚠️ DEPRECATED - Use al-conductor instead. Retained as educational reference for creating complex agents.
- **al-architect**: Solution design - **cannot** execute builds, only designs. Use before al-conductor for architecture planning.
- **al-developer**: Tactical implementation - **can** execute builds, edit code, run tests. For simple changes outside Orchestra.
- **al-debugger**: Diagnosis - **cannot** run debugger, only analyzes and recommends al-diagnose workflow
- **al-tester**: Test strategy - **cannot** run tests, only designs test approach
- **al-api**: API design/implementation - REST, OData, authentication
- **al-copilot**: AI feature design - Azure OpenAI integration, prompt engineering, responsible AI

**Tool Boundaries**: Each mode has explicit CAN/CANNOT lists preventing scope creep (like professional licensing).

### Orchestra System (Multi-Agent TDD)
Structured Test-Driven Development with automatic planning, implementation, and review:
- **al-conductor**: Main orchestrator - coordinates Planning → Implementation → Review → Commit cycles
- **al-planning-subagent**: AL-aware research - gathers context about base objects, events, AL-Go structure (called by conductor)
- **al-implement-subagent**: TDD implementation - executes RED (tests) → GREEN (code) → REFACTOR (called by conductor)
- **al-review-subagent**: Quality assurance - validates against AL best practices, checks test coverage (called by conductor)

**Use Orchestra when**: Complex features (3+ objects), need TDD enforcement, require quality gates, want documentation trail.
**Use Workflows when**: Simple tasks (1-2 files), quick operations, no comprehensive tests needed.

See [`agents/orchestration/README.md`](../agents/orchestration/README.md) for complete Orchestra documentation.

## Common Commands/Workflows

### New Project Setup
```bash
# 1. Initialize project (prompts for project type)
@workspace use al-initialize

# 2. Downloads symbols automatically
# Tools used: al_new_project, al_go, al_download_symbols

# 3. Configure launch.json for debugging
# Auto-suggests server, authentication, company
```

### Debugging a Runtime Issue
```bash
# 1. Start systematic diagnosis
@workspace use al-diagnose

# Workflow:
# - Analyzes error messages/symptoms
# - Recommends al_debug_without_publish or al_initialize_snapshot_debugging
# - For intermittent issues: snapshot debugging
# - For performance: recommends al-performance workflow
```

### Building & Deploying
```bash
# Quick build
@workspace use al-build

# Tools available:
# - al_build (compile)
# - al_package (create .app)
# - al_publish (deploy to server)
# - al_incremental_publish (faster, changes only)
```

### Generating Tests
```bash
# Switch to test strategy mode
Use al-tester mode

# Then ask: "Create test suite for SalesPost codeunit"
# Mode designs strategy, auto-instructions enforce AL-Go structure
```

### Performance Analysis
```bash
# Quick static analysis
@workspace use al-performance.triage

# Deep profiling with CPU profile
@workspace use al-performance
# Uses al_generate_cpu_profile_file to create performance snapshot
```

## Integration Points & Dependencies

### GitHub Copilot Integration
All files designed for VS Code Copilot following [official customization docs](https://code.visualstudio.com/docs/copilot/copilot-customization):
- Instructions load via `applyTo` frontmatter (glob patterns)
- Prompts invoked via `@workspace use [name]`
- Agents switched via `Use [mode-name] mode`

### AL Language Extension Tools
Workflows access AL extension via MCP tools:
- `al_new_project`, `al_go`: Project initialization
- `al_build`, `al_package`, `al_publish`: Build/deploy
- `al_download_symbols`, `al_download_source`: Dependency management
- `al_generate_cpu_profile_file`: Performance profiling
- `al_open_Page_Designer`: UI design assistance
- `al_generate_permissionset_for_extension_objects`: Security

**Tool boundaries in agents**: Modes like `al-architect` **cannot** call build tools (only analyze/design). Enforcement via explicit tool lists in frontmatter.

### External Documentation References
Files reference:
- [Microsoft AL Language docs](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/)
- [AL-Go for GitHub](https://freddysblog.com/category/al-go-for-github/) - DevOps patterns
- [AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)

## Conventions to Follow When Modifying

### Adding New Instructions
1. Create in `instructions/` as `al-[feature].instructions.md`
2. Add frontmatter:
   ```yaml
   ---
   applyTo: "**/*.al"  # or more specific pattern
   description: "Brief description"
   ---
   ```
3. Structure: # Title → ## Rule 1 → ### Intent → ### Examples → ### Reasoning
4. Update `instructions/al-guidelines.instructions.md` to reference it
5. Add to `collections/al-development.collection.yml`
6. Run `npm run validate`

### Adding New Workflows
1. Create in `prompts/` as `al-[task].prompt.md`
2. Add frontmatter:
   ```yaml
   ---
   agent: agent
   model: Claude Sonnet 4.5
   description: "Task description"
   tools: ['edit', 'search', 'ms-dynamics-smb.al/*']  # AL tools
   ---
   ```
3. Structure: ## Context Loading → ## Execution Steps → ## Validation Gates → ## Deliverables
4. Include links to relevant instructions for context
5. Add to collection manifest and validate

### Adding New Agents
1. Create in `agents/` as `al-[role].agent.md`
2. Add frontmatter:
   ```yaml
   ---
   description: "Role description"
   tools: ['search', 'usages']  # NO build tools for strategic modes
   model: Claude Sonnet 4.5
   ---
   ```
3. Include ## Tool Boundaries section with explicit CAN/CANNOT lists
4. Add to collection manifest with detailed `usage` description
5. Validate

### Frontmatter Requirements (Enforced by Validation)
**Instructions**:
- `applyTo`: Glob pattern (string or array)
- `description`: Brief summary

**Prompts**:
- `agent`: "agent" (agentic workflow)
- `model`: LLM name (e.g., "Claude Sonnet 4.5")
- `description`: Task summary
- `tools`: Array of available tools

**Agents**:
- `description`: Role summary
- `tools`: Array (strategic modes should exclude build tools)
- `model`: LLM name

## Testing Your Contributions

### Local Validation
```bash
npm install
npm run validate
```

Expected output:
```
✅ Successes: 34
⚠️  Warnings:  0
❌ Errors:    0
🎉 Collection is fully compliant and ready for contribution!
```

### Manual Testing
1. Open any `.al` file - instructions should auto-apply
2. Try `@workspace use [your-new-prompt]` - should execute
3. Try `Use [your-new-mode] mode` - should switch context
4. Check Copilot suggestions follow your new rules

## Why This Architecture Matters

**Without this collection**: "Create a table" → Generic AL code, possibly wrong patterns, no error handling, mixed standards

**With this collection**: "Create a table" → 
1. `al-code-style` auto-applies (feature-based location, XML docs)
2. `al-naming-conventions` auto-applies (26-char limit, PascalCase)
3. `al-performance` suggests SetLoadFields patterns
4. `al-error-handling` activates if validation added
5. Result: Production-ready code following all BC best practices automatically

**For simple tasks**: Use direct workflows or agents (al-developer, al-tester, etc.)

**For complex tasks with TDD**: al-conductor orchestrates → al-planning-subagent researches → al-implement-subagent executes TDD → al-review-subagent validates → documentation generated

**Starting point when unsure**: `Use al-conductor mode` (for complex features) or direct workflows (for simple tasks)
**Setup new project**: `@workspace use al-initialize`
**Debug runtime issue**: `@workspace use al-diagnose`
**Performance problem**: `@workspace use al-performance` or `al-performance.triage`
**Build & deploy**: `@workspace use al-build`
**Design architecture**: `Use al-architect mode` → then `Use al-conductor mode` for implementation
**Implement simple features**: `Use al-developer mode` or direct workflows
**Implement complex features with TDD**: `Use al-conductor mode`
**Test strategy**: `Use al-tester mode`
**API work**: `Use al-api mode`
**AI features**: `Use al-copilot mode`

**Framework**: [AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)  
**Version**: 2.6.0  
**Total Primitives**: 37 (7 instructions + 18 workflows + 7 modes + 4 Orchestra agents + 1 guide)  
**Validation**: Run `npm run validate` before committing
