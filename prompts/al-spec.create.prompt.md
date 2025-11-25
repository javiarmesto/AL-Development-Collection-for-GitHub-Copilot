---
agent: agent
model: Claude Sonnet 4.5
description: 'Create a structured AL specification document (.spec.md) before starting a new feature or enhancement in Business Central.'
tools: ['runCommands', 'runTasks', 'github/*', 'microsoft-docs/*', 'upstash/context7/*', 'edit', 'runNotebooks', 'search', 'new', 'Microsoft Docs/*', 'Azure MCP/search', 'extensions', 'runSubagent', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'openSimpleBrowser', 'fetch', 'githubRepo', 'ms-vscode.vscode-websearchforcopilot/websearch', 'al-symbols-mcp/al_search_objects', 'al-symbols-mcp/al_get_object_summary', 'todos', 'runTests']
---

# AL Specification Creation Workflow

Your goal is to generate a concise, actionable **functional-technical specification** for `${input:FeatureName}` in the repository.

## Context

The goal is to create a structured specification document that serves as a mini RFP (Request for Proposal) before starting development. This ensures proper planning, identifies dependencies, and establishes clear acceptance criteria.

If `${input:Scope}` is provided, include it as part of the specification context.

## Guardrails

**Deterministic Requirements:**
- Never modify or create real AL objects during specification phase
- Only describe structure, dependencies, and interfaces
- Focus on documentation, not implementation
- Stop if feature already has a spec.md or similar documentation

## Process

### 1. Repository Analysis

Use `codebase` to review existing project structure:
```
codebase: Review /src directory and related modules
```

Identify:
- Current naming conventions
- Existing object patterns (tables, pages, codeunits)
- Dependencies and integration points
- Similar features for reference

Use `search` to find:
- Related objects and functionality
- Existing event patterns
- API endpoints (if relevant)
- Test structure

### 2. Specification Structure

Create `/specs/${input:FeatureName}.spec.md` with the following sections:

#### Overview and Purpose
- Brief description of the feature
- Business value and objectives
- Target users or scenarios

#### Object List

Create a table with planned AL objects:

| Object Type | Object ID | Name | Purpose |
|------------|-----------|------|---------|
| Table | TBD | [TableName] | Data storage for... |
| Page | TBD | [PageName] | User interface for... |
| Codeunit | TBD | [CodeunitName] | Business logic for... |
| Report | TBD | [ReportName] | Reporting for... |

#### Integration Points

Document how this feature connects with existing functionality:

**Events:**
- Subscribe to: [Event publisher and subscriber details]
- Publish: [New events this feature will expose]

**APIs:**
- Endpoints: [If exposing or consuming APIs]
- Authentication: [Security requirements]

**Dependencies:**
- Required extensions or modules
- Database dependencies
- External system integrations

#### Field-Level Details

For each table, provide field specifications:

| Field Name | Type | Length | Required | Description |
|-----------|------|--------|----------|-------------|
| | | | | |

### 3. Acceptance Criteria

Define clear success criteria:

**Functional Requirements:**
- [ ] User can perform [action]
- [ ] System validates [condition]
- [ ] Data is stored in [location]

**Technical Requirements:**
- [ ] Code follows naming conventions
- [ ] Events are properly documented
- [ ] API endpoints follow REST standards
- [ ] Permission sets are defined

**Quality Requirements:**
- [ ] Unit tests cover main scenarios
- [ ] Performance meets standards
- [ ] Documentation is complete

### 4. Validation Checklist

Include a review checklist:

**Design Review:**
- [ ] Object naming follows conventions
- [ ] Dependencies are identified
- [ ] Integration points are clear
- [ ] Security considerations addressed

**Technical Review:**
- [ ] Object IDs are available
- [ ] Database design is normalized
- [ ] Event patterns are appropriate
- [ ] API design follows standards

**Documentation Review:**
- [ ] Specification is complete
- [ ] Examples are provided
- [ ] Edge cases are documented
- [ ] Acceptance criteria are testable

## Output

Create the file `.github/specs/${input:FeatureName}.spec.md` with all sections completed.

Include a "Next Steps" section at the end:

```markdown
## Next Steps

> **Ready for Design Phase**
> 
> This specification is now ready for architectural review. Once approved:
> 
> Switch to `al-architect-mode` using:
> ```
> @workspace use al-architect-mode
> ```
> 
> The architect will help design the detailed solution structure, 
> object relationships, and implementation approach.
```

## Handoff

**To:** `al-architect-mode`  
**When:** The specification is approved and ready for the design phase  
**Purpose:** Translate specification into detailed architectural design

## Success Criteria

- ✅ Structured spec.md file created under `/specs/`
- ✅ Includes tables, codeunits, pages, and API endpoints (if relevant)
- ✅ Integration points are documented
- ✅ Acceptance criteria are clear and testable
- ✅ Validation checklist is complete
- ✅ File follows markdown standards

## Common Specification Patterns

### Pattern 1: Data Extension Feature
- Focus on table structure and fields
- Document page integration points
- Define validation rules

### Pattern 2: Workflow Enhancement
- Map existing workflow touchpoints
- Define event subscribers needed
- Specify state management

### Pattern 3: API Integration
- Define endpoint structure
- Document authentication approach
- Specify error handling

### Pattern 4: Report Addition
- Define data sources
- Specify filters and grouping
- Document output format

## Tips

- Keep specifications concise but complete
- Use tables for structured data
- Reference existing objects by name and ID
- Include visual diagrams if helpful
- Consider both happy path and edge cases
- Think about backwards compatibility
- Document any assumptions made
