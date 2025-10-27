---
agent: agent
model: Claude Sonnet 4.5
description: 'Analyze AL codebase to identify performance bottlenecks, circular dependencies, or FlowField inefficiencies.'
tools: ['edit', 'runNotebooks', 'search', 'new', 'runCommands', 'runTasks', 'runSubagent', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'openSimpleBrowser', 'fetch', 'githubRepo', 'extensions', 'todos', 'runTests']
---

# AL Performance Triage Workflow

Your goal is to review the AL code to detect **inefficient queries, FlowFields, and circular dependencies** that may degrade Business Central performance.

## Context

This workflow systematically analyzes AL code under `${input:Path}` (or entire repository if not specified) to identify and prioritize performance issues. The focus is on detection and ranking, not automatic fixing.

## Guardrails

**Deterministic Requirements:**
- Do not modify source code automatically
- Focus on identifying and ranking hotspots
- Provide actionable recommendations only
- Stop if no performance issues found or insufficient data available

## Process

### 1. Code Analysis

#### Load Target Files

Use `codebase` to analyze:
```
codebase: Load all .al files under ${input:Path}
```

If no path specified, analyze entire repository structure focusing on:
- `/src` directory
- Table and TableExtension objects
- Page and PageExtension objects
- Codeunit objects with business logic
- Report objects

#### Detect Problems

Use `problems` to gather:
```
problems: Check for performance-related warnings and errors
```

Look specifically for:
- FlowField warnings (AL0896 - circular dependencies)
- Query performance hints
- Index usage recommendations

### 2. Performance Hotspot Detection

#### Inefficient Queries

**Find patterns:**
```al
// Red flags:
- FindFirst without SetLoadFields
- FindSet without filtering
- Repeat loops with nested database calls
- Missing key usage
- Unfiltered table scans
```

**Detection criteria:**
- Database calls inside loops
- Missing SetRange before Find operations
- Lack of SetLoadFields for partial records
- Multiple CalcFields in loops

#### FlowField Issues

**Check for:**
- Circular FlowField references (Table A → Table B → Table A)
- Complex CalcFormula expressions
- FlowFields without appropriate indexes
- Excessive FlowField calculations in loops
- Missing SumIndexField opportunities

**Common problem patterns:**
```al
// Circular dependency example:
Table "Customer": FlowField references "Sales Statistics"
Table "Sales Statistics": FlowField references "Customer"

// Solution: Break the circle or use direct calculation
```

#### Loop Optimization Issues

**Identify:**
- Nested loops with database operations
- Repeat-until with unoptimized queries
- Record modifications inside loops
- Commit statements in loops

**Example problems:**
```al
// Bad pattern:
repeat
    OtherTable.SetRange(Field, MainTable.Field);
    if OtherTable.FindSet() then
        repeat
            // Nested database access
        until OtherTable.Next() = 0;
until MainTable.Next() = 0;
```

#### Missing Optimizations

**Look for:**
- Tables without appropriate keys
- Missing SetLoadFields usage
- Inefficient SetRange/SetFilter usage
- Unnecessary field loading
- Redundant database calls

### 3. Impact Assessment

For each finding, evaluate:

**Severity Levels:**
- 🔴 **Critical**: Causes significant performance degradation, affects multiple users
- 🟡 **High**: Noticeable impact, specific scenarios affected
- 🟢 **Medium**: Minor impact, optimization opportunity
- 🔵 **Low**: Best practice suggestion, minimal current impact

**Impact Factors:**
- Frequency of execution
- Data volume processed
- Number of affected users
- Response time impact

### 4. Generate Report

#### Human Gate: Report Content Review
**Performance reports may contain sensitive code patterns**

Before saving report:
1. **Review findings** - Ensure no sensitive information exposed
2. **Validate recommendations** - Confirm suggestions are appropriate
3. **Obtain approval** - Wait for confirmation before creating file

Create `/reports/perf-summary.md` with findings (only after approval):

#### Report Structure

```markdown
# Performance Triage Report

**Repository:** [Repository Name]
**Analysis Path:** ${input:Path}
**Date:** [Current Date]
**Total Issues Found:** [Count]

## Executive Summary

Brief overview of findings and overall health assessment.

## Findings by Severity

### 🔴 Critical Issues ([Count])

| Location | Issue | Impact | Recommendation |
|----------|-------|--------|----------------|
| [File:Line] | [Description] | [Impact details] | [Fix suggestion] |

### 🟡 High Priority Issues ([Count])

| Location | Issue | Impact | Recommendation |
|----------|-------|--------|----------------|
| [File:Line] | [Description] | [Impact details] | [Fix suggestion] |

### 🟢 Medium Priority Issues ([Count])

[Similar table structure]

### 🔵 Low Priority Issues ([Count])

[Similar table structure]

## Detailed Analysis

### Issue 1: [Title]

**Location:** `[FileName.al:LineNumber]`  
**Object:** [Object Type and Name]  
**Severity:** [Critical/High/Medium/Low]

**Description:**
[Detailed explanation of the issue]

**Current Code:**
```al
[Code snippet showing the problem]
```

**Impact:**
- Performance: [Specific impact on response time]
- Frequency: [How often this code executes]
- Users Affected: [Who experiences this]

**Recommendation:**
```al
[Suggested optimized code]
```

**Rationale:**
[Why this change improves performance]

[Repeat for each significant issue]

## Common Patterns Found

### Pattern 1: [Pattern Name]
- **Occurrences:** [Count]
- **Locations:** [List of files]
- **Fix Strategy:** [General approach]

## Performance Optimization Priorities

1. **Quick Wins** (Low effort, high impact)
   - [List specific recommendations]

2. **Strategic Improvements** (Medium effort, medium-high impact)
   - [List specific recommendations]

3. **Long-term Optimizations** (High effort, variable impact)
   - [List specific recommendations]

## Refactoring Patterns

### FlowField Optimization
- Break circular dependencies
- Use direct queries where appropriate
- Implement SumIndexFields

### Query Optimization
- Add SetLoadFields for partial records
- Implement proper key usage
- Optimize filter sequences

### Loop Optimization
- Move database calls outside loops
- Use temporary tables for complex calculations
- Batch operations where possible

## Next Steps

> **Ready for Deep Analysis**
> 
> For detailed runtime profiling and performance debugging:
> 
> Switch to `al-debug-mode` using:
> ```
> @workspace use al-debug-mode
> ```
> 
> The debugger will help with:
> - Runtime profiling
> - Snapshot debugging for intermittent issues
> - Detailed execution analysis
```

### 5. Include Metrics

Add performance metrics section:

```markdown
## Performance Metrics

**Code Analysis:**
- Files Analyzed: [Count]
- Objects Reviewed: [Count]
- Potential Issues: [Count]

**Severity Distribution:**
- Critical: [Count] ([Percentage]%)
- High: [Count] ([Percentage]%)
- Medium: [Count] ([Percentage]%)
- Low: [Count] ([Percentage]%)

**Estimated Impact:**
- High-traffic paths affected: [Count]
- Potential time savings: [Estimate]
- Users impacted: [Estimate]
```

## Output

**Primary:** `/reports/perf-summary.md`  
**Format:** Structured markdown with tables and code examples

**Contents:**
- Executive summary
- Detailed findings by severity
- Specific AL object names and line references
- Code examples (current vs. optimized)
- Actionable recommendations
- Prioritized action plan

## Handoff

**To:** `al-debug-mode`  
**When:** Profiling or runtime analysis is needed for deeper investigation  
**Purpose:** Conduct detailed performance profiling and execution analysis

## Success Criteria

- ✅ Performance summary generated under `/reports/perf-summary.md`
- ✅ Each finding includes location, impact, and recommendation
- ✅ Issues are ranked by severity and impact
- ✅ Code examples show both problem and solution
- ✅ Recommendations are specific and actionable
- ✅ Next steps are clearly documented

## Common Performance Issues

### Issue 1: Long-Running Queries
**Symptoms:**
- Slow page loads
- Report timeouts
- Database pressure

**Detection:**
- Missing SetLoadFields
- Lack of SetRange filtering
- Improper FindFirst/FindSet usage

**Solution:**
- Add appropriate filters
- Use partial records
- Implement proper keys

### Issue 2: Circular FlowField References (AL0896)
**Symptoms:**
- Infinite evaluation loops
- Stack overflow errors
- Unpredictable calculations

**Detection:**
- Table A FlowField → Table B → Table A reference
- Compiler warnings about circular dependencies

**Solution:**
- Break circular dependencies
- Use regular fields with triggers
- Implement alternative calculation methods

### Issue 3: Inefficient Loops
**Symptoms:**
- Slow batch operations
- High database load
- Timeout on large datasets

**Detection:**
- Nested loops with database calls
- Database operations inside repeat-until
- Missing bulk operations

**Solution:**
- Use temporary tables
- Batch operations
- Move database calls outside loops

### Issue 4: Missing Keys or Indexes
**Symptoms:**
- Table scans on large tables
- Slow queries with filters

**Detection:**
- Queries without corresponding keys
- Performance warnings in problems

**Solution:**
- Add appropriate keys to tables
- Use existing keys effectively
- Consider SumIndexFields

## Tips

- Focus on high-traffic code paths first
- Consider data volume in impact assessment
- Provide specific line numbers and object names
- Include working code examples in recommendations
- Prioritize quick wins for immediate impact
- Document assumptions about data volume and usage patterns
- Consider both current and projected scale
