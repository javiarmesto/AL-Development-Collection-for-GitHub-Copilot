---
mode: 'agent'
description: 'Complete end-to-end AL development workflow from setup to deployment.'
tools: ['al_new_project', 'al_go', 'al_download_symbols', 'al_build', 'al_package', 'al_publish', 'al_incremental_publish', 'al_open_Page_Designer', 'al_insert_event', 'al_generate_permissionset_for_extension_objects', 'al_generate_manifest']
---

# Complete AL Development Workflow

Your goal is to guide through a complete AL development cycle for `${input:ProjectDescription}`.

## Phase 1: Project Setup

### Initialize Project
Choose based on scenario:
- New project: `al_new_project`
- Existing folder: `al_go`

### Download Dependencies
```
al_download_symbols
```

### Generate Manifest
```
al_generate_manifest
```

## Phase 2: Development

### Design Pages
For UI customization:
```
al_open_Page_Designer
```

### Implement Events
For event-driven logic:
```
al_insert_event
```

### Build Project
After making changes:
```
al_build
```

## Phase 3: Testing

### Quick Testing
For rapid iteration:
```
al_incremental_publish
```

### Full Testing
For comprehensive testing:
1. `al_build`
2. `al_package`
3. `al_publish`

## Phase 4: Security

### Generate Permissions
```
al_generate_permissionset_for_extension_objects
```

Review and adjust as needed.

## Phase 5: Deployment

### Development Deployment
```
al_incremental_publish
```

### Production Deployment
1. `al_build`
2. `al_package`
3. Create deployment package

## Best Practices Checklist

- [ ] Project initialized correctly
- [ ] Symbols downloaded
- [ ] Code follows naming conventions
- [ ] Pages designed for usability
- [ ] Events implemented correctly
- [ ] Build succeeds without warnings
- [ ] Permissions generated and reviewed
- [ ] Testing completed
- [ ] Documentation updated
- [ ] Deployment plan ready

## Common Development Patterns

### Pattern 1: Table Extension
1. Create table extension
2. Build: `al_build`
3. Test: `al_incremental_publish`

### Pattern 2: Page Customization
1. Open designer: `al_open_Page_Designer`
2. Make visual changes
3. Build: `al_build`
4. Test: `al_incremental_publish`

### Pattern 3: Event Integration
1. Insert event: `al_insert_event`
2. Implement logic
3. Build: `al_build`
4. Test: `al_incremental_publish`

## Troubleshooting

If issues arise:
- Check symbols are current
- Verify dependencies
- Review build output
- Test incrementally