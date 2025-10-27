---
agent: 'agent'
description: 'Analyze and optimize AL code performance using profiling tools and best practices.'
tools: ['al_generate_cpu_profile_file', 'al_clear_profile_codelenses', 'al_build']
---

# AL Performance Analysis

Your goal is to analyze and optimize performance for `${input:PerformanceIssue}`.

## Performance Analysis Process

### 1. Generate Performance Profile
Generate CPU profile:
```
al_generate_cpu_profile_file
```

### 2. Analyze Profile Results
- Identify hotspots (functions with high execution time)
- Find frequently called procedures
- Detect inefficient loops
- Locate expensive database operations

### 3. Common Performance Issues

#### FlowField Recursive Dependencies (AL0896)
**Problem**: Circular FlowField references causing infinite evaluation

**Solution**: 
- Break circular dependencies
- Use regular fields with triggers
- Implement alternative calculation methods

#### Inefficient Queries
**Problem**: Missing keys, poor filtering

**Solution**:
- Add appropriate keys
- Use SetLoadFields for partial records
- Optimize filter sequences

#### Loop Optimization
**Problem**: Nested loops with database calls

**Solution**:
```al
// Bad
repeat
    OtherTable.SetRange(Field, MainTable.Field);
    if OtherTable.FindSet() then
        repeat
            // Process
        until OtherTable.Next() = 0;
until MainTable.Next() = 0;

// Good
if OtherTable.FindSet() then
    repeat
        TempTable.Init();
        TempTable.TransferFields(OtherTable);
        TempTable.Insert();
    until OtherTable.Next() = 0;
```

### 4. Performance Best Practices

#### Database Access
- Use partial records with SetLoadFields
- Minimize round trips
- Use temporary tables for complex calculations
- Implement appropriate keys

#### Code Structure
- Avoid recursive procedures
- Cache calculated values
- Use lazy evaluation
- Minimize event subscriber overhead

#### FlowFields
- Avoid complex CalcFormula
- Check for circular dependencies
- Consider alternative implementations
- Use SumIndexFields when possible

### 5. Clean Up

#### Human Gate: Profile Data Removal Confirmation
**Clearing codelenses will remove performance analysis data**

Before clearing:
1. **Confirm analysis is complete** - All data captured?
2. **Save important findings** - Document bottlenecks identified
3. **Obtain approval** - Wait for confirmation to proceed

Clear profiling code lenses after analysis (only after approval):
```
al_clear_profile_codelenses
```

## Optimization Workflow

1. **Measure**: Generate baseline profile with `al_generate_cpu_profile_file`
2. **Analyze**: Identify bottlenecks
3. **Optimize**: Apply targeted fixes
4. **Verify**: Re-profile to confirm improvements
5. **Clean**: Use `al_clear_profile_codelenses` to clean workspace
6. **Document**: Record optimization decisions

## Performance Targets

- Page load: < 2 seconds
- Report generation: < 10 seconds for standard data
- API calls: < 500ms response time
- Batch processing: > 1000 records/minute