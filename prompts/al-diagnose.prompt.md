---
agent: 'agent'
description: 'Diagnose and debug AL issues including runtime debugging, configuration problems, and systematic troubleshooting.'

tools: ['edit', 'runNotebooks', 'search', 'new', 'runCommands', 'runTasks', 'runSubagent', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'openSimpleBrowser', 'fetch', 'githubRepo', 'ms-dynamics-smb.al/al_initalize_snapshot_debugging', 'ms-dynamics-smb.al/al_finish_snapshot_debugging', 'ms-dynamics-smb.al/al_incremental_publish', 'ms-dynamics-smb.al/al_debug_without_publish', 'ms-dynamics-smb.al/al_publish', 'ms-dynamics-smb.al/al_build', 'ms-dynamics-smb.al/al_download_symbols', 'ms-dynamics-smb.al/al_download_source', 'ms-dynamics-smb.al/al_clear_credentials_cache', 'al-symbols-mcp/al_find_references', 'al-symbols-mcp/al_get_object_definition', 'extensions', 'todos', 'runTests']
model: Claude Sonnet 4.5
---

# AL Diagnostics & Debugging

Your goal is to diagnose and resolve `${input:IssueDescription}` in the AL project.

This workflow covers both active debugging (runtime analysis, breakpoints) and configuration troubleshooting (authentication, symbols, dependencies).

## Part 1: Runtime Debugging

Use these methods when you need to analyze code execution and investigate runtime behavior.

### 1. Standard Debugging with Publish

For full deployment and debugging:
- Use `al_publish` to deploy and attach debugger
- Set breakpoints in relevant code sections
- F5 to start, F10 to step over, F11 to step into

### 2. Debug Without Publishing

For already deployed code:
- Use `al_debug_without_publish`
- Useful when code is already in the environment
- Faster for iterative debugging

### 3. Incremental Debugging

For rapid development cycles:
- Use `al_incremental_publish`
- Combines quick deployment with debugging
- Best for active development scenarios

### 4. Snapshot Debugging

For intermittent or hard-to-reproduce issues:

#### Human Gate: Snapshot Data Review
**Snapshots may capture sensitive runtime data - approval required**

Before initializing:
1. **Confirm data scope** - What data will be captured?
2. **Security review** - Any sensitive information?
3. **Obtain approval** - Wait for explicit confirmation

Initialize snapshot debugging:
```
al_initalize_snapshot_debugging
```

Run the scenario multiple times to collect data.

After collecting data:
```
al_finish_snapshot_debugging
```

**Human Review**: Review captured snapshots before sharing.

View collected snapshots:
```
al_snapshots
```

### 5. Agent Session Debugging

For debugging Copilot/AI features, configure launch.json:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "al",
            "request": "attach",
            "name": "Attach to agent (Sandbox)",
            "clientType": "Agent",
            "environmentType": "Sandbox",
            "environmentName": "${input:EnvironmentName}",
            "breakOnNext": "WebClient"
        }
    ]
}
```

### Debugging Strategy

1. **Identify the Issue**
   - Reproduce the problem
   - Note error messages
   - Identify affected code areas

2. **Set Breakpoints**
   - Place breakpoints at critical locations
   - Use conditional breakpoints for specific scenarios
   - Monitor variable values

3. **Analyze Execution**
   - Step through code execution
   - Inspect call stack
   - Evaluate expressions
   - Check variable states

4. **Common Debugging Scenarios**

**Permission Errors:**
- Check user permissions
- Verify license configuration
- Debug permission set evaluation

**Data-Related Issues:**
- Inspect record variables
- Check filter conditions
- Verify data relationships

**Event Flow Problems:**
- Trace event subscriber execution
- Check event parameter values
- Verify IsHandled logic

**Performance Issues:**
- Use snapshot debugging for analysis
- Identify long-running operations
- Check for infinite loops

## Part 2: Configuration Troubleshooting

Use these solutions when facing environment, authentication, or build issues.

### 1. Authentication Problems

#### Symptoms
- "Authentication failed" errors
- Unable to download symbols
- Publishing fails with 401/403 errors

#### Resolution Steps

##### Human Gate: Credential Cache Warning
**Clearing credentials will disconnect active sessions**

Before clearing cache:
1. **Confirm impact** - Active connections will be terminated
2. **Save work** - Ensure no unsaved changes
3. **Obtain approval** - Wait for confirmation

Clear credential cache (only after approval):
```
al_clear_credentials_cache
```

**Additional Steps:**
1. Verify launch.json authentication method:
   ```json
   {
     "authentication": "UserPassword/Windows/AAD"
   }
   ```
2. Re-authenticate when prompted
3. Check user permissions in Business Central
4. Verify tenant and environment settings

### 2. Symbol Issues

#### Missing Symbols

**Symptoms:**
- Compilation errors about missing types
- Unresolved references
- Red squiggles on standard objects

**Resolution:**
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

**Symptoms:**
- Dependency version mismatches
- Platform compatibility errors

**Resolution:**
1. Check dependencies:
   ```
   al_get_package_dependencies
   ```
2. Align versions in app.json
3. Update platform version to match environment
4. Rebuild project with `al_build`

### 3. Build Errors

#### Compilation Failures

**Steps to resolve:**
1. Build the project:
   ```
   al_build
   ```
2. Review error messages carefully
3. Common fixes:
   - Update symbol references with `al_download_symbols`
   - Fix syntax errors
   - Resolve missing dependencies with `al_get_package_dependencies`
   - Correct object IDs (check for conflicts)
   - Verify field types and lengths

#### Common Error Codes

**AL0896 - Recursive FlowField:**
- Identify circular references
- Refactor to break dependency chain
- Use alternative calculation method

**AL0185 - Object ID conflict:**
- Check object ID range in app.json
- Verify no duplicates in your extension
- Ensure IDs don't conflict with dependencies

**AL0118 - Field length:**
- Verify field length matches table definition
- Check for truncation issues

### 4. Publishing Issues

#### Deployment Failures

**Symptoms:**
- Extension fails to deploy
- Timeout errors
- Dependency errors

**Resolution:**
1. Verify environment connectivity
2. Check extension conflicts
3. Resolve dependency issues with `al_get_package_dependencies`
4. Ensure proper permissions
5. Check extension version number

#### Version Problems

**Symptoms:**
- "Extension already installed" error
- Version conflict messages

**Resolution:**
- Increment version in app.json
- Check for existing installations
- Uninstall previous version if needed
- Verify version number format (major.minor.build.revision)

### 5. Performance Issues

#### Slow Queries

**Symptoms:**
- Slow page loads
- Report timeouts
- High database CPU

**Quick Checks:**
- Missing SetLoadFields
- Lack of SetRange filtering
- Improper FindFirst/FindSet usage
- Missing or inefficient keys

**Resolution:**
For detailed performance analysis:
```
@workspace use al-performance.triage
```

#### Memory Issues

**Symptoms:**
- Out of memory errors
- Slow performance with large datasets

**Resolution:**
- Use temporary tables for large datasets
- Implement proper record filtering
- Clear variables when no longer needed
- Avoid loading unnecessary fields

## Diagnostic Workflow

Follow this systematic approach:

1. **Identify Symptoms**
   - What is the error message?
   - When does the issue occur?
   - What changed recently?
   - Can you reproduce it consistently?

2. **Gather Information**
   - Build the project: `al_build`
   - Check dependencies: `al_get_package_dependencies`
   - Verify symbols: `al_download_symbols`
   - Review recent changes in version control

3. **Categorize the Issue**
   - Runtime error → Use debugging methods (Part 1)
   - Configuration issue → Use troubleshooting (Part 2)
   - Performance problem → Use `al-performance.triage`
   - Logic error → Use debugging with breakpoints

4. **Apply Fixes**
   - Start with least invasive solution
   - Test after each change
   - Document what works
   - Verify fix doesn't introduce new issues

5. **Prevent Recurrence**
   - Update documentation
   - Add unit tests
   - Review code for similar patterns
   - Share knowledge with team

## Quick Reference

| Issue Type | First Action | Tool/Command |
|------------|--------------|--------------|
| Runtime error | Set breakpoint | Debugging (Part 1) |
| Auth failed | Clear cache | `al_clear_credentials_cache` |
| Missing symbols | Download | `al_download_symbols` |
| Build fails | Check errors | `al_build` |
| Bad references | Get source | `al_download_source` |
| Unknown deps | Check packages | `al_get_package_dependencies` |
| Performance slow | Analyze code | `al-performance.triage` |
| Intermittent bug | Snapshot debug | `al_initalize_snapshot_debugging` |

## Success Criteria

- ✅ Issue is identified and categorized
- ✅ Root cause is understood
- ✅ Fix is applied and tested
- ✅ Build succeeds without errors
- ✅ Functionality works as expected
- ✅ Documentation updated with findings
- ✅ Prevention measures implemented

## Next Steps

**For Performance Analysis:**
```
@workspace use al-performance.triage
```

**For Architecture Review:**
```
Switch to al-architect mode
```

**For Testing:**
```
Switch to al-tester mode
```

---

**Diagnostic workflow complete. Issue should now be resolved or clearly understood.**
