---
mode: 'agent'
description: 'Set up and conduct AL debugging sessions including standard, snapshot, and agent debugging.'
tools: ['al_publish', 'al_debug_without_publish', 'al_incremental_publish', 'al_initalize_snapshot_debugging', 'al_finish_snapshot_debugging', 'al_snapshots']
---

# AL Debugging Session

Your goal is to set up a debugging session for investigating `${input:DebugScenario}`.

## Debugging Methods

### 1. Standard Debugging with Publish
- Use `al_publish` to deploy and attach debugger
- Set breakpoints in relevant code sections
- F5 to start, F10 to step over, F11 to step into

### 2. Debug Without Publishing
- Use `al_debug_without_publish` for already deployed code
- Useful when code is already in the environment
- Faster for iterative debugging

### 3. Incremental Debugging
- Use `al_incremental_publish` for rapid development
- Combines quick deployment with debugging
- Best for active development scenarios

### 4. Snapshot Debugging
Initialize snapshot debugging:
```
al_initalize_snapshot_debugging
```

After collecting data:
```
al_finish_snapshot_debugging
```

View collected snapshots:
```
al_snapshots
```

### 5. Agent Session Debugging
Configure launch.json:
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

## Debugging Strategy

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

4. **Snapshot Analysis** (for intermittent issues)
   - Initialize snapshot debugging with `al_initalize_snapshot_debugging`
   - Run the scenario multiple times
   - Finish with `al_finish_snapshot_debugging`
   - Analyze collected snapshots using `al_snapshots`

## Common Debugging Scenarios

### Permission Errors
- Check user permissions
- Verify license configuration
- Debug permission set evaluation

### Data-Related Issues
- Inspect record variables
- Check filter conditions
- Verify data relationships

### Event Flow Problems
- Trace event subscriber execution
- Check event parameter values
- Verify IsHandled logic

### Performance Issues
- Use snapshot debugging for analysis
- Identify long-running operations
- Check for infinite loops