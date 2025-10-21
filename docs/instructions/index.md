# Instructions - Layer 2: Agent Primitives

**Markdown Prompt Engineering** implemented as modular `.instructions.md` files with **Context Engineering** via `applyTo` patterns. These files customize GitHub Copilot's behavior for AL development in Business Central.

## 📋 What Are Instructions?

Instructions are **auto-applied coding guidelines** that:
- Load automatically based on `applyTo` patterns (e.g., `**/*.al`)
- Provide persistent context to GitHub Copilot during code generation
- Implement best practices through structured markdown rules
- Use semantic markdown (headers, lists, examples) for AI reasoning

## 🎯 How to Use Instructions

Instructions work **automatically** - no activation needed. When you:
- Open an AL file → Instructions with matching `applyTo` patterns load
- Type code → Copilot applies these guidelines in real-time
- Ask for help → Context from relevant instructions is available

## 📦 Available Instructions (8 files)

### Always Active (apply to `**/*.al`)

| File | Purpose | Key Rules |
|------|---------|-----------|
| **al-guidelines.instructions.md** | Master hub and integration guide | References all other instructions, AL development philosophy |
| **al-code-style.instructions.md** | Code formatting & organization | Feature-based structure, PascalCase, 120 char lines |
| **al-naming-conventions.instructions.md** | Naming standards | PascalCase for all, 26-char table limits, Codeunit suffixes |
| **al-performance.instructions.md** | Performance optimization | SetLoadFields, early filtering, temporary tables |

### Context-Triggered (specific patterns)

| File | Apply Pattern | Purpose |
|------|---------------|---------|
| **al-error-handling.instructions.md** | `**/*.al` | TryFunctions, error labels, telemetry patterns |
| **al-events.instructions.md** | `**/*.al` | Event publishers/subscribers, IntegrationEvent patterns |
| **al-testing.instructions.md** | `**/*.al` | AL-Go test structure, test codeunits, scenarios |

### Reference Only

| File | Purpose |
|------|---------|
| **copilot-instructions.md** | Meta-instructions for Copilot behavior (not AL-specific) |

## 🏗️ Architecture Patterns

### Layer 1: Markdown Prompt Engineering
Each instruction uses structured markdown:
```markdown
## Rule: Clear Title

### Intent
What this rule accomplishes

### Implementation  
How to implement it

### Examples
✅ Good / ❌ Bad examples
```

### Layer 3: Context Engineering
Instructions use `applyTo` patterns for modular loading:
```yaml
---
description: 'Performance optimization patterns'
applyTo: ['**/*.al']
---
```

## 💡 Best Practices

### When Instructions Apply
- ✅ **Active Coding** - Instructions load during development
- ✅ **Code Review** - Context available for analysis
- ✅ **Refactoring** - Guidelines inform improvements
- ⚠️ **Read-Only** - May not apply when just viewing

### Combining with Other Primitives
Instructions work alongside:
- **Agentic Workflows** (`@workspace use [prompt]`) - For specific tasks
- **Chat Modes** (`Use [mode-name]`) - For strategic consultation
- Both can reference instruction rules in their guidance

### Creating Custom Instructions

1. **Create file** in this directory: `al-[feature].instructions.md`
2. **Add frontmatter**:
   ```yaml
   ---
   description: 'Brief description'
   applyTo: ['**/*.al']  # Or more specific pattern
   ---
   ```
3. **Structure content** using semantic markdown
4. **Update collection manifest** in `collections/al-development.collection.yml`
5. **Test** by opening matching files and observing Copilot behavior

## 🔗 Related Resources

- **Collection Manifest**: `collections/al-development.collection.yml`
- **Framework Reference**: `references/A-INSTRUCTIONS-ARCHITECTURE.md`
- **User Guide**: `al-development.md`
- **Contributing**: `CONTRIBUTING.md`

## 📊 Validation

Run `npm run validate` to verify:
- All instruction files exist
- Frontmatter is properly formatted
- File naming conventions are followed
- applyTo patterns are valid

---

**Framework Compliance**: These instructions implement **A-Instructions Architecture** - Layer 2 (Agent Primitives) using Layer 1 (Markdown Prompt Engineering) and Layer 3 (Context Engineering) principles.
