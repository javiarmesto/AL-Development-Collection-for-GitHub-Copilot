---
mode: 'agent'
description: 'Set up and configure an AL development workspace for Business Central development.'
tools: ['edit', 'runNotebooks', 'search', 'new', 'runCommands', 'runTasks', 'runSubagent', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'openSimpleBrowser', 'fetch', 'githubRepo', 'ms-dynamics-smb.al/al_download_symbols', 'ms-dynamics-smb.al/al_clear_credentials_cache', 'ms-dynamics-smb.al/al_go', 'ms-dynamics-smb.al/al_new_project', 'ms-dynamics-smb.al/al_generate_manifest', 'extensions', 'todos', 'runTests']
model: gpt-4
---

# AL Workspace Setup

Your goal is to set up an AL development workspace for `${input:ProjectName}`.

You will guide the user through the complete setup process for their Business Central development environment, ensuring all necessary components are properly configured.

## Setup Process

1. **Project Initialization**
   - Determine if this is a new project (`al_new_project`) or existing folder (`al_go`)
   - Create the appropriate project structure
   - Configure app.json with project metadata

2. **Symbol Management**
   - Download required symbols using `al_download_symbols`
   - Verify all base application dependencies are available
   - Check for any missing symbol packages

3. **Dependency Configuration**
   - Use `al_get_package_dependencies` to retrieve current dependencies
   - Ensure all dependencies are properly declared in app.json
   - Resolve any version conflicts

4. **Manifest Generation**
   - Generate manifest file using `al_generate_manifest`
   - Verify manifest contents are correct

5. **Launch Configuration**
   
   Create a `.vscode/launch.json` file in the workspace root with the appropriate debugging configuration. Choose the configuration that matches your development environment:
   
   **For Standard Debugging (Cloud Sandbox):**
   ```json
   {
       "version": "0.2.0",
       "configurations": [
           {
               "type": "al",
               "request": "launch",
               "name": "Your own server",
               "server": "https://businesscentral.dynamics.com",
               "serverInstance": "BC",
               "authentication": "AAD",
               "startupObjectType": "Page",
               "startupObjectId": 22,
               "schemaUpdateMode": "Synchronize",
               "tenant": "default"
           }
       ]
   }
   ```
   
   **For On-Premises Debugging:**
   ```json
   {
       "version": "0.2.0",
       "configurations": [
           {
               "type": "al",
               "request": "launch",
               "name": "Local server",
               "server": "http://localhost",
               "serverInstance": "BC210",
               "authentication": "Windows",
               "startupObjectType": "Page",
               "startupObjectId": 22,
               "schemaUpdateMode": "Synchronize"
           }
       ]
   }
   ```
   
   **For Agent Debugging (Copilot/AI features):**
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
   
   **Configuration Parameters:**
   - `server`: Business Central server URL
   - `serverInstance`: BC instance name
   - `authentication`: AAD (cloud), Windows, or NavUserPassword (on-prem). Note: NavUserPassword requires additional `username` and `password` properties in the configuration
   - `startupObjectType`: Type of object to launch when debugging starts (valid types: Page, Codeunit, Report, Query, Table, XMLport)
   - `startupObjectId`: ID of an existing object of the specified type to launch
   - `schemaUpdateMode`: How to handle database schema changes (Synchronize, Recreate, ForceSync)
   - `tenant`: Tenant name for multi-tenant environments
   - `environmentName`: Cloud environment name (for Sandbox/Production)
   - `clientType`: Standard WebClient or Agent (for Copilot features)
   
   Ask the user about their environment to create the appropriate configuration.

## Troubleshooting

If authentication issues occur:
- Use `al_clear_credentials_cache` to clear cached credentials
- Guide user through re-authentication process

## Best Practices

- Always verify project compiles after setup
- Ensure proper naming conventions are followed
- Set up appropriate .gitignore file
- Configure AL formatter settings