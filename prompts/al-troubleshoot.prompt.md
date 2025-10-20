---
mode: 'agent'
description: 'Troubleshoot common AL development issues including authentication, symbols, and dependencies.'
tools: ['edit', 'runNotebooks', 'search', 'new', 'runCommands', 'runTasks', 'runSubagent', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'openSimpleBrowser', 'fetch', 'githubRepo', 'ms-dynamics-smb.al/al_build', 'ms-dynamics-smb.al/al_download_symbols', 'ms-dynamics-smb.al/al_download_source', 'ms-dynamics-smb.al/al_clear_credentials_cache', 'extensions', 'todos', 'runTests']
model: gpt-4
---

# AL Development Troubleshooting

Your goal is to diagnose and resolve `${input:IssueDescription}`.

## Common Issues and Solutions

### 1. Authentication Problems

#### Symptoms
- "Authentication failed" errors
- Unable to download symbols
- Publishing fails with 401/403 errors

#### Resolution Steps
1. Clear credential cache:
   ```
   al_clear_credentials_cache
   ```
2. Verify launch.json authentication:
   ```json
   {
     "authentication": "UserPassword/Windows/AAD"
   }
   ```
3. Re-authenticate when prompted
4. Check user permissions in Business Central

### 2. Symbol Issues

#### Missing Symbols
1. Download symbols:
   ```
   al_download_symbols
   ```
2. If persistent, download source:
   ```
   al_download_source
   ```
3. Verify app.json dependencies:
   ```json
   {
     "dependencies": [
       {
         "id": "...",
         "name": "Base Application",
         "publisher": "Microsoft",
         "version": "22.0.0.0"
       }
     ]
   }
   ```

#### Version Conflicts
1. Check dependencies:
   ```
   al_get_package_dependencies
   ```
2. Align versions in app.json
3. Update platform version
4. Rebuild project with `al_build`

### 3. Build Errors

#### Compilation Failures
1. Build the project:
   ```
   al_build
   ```
2. Common fixes:
   - Update symbol references with `al_download_symbols`
   - Fix syntax errors
   - Resolve missing dependencies with `al_get_package_dependencies`
   - Correct object IDs

#### AL0896 - Recursive FlowField
- Identify circular references
- Refactor to break dependency chain
- Use alternative calculation method

### 4. Publishing Issues

#### Deployment Failures
1. Verify environment connectivity
2. Check extension conflicts
3. Resolve dependency issues with `al_get_package_dependencies`
4. Ensure proper permissions

#### Version Problems
- Increment version in app.json
- Check for existing installations
- Use force flag if needed

## Diagnostic Workflow

1. **Identify Symptoms**
   - Error messages
   - When issue occurs
   - Recent changes

2. **Gather Information**
   - Build the project: `al_build`
   - Check dependencies: `al_get_package_dependencies`
   - Verify symbols: `al_download_symbols`

3. **Apply Fixes**
   - Start with least invasive
   - Document what works
   - Test thoroughly

4. **Prevent Recurrence**
   - Update documentation
   - Adjust procedures
   - Share knowledge

## Quick Fixes Reference

| Issue | Command | Notes |
|-------|---------|-------|
| Auth failed | `al_clear_credentials_cache` | Re-auth required |
| Missing symbols | `al_download_symbols` | Check versions |
| Bad references | `al_download_source` | Full source access |
| Unknown deps | `al_get_package_dependencies` | Review output |
| Build fails | `al_build` | Check errors |