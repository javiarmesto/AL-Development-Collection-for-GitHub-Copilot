# AL Development Prompts - Parameter Documentation

This document provides a comprehensive overview of all prompts in the AL Development Collection and their parameter usage.

## Summary

The collection includes **10 task-specific prompts** that can be invoked using:
```
@workspace use [prompt-name]
```

## Parameter Analysis

### Current Parameter Usage

All prompts currently use `${input:ParameterName}` variables in their goal statement. These parameters are **optional** and serve to provide context. The prompts work with or without these parameters as GitHub Copilot can understand context from:
- User's natural language request
- Current workspace files
- Open files and code context
- Conversation history

### Recommendation

**Parameters are NOT strictly necessary** for prompt functionality. They are primarily used for:
1. Making the goal statement more specific
2. Providing a placeholder for users to understand what context to provide
3. Consistency with VS Code input variable patterns

Users can simply invoke prompts and describe their needs in natural language, and Copilot will understand the context.

## Prompt Reference Table

| Prompt Name | Command | Parameters | Parameter Description | Required? | Example Values |
|-------------|---------|------------|----------------------|-----------|----------------|
| **al-workspace** | `@workspace use al-workspace` | `ProjectName` | Name of the AL project to set up | No | "CustomerManagement", "SalesExtension", "InventoryApp" |
| **al-build** | `@workspace use al-build` | `DeploymentType` | Target environment for deployment | No | "Development", "Testing", "Production", "Existing Package Deployment", "Full Dependency Package" |
| **al-events** | `@workspace use al-events` | `EventScenario` | Event functionality to implement | No | "Document posting", "Master data validation", "Integration trigger", "Workflow extension", "UI customization" |
| **al-debug** | `@workspace use al-debug` | `DebugScenario` | Issue or scenario to debug | No | "Permission error", "Data issue", "Event flow problem", "Performance bottleneck", "Runtime error" |
| **al-performance** | `@workspace use al-performance` | `PerformanceIssue` | Performance problem to analyze | No | "Slow report", "Page loading", "Batch processing", "FlowField calculation", "AL0896 recursive error" |
| **al-permissions** | `@workspace use al-permissions` | `ExtensionName` | Extension to generate permissions for | No | "MyCustomExtension", "SalesEnhancement", "InventoryTools" |
| **al-troubleshoot** | `@workspace use al-troubleshoot` | `IssueDescription` | Problem to diagnose and resolve | No | "Authentication failed", "Missing symbols", "Build error", "Publishing fails", "Version conflict" |
| **al-migrate** | `@workspace use al-migrate` | `SourceVersion`, `TargetVersion` | Current and target BC versions | No | Source: "BC 20.x", "BC 21.x", "BC 22.x"<br>Target: "BC 21.x", "BC 22.x", "BC 23.x", "BC 24.x" |
| **al-pages** | `@workspace use al-pages` | `PagePurpose` | Purpose of the page to design | No | "Customer card enhancement", "Sales list", "Document page", "Worksheet", "Role Center", "Mobile view" |
| **al-workflow** | `@workspace use al-workflow` | `ProjectDescription` | Description of the project workflow | No | "New sales feature", "API integration", "Report development", "Page customization" |

## Parameter Details by Prompt

### al-workspace
**Parameter:** `ProjectName`
- **Purpose:** Identifies the AL project being set up
- **Used in:** Goal statement only
- **Can be omitted:** Yes - Copilot will ask or infer from context
- **Alternative:** Simply state "I need to set up an AL workspace for customer management"

---

### al-build
**Parameter:** `DeploymentType`
- **Purpose:** Specifies target deployment environment
- **Used in:** Goal statement and workflow selection
- **Can be omitted:** Yes - User can specify in natural language
- **Options:**
  - **Development Environment:** Fast iteration with `al_incremental_publish`
  - **Testing Environment:** Full validation with debugging enabled
  - **Production Environment:** Release build without debug symbols
  - **Existing Package Deployment:** Deploy pre-built .app files
  - **Full Dependency Package:** Package with all dependencies for offline install

---

### al-events
**Parameter:** `EventScenario`
- **Purpose:** Describes the event functionality to implement
- **Used in:** Goal statement only
- **Can be omitted:** Yes - User describes scenario naturally
- **Common scenarios:**
  - Document posting interventions
  - Master data validations
  - Integration triggers
  - Workflow extensions
  - UI customizations

---

### al-debug
**Parameters:** `DebugScenario`, `EnvironmentName` (in code example)
- **Purpose:** Identifies what needs to be debugged
- **Used in:** Goal statement and example configuration
- **Can be omitted:** Yes for DebugScenario; EnvironmentName is a VS Code variable
- **Debugging methods:**
  - Standard debugging with publish
  - Debug without publishing
  - Incremental debugging
  - Snapshot debugging (for intermittent issues)
  - Agent session debugging

**Note:** `${input:EnvironmentName}` in launch.json is a VS Code input variable, not a prompt parameter.

---

### al-performance
**Parameter:** `PerformanceIssue`
- **Purpose:** Specifies the performance problem to analyze
- **Used in:** Goal statement only
- **Can be omitted:** Yes - User describes the issue
- **Common issues:**
  - FlowField recursive dependencies (AL0896)
  - Inefficient queries
  - Loop optimization needs
  - Database access patterns
  - Code structure problems

---

### al-permissions
**Parameter:** `ExtensionName`
- **Purpose:** Identifies which extension needs permissions
- **Used in:** Goal statement only
- **Can be omitted:** Yes - Inferred from workspace context
- **Permission types:**
  - AL Permission Set Object (`.al` file)
  - XML Permission Set (legacy format)
  - Role-based permission sets (Base, User, Admin)

---

### al-troubleshoot
**Parameter:** `IssueDescription`
- **Purpose:** Describes the problem to troubleshoot
- **Used in:** Goal statement only
- **Can be omitted:** Yes - User describes issue naturally
- **Common issues:**
  - Authentication problems
  - Symbol issues (missing or version conflicts)
  - Build errors
  - Publishing failures
  - AL0896 recursive FlowField errors

---

### al-migrate
**Parameters:** `SourceVersion`, `TargetVersion`
- **Purpose:** Specifies migration path between BC versions
- **Used in:** Goal statement and example configurations
- **Can be omitted:** Yes - User specifies versions in description
- **Version paths:**
  - BC 20.x → BC 21.x
  - BC 21.x → BC 22.x
  - BC 22.x → BC 23.x
  - BC 23.x → BC 24.x

**Note:** `${input:TargetVersion}` in app.json example is a placeholder for documentation, not an active VS Code variable.

---

### al-pages
**Parameter:** `PagePurpose`
- **Purpose:** Describes the page design intent
- **Used in:** Goal statement only
- **Can be omitted:** Yes - Described in user request
- **Page types:**
  - Card Pages (single record display)
  - List Pages (multiple records)
  - Document Pages (header/lines structure)
  - Worksheet Pages (data entry)
  - Role Centers (user dashboards)
  - Page Extensions (customizing existing pages)

---

### al-workflow
**Parameter:** `ProjectDescription`
- **Purpose:** Overall project description for end-to-end guidance
- **Used in:** Goal statement only
- **Can be omitted:** Yes - User describes their project
- **Workflow phases:**
  - Phase 1: Project Setup
  - Phase 2: Development
  - Phase 3: Testing
  - Phase 4: Security
  - Phase 5: Deployment

---

## Usage Recommendations

### Without Parameters (Recommended)
Simply invoke the prompt and describe your needs:

```
@workspace use al-workspace
"I need to set up a new AL project for customer management"
```

```
@workspace use al-build
"Deploy this to our testing environment"
```

```
@workspace use al-debug
"I'm getting a permission error when posting sales orders"
```

### With Parameters (Optional)
If you prefer structured input, you can provide context in your description:

```
@workspace use al-migrate
"Migrate from BC 22.5 to BC 24.0"
```

```
@workspace use al-performance
"The sales report is taking 30 seconds to generate with large datasets"
```

## Technical Notes

### VS Code Input Variables
Some prompts include `${input:VariableName}` in example code snippets (e.g., launch.json, app.json). These are:
- **VS Code input variables** for use in configuration files
- **NOT** prompt parameters
- **Examples** for users to implement in their own configurations

### Prompt Parameter vs Configuration Variable

| Type | Location | Purpose | Required |
|------|----------|---------|----------|
| **Prompt Parameter** | Goal statement (`Your goal is...`) | Context for Copilot | No |
| **VS Code Input Variable** | Configuration file examples | Runtime configuration | Depends on VS Code |

## Future Considerations

### Potential Improvements

1. **Make parameters optional in prompts:**
   - Remove `${input:Parameter}` from goal statements
   - Use more generic goal statements like "Your goal is to guide the user through..."
   - Let Copilot extract context from user's natural language

2. **Add parameter validation:**
   - If parameters are kept, document valid values
   - Provide autocomplete suggestions
   - Add parameter schemas

3. **Context-aware prompts:**
   - Detect current workspace state
   - Infer common scenarios automatically
   - Suggest parameters based on file context

## Conclusion

**All parameters in the prompt files are optional** and serve primarily as placeholders for context. Users can successfully use all prompts by:
1. Invoking the prompt with `@workspace use [prompt-name]`
2. Describing their needs in natural language
3. Providing any necessary context in their message

The parameters do not need to be formally supplied; GitHub Copilot will understand intent from the conversation.

---

**Last Updated:** 2025-10-18  
**Collection Version:** 2.1  
**Total Prompts:** 10
