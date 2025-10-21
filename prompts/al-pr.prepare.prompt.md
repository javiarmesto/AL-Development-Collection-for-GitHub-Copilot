---
mode: 'agent'
description: 'Prepare a clean, documented pull request draft for AL features or fixes with summary, testing notes, and checklist.'
tools: ['edit', 'runNotebooks', 'search', 'new', 'runCommands', 'runTasks', 'github/*', 'runSubagent', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'openSimpleBrowser', 'fetch', 'githubRepo', 'extensions', 'todos', 'runTests']
model: claude-sonnet-4.5
---

# AL Pull Request Preparation Workflow

Your goal is to prepare a **pull request draft** for the branch `${input:Branch}` summarizing all modifications, test evidence, and validation steps.

## Context

This workflow analyzes changes between the feature branch and the main branch, classifies modifications, and creates a comprehensive PR draft document that makes code review efficient and thorough.

## Guardrails

**Deterministic Requirements:**
- Do not create or push PRs automatically
- Only summarize changes, do not execute git operations
- Focus on documentation and analysis
- Stop if branch not found or uncommitted changes present

## 🔒 Human Gate: Pre-PR Review

**Before generating PR draft document:**

1. **Review code changes** - Present summary of all modifications
2. **Security check** - Confirm no sensitive data in commits
3. **Quality validation** - Verify tests pass and build succeeds
4. **Human approval required** - Obtain confirmation before creating PR draft

**Note**: Even though this creates a draft, the document will contain code details that may be shared. Review is mandatory.

## Process

### 1. Change Analysis

#### Inspect Branch Differences

Use `codebase` to analyze modifications:
```
codebase: Compare ${input:Branch} with main branch
```

Use `githubRepo` to gather context:
```
githubRepo: Get branch information and commit history
```

**Gather information about:**
- Modified files and line counts
- New files added
- Deleted files
- Commit messages and references
- Related issues or work items

#### Classify Changes

Categorize each change into:

**1. New Features**
- New AL objects (tables, pages, codeunits)
- New functionality added to existing objects
- New APIs or integrations

**2. Bug Fixes or Refactors**
- Corrections to existing logic
- Code improvements without feature changes
- Performance optimizations
- Technical debt reduction

**3. Test Files**
- New test codeunits
- Test scenario additions
- Test data modifications

**4. Configuration Changes**
- app.json modifications
- Permission set changes
- Dependencies updates
- Manifest changes

**5. Documentation**
- README updates
- Code comments
- Inline documentation
- API documentation

### 2. Extract Metadata

#### Find References

Scan commit messages for:
- Issue references (#123)
- Work item IDs
- Requirement numbers
- User story references
- Bug ticket numbers

**Pattern matching:**
```
- Fixes #123
- Closes #456
- Related to WORK-789
- Implements REQ-001
```

#### Identify Reviewers

If `${input:Reviewer}` is specified, include in the draft.

Consider suggesting reviewers based on:
- Files modified (code owners)
- Subject matter expertise areas
- Previous contributions to related code

### 3. Generate PR Draft

Create `/reports/pr-draft.md` with complete structure:

#### Draft Structure

```markdown
# Pull Request: [Feature/Fix Title]

**Branch:** `${input:Branch}`  
**Target:** `main`  
**Author:** [Author Name]  
**Date:** [Current Date]

## Overview

[Brief description of the changes - 2-3 sentences]

**Type of Change:**
- [ ] New Feature
- [ ] Bug Fix
- [ ] Refactoring
- [ ] Performance Improvement
- [ ] Documentation
- [ ] Configuration Change

## Motivation and Context

[Why was this change necessary? What problem does it solve?]

**Related Issues:**
- Closes #[issue-number]
- Relates to #[issue-number]
- Fixes [work-item-id]

## Changes Summary

### File Changes Overview

| Category | Files Changed | Lines Added | Lines Removed |
|----------|---------------|-------------|---------------|
| New Features | [count] | [+lines] | [-lines] |
| Bug Fixes | [count] | [+lines] | [-lines] |
| Tests | [count] | [+lines] | [-lines] |
| Documentation | [count] | [+lines] | [-lines] |
| **Total** | **[count]** | **[+lines]** | **[-lines]** |

### Detailed Changes

#### New Features

| File | Change Type | Description |
|------|-------------|-------------|
| [FileName.al] | New Object | [Brief description] |
| [FileName.al] | Modified | [What was changed] |

#### Bug Fixes

| File | Issue | Description |
|------|-------|-------------|
| [FileName.al] | #[issue] | [Fix description] |

#### Test Coverage

| Test File | Coverage | Description |
|-----------|----------|-------------|
| [TestFileName.al] | New | [Test scenarios covered] |

#### Configuration Changes

| File | Change | Impact |
|------|--------|--------|
| app.json | [What changed] | [Impact description] |

## AL Objects Modified

### New Objects

| Object Type | ID | Name | Purpose |
|-------------|----|----- |---------|
| Table | [ID] | [Name] | [Purpose] |
| Page | [ID] | [Name] | [Purpose] |
| Codeunit | [ID] | [Name] | [Purpose] |

### Modified Objects

| Object Type | ID | Name | Changes |
|-------------|----|----- |---------|
| TableExtension | [ID] | [Name] | [What changed] |
| PageExtension | [ID] | [Name] | [What changed] |

### Deleted Objects

| Object Type | ID | Name | Reason |
|-------------|----|----- |-------|
| [Type] | [ID] | [Name] | [Why removed] |

## Technical Details

### Architecture Changes

[Describe any architectural or design pattern changes]

### Dependencies

**New Dependencies:**
- [Dependency name and version]

**Modified Dependencies:**
- [Dependency name: old version → new version]

### Database Changes

**Schema Changes:**
- [ ] New tables added
- [ ] New fields added to existing tables
- [ ] Field types modified
- [ ] Keys added or modified

**Migration Notes:**
[Any data migration considerations]

### API Changes

**New Endpoints:**
- `GET /api/[endpoint]` - [Description]
- `POST /api/[endpoint]` - [Description]

**Modified Endpoints:**
- `[Method] /api/[endpoint]` - [What changed]

**Breaking Changes:**
- [List any breaking API changes]

### Events

**New Events Published:**
- [EventName in ObjectName] - [Purpose]

**New Event Subscribers:**
- [SubscriberName subscribes to EventName] - [Purpose]

## Testing Evidence

### Manual Testing

**Test Scenarios Executed:**

1. **Scenario:** [Description]
   - **Steps:** [How to reproduce]
   - **Expected Result:** [What should happen]
   - **Actual Result:** ✅ Pass / ❌ Fail
   - **Evidence:** [Screenshot/Log reference]

2. **Scenario:** [Description]
   - [Same structure]

### Automated Testing

**Test Results:**
- ✅ Unit Tests: [X passed / Y total]
- ✅ Integration Tests: [X passed / Y total]
- ✅ Regression Tests: [X passed / Y total]

**Code Coverage:**
- Overall: [X]%
- New Code: [X]%

**Test Execution Log:**
```
[Paste relevant test output or link to test results]
```

### Performance Testing

**Performance Impact:**
- [ ] No performance impact expected
- [ ] Performance improvement: [Details]
- [ ] Potential performance impact: [Mitigation steps]

**Benchmark Results:**
[If applicable, include before/after metrics]

## Review Checklist

### Code Quality

- [ ] Code follows AL naming conventions
- [ ] Code follows AL style guidelines
- [ ] No compiler warnings
- [ ] No performance anti-patterns
- [ ] Error handling is appropriate
- [ ] Logging is adequate

### Security

- [ ] No hardcoded credentials or secrets
- [ ] Permission sets reviewed and appropriate
- [ ] Input validation implemented
- [ ] Security best practices followed
- [ ] No SQL injection vulnerabilities

### Testing

- [ ] All tests passed successfully
- [ ] New functionality has test coverage
- [ ] Edge cases are tested
- [ ] Regression tests included
- [ ] Manual testing completed

### Documentation

- [ ] Code comments added where necessary
- [ ] API documentation updated
- [ ] README updated if needed
- [ ] Inline help text added for user-facing features
- [ ] Technical documentation updated

### Dependencies and Configuration

- [ ] app.json updated correctly
- [ ] Dependencies are necessary and appropriate
- [ ] Permission sets generated
- [ ] No unnecessary dependencies added
- [ ] Version numbers updated appropriately

### Business Central Specific

- [ ] Object IDs are in correct range
- [ ] Translations handled (if applicable)
- [ ] Event patterns followed correctly
- [ ] Page layouts are user-friendly
- [ ] Report layouts are appropriate

### Deployment

- [ ] Build succeeds without errors
- [ ] Package can be created successfully
- [ ] Deployment steps documented
- [ ] Rollback plan considered
- [ ] Breaking changes documented

## Deployment Notes

### Deployment Steps

1. [Step-by-step deployment instructions]
2. [Configuration changes needed]
3. [Post-deployment verification steps]

### Prerequisites

- [Any prerequisites for deployment]
- [Environment configuration requirements]

### Rollback Plan

[How to rollback if issues are discovered]

## Screenshots

[Include relevant screenshots of UI changes, test results, etc.]

### Before
[Screenshot or description of previous state]

### After
[Screenshot or description of new state]

## Additional Notes

### Known Issues

- [Any known limitations or issues]

### Future Enhancements

- [Potential future improvements]

### Breaking Changes

- [List any breaking changes that affect existing functionality]

## Reviewer Notes

**Suggested Reviewers:**
- ${input:Reviewer} - [Reason for suggestion]
- [Other suggested reviewer] - [Expertise area]

**Review Focus Areas:**
1. [Specific area to review carefully]
2. [Another focus area]

**Questions for Reviewers:**
- [Any specific questions or concerns]

## Next Steps

> **Ready for Review**
> 
> This PR draft is ready to be used for creating the actual pull request.
> 
> **Before submitting:**
> - Ensure all checklist items are completed
> - Verify test evidence is included
> - Confirm all changes are committed and pushed
> 
> **For final validation, switch to `al-test-mode`:**
> ```
> @workspace use al-test-mode
> ```
> 
> The tester will help with:
> - Final regression testing
> - Test coverage verification
> - Quality assurance checks

---

**Generated by:** AL PR Preparation Workflow  
**Generated on:** [Timestamp]  
**Ready for:** GitHub Pull Request Creation
```

## Output

**Primary:** `/reports/pr-draft.md`  
**Format:** Complete markdown document ready for PR creation

**Contents:**
- Comprehensive change summary
- Detailed file-by-file analysis
- Testing evidence and results
- Complete review checklist
- Deployment instructions
- Screenshots (where applicable)

## Handoff

**To:** `al-test-mode`  
**When:** Validation or regression testing is incomplete  
**Purpose:** Ensure comprehensive testing before final PR submission

## Success Criteria

- ✅ PR draft file generated under `/reports/pr-draft.md`
- ✅ Includes changelog summary organized by category
- ✅ Test verification checklist is complete
- ✅ All modified AL objects are documented
- ✅ Related issues and work items are referenced
- ✅ Review checklist covers all key areas
- ✅ Deployment notes are clear and actionable

## Common PR Patterns

### Pattern 1: Feature Addition PR
- Emphasize new capabilities
- Focus on user benefit
- Include comprehensive testing
- Document new APIs or events

### Pattern 2: Bug Fix PR
- Reference original issue clearly
- Explain root cause
- Show before/after behavior
- Include regression tests

### Pattern 3: Refactoring PR
- Explain motivation
- Show no functional changes
- Highlight improvements
- Demonstrate test coverage

### Pattern 4: Performance Optimization PR
- Include benchmark data
- Show measurable improvements
- Document optimization approach
- Note any trade-offs

## Tips

- Be concise but thorough
- Use tables for structured information
- Include specific file names and line numbers
- Link to related issues and documentation
- Provide context for why changes were made
- Make it easy for reviewers to understand impact
- Include visual evidence when possible
- Anticipate reviewer questions
- Document any non-obvious decisions
- Keep security considerations visible
