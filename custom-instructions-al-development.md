---
title: Custom Instructions for AL Development with GitHub Copilot
version: 1.0
date_created: 2025-10-15
last_updated: 2025-10-15
owner: javiarmesto
tags: [al, business-central, development, copilot, agent, instructions]
---

# Custom Instructions for AL Development

## Overview

This document provides custom instructions for GitHub Copilot when working with AL (Application Language) development for Microsoft Dynamics 365 Business Central. These instructions reference specialized prompt files designed to leverage the new AL agent tools available in Visual Studio Code.

## Available AL Agent Tools

GitHub Copilot agents now have access to specialized AL development tools that streamline Business Central extension development:

### Project Management
- `al_new_project` - Create new AL projects
- `al_go` - Initialize AL in existing folders
- `al_generate_manifest` - Generate manifest files

### Build & Deploy
- `al_build` - Build AL projects
- `al_package` - Create .app packages
- `al_publish` - Publish with debugging
- `al_incremental_publish` - Rapid deployment
- `al_publish_without_debug` - Production deployment
- `al_publish_existing_extension` - Deploy pre-built packages
- `al_full_package` - Create packages with dependencies

### Debugging
- `al_debug_without_publish` - Debug without republishing
- `al_initalize_snapshot_debugging` - Start snapshot debugging
- `al_finish_snapshot_debugging` - End snapshot debugging
- `al_snapshots` - View debugging snapshots

### Development Tools
- `al_open_Page_Designer` - Visual page design
- `al_open_Event_Recorder` - Record and discover events
- `al_insert_event` - Insert event code

### Dependencies & Symbols
- `al_download_symbols` - Download symbols
- `al_download_source` - Download source code
- `al_get_package_dependencies` - Check dependencies

### Performance & Analysis
- `al_generate_cpu_profile_file` - Performance profiling
- `al_clear_profile_codelenses` - Clear profiling lenses

### Security
- `al_generate_permissionset_for_extension_objects` - Generate AL permissions
- `al_generate_permissionset_for_extension_objects_as_xml` - Generate XML permissions

### Maintenance
- `al_clear_credentials_cache` - Clear authentication cache

### Agent Debugging
- Attach to agent sessions for debugging AL code executed by AI agents
- Use `clientType: "Agent"` in launch configurations

## Custom Prompt Files

The following specialized prompt files are available to assist with specific AL development scenarios:

### 1. Workspace Setup (`al-workspace-setup.md`)
**Use when:** Starting a new AL project or configuring a development environment

**Capabilities:**
- Initialize new AL projects or existing folders
- Download and configure symbols
- Manage dependencies
- Generate manifests
- Troubleshoot authentication issues

**Example usage:**
```
Use the al-workspace-setup prompt to help me set up a new Business Central extension project
```

### 2. Build & Deploy (`al-build-deploy.md`)
**Use when:** Building and deploying AL extensions to different environments

**Capabilities:**
- Development deployments with rapid iteration
- Testing environment deployments
- Production deployments without debug symbols
- Deploy existing packages
- Create full dependency packages

**Example usage:**
```
Use the al-build-deploy prompt to deploy my extension to the production environment
```

### 3. Event Implementation (`al-event-implementation.md`)
**Use when:** Working with AL events, subscribers, or publishers

**Capabilities:**
- Discover available events using Event Recorder
- Create event subscribers
- Implement event publishers
- Follow event best practices
- Handle Integration and Business events

**Example usage:**
```
Use the al-event-implementation prompt to help me subscribe to the OnBeforePostSalesHeader event
```

### 4. Debugging Session (`al-debugging-session.md`)
**Use when:** Debugging AL code or investigating issues

**Capabilities:**
- Standard debugging with publish
- Debug without republishing
- Snapshot debugging for intermittent issues
- Agent session debugging
- Performance debugging

**Example usage:**
```
Use the al-debugging-session prompt to help me debug why my sales validation is failing
```

### 5. Performance Analysis (`al-performance-analysis.md`)
**Use when:** Analyzing or optimizing AL code performance

**Capabilities:**
- Generate CPU profiles
- Identify performance bottlenecks
- Resolve FlowField recursive dependencies (AL0896)
- Optimize queries and loops
- Clear profiling artifacts

**Example usage:**
```
Use the al-performance-analysis prompt to help me optimize my extension's performance
```

### 6. Permission Management (`al-permission-management.md`)
**Use when:** Creating or managing permission sets

**Capabilities:**
- Generate AL permission set objects
- Generate XML permission sets
- Implement security best practices
- Create role-based permissions
- Review and adjust permissions

**Example usage:**
```
Use the al-permission-management prompt to generate permissions for my extension
```

### 7. Troubleshooting (`al-troubleshooting.md`)
**Use when:** Encountering development issues

**Capabilities:**
- Resolve authentication problems
- Fix symbol and dependency issues
- Diagnose build errors
- Handle publishing failures
- Resolve AL0896 recursive FlowField errors

**Example usage:**
```
Use the al-troubleshooting prompt to help me fix authentication errors
```

### 8. Project Migration (`al-project-migration.md`)
**Use when:** Migrating AL projects between versions

**Capabilities:**
- Download and backup source code
- Analyze dependencies
- Update project configuration
- Handle breaking changes
- Generate migration packages

**Example usage:**
```
Use the al-project-migration prompt to migrate my project from BC 22 to BC 23
```

### 9. Page Designer Customization (`al-page-designer-customization.md`)
**Use when:** Designing or customizing Business Central pages

**Capabilities:**
- Visual page design with Page Designer
- Create Card, List, Document, and Role Center pages
- Implement page extensions
- Optimize for mobile
- Follow UI/UX best practices

**Example usage:**
```
Use the al-page-designer-customization prompt to help me customize the Customer Card page
```

### 10. Complete Workflow (`al-complete-workflow.md`)
**Use when:** Need end-to-end guidance for AL development

**Capabilities:**
- Complete project lifecycle guidance
- From setup to deployment
- Integrated development patterns
- Best practices checklist
- Common development workflows

**Example usage:**
```
Use the al-complete-workflow prompt to guide me through creating a complete AL extension
```

## General Copilot Instructions for AL Development

### 1. Tool Selection
When working with AL development:
- **Always use AL-specific tools** when available instead of generic alternatives
- Reference the appropriate prompt file for complex scenarios
- Combine multiple tools in logical workflows

### 2. Code Quality Standards
- Follow AL naming conventions (PascalCase for objects, camelCase for local variables)
- Use meaningful object IDs in assigned ranges (typically 50000-99999 for customizations)
- Implement proper error handling with meaningful messages
- Add XML documentation comments for public procedures
- Use temporary tables for complex in-memory operations

### 3. Performance Considerations
- Always check for FlowField recursive dependencies
- Use SetLoadFields for partial record loading
- Implement appropriate keys for filtering and sorting
- Avoid nested loops with database calls
- Cache frequently accessed values

### 4. Security Best Practices
- Generate permission sets for all extension objects
- Follow principle of least privilege
- Never hardcode credentials or sensitive data
- Use proper authentication methods in launch.json
- Test with different permission levels

### 5. Debugging Approach
- Use incremental publish for rapid development iteration
- Implement snapshot debugging for intermittent issues
- Use agent debugging for AI-executed AL code
- Set conditional breakpoints for specific scenarios
- Monitor performance with CPU profiling

### 6. Event-Driven Development
- Use Event Recorder to discover available events
- Prefer Integration Events for critical business logic
- Include IsHandled parameters in OnBefore events
- Follow OnBefore/OnAfter naming conventions
- Document event purposes and parameters

### 7. Version Control
- Always commit before major refactoring
- Use meaningful commit messages
- Tag releases with version numbers
- Document breaking changes
- Maintain CHANGELOG.md

### 8. Testing Strategy
- Write unit tests for business logic
- Test with different user permissions
- Validate on different Business Central versions
- Test mobile responsiveness for pages
- Perform load testing for performance-critical code

## Workflow Recommendations

### Starting a New Extension
1. Use `al-workspace-setup.md` prompt for initial setup
2. Use `al-page-designer-customization.md` for UI design
3. Use `al-event-implementation.md` for business logic integration
4. Use `al-permission-management.md` for security
5. Use `al-build-deploy.md` for deployment

### Debugging Production Issues
1. Use `al-troubleshooting.md` for initial diagnosis
2. Use `al-debugging-session.md` for detailed investigation
3. Use `al-performance-analysis.md` if performance-related
4. Use `al-build-deploy.md` for hotfix deployment

### Optimizing Existing Code
1. Use `al-performance-analysis.md` to identify bottlenecks
2. Use `al-debugging-session.md` to understand execution flow
3. Refactor and rebuild with `al-build-deploy.md`
4. Validate with snapshot debugging

### Migrating Between Versions
1. Use `al-project-migration.md` for migration guidance
2. Use `al-troubleshooting.md` for resolving migration issues
3. Use `al-performance-analysis.md` to verify performance
4. Use `al-build-deploy.md` for final deployment

## Important Notes

### AL0896 Error - Recursive FlowFields
This new compiler error detects FlowField definitions that are recursively dependent and could cause infinite evaluation. When encountered:
1. Use `al-performance-analysis.md` prompt
2. Identify circular references in FlowFields
3. Refactor to break the dependency chain
4. Use regular fields with triggers as alternative

### Agent Session Debugging
A new capability allows debugging AL code executed by AI agents:
1. Configure launch.json with `clientType: "Agent"`
2. Use `al-debugging-session.md` prompt for setup
3. Attach to active agent sessions
4. Debug in real-time as agents execute AL code

### Snapshot Debugging
For intermittent or hard-to-reproduce issues:
1. Initialize with `al_initalize_snapshot_debugging`
2. Run the problematic scenario multiple times
3. Finish with `al_finish_snapshot_debugging`
4. Analyze with `al_snapshots`

## Context Awareness

When providing AL development assistance:
- **Ask for clarification** if the scenario is ambiguous
- **Suggest the appropriate prompt file** for complex tasks
- **Combine multiple tools** for comprehensive solutions
- **Provide code examples** following AL best practices
- **Explain the reasoning** behind tool and pattern choices
- **Consider the target environment** (cloud vs. on-premise)
- **Account for version differences** in Business Central

## Integration with Other Tools

### Git Integration
- Commit before using `al_incremental_publish`
- Tag releases after `al_package`
- Document changes in commit messages

### VS Code Integration
- Use problems panel with `al_build`
- Monitor terminal output during publish
- Leverage IntelliSense with downloaded symbols

### Business Central Integration
- Test in sandbox before production
- Use Extension Management to verify deployment
- Monitor telemetry for performance issues

## Quick Reference

### Most Common Workflows

**Setup New Project:**
```
@workspace Use al-workspace-setup to create a new AL project for inventory management
```

**Fix Build Error:**
```
@workspace Use al-troubleshooting to help resolve my AL build errors
```

**Deploy to Production:**
```
@workspace Use al-build-deploy to deploy my extension to production environment
```

**Optimize Performance:**
```
@workspace Use al-performance-analysis to optimize my slow-running report
```

**Create Permissions:**
```
@workspace Use al-permission-management to generate permission sets for my extension
```

## Support and Updates

- **Documentation**: Reference the Business Central AL documentation at https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/
- **Community**: YZH Blog provides excellent AL development insights at https://yzhums.com/
- **Updates**: AL tools are experimental and subject to change in future updates
- **Feedback**: Report issues or suggestions through appropriate channels

---

**Last Updated:** 2025-10-15 by javiarmesto

**Version:** 1.0

**Applies to:** AL Development for Microsoft Dynamics 365 Business Central with GitHub Copilot Agent capabilities