---
mode: 'agent'
description: 'Migrate AL projects between versions or environments.'
tools: ['al_download_source', 'al_get_package_dependencies', 'al_generate_manifest', 'al_full_package', 'al_build']
---

# AL Project Migration

Your goal is to migrate the AL project from `${input:SourceVersion}` to `${input:TargetVersion}`.

## Migration Process

### 1. Preparation Phase

#### Download Current Source
```
al_download_source
```
- Backup current codebase
- Document customizations
- Note dependencies

#### Analyze Dependencies
```
al_get_package_dependencies
```
- List all current dependencies
- Check compatibility with target version
- Identify deprecated features

### 2. Migration Steps

#### Update Project Configuration
1. Modify app.json:
   ```json
   {
     "platform": "${input:TargetVersion}",
     "runtime": "11.0",
     "target": "Cloud"
   }
   ```

2. Update dependencies versions
3. Adjust compiler features

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