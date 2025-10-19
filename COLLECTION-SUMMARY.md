# AL Development Collection - Complete Documentation

> **Note**: This is the complete internal documentation. For the official collection description, see [al-development.md](./al-development.md)

**Collection ID**: `al-development`  
**Version**: 2.1  
**Last Updated**: 2025-10-15  
**Author**: javiarmesto

## 📁 Official File Structure (Following Contribution Guidelines)

```
.github/
├── copilot-instructions.md              # ✅ Master integration guide
├── instructions/                        # ✅ Auto-applied AL coding standards
│   ├── al-guidelines.instructions.md    # (applyTo: **/*.{al,json})
│   ├── al-code-style.instructions.md    # (applyTo: **/*.al)
│   ├── al-naming-conventions.instructions.md  # (applyTo: **/*.al)
│   ├── al-performance.instructions.md   # (applyTo: **/*.al)
│   ├── al-error-handling.instructions.md  # (applyTo: **/*.al)
│   ├── al-events.instructions.md        # (applyTo: **/*.al)
│   └── al-testing.instructions.md       # (applyTo: **/test/**/*.al)
├── prompts/                             # ✅ Agentic workflows (task execution)
│   ├── al-workspace.prompt.md           # (model: gpt-4)
│   ├── al-build.prompt.md               # (model: gpt-4)
│   ├── al-events.prompt.md              # (model: gpt-4)
│   ├── al-debug.prompt.md               # (model: gpt-4)
│   ├── al-performance.prompt.md         # (model: gpt-4)
│   ├── al-permissions.prompt.md         # (model: gpt-4)
│   ├── al-troubleshoot.prompt.md        # (model: gpt-4)
│   ├── al-migrate.prompt.md             # (model: gpt-4)
│   ├── al-pages.prompt.md               # (model: gpt-4)
│   └── al-workflow.prompt.md            # (model: gpt-4)
└── chatmodes/                           # ✅ Strategic consultants (bounded tools)
    ├── al-orchestrator.chatmode.md      # (model: Claude Sonnet 4)
    ├── al-architect.chatmode.md         # (model: Claude Sonnet 4)
    ├── al-debugger.chatmode.md          # (model: Claude Sonnet 4)
    ├── al-tester.chatmode.md            # (model: Claude Sonnet 4)
    ├── al-api.chatmode.md               # (model: Claude Sonnet 4)
    └── al-copilot.chatmode.md           # (model: Claude Sonnet 4)

collections/
└── al-development.collection.yml        # ✅ Collection manifest

al-development.md                        # ✅ Collection documentation
COLLECTION-SUMMARY.md                    # This file - Internal docs
README.md                                # User-facing documentation
```

## ✅ Compliance with Contribution Guidelines

### File Naming Conventions
- ✅ Instructions: `.instructions.md` suffix
- ✅ Prompts: `.prompt.md` suffix (CORRECTED)
- ✅ Chat Modes: `.chatmode.md` suffix (CORRECTED)
- ✅ Collection: `.collection.yml` format (ADDED)
- ✅ Lowercase with hyphens: All files follow pattern

### Frontmatter Requirements
- ✅ Instructions have `description` and `globs`
- ✅ Prompts have `mode`, `tools`, `description`
- ✅ Chat modes have `description`, `model` (optional), `tools`
- ✅ Collection has proper YAML structure

### Collection Manifest
- ✅ Unique ID: `al-development`
- ✅ Clear description and tags
- ✅ All referenced files exist
- ✅ Proper `kind` for each item (instruction/prompt/chat-mode)
- ✅ Usage guidance for chat modes
- ✅ Display settings configured

## 📊 Collection Statistics

**Total Items**: 24 tools
- 7 Instructions (auto-applied + contextual)
- 10 Prompts (task-specific)
- 6 Chat Modes (role-based, core only)
- 1 Master Guide (copilot-instructions.md)

**Tags**: al, business-central, dynamics365, erp, microsoft, architecture, testing, api, copilot, debugging

**Display**: Manual ordering with badge enabled

## 🎯 Changes Made for Compliance

### Renamed Files (20 files)

**Prompts** (10 files):
```
al-workspace.md → al-workspace.prompt.md
al-build.md → al-build.prompt.md
al-events.md → al-events.prompt.md
al-debug.md → al-debug.prompt.md
al-performance.md → al-performance.prompt.md
al-permissions.md → al-permissions.prompt.md
al-troubleshoot.md → al-troubleshoot.prompt.md
al-migrate.md → al-migrate.prompt.md
al-pages.md → al-pages.prompt.md
al-workflow.md → al-workflow.prompt.md
```

**Chat Modes** (6 files):
```
al-orchestrator.md → al-orchestrator.chatmode.md
al-architect.md → al-architect.chatmode.md
al-debugger.md → al-debugger.chatmode.md
al-tester.md → al-tester.chatmode.md
al-api.md → al-api.chatmode.md
al-copilot.md → al-copilot.chatmode.md
```

**Instructions** (7 files):
```
✅ Already compliant - no changes needed
```

### New Files (3 files)

1. **al-development.collection.yml** - Collection manifest
2. **al-development.md** - Collection documentation
3. Updated **COLLECTION-SUMMARY.md** - This file

### Updated Files (1 file)

1. **copilot-instructions.md** - Updated to reference .prompt.md and .chatmode.md extensions

## 🔄 Migration Guide

If you have existing references to old filenames, update them:

### In Code/Documentation
```markdown
# Old
@workspace use al-workspace
mode: al-architect

# New (extensions added internally, usage stays the same)
@workspace use al-workspace
mode: al-architect
```

### In File Paths
```
# Old
.github/copilot-prompts/al-workspace.md
modes/al-architect.md

# New
.github/copilot-prompts/al-workspace.prompt.md
chatmodes/al-architect.chatmode.md
```

## 📖 Complete Tool Reference

See [al-development.md](./al-development.md) for user-facing documentation.

### Layer 1: Always-Active Instructions

| File | Applies To | Auto-Active |
|------|-----------|-------------|
| al-guidelines.instructions.md | `*.al`, `*.json` | ✅ Always |
| al-code-style.instructions.md | `*.al` | ✅ Always |
| al-naming-conventions.instructions.md | `*.al` | ✅ Always |
| al-performance.instructions.md | `*.al` | ✅ Always |

### Layer 2: Contextual Instructions

| File | Applies To | Triggers |
|------|-----------|----------|
| al-error-handling.instructions.md | `*.al` | Error handling code |
| al-events.instructions.md | `*.al` | Event-related code |
| al-testing.instructions.md | `*.al`, `app.json` | Test files |

### Layer 3: Task-Specific Prompts

| Prompt | Command | Tools |
|--------|---------|-------|
| al-workspace.prompt.md | `@workspace use al-workspace` | al_new_project, al_go, al_download_symbols |
| al-build.prompt.md | `@workspace use al-build` | al_build, al_package, al_publish |
| al-events.prompt.md | `@workspace use al-events` | al_insert_event, al_open_Event_Recorder |
| al-debug.prompt.md | `@workspace use al-debug` | al_debug_without_publish, al_snapshots |
| al-performance.prompt.md | `@workspace use al-performance` | al_generate_cpu_profile_file |
| al-permissions.prompt.md | `@workspace use al-permissions` | al_generate_permissionset_* |
| al-troubleshoot.prompt.md | `@workspace use al-troubleshoot` | al_clear_credentials_cache |
| al-migrate.prompt.md | `@workspace use al-migrate` | al_download_source, al_get_package_dependencies |
| al-pages.prompt.md | `@workspace use al-pages` | al_open_Page_Designer |
| al-workflow.prompt.md | `@workspace use al-workflow` | Multiple |

### Layer 4: Role-Based Chat Modes

| Mode | Focus | Usage |
|------|-------|-------|
| al-orchestrator.chatmode.md | Strategic routing | Recommended |
| al-architect.chatmode.md | Architecture design | Recommended |
| al-debugger.chatmode.md | Debugging | Optional |
| al-tester.chatmode.md | Testing strategy | Optional |
| al-api.chatmode.md | API development | Optional |
| al-copilot.chatmode.md | AI features | Optional |

## 🧪 Validation

To validate the collection:
```bash
node validate-collections.js
```

Expected output:
```
✅ al-development.collection.yml is valid
✅ All referenced files exist
✅ All frontmatter is correct
✅ Display settings are valid
```

## 📝 Maintenance Notes

### Version History

- **2.1** (2025-10-15) - Streamlined chat modes
  - Archived 5 duplicate chatmodes to maintain focus
  - Kept 6 core strategic chatmodes (orchestrator, architect, debugger, tester, api, copilot)
  - Updated documentation to reflect 24 total tools
  - Integrated practical examples into master guide

- **2.0** (2025-01-15) - Compliance with contribution guidelines
  - Renamed all prompts to `.prompt.md`
  - Renamed all chat modes to `.chatmode.md`
  - Added collection manifest and documentation
  - Moved chat modes to `chatmodes/` directory

- **1.0** (2025-01-15) - Initial creation
  - 10 prompts
  - 6 modes
  - 7 instructions
  - Integration docs

### Future Enhancements
- Analytics on tool usage
- User feedback integration
- Performance metrics
- BC version-specific variants

## 🎓 For Contributors

When adding to this collection:

1. **Follow naming conventions** strictly
   - Instructions: `name.instructions.md`
   - Prompts: `name.prompt.md`
   - Chat modes: `name.chatmode.md`

2. **Update the manifest** (`al-development.collection.yml`)
   - Add new items with correct `kind`
   - Update display ordering if needed

3. **Test thoroughly**
   - Verify file works with Copilot
   - Run validation script
   - Update documentation

4. **Document changes**
   - Update `al-development.md` for users
   - Update this file for maintainers
   - Note in version history

---

**Maintained by**: javiarmesto  
**Collection Status**: ✅ Ready for contribution  
**Validation**: ✅ Passing  
**Documentation**: ✅ Complete