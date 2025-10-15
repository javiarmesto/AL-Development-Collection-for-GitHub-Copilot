---
mode: 'agent'
description: 'Set up and configure an AL development workspace for Business Central development.'
tools: ['al_new_project', 'al_go', 'al_download_symbols', 'al_get_package_dependencies', 'al_generate_manifest', 'al_clear_credentials_cache']
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
   - Set up launch.json for debugging
   - Configure server settings
   - Add agent debugging configurations if needed

## Troubleshooting

If authentication issues occur:
- Use `al_clear_credentials_cache` to clear cached credentials
- Guide user through re-authentication process

## Best Practices

- Always verify project compiles after setup
- Ensure proper naming conventions are followed
- Set up appropriate .gitignore file
- Configure AL formatter settings