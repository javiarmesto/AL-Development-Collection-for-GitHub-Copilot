# AL Orchestra Agents Index

> **Multi-Agent Test-Driven Development System for Business Central**

⚠️ **IMPORTANT FOR VS CODE COPILOT VISIBILITY**:

The orchestra agents in this folder (`al-conductor`, `al-planning-subagent`, `al-implement-subagent`, `al-review-subagent`) are **NOT directly accessible as modes** in VS Code Copilot Chat.

**Why?** VS Code Copilot only detects `.agent.md` files in the **root `agents/` directory**, not in subfolders.

**How to use these agents:**
- **al-conductor**: Invoked via `Use al-conductor mode` (references file via collection manifest or direct file path loading by Copilot)
- **Subagents**: Called automatically by al-conductor using `runSubagent` tool
- **Alternative**: If visibility issues occur, symlink or copy files to `agents/` root

**Verification**: Run `@workspace /explain` and check which modes are listed. Only root-level agents appear.

## Quick Links

- **[Complete Documentation](./README.md)** - Full guide to AL Orchestra system
- **[Adaptability Report](../../docs/analysis/multi-agent-orchestration-adaptability-report.md)** - Technical analysis and integration details

## Agents Overview

| Agent | Type | Model | Purpose |
|-------|------|-------|---------|
| **[al-conductor](./al-conductor.agent.md)** | Orchestrator | Sonnet 4.5 | Main coordination agent for Planning → Implementation → Review → Commit cycle |
| **[al-planning](./al-planning-subagent.agent.md)** | Subagent | Sonnet 4.5 | AL-aware research and context gathering |
| **[al-implement](./al-implement-subagent.agent.md)** | Subagent | Haiku 4.5 | TDD-focused implementation with AL MCP tools |
| **[al-review](./al-review-subagent.agent.md)** | Subagent | Sonnet 4.5 | Code review against AL best practices |

## When to Use

### Use AL Orchestra (al-conductor) For:
- ✅ Complex multi-phase features (3+ AL objects)
- ✅ Features requiring TDD proof (bug fixes with tests)
- ✅ Production features needing quality gates
- ✅ Team projects requiring documentation trail
- ✅ Learning AL patterns through guided implementation

### Use Standalone Agents For:
- ✅ Simple single-file changes (al-developer)
- ✅ Quick prototyping or exploration
- ✅ Architecture design without implementation (al-architect)
- ✅ Test strategy planning (al-tester)

## Quick Start

```markdown
Use al-conductor mode

I need to add email validation to the Customer table.
The validation should:
- Use regex pattern matching
- Allow empty emails (Email is optional in BC)
- Show user-friendly error message
```

**Result**: Structured plan → TDD implementation → Automated review → Documentation

## Architecture

```
al-conductor (Orchestrator)
├── Delegates research → al-planning-subagent
│   └── Returns AL context (objects, events, AL-Go structure)
├── Coordinates implementation → al-implement-subagent
│   └── Executes TDD: RED (tests) → GREEN (code) → REFACTOR
└── Enforces quality → al-review-subagent
    └── Returns APPROVED / NEEDS_REVISION / FAILED
```

## Key Features

### 1. Test-Driven Development Enforcement
```al
// Phase: RED - Write failing test
[Test]
procedure ValidateEmail_Invalid_ThrowsError()
begin
    asserterror Customer.Validate("E-Mail", 'invalid');
end;
// Run test → FAILS (expected)

// Phase: GREEN - Implement minimal code
[EventSubscriber(...)]
local procedure ValidateEmail(var Rec: Record Customer)
begin
    if not IsValidEmail(Rec."E-Mail") then
        Error('Invalid email');
end;
// Run test → PASSES
```

### 2. Event-Driven Architecture Validation
```al
// ❌ REJECTED by al-review-subagent
table 18 Customer { /* Cannot modify base objects */ }

// ✅ APPROVED by al-review-subagent
tableextension 50100 "Customer Ext" extends Customer
{
    fields { field(50100; "Custom Field"; Text[50]) { } }
}
```

### 3. AL-Go Structure Compliance
```
✅ Enforced Structure:
/app                    # Application code
  /CustomerManagement
    Customer.TableExt.al
/test                   # Test code
  /CustomerManagement
    CustomerEmail.Test.Codeunit.al
```

### 4. Automatic Documentation
```
.github/plans/
├── add-email-validation-plan.md           # Initial plan (user approved)
├── add-email-validation-phase-1-complete.md  # Phase 1 summary
├── add-email-validation-phase-2-complete.md  # Phase 2 summary
└── add-email-validation-complete.md       # Final summary
```

## Example Workflows

### Simple Feature (3 phases, ~20 mins)
```
User: "Add email validation to Customer"
→ Planning: Analyze Customer table and events
→ Phase 1: Create failing tests
→ Phase 2: Implement event subscriber
→ Phase 3: Add documentation
Result: Tested, reviewed, documented feature with 3 clean commits
```

### Complex Feature (8 phases, ~2-3 hours)
```
User: "Add sales approval workflow with email notifications"
→ Planning: Analyze Sales module architecture
→ Phase 1-8: Build incrementally with TDD
→ Each phase: Implement → Review → Commit
Result: 25+ AL objects, full test coverage, documented architecture
```

## Cost Optimization

Orchestra uses different models for different tasks:

| Agent | Model | Cost | Usage |
|-------|-------|------|-------|
| al-conductor | Sonnet 4.5 | $$$ | Strategic decisions, planning |
| al-planning | Sonnet 4.5 | $$$ | Complex analysis |
| **al-implement** | **Haiku 4.5** | **$** | **Repetitive implementation** |
| al-review | Sonnet 4.5 | $$$ | Thorough validation |

**Result**: 30-40% cost reduction vs all-Sonnet while maintaining quality.

## Integration with Collection

Orchestra complements existing AL Development Collection agents:

```
Design Phase:
al-architect → Design solution architecture

Implementation Phase:
al-conductor → Orchestrate TDD implementation
  ├── al-planning-subagent → Research AL context
  ├── al-implement-subagent → Execute TDD cycle
  └── al-review-subagent → Validate quality

Optional Refinements:
al-developer → Manual adjustments outside Orchestra
al-tester → Additional test scenarios
```

## Best Practices

1. **Be specific in requests** - Provide business context and constraints
2. **Review plans carefully** - Planning phase is your control point
3. **Commit between phases** - Don't skip commit gates
4. **Trust TDD process** - Tests first seems slow but catches issues early
5. **Leverage documentation** - Use generated plans for PRs and reviews

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Subagent not found | Ensure all 4 files present in `agents/orchestration/` |
| Plans directory missing | Create `.github/plans/` or configure location |
| Review fails "CRITICAL" | This is correct - BC requires extension patterns |
| Tests fail in RED phase | Expected behavior - implement code to fix |
| Conductor doesn't pause | Check `runSubagent` usage in VS Code Insiders |

## Version History

### v2.6.0 (2025-11-08) - Initial Release
- ✨ 4 specialized agents (Conductor + 3 subagents)
- 🧪 TDD enforcement for AL development
- 📋 Automatic plan and documentation generation
- ✅ AL best practices validation
- 🎨 AL-Go structure compliance
- 💰 Cost optimization with Haiku for implementation

## Credits

Adapted from [GitHub Copilot Orchestra](https://github.com/ShepAlderson/copilot-orchestra) by Shep Alderson.  
Enhanced for Business Central AL development with AL-specific patterns, tools, and workflows.

## License

MIT License - See [repository LICENSE](../../LICENSE) for details.

---

**Framework**: [AI Native-Instructions Architecture](https://danielmeppiel.github.io/awesome-ai-native/)  
**Collection**: AL Development Collection v2.6.0  
**Primitives**: 36 total (32 existing + 4 Orchestra agents)  
**Status**: ✅ Production Ready

