---
agent: agent
model: Claude Sonnet 4.5
description: 'Migrate AL projects between versions or environments.'
tools: ['edit', 'runNotebooks', 'search', 'new', 'runCommands', 'runTasks', 'microsoft-docs/*', 'runSubagent', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'openSimpleBrowser', 'fetch', 'githubRepo', 'ms-dynamics-smb.al/al_build', 'ms-dynamics-smb.al/al_download_source', 'ms-dynamics-smb.al/al_full_package', 'ms-dynamics-smb.al/al_generate_manifest', 'extensions', 'todos', 'runTests']
---

# AL Project Migration

Your goal is to migrate the AL project from `${input:SourceVersion}` to `${input:TargetVersion}`.

## ⚠️ CRITICAL: Human Gate Required

**STOP - Migration Risk Assessment Required**

Before proceeding with ANY migration steps:
1. **Present migration plan** to stakeholder for review
2. **Confirm backup strategy** is in place
3. **Verify rollback plan** is documented and tested
4. **Obtain explicit approval** before executing migration commands

**Migration involves HIGH RISK operations that can:**
- Break production environments
- Cause data incompatibilities
- Require complex rollbacks
- Impact multiple users simultaneously

**MANDATORY: Wait for human approval before continuing**

---

## Migration Process

### 1. Preparation Phase (Analysis Only - No Changes)

#### Download Current Source
```
al_download_source
```
- Backup current codebase
- Document customizations
- Note dependencies
- **Human Review Required**: Confirm backup is complete

#### Analyze Dependencies
```
al_get_package_dependencies
```
- List all current dependencies
- Check compatibility with target version
- Identify deprecated features

### 2. Migration Steps

#### Human Gate: Configuration Changes
**Present proposed changes and wait for approval before modifying files**

#### Update Project Configuration
1. **Review and Approve**: Present app.json changes:
   ```json
   {
     "platform": "${input:TargetVersion}",
     "runtime": "11.0",
     "target": "Cloud"
   }
   ```

2. **Wait for Approval**: Update dependencies versions (requires confirmation)
3. **Wait for Approval**: Adjust compiler features (requires confirmation)

#### Code Migration
1. **Breaking Changes**
   - Review release notes
   - Update obsolete code patterns
   - Fix deprecated API usage

2. **Common Updates**
   ```al
   // Old pattern
   Record.FIND('-');
   
   // New pattern
   Record.FindSet();
   ```

3. **Event Updates**
   - Check for new mandatory parameters
   - Update event signatures
   - Verify subscriber compatibility

### 3. Regeneration

#### Generate New Manifest
```
al_generate_manifest
```

#### Create Full Package
```
al_full_package
```
- Includes all dependencies
- Ready for deployment
- Version stamped

### 4. Validation

#### Build Verification
```
al_build
```
- Fix compilation errors
- Resolve warnings
- Test functionality

## Version-Specific Considerations

### BC 20.x to 21.x
- UI changes in pages
- New permission model
- API versioning

### BC 21.x to 22.x
- Namespace support
- Async patterns
- Security updates

### BC 22.x to 23.x
- Performance improvements
- New AL capabilities
- Deprecation notices

### BC 23.x to 24.x
- Agent integration capabilities
- Enhanced debugging features
- New AL tools

## Migration Checklist

- [ ] Backup original project
- [ ] Download source with `al_download_source`
- [ ] Document all customizations
- [ ] Check dependencies with `al_get_package_dependencies`
- [ ] Update platform version
- [ ] Fix breaking changes
- [ ] Update dependencies
- [ ] Generate manifest with `al_generate_manifest`
- [ ] Build project with `al_build`
- [ ] Create full package with `al_full_package`
- [ ] Test all functionality
- [ ] Update documentation
- [ ] Plan rollback strategy
- [ ] Schedule migration window

## Post-Migration

1. Performance testing
2. User acceptance testing
3. Monitor for issues
4. Update procedures
5. Train users on changes