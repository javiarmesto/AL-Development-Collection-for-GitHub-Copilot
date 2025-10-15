# File Renaming Plan

## Prompt Files (Shorter, More Usable Names)

### Current → New
1. `al-workspace-setup.md` → `al-workspace.md` ✅
2. `al-build-deploy.md` → `al-build.md` ✅
3. `al-event-implementation.md` → `al-events.md` ✅
4. `al-debugging-session.md` → `al-debug.md` ✅
5. `al-performance-analysis.md` → `al-performance.md` ✅
6. `al-permission-management.md` → `al-permissions.md` ✅
7. `al-troubleshooting.md` → `al-troubleshoot.md` ✅
8. `al-project-migration.md` → `al-migrate.md` ✅
9. `al-page-designer-customization.md` → `al-pages.md` ✅ (MAYOR CAMBIO)
10. `al-complete-workflow.md` → `al-workflow.md` ✅

## Chat Modes (Shorter, Clearer Names)

### Current → New
1. `al-architect-mode.md` → `al-architect.md` ✅
2. `al-debug-mode.md` → `al-debugger.md` ✅ (evita conflicto con prompt)
3. `al-test-mode.md` → `al-tester.md` ✅
4. `al-api-mode.md` → `al-api.md` ✅
5. `al-copilot-mode.md` → `al-copilot.md` ✅
6. `al-orchestrator-mode.md` → `al-orchestrator.md` ✅

## Custom Instructions

### Current → New
`custom-instructions-al-development.md` → `copilot-instructions.md` ✅
(Mover a `.github/copilot-instructions.md`)

## Rationale

**Why shorter names?**
- Easier to type: `@workspace use al-workspace` vs `@workspace use al-workspace-setup`
- More memorable
- Faster to communicate
- Still clear and descriptive

**Why remove `-mode` suffix?**
- Redundant (están en carpeta `modes/`)
- Más limpio
- Consistente con prompt files

**Why specific renames?**
- `al-debugger` vs `al-debug`: Evita conflicto con prompt file
- `al-tester` vs `al-test`: Más claro que es el "rol"
- `al-pages`: Mucho más corto, igualmente claro
- `al-troubleshoot`: Verbo → nombre más natural