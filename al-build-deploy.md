---
mode: 'agent'
description: 'Build, package, and deploy AL extensions to Business Central environments.'
tools: ['al_build', 'al_package', 'al_publish', 'al_incremental_publish', 'al_publish_without_debug', 'al_publish_existing_extension', 'al_full_package']
---

# Build and Deploy AL Extension

Your goal is to build and deploy the AL extension for `${input:DeploymentType}` environment.

## Deployment Types

Based on the deployment type, use the appropriate strategy:

### Development Environment
1. **Build**: Use `al_build` to compile the project
2. **Deploy**: Use `al_incremental_publish` for rapid iteration
3. **Verify**: Check for any compilation errors

### Testing Environment
1. **Build**: Use `al_build` with full validation
2. **Package**: Create .app file with `al_package`
3. **Deploy**: Use `al_publish` to deploy with debugging enabled
4. **Test**: Ensure all unit tests pass

### Production Environment
1. **Build**: Use `al_build` with strict validation
2. **Package**: Create release package with `al_package`
3. **Deploy**: Use `al_publish_without_debug` for production
4. **Verify**: Confirm deployment without debug symbols

### Existing Package Deployment
- Use `al_publish_existing_extension` when deploying pre-built .app files
- Verify package compatibility with target environment

### Full Dependency Package
- Use `al_full_package` when creating packages with all dependencies
- Useful for offline installations or isolated environments

## Error Handling

Monitor the output for:
- Compilation errors
- Dependency conflicts
- Publishing failures
- Permission issues

## Post-Deployment Verification

After deployment:
1. Verify extension appears in Extension Management
2. Check all functionality works as expected
3. Validate permissions are correctly applied
4. Monitor for any runtime errors