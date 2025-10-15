---
description: AL Development guidelines and prompt file usage for Business Central extensions with GitHub Copilot
globs: ["*.al", "app.json", "launch.json", ".vscode/**"]
alwaysApply: true
---

# AL Development with GitHub Copilot Agent Tools

These instructions guide GitHub Copilot in assisting with AL (Application Language) development for Microsoft Dynamics 365 Business Central, leveraging specialized agent tools and custom prompt files.

## Available AL Agent Tools

GitHub Copilot agents have access to specialized AL development tools:
- **Project**: `al_new_project`, `al_go`, `al_generate_manifest`
- **Build/Deploy**: `al_build`, `al_package`, `al_publish`, `al_incremental_publish`, `al_publish_without_debug`, `al_publish_existing_extension`, `al_full_package`
- **Debug**: `al_debug_without_publish`, `al_initalize_snapshot_debugging`, `al_finish_snapshot_debugging`, `al_snapshots`
- **Development**: `al_open_Page_Designer`, `al_open_Event_Recorder`, `al_insert_event`
- **Dependencies**: `al_download_symbols`, `al_download_source`, `al_get_package_dependencies`
- **Performance**: `al_generate_cpu_profile_file`, `al_clear_profile_codelenses`
- **Security**: `al_generate_permissionset_for_extension_objects`, `al_generate_permissionset_for_extension_objects_as_xml`
- **Maintenance**: `al_clear_credentials_cache`

## Custom Prompt Files Reference

Ten specialized prompt files are available for common AL development scenarios. Reference them when appropriate.

## Rule 1: Use Appropriate Prompt Files for Complex Tasks

### Intent
Leverage specialized prompt files for complex AL development scenarios instead of providing ad-hoc guidance. Each prompt file contains comprehensive workflows and best practices for specific tasks.

### When to Reference Prompt Files

**Project Setup Tasks** → Use `al-workspace-setup.md`
- Creating new AL projects
- Initializing development environments
- Configuring symbols and dependencies

**Build and Deployment Tasks** → Use `al-build-deploy.md`
- Building extensions for different environments
- Creating deployment packages
- Publishing to development, test, or production

**Event-Driven Development** → Use `al-event-implementation.md`
- Discovering available events
- Creating event subscribers
- Implementing event publishers

**Debugging Issues** → Use `al-debugging-session.md`
- Standard debugging sessions
- Snapshot debugging for intermittent issues
- Agent session debugging

**Performance Problems** → Use `al-performance-analysis.md`
- Generating CPU profiles
- Resolving AL0896 recursive FlowField errors
- Optimizing slow operations

**Security and Permissions** → Use `al-permission-management.md`
- Generating permission sets
- Implementing security best practices

**Development Issues** → Use `al-troubleshooting.md`
- Authentication failures
- Symbol and dependency problems
- Build errors

**Version Migration** → Use `al-project-migration.md`
- Upgrading between Business Central versions
- Handling breaking changes

**UI Customization** → Use `al-page-designer-customization.md`
- Designing pages visually
- Implementing page extensions

**Complete Workflows** → Use `al-complete-workflow.md`
- End-to-end extension development
- Integrated development patterns

### Examples

```markdown
// Good example - Reference appropriate prompt file
User: "I need to create a new AL extension for inventory management"
Assistant: "I'll use the al-workspace-setup prompt to guide you through creating a new AL project..."

User: "My extension is running slowly"
Assistant: "I'll use the al-performance-analysis prompt to help identify and resolve performance bottlenecks..."
```

```markdown
// Bad example - Avoid ad-hoc guidance for complex scenarios
User: "I need to create a new AL extension"
Assistant: "First, open VS Code, then create a folder, then run AL:Go command..."
// Instead: Use al-workspace-setup.md prompt
```

## Rule 2: AL Code Naming and Structure Conventions

### Intent
Follow AL naming conventions consistently to ensure code clarity and maintainability. Use appropriate naming patterns that clearly indicate object types and purposes.

### Naming Patterns

**Objects**: PascalCase with descriptive names
**Variables**: PascalCase (global), camelCase (local)
**Object IDs**: 50000-99999 range for customizations
**Fields**: Use descriptive names with spaces in quotes
**Procedures**: Verb + Noun pattern

### Examples

```al
// Good example - Clear naming conventions
table 50100 "Custom Sales Statistics"
{
    fields
    {
        field(1; "Entry No."; Integer) { }
        field(10; "Customer No."; Code[20]) { }
        field(20; "Total Amount"; Decimal) { }
    }
}

pageextension 50100 "Customer Card Extension" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group(CustomStatistics)
            {
                Caption = 'Sales Statistics';
                field(TotalSalesAmount; TotalSales)
                {
                    Caption = 'Total Sales Amount';
                    Editable = false;
                }
            }
        }
    }
}

codeunit 50100 "Sales Statistics Management"
{
    procedure CalculateTotalSales(CustomerNo: Code[20]): Decimal
    var
        salesEntry: Record "Cust. Ledger Entry";
        totalAmount: Decimal;
    begin
        salesEntry.SetRange("Customer No.", CustomerNo);
        if salesEntry.FindSet() then
            repeat
                totalAmount += salesEntry.Amount;
            until salesEntry.Next() = 0;
        exit(totalAmount);
    end;
}
```

```al
// Bad example - Unclear naming
table 50100 "tbl1" // Unclear table name
{
    fields
    {
        field(1; "f1"; Integer) { } // Cryptic field name
        field(10; "cn"; Code[20]) { } // Abbreviated
    }
}
```

## Rule 3: Use AL Tools Over Manual Operations

### Intent
Always prefer AL-specific tools over manual operations when available. The AL tools provide proper integration, error handling, and workflow support.

### Tool Selection Priority

1. **Use AL tools first**: `al_build`, `al_publish`, etc.
2. **Use prompt files for complex workflows**
3. **Manual operations only when no tool exists**

### Examples

```markdown
// Good example - Use AL tools
User: "Build my project and deploy it"
Assistant: "I'll build your project using al_build and then deploy with al_incremental_publish..."

User: "I need to download symbols"
Assistant: "I'll use al_download_symbols to fetch the required symbols..."
```

```markdown
// Bad example - Manual operations when tools exist
User: "Build my project"
Assistant: "Open terminal and run: dotnet build..."
// Instead: Use al_build
```

## Rule 4: Performance and AL0896 Error Handling

### Intent
Proactively address performance issues and handle the new AL0896 compiler error for recursive FlowField dependencies. Always consider performance implications in AL code.

### Performance Best Practices

**FlowFields**: Avoid circular CalcFormula dependencies
**Queries**: Use SetLoadFields for partial record loading
**Loops**: Minimize database calls in iterations
**Temporary Tables**: Use for complex in-memory operations

### Examples

```al
// Good example - Avoid recursive FlowFields
table 50100 "Sales Statistics"
{
    fields
    {
        field(1; "Customer No."; Code[20]) { }
        
        // Good: Direct calculation
        field(10; "Total Sales"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Cust. Ledger Entry".Amount where("Customer No." = field("Customer No.")));
        }
    }
}

// Good example - Optimized query
procedure GetCustomerOrders(CustomerNo: Code[20])
var
    salesHeader: Record "Sales Header";
begin
    salesHeader.SetLoadFields("No.", "Order Date", Amount);
    salesHeader.SetRange("Sell-to Customer No.", CustomerNo);
    if salesHeader.FindSet() then
        repeat
            // Process only loaded fields
        until salesHeader.Next() = 0;
end;
```

```al
// Bad example - Circular FlowField (AL0896 error)
table 50100 "Table A"
{
    fields
    {
        field(1; "Amount from B"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Table B"."Amount from A");
        }
    }
}

table 50101 "Table B"
{
    fields
    {
        field(1; "Amount from A"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Table A"."Amount from B"); // Circular!
        }
    }
}
```

## Rule 5: Event-Driven Programming Patterns

### Intent
Use events for extensibility following AL best practices. Leverage the Event Recorder and proper event patterns for maintainable code.

### Event Patterns

**Subscribers**: Use `al_insert_event` or `al_open_Event_Recorder`
**Publishers**: Implement OnBefore/OnAfter pattern
**Parameters**: Include IsHandled for OnBefore events

### Examples

```al
// Good example - Event subscriber pattern
codeunit 50100 "Sales Document Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDocument(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        // Validate custom fields
        ValidateCustomFields(SalesHeader);
        
        // Set IsHandled if preventing default behavior
        if SalesHeader."Custom Field" = 'BLOCK' then
            IsHandled := true;
    end;

    local procedure ValidateCustomFields(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.TestField("Custom Approval Status", SalesHeader."Custom Approval Status"::Approved);
    end;
}

// Good example - Event publisher
codeunit 50101 "Custom Document Management"
{
    procedure ProcessDocument(var DocumentHeader: Record "Sales Header")
    begin
        OnBeforeProcessDocument(DocumentHeader);
        
        // Processing logic
        
        OnAfterProcessDocument(DocumentHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeProcessDocument(var DocumentHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterProcessDocument(var DocumentHeader: Record "Sales Header")
    begin
    end;
}
```

## Rule 6: Debugging Strategy Selection

### Intent
Choose the appropriate debugging strategy based on the scenario. Use snapshot debugging for intermittent issues, agent debugging for AI-executed code, and standard debugging for active development.

### Debugging Strategy Matrix

**Active Development** → `al_incremental_publish` (fast iteration)
**Standard Issues** → `al_publish` or `al_debug_without_publish`
**Intermittent Issues** → Snapshot debugging workflow
**Agent-Executed Code** → Agent session debugging with clientType: "Agent"

### Examples

```markdown
// Good example - Appropriate debugging strategy
User: "This error only happens sometimes"
Assistant: "For intermittent issues, I'll set up snapshot debugging:
1. al_initalize_snapshot_debugging
2. Run your scenario multiple times
3. al_finish_snapshot_debugging
4. al_snapshots to analyze"

User: "Need to debug code executed by an agent"
Assistant: "I'll configure agent session debugging in launch.json with clientType: 'Agent'..."
```

## Rule 7: Security and Permission Management

### Intent
Always generate and review permission sets for extensions. Follow the principle of least privilege and create role-based permission structures.

### Permission Patterns

**Generate First**: Use `al_generate_permissionset_for_extension_objects`
**Review and Adjust**: Never deploy auto-generated permissions without review
**Role-Based**: Create hierarchical permission sets (Base → User → Admin)

### Examples

```al
// Good example - Hierarchical permissions
permissionset 50100 "Sales Ext - Base"
{
    Assignable = false;
    Caption = 'Sales Extension - Base';
    
    Permissions = 
        tabledata "Custom Sales Statistics" = R;
}

permissionset 50101 "Sales Ext - User"
{
    Assignable = true;
    Caption = 'Sales Extension - User';
    IncludedPermissionSets = "Sales Ext - Base";
    
    Permissions = 
        tabledata "Custom Sales Statistics" = RM,
        page "Sales Statistics Page" = X;
}

permissionset 50102 "Sales Ext - Admin"
{
    Assignable = true;
    Caption = 'Sales Extension - Admin';
    IncludedPermissionSets = "Sales Ext - User";
    
    Permissions = 
        tabledata "Custom Sales Statistics" = RIMD,
        codeunit "Sales Statistics Management" = X;
}
```

## Rule 8: Project Structure and Organization

### Intent
Organize AL projects by feature rather than object type for better maintainability and logical grouping.

### Organization Patterns

**Feature-Based**: `src/FeatureName/SubFeature/`
**Shared Components**: `src/Common/` or `src/Shared/`
**Tests**: `test/FeatureName/`

### Examples

```
// Good example - Feature-based organization
src/
├── SalesEnhancements/
│   ├── Statistics/
│   │   ├── CustomSalesStatistics.Table.al
│   │   ├── SalesStatisticsPage.Page.al
│   │   └── SalesStatisticsMgt.Codeunit.al
│   └── Approval/
│       ├── SalesApprovalWorkflow.Codeunit.al
│       └── SalesApprovalPage.Page.al
├── Common/
│   ├── Helpers/
│   │   └── DateTimeHelper.Codeunit.al
│   └── Interfaces/
│       └── IValidatable.Interface.al
└── Permissions/
    └── SalesExtPermissions.PermissionSet.al

test/
└── SalesEnhancements/
    └── SalesStatisticsTests.Codeunit.al
```

## Rule 9: Error Handling and Validation

### Intent
Implement comprehensive error handling with meaningful messages. Use proper validation patterns and provide clear user feedback.

### Error Handling Patterns

**Validation**: Use TestField and Error with clear messages
**Confirmation**: Use Confirm for destructive operations
**Messages**: Use Message for informational feedback

### Examples

```al
// Good example - Comprehensive validation
procedure ValidateAndPostSalesOrder(var SalesHeader: Record "Sales Header")
begin
    // Validate required fields
    SalesHeader.TestField("Sell-to Customer No.");
    SalesHeader.TestField("Order Date");
    
    // Custom validation with clear message
    if SalesHeader."Shipment Date" < SalesHeader."Order Date" then
        Error('Shipment date %1 cannot be earlier than order date %2', 
              SalesHeader."Shipment Date", 
              SalesHeader."Order Date");
    
    // Confirm before destructive operation
    if not Confirm('Do you want to post sales order %1?', true, SalesHeader."No.") then
        exit;
    
    // Post and provide feedback
    PostSalesOrder(SalesHeader);
    Message('Sales order %1 posted successfully', SalesHeader."No.");
end;
```

## Rule 10: Documentation and Code Comments

### Intent
Provide XML documentation for all public procedures. Keep code self-documenting through clear naming, but document complex business logic.

### Documentation Patterns

**Public Procedures**: Always use XML documentation
**Complex Logic**: Add explanation comments
**Business Rules**: Document why, not what

### Examples

```al
// Good example - XML documentation for public API
codeunit 50100 "Discount Calculator"
{
    /// <summary>
    /// Calculates the discount amount based on customer tier and total amount.
    /// </summary>
    /// <param name="CustomerNo">The customer number for tier lookup.</param>
    /// <param name="TotalAmount">The base amount before discount.</param>
    /// <returns>The calculated discount amount.</returns>
    procedure CalculateCustomerDiscount(CustomerNo: Code[20]; TotalAmount: Decimal): Decimal
    var
        customer: Record Customer;
        discountPct: Decimal;
    begin
        customer.Get(CustomerNo);
        discountPct := GetDiscountPercentage(customer."Customer Tier");
        
        // Apply maximum discount cap per company policy (CFO approval 2024-03-15)
        if discountPct > 25 then
            discountPct := 25;
            
        exit(TotalAmount * discountPct / 100);
    end;
}
```

---

**Note**: These instructions work in conjunction with the specialized AL prompt files located in the `.github/copilot-prompts/` directory. Always reference the appropriate prompt file for complex scenarios to ensure comprehensive and consistent guidance.