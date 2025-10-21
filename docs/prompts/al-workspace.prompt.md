---
mode: 'agent'
description: 'Set up and configure an AL development workspace for Business Central development.'
tools: ['edit', 'runNotebooks', 'search', 'new', 'runCommands', 'runTasks', 'runSubagent', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'openSimpleBrowser', 'fetch', 'githubRepo', 'ms-dynamics-smb.al/al_download_symbols', 'ms-dynamics-smb.al/al_clear_credentials_cache', 'ms-dynamics-smb.al/al_go', 'ms-dynamics-smb.al/al_new_project', 'ms-dynamics-smb.al/al_generate_manifest', 'extensions', 'todos', 'runTests']
model: claude-sonnet-4.5
---

# AL Workspace Setup

Your goal is to set up an AL development workspace for `${input:ProjectName}`.

You will guide the user through the complete setup process for their Business Central development environment, ensuring all necessary components are properly configured.

## Setup Process

1. **Project Initialization**
   - Determine if this is a new project (`al_new_project`) or existing folder (`al_go`)
   - Create the appropriate project structure
   - Configure app.json with project metadata (see below)

   ### App.json Configuration
   
   Create or update the `app.json` file in the workspace root with the complete application manifest. The file must include all required fields for a valid Business Central extension:

   **Basic app.json Template:**
   ```json
   {
     "id": "00000000-0000-0000-0000-000000000000",
     "name": "Project Name",
     "publisher": "Publisher Name",
     "version": "1.0.0.0",
     "brief": "Brief description of your extension",
     "description": "Detailed description of your extension",
     "platform": "1.0.0.0",
     "application": "1.0.0.0",
     "runtime": "11.0",
     "idRanges": [
       {
         "from": 50000,
         "to": 50099
       }
     ],
     "dependencies": [
       {
         "id": "63ca2fa4-4f03-4f2b-a480-172fef340d3f",
         "name": "System Application",
         "publisher": "Microsoft",
         "version": "1.0.0.0"
       },
       {
         "id": "437dbf0e-84ff-417a-965d-ed2bb9650972",
         "name": "Base Application",
         "publisher": "Microsoft",
         "version": "1.0.0.0"
       }
     ],
     "screenshots": [],
     "privacyStatement": "",
     "EULA": "",
     "help": "",
     "url": "",
     "logo": "",
     "target": "OnPrem"
   }
   ```

   **Required Fields Explanation:**
   - `id`: Unique GUID for your extension (generate a new one for each project)
   - `name`: Unique name of your extension (must be unique across all extensions)
   - `publisher`: Your or your company's name as the publisher
   - `version`: Extension version in format Major.Minor.Build.Revision (e.g., 1.0.0.0)

   **Important Fields:**
   - `platform`: Minimum Business Central platform version (e.g., "20.0.0.0" for BC20, "21.0.0.0" for BC21, etc.)
   - `application`: Minimum base application version required
   - `runtime`: AL runtime version (use "11.0" for BC20+, "10.0" for BC19, "9.0" for BC18)
   - `idRanges`: Object ID ranges your extension will use
     - Standard ranges: 50000-99999 for custom objects
     - For AppSource: Microsoft assigns specific ranges
   - `dependencies`: Other extensions your app depends on
     - System Application: Core system functionality
     - Base Application: Standard BC business logic
     - Add other dependencies as needed (Library Assert for test projects, etc.)
   - `target`: Deployment target - "OnPrem", "Cloud", or "Extension" (omit for all targets)

   **Optional but Recommended Fields:**
   - `brief`: Short description (max 250 characters) for AppSource listing
   - `description`: Detailed description of functionality and features
   - `privacyStatement`: URL to privacy policy (required for AppSource)
   - `EULA`: URL to End User License Agreement (required for AppSource)
   - `help`: URL to documentation and help resources
   - `url`: URL to your product or company website
   - `logo`: Path to logo image file (required for AppSource)

   **Ask the user for:**
   1. Project name and publisher information
   2. Target Business Central version (to set correct platform/application versions)
   3. Object ID range (ensure it doesn't conflict with other extensions)
   4. Whether this is for AppSource submission (requires additional fields)

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
   
   ### 🔒 Human Gate: Authentication Configuration Review
   **SECURITY CHECKPOINT - Configuration contains sensitive information**
   
   Before creating launch.json:
   1. **Review authentication method** with stakeholder
   2. **Confirm server URLs** are correct for target environment
   3. **Verify credentials handling** follows security policies
   4. **Obtain approval** before saving configuration
   
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