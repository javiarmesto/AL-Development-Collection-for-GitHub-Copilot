---
agent: agent
model: Claude Sonnet 4.5
description: 'Register a new Copilot capability in Business Central. Creates enum extension, install codeunit, and isolated storage wrapper for Azure OpenAI integration.'
tools: ['vscode', 'execute', 'read', 'al-symbols-mcp/*', 'edit', 'search', 'web', 'microsoft-docs/*', 'azure-mcp/search', 'context7/*', 'agent', 'memory', 'ms-dynamics-smb.al/al_insert_event', 'ms-dynamics-smb.al/al_generate_permission_set_for_extension_objects', 'ms-dynamics-smb.al/al_generate_permission_set_for_extension_objects_as_xml', 'ms-vscode.vscode-websearchforcopilot/websearch', 'todo']

---

# Copilot Capability Registration Workflow

Complete workflow to register a new Copilot capability in Business Central, including enum extension, capability registration, and Azure OpenAI configuration.

## Objective

Create all necessary components to register a custom Copilot capability that can be used with Azure OpenAI services in Business Central.

## Context Loading Phase

Before starting, review:
- [Existing Copilot implementations in codebase]
- [Microsoft Docs: Build Copilot Capability](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/ai-build-capability-in-al)
- [Registered Copilot capabilities](https://github.com/microsoft/BCTech/blob/master/samples/AzureOpenAI/2-ItemSubstitution/CopilotCodeunits/CapabilitiesSetup.Codeunit.al)
- [app.json for object ID ranges]
- [Existing enum extensions]

## Prerequisites

- Business Central AL workspace
- Available object ID range
- Azure OpenAI resource (development) or commitment to use Microsoft managed resources (production)
- Understanding of Copilot feature to be implemented

## Step-by-Step Process

### Phase 1: Gather Information

Ask the user for:

1. **Capability Name**: What is the name of this Copilot capability?
   - Example: "Sales Analysis", "Inventory Optimization", "Invoice Matching"

2. **Capability Purpose**: What will this Copilot do?
   - Brief description of the feature

3. **Object ID Range**: What object IDs should be used?
   - Check app.json for available ranges
   - Suggest appropriate IDs based on existing objects

4. **Namespace**: What namespace/prefix to use?
   - Example: "MyCompany.CopilotFeatures"

5. **Azure OpenAI Setup**: Will you use:
   - Microsoft managed resources (recommended for production)
   - Own Azure OpenAI subscription (required for development)

### Phase 2: Create Enum Extension

Generate the enum extension file:

**File**: `<CapabilityName>.EnumExt.al`

**Template**:
```al
namespace <Namespace>;

using System.AI;

enumextension <ObjectID> "<Enum Extension Name>" extends "Copilot Capability"
{
    value(<Value>; "<Capability Name>")
    {
        Caption = '<User-Friendly Caption>';
    }
}
```

**Validation**:
- [ ] Enum value is within object ID range
- [ ] Caption is user-friendly and descriptive
- [ ] Namespace is correctly defined
- [ ] File name follows naming convention

### Phase 3: Create Install Codeunit

Generate the install codeunit for capability registration:

**File**: `<CapabilityName>Setup.Codeunit.al`

**Template**:
```al
namespace <Namespace>;

using System.AI;

codeunit <ObjectID> "<Capability Name> Setup"
{
    Subtype = Install;
    InherentEntitlements = X;
    InherentPermissions = X;
    Access = Internal;

    trigger OnInstallAppPerDatabase()
    begin
        RegisterCapability();
        SetupSecrets();
    end;

    local procedure RegisterCapability()
    var
        CopilotCapability: Codeunit "Copilot Capability";
        LearnMoreUrlTxt: Label 'https://learn.microsoft.com/dynamics365/business-central/', Locked = true;
    begin
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"<Capability Name>") then
            CopilotCapability.RegisterCapability(
                Enum::"Copilot Capability"::"<Capability Name>",
                Enum::"Copilot Availability"::Preview,
                LearnMoreUrlTxt);
    end;

    local procedure SetupSecrets()
    var
        IsolatedStorageWrapper: Codeunit "Isolated Storage Wrapper";
    begin
        // IMPORTANT: Configure Azure OpenAI secrets
        // For development: Set up your own Azure OpenAI credentials
        // For production: Use Microsoft's managed resources

        Error('Configure your Azure OpenAI secrets before publishing. See IsolatedStorageWrapper codeunit.');

        // Development configuration (uncomment and configure):
        // IsolatedStorageWrapper.SetSecretKey('YOUR_AZURE_OPENAI_KEY');
        // IsolatedStorageWrapper.SetDeployment('gpt-4o');
        // IsolatedStorageWrapper.SetEndpoint('https://your-resource.openai.azure.com/');
    end;
}
```

**Validation**:
- [ ] Codeunit ID is within range
- [ ] Capability name matches enum extension
- [ ] Error message reminds developer to configure secrets
- [ ] Access is set to Internal
- [ ] Subtype is Install

### Phase 4: Create or Update Isolated Storage Wrapper

Check if `IsolatedStorageWrapper` codeunit exists. If not, create it:

**File**: `IsolatedStorageWrapper.Codeunit.al`

**Template**:
```al
namespace <Namespace>;

codeunit <ObjectID> "Isolated Storage Wrapper"
{
    Access = Internal;

    procedure GetSecretKey(): Text
    var
        Secret: Text;
    begin
        if IsolatedStorage.Get('AzureOpenAIKey', DataScope::Module, Secret) then
            exit(Secret);
        Error('Azure OpenAI key not configured. Configure in install codeunit.');
    end;

    procedure SetSecretKey(NewKey: Text)
    begin
        IsolatedStorage.Set('AzureOpenAIKey', NewKey, DataScope::Module);
    end;

    procedure GetDeployment(): Text
    var
        Deployment: Text;
    begin
        if IsolatedStorage.Get('AzureOpenAIDeployment', DataScope::Module, Deployment) then
            exit(Deployment);
        exit('gpt-4o'); // Default deployment
    end;

    procedure SetDeployment(NewDeployment: Text)
    begin
        IsolatedStorage.Set('AzureOpenAIDeployment', NewDeployment, DataScope::Module);
    end;

    procedure GetEndpoint(): Text
    var
        Endpoint: Text;
    begin
        if IsolatedStorage.Get('AzureOpenAIEndpoint', DataScope::Module, Endpoint) then
            exit(Endpoint);
        Error('Azure OpenAI endpoint not configured. Configure in install codeunit.');
    end;

    procedure SetEndpoint(NewEndpoint: Text)
    begin
        IsolatedStorage.Set('AzureOpenAIEndpoint', NewEndpoint, DataScope::Module);
    end;
}
```

**Validation**:
- [ ] Codeunit uses IsolatedStorage for security
- [ ] Error messages are helpful
- [ ] Default deployment is modern (gpt-4o)
- [ ] Access is Internal

### Phase 5: Update Permission Set

Add permissions for the new objects:

**File**: Update existing permission set or create new one

**Template**:
```al
permissionset <ObjectID> "<Capability Name> Permissions"
{
    Assignable = true;
    Caption = '<Capability Name> Copilot';

    Permissions =
        codeunit "<Capability Name> Setup" = X,
        codeunit "Isolated Storage Wrapper" = X;
        // Add more permissions as needed for pages, tables, etc.
}
```

**Validation**:
- [ ] All created codeunits are included
- [ ] Permission set is assignable
- [ ] Caption is user-friendly

### Phase 6: Build and Test

1. **Compile the code**:
   ```
   Use al_build tool
   ```

2. **Check for errors**:
   ```
   Review problems panel
   ```

3. **Publish to development environment**:
   ```
   Use al_incremental_publish tool
   ```

4. **Verify capability registration**:
   - Open Business Central
   - Search for "Copilot AI Capabilities"
   - Verify your capability appears

### Phase 7: Document the Setup

Create a README or comment block with:

```markdown
# <Capability Name> Copilot Capability

## Setup Instructions

### Development Environment

1. Obtain Azure OpenAI resource:
   - Create resource in Azure Portal
   - Get endpoint URL, deployment name, and API key

2. Configure secrets:
   - Open `<Capability Name>Setup.Codeunit.al`
   - Uncomment and configure SetSecretKey, SetDeployment, SetEndpoint
   - Remove or comment the Error() call

3. Publish extension

### Production Environment

For production, use Microsoft's managed Azure OpenAI resources:
- No secret configuration needed
- Use SetManagedResourceAuthorization in your code
- Automatic scaling and reliability

## Next Steps

- Create PromptDialog page: Use `@workspace use al-copilot-promptdialog`
- Implement AI logic
- Add tests: Use `@workspace use al-copilot-test`
```

## Structured Output Requirements

Deliver the following files:
- [ ] `<CapabilityName>.EnumExt.al` - Enum extension
- [ ] `<CapabilityName>Setup.Codeunit.al` - Install codeunit
- [ ] `IsolatedStorageWrapper.Codeunit.al` - Secrets management (if not exists)
- [ ] Permission set updates
- [ ] Setup documentation

## Human Validation Gate 🚨

**STOP**: Before proceeding, confirm with the user:
- [ ] Object IDs are correct and available
- [ ] Capability name is approved
- [ ] Azure OpenAI resource availability confirmed (dev) or managed resources approved (prod)
- [ ] Files compile without errors
- [ ] Capability appears in "Copilot AI Capabilities" page

## Common Issues & Solutions

### Issue: "Object ID already in use"
**Solution**: Check app.json idRanges and choose available ID

### Issue: "Capability already registered"
**Solution**: Check if enum value name conflicts with existing capability

### Issue: "Azure OpenAI key not configured" error
**Solution**:
- For development: Configure secrets in install codeunit
- For production: Use SetManagedResourceAuthorization instead

### Issue: Permission errors
**Solution**: Ensure permission set includes all created objects

## Next Steps

After capability registration:
1. Create PromptDialog page: `@workspace use al-copilot-promptdialog`
2. Implement AI generation logic
3. Add testing: `@workspace use al-copilot-test`

## Success Criteria

- [ ] Enum extension created and compiles
- [ ] Install codeunit created and compiles
- [ ] IsolatedStorage wrapper available
- [ ] Permission set updated
- [ ] Code builds successfully
- [ ] Capability visible in BC admin interface
- [ ] Documentation provided

### Solution example
namespace CopilotToolkitDemo.ItemSubstitution;

using System.AI;

codeunit 54310 "Capabilities Setup"
{
    Subtype = Install;
    InherentEntitlements = X;
    InherentPermissions = X;
    Access = Internal;

    trigger OnInstallAppPerDatabase()
    begin
        RegisterCapability();
    end;

    local procedure RegisterCapability()
    var
        CopilotCapability: Codeunit "Copilot Capability";
        LearnMoreUrlTxt: Label 'https://example.com/CopilotToolkit', Locked = true;
    begin
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"Find Item Substitutions") then
            CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"Find Item Substitutions",
                Enum::"Copilot Availability"::Preview,
                Enum::"Copilot Billing Type"::"Microsoft Billed",
                'https://about:none');
    end;
}
###
---

**Framework Compliance**: This workflow implements AI-Native Instructions Architecture Layer 2 (Agent Primitives - Agentic Workflows) with Context Loading, Human Validation Gates, and Structured Output Requirements.
