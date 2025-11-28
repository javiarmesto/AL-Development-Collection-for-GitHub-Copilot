---
agent: agent
model: Claude Sonnet 4.5
description: 'Implement AL events, subscribers, and publishers in Business Central extensions.'
tools: ['runCommands', 'runTasks', 'edit', 'runNotebooks', 'search', 'new', 'Microsoft Docs/*', 'extensions', 'runSubagent', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'openSimpleBrowser', 'fetch', 'githubRepo', 'ms-dynamics-smb.al/al_insert_event', 'al-symbols-mcp/al_search_objects', 'al-symbols-mcp/al_get_object_definition', 'al-symbols-mcp/al_find_references', 'todos', 'runTests']
---

# Implement AL Events

Your goal is to implement event-driven functionality for `${input:EventScenario}`.

## Event Implementation Process

### 1. Event Discovery
- Use `al_open_Event_Recorder` to discover available events
- Record the business process to find relevant events
- Analyze the event flow and parameters

### 2. Event Subscriber Creation
- Use `al_insert_event` to create event subscriber structure
- Implement the following pattern:

```al
[EventSubscriber(ObjectType::[ObjectType], [ObjectId], '[EventName]', '[ElementName]', [SkipOnMissingLicense], [SkipOnMissingPermission])]
local procedure MyEventSubscriber(parameters)
begin
    // Implementation
end;
```

### 3. Event Publisher Creation (if needed)
- Use `al_insert_event` to create custom event publishers
- Follow naming convention: OnBefore/OnAfter + Action

```al
[IntegrationEvent(false, false)]
local procedure OnBeforeMyCustomAction(var Record: Record MyTable; var IsHandled: Boolean)
begin
end;
```

## Event Types

### Integration Events
- For extending standard functionality
- Cannot be disabled by users
- Use for critical business logic integration

### Business Events
- Can be disabled by users
- Use for optional functionality
- Suitable for external integrations

## Best Practices

1. **Event Naming**
   - OnBefore[Action] - For validation/modification
   - OnAfter[Action] - For additional processing
   - Include IsHandled parameter for OnBefore events

2. **Parameter Guidelines**
   - Pass records by reference (var) when modification is expected
   - Include sender/source information
   - Add context parameters for complex scenarios

3. **Performance Considerations**
   - Avoid heavy processing in subscribers
   - Use event attributes appropriately
   - Consider subscriber execution order

## Common Scenarios

- Document posting interventions
- Master data validations
- Integration triggers
- Workflow extensions
- UI customizations