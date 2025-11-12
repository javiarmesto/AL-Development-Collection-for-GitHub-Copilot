# AL Orchestra - Multi-Agent TDD System for Business Central

> **Structured Test-Driven Development workflow for AL extensions using AI-assisted multi-agent orchestration**

## ⚠️ Important: VS Code Copilot Visibility

**Orchestra agents are located in a subfolder** (`agents/orchestration/`) which **affects VS Code Copilot Chat visibility**.

### The Problem

VS Code Copilot Chat only auto-detects `.agent.md` files located in the **root `agents/` directory**. Files in subfolders like `agents/orchestration/` are **not automatically visible** as chat modes.

### How to Use al-conductor

Despite the subfolder location, you can still use al-conductor:

```markdown
Use al-conductor mode
```

**If this doesn't work**, try these solutions:

#### Solution 1: Verify Collection Manifest (Recommended)
Check that `collections/al-development.collection.yml` includes orchestration agents with correct file paths.

#### Solution 2: Create Symlinks
Create symbolic links in root `agents/` pointing to orchestration folder:
```powershell
# PowerShell (run as Administrator)
cd agents
New-Item -ItemType SymbolicLink -Name "al-conductor.agent.md" -Target "orchestration\al-conductor.agent.md"
```

#### Solution 3: Copy Files to Root
If symlinks don't work, copy files directly to `agents/` root (maintain both copies).

#### Solution 4: Update VS Code Settings
Check VS Code settings for custom agent paths configuration.

### Subagents Access

The subagents (`al-planning-subagent`, `al-implement-subagent`, `al-review-subagent`) are **automatically invoked by al-conductor** using the `runSubagent` tool. You don't need direct access to these.

---

## Overview

The AL Orchestra system implements the **Planning → Implementation → Review → Commit** cycle for Business Central AL development, adapted from the [GitHub Copilot Orchestra pattern](https://github.com/ShepAlderson/copilot-orchestra) with AL-specific enhancements.

## Architecture

```
┌──────────────────────────────────────────────────────┐
│                  al-conductor                         │
│  Orchestrates Planning → Implement → Review → Commit │
└────┬──────────────┬────────────────┬─────────────────┘
     ↓              ↓                ↓
┌─────────┐  ┌────────────┐  ┌──────────┐
│Planning │  │Implement   │  │Review    │
│Subagent │  │Subagent    │  │Subagent  │
└─────────┘  └────────────┘  └──────────┘
AL-aware     TDD-focused     AL patterns
research     implementation  validation
```

## Agents

### al-conductor.agent.md
**Main orchestration agent** that manages the complete TDD cycle.

**Usage**: 
```markdown
Use al-conductor mode

I need to add email validation to the Customer table
```

**Responsibilities**:
- Analyzes user requests and creates multi-phase plans
- Delegates research to planning subagent
- Coordinates implementation through implement subagent
- Enforces quality gates via review subagent
- Manages commit workflow and documentation
- Creates plan files in `.github/plans/`

**Tools**: `runSubagent`, `edit`, `search`, `usages`, `problems`, `changes`, `todos`

**Model**: Claude Sonnet 4.5

### al-planning-subagent.agent.md
**AL-aware research specialist** that gathers context for plan creation.

**Invoked by**: al-conductor (not for direct use)

**Responsibilities**:
- Analyzes AL codebase structure and dependencies
- Identifies relevant AL objects (Tables, Pages, Codeunits)
- Maps event architecture (subscribers/publishers)
- Verifies AL-Go structure (app/ vs test/ separation)
- Returns structured findings with implementation options

**Tools**: `search`, `usages`, `problems`, `changes`, AL MCP tools (al_get_package_dependencies, al_download_source)

**Model**: Claude Sonnet 4.5

### al-implement-subagent.agent.md
**TDD-focused implementation specialist** with full AL MCP tool access.

**Invoked by**: al-conductor (not for direct use)

**Responsibilities**:
- Executes TDD cycle: Red (failing tests) → Green (minimal code) → Refactor
- Creates AL objects following BC extension patterns
- Uses event-driven architecture (no base modifications)
- Follows AL-Go structure (app/ vs test/ separation)
- Applies AL performance patterns (SetLoadFields, early filtering)
- Reports completion back to conductor

**Tools**: `edit`, `search`, `runCommands`, `runTasks`, AL MCP tools (al_build, al_publish, al_debug_without_publish)

**Model**: Claude Haiku 4.5 (cost-optimized for execution)

### al-review-subagent.agent.md
**Quality assurance specialist** for AL code validation.

**Invoked by**: al-conductor (not for direct use)

**Responsibilities**:
- Reviews AL code against BC best practices
- Validates event-driven architecture (no base mods)
- Checks naming conventions (26-char limit)
- Verifies AL-Go structure compliance
- Confirms test coverage and passing tests
- Returns structured review: APPROVED / NEEDS_REVISION / FAILED

**Tools**: `search`, `usages`, `problems`, `changes`, `testFailure`, AL MCP tools (al_generate_cpu_profile)

**Model**: Claude Sonnet 4.5

## How It Works

### Phase 1: Planning

1. **User describes feature**: "Add email validation to Customer"
2. **Conductor delegates research** → al-planning-subagent analyzes AL codebase
3. **Planning returns findings**: Base objects, extensions, event architecture, AL-Go structure
4. **Conductor creates multi-phase plan** (typically 3-10 phases)
5. **User reviews and approves plan** → **MANDATORY STOP**
6. **Plan saved** to `.github/plans/<task-name>-plan.md`

### Phase 2: Implementation Cycle (Per Phase)

1. **Conductor delegates to implement subagent** with phase requirements
2. **Implement follows TDD**:
   - Write failing tests in `/test` project
   - Run tests → Verify failure (RED)
   - Write minimal AL code in `/app` project
   - Run tests → Verify pass (GREEN)
   - Refactor and apply AL patterns
3. **Conductor delegates to review subagent** for validation
4. **Review analyzes** against AL best practices:
   - Event-driven architecture
   - Naming conventions (26-char limit)
   - AL-Go structure
   - Performance patterns
   - Test coverage
5. **Review returns status**:
   - **APPROVED** → Proceed to commit
   - **NEEDS_REVISION** → Return to implement with feedback
   - **FAILED** → Escalate to user
6. **Conductor presents summary** → **MANDATORY STOP**
7. **User makes git commit** and confirms to continue

### Phase 3: Plan Completion

1. **Conductor compiles final report** → `.github/plans/<task-name>-complete.md`
2. **Summary presented** with all AL objects created, tests passing, patterns applied
3. **Task closed**

## Generated Artifacts

The Orchestra system creates documentation in `.github/plans/`:

### Plan File
`.github/plans/<task-name>-plan.md` - Created after user approval

Contains:
- Task overview and objectives
- AL context (base objects, extension patterns, AL-Go structure)
- Complete phase breakdown (3-10 phases)
- AL objects to create/modify
- Event architecture (subscribers/publishers)
- Tests to write
- Open questions for user

### Phase Completion Files
`.github/plans/<task-name>-phase-<N>-complete.md` - Created after each phase commit

Contains:
- Phase objective and summary
- AL objects created/modified
- Event subscribers/publishers added
- Files and functions changed
- Tests created (with pass status)
- AL patterns applied
- Review status
- Git commit message

### Final Completion File
`.github/plans/<task-name>-complete.md` - Created when all phases done

Contains:
- Overall summary
- All phases completed (checklist)
- Complete list of AL objects created/modified
- Event architecture implemented
- Test coverage summary
- AL best practices compliance
- Recommendations for next steps

## AL-Specific Features

### Event-Driven Development Enforcement

Orchestra **prevents base object modifications** and enforces BC extension patterns:

```al
// ❌ REJECTED by Review Subagent
table 18 Customer
{
    // Cannot modify base BC objects
}

// ✅ APPROVED by Review Subagent
tableextension 50100 "Customer Ext" extends Customer
{
    fields
    {
        field(50100; "Custom Field"; Text[50]) { }
    }
}

// ✅ APPROVED by Review Subagent
[EventSubscriber(ObjectType::Table, Database::Customer, 
                 'OnBeforeValidateEvent', 'E-Mail', false, false)]
local procedure ValidateEmail(var Rec: Record Customer)
```

### AL-Go Structure Compliance

Orchestra **separates app and test code** per AL-Go conventions:

```
✅ CORRECT (Enforced):
/app
  /CustomerManagement
    Customer.TableExt.al
    CustomerValidator.Codeunit.al
/test
  /CustomerManagement
    CustomerEmail.Test.Codeunit.al

❌ REJECTED (Review fails):
/src
  Customer.TableExt.al
  CustomerEmail.Test.Codeunit.al  # Tests in app project
```

### Test-Driven Development for AL

Orchestra **enforces TDD** with AL-specific patterns:

```al
// Phase: RED (failing test)
[Test]
procedure ValidateEmail_InvalidFormat_ThrowsError()
begin
    asserterror Customer.Validate("E-Mail", 'invalid-email');
    // Fails - validation not implemented yet
end;

// Run test → FAILS ✅ (expected)

// Phase: GREEN (minimal implementation)
[EventSubscriber(ObjectType::Table, Database::Customer, ...)]
local procedure ValidateEmail(var Rec: Record Customer)
begin
    if not IsValidEmail(Rec."E-Mail") then
        Error('Invalid email');
end;

// Run test → PASSES ✅

// Phase: REFACTOR (apply AL patterns)
- Add error labels (translation support)
- Apply performance patterns (if needed)
- Add XML documentation
```

### AL Performance Patterns

Orchestra **applies and validates** BC performance patterns:

- **SetLoadFields**: For large tables (Customer, Item, G/L Entry)
- **Early Filtering**: SetRange before FindSet
- **Temporary Tables**: For interMEDIUMte processing
- **TryFunctions**: For error-prone operations

Review subagent **checks these patterns** and fails review if violated on large tables.

### Naming Convention Enforcement

Orchestra **validates 26-character limit** (SQL Server constraint):

```al
// ❌ MAJOR issue - Review fails
codeunit 50100 "Customer Email Validation Handler"  // 27 chars

// ✅ APPROVED
codeunit 50100 "Customer Email Valid"  // 21 chars
```

## Usage Examples

### Example 1: Simple Feature

**Request**: "Add email validation to Customer table"

**Result**:
- 3-phase plan: Test setup → Implementation → Integration
- Tests created in `/test/CustomerManagement/`
- Event subscriber created in `/app/CustomerManagement/`
- All tests pass, AL patterns applied
- 3 commits (one per phase)
- Complete documentation trail

**Time**: ~20-30 minutes (vs 1-2 hours manual)

### Example 2: Complex Feature

**Request**: "Add multi-company sales approval workflow with email notifications"

**Result**:
- 8-phase plan:
  1. Approval Entry table design
  2. Approval Workflow codeunit (event publishers)
  3. Sales Header extension (approval fields)
  4. Approval Request Page
  5. Email notification integration
  6. Sales Post integration (event subscriber)
  7. Permission sets
  8. Integration tests
- 25+ AL objects created
- Full test coverage
- Event architecture documented
- 8 commits with clear history
- Complete plan documentation

**Time**: ~2-3 hours (vs 1-2 days manual)

### Example 3: Bug Fix with TDD

**Request**: "Fix: Customer blocking status not validated before posting sales orders"

**Result**:
- 2-phase plan: Failing test → Fix implementation
- Test demonstrates bug
- Event subscriber adds validation
- Regression tests pass
- 2 commits with clear fix trail

**Time**: ~15-20 minutes (vs 1 hour manual)

## Configuration

### Plan Storage Location

Plans are stored in `.github/plans/` by default. To change:

1. Edit `al-conductor.agent.md`
2. Change all references to `.github/plans/` to your preferred location
3. Options:
   - `.github/plans/` - Default, aligned with Copilot conventions
   - `docs/plans/` - If documenting in wiki
   - `.vscode/copilot/plans/` - Isolated from project

### .gitignore Plans (Optional)

If you don't want to commit plans:

```gitignore
# .gitignore
.github/plans/
```

Or keep completed plans and ignore in-progress:

```gitignore
# .gitignore
.github/plans/*-plan.md
.github/plans/*-phase-*.md
# But keep completed plans
!.github/plans/*-complete.md
```

### Model Selection

Default models are optimized for cost/quality balance:

```yaml
al-conductor.agent.md: Claude Sonnet 4.5  # Strategic decisions
al-planning-subagent.agent.md: Claude Sonnet 4.5  # Complex analysis
al-implement-subagent.agent.md: Claude Haiku 4.5  # Cost-efficient execution
al-review-subagent.agent.md: Claude Sonnet 4.5  # Thorough review
```

To change models, edit the `model:` field in frontmatter.

## Tips for Best Results

### 1. Be Specific in Requests

**Good**: "Add email validation to Customer table using regex pattern, allowing empty emails, normalizing to lowercase"

**Less Ideal**: "Add validation to Customer"

### 2. Review Plans Carefully

The planning phase is your chance to guide implementation:
- Check phase scope (not too large)
- Verify AL object IDs and naming
- Confirm event architecture approach
- Answer open questions clearly

### 3. Commit Between Phases

Don't skip commit steps:
- Each phase is independently committable
- Smaller commits are easier to review/revert
- Creates clear development history
- Review subagent checks uncommitted code

### 4. Trust the TDD Process

Tests first seems slow but:
- Catches issues early
- Provides clear guide rails
- Confirms correct behavior
- Enables confident refactoring

### 5. Leverage Documentation

Phase completion files are valuable:
- Review before committing
- Use for PR descriptions
- Reference in discussions
- Onboarding documentation

## Comparison: Standalone vs Orchestra

### al-developer (Standalone)

**Use for**: Simple, single-file changes

```markdown
Use al-developer mode

Add a "Priority" field to Sales Header table
```

**Result**: Direct implementation, quick, no plan overhead

### al-conductor (Orchestra)

**Use for**: Complex, multi-phase features

```markdown
Use al-conductor mode

Add AI-powered sales approval workflow with email notifications
```

**Result**: Structured plan, TDD enforced, quality gates, documentation trail

**Rule of Thumb**:
- 1-2 files, simple change → Use al-developer
- 3+ files, complex feature → Use al-conductor
- Bug requiring tests → Use al-conductor (TDD proof)
- Exploration/prototyping → Use al-developer
- Production feature → Use al-conductor (quality gates)

## Integration with Existing Collection

Orchestra **complements** existing AL Development Collection agents:

```
al-architect (design) → al-conductor (orchestrate) → al-developer (execute)
                              ↓
                       al-planning-subagent (research)
                       al-implement-subagent (TDD)
                       al-review-subagent (validate)
```

**Workflow**:
1. **al-architect**: Design solution architecture
2. **al-conductor**: Orchestrate implementation with TDD
3. **al-tester**: Design additional test scenarios (if needed)
4. **al-developer**: Make adjustments outside Orchestra (if needed)

## Troubleshooting

### Issue: Subagent not found

**Solution**: Ensure all 4 files in `agents/orchestration/` are present and properly named.

### Issue: Plans directory doesn't exist

**Solution**: Create `.github/plans/` directory or change location in conductor.

### Issue: Review fails with "CRITICAL: Base object modification"

**Solution**: This is correct! BC extensions cannot modify base objects. Use TableExtension, PageExtension, or event subscribers.

### Issue: Tests fail during implementation

**Solution**: This is expected in RED phase. Verify failures, then implement minimal code to pass.

### Issue: Conductor doesn't pause for approval

**Solution**: Check that you're using `#runSubagent` correctly. Conductor should pause after plan presentation.

## Limitations

- **VS Code Insiders Required**: `runSubagent` feature needs VS Code Insiders
- **GitHub Copilot Subscription**: Required for AI agents
- **AL-Go Structure Assumed**: Works best with AL-Go project structure
- **English Language**: Plans and reviews in English (can be adapted)
- **Learning Curve**: First use takes longer as you learn the workflow

## Version History

### v2.6.0 (2025-11-08)
- ✨ Initial release of AL Orchestra system
- 🎯 4 specialized agents (Conductor + 3 subagents)
- 🧪 TDD enforcement for AL development
- 📋 Automatic plan and documentation generation
- ✅ AL best practices validation
- 🎨 AL-Go structure compliance

## Credits

Adapted from [GitHub Copilot Orchestra](https://github.com/ShepAlderson/copilot-orchestra) by Shep Alderson with AL-specific enhancements for Business Central development.

## License

MIT License - See repository LICENSE file for details.

---

**Framework**: [AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)  
**Collection**: AL Development Collection v2.6.0  
**Status**: ✅ Production Ready
