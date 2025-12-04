---
agent: agent
model: Claude Sonnet 4.5
description: 'Generate and manage permission sets for AL extensions.'
tools: ['vscode', 'execute', 'read', 'edit', 'search', 'web', 'microsoft-docs/*', 'azure-mcp/search', 'agent', 'memory', 'ms-dynamics-smb.al/al_generate_permission_set_for_extension_objects', 'ms-dynamics-smb.al/al_generate_permission_set_for_extension_objects_as_xml', 'todo']
---

# AL Permission Management

Your goal is to create and manage permissions for `${input:ExtensionName}`.

## 🛡️ SECURITY: Human Gate Required

**STOP - Permission Review Required**

Permission generation directly affects system security. Before generating:

1. **Analyze security implications** of required permissions
2. **Present permission list** to stakeholder for review
3. **Justify each permission** (Read, Insert, Modify, Delete, Execute)
4. **Confirm principle of least privilege** is followed
5. **Obtain explicit approval** before generating permission sets

**MANDATORY: Wait for security approval before executing permission generation**

---

## Permission Generation Options

### 1. AL Permission Set Object
Use `al_generate_permissionset_for_extension_objects` to create:

```al
permissionset 50100 "My Extension Permissions"
{
    Assignable = true;
    Caption = 'My Extension Permissions';
    
    permissions = 
        table "My Custom Table" = X,
        tabledata "My Custom Table" = RIMD,
        codeunit "My Business Logic" = X,
        page "My Custom Page" = X,
        report "My Custom Report" = X,
        xmlport "My Data Exchange" = X;
}
```

### 2. XML Permission Set
Use `al_generate_permissionset_for_extension_objects_as_xml` for legacy format:

```xml
<?xml version="1.0" encoding="utf-8"?>
<PermissionSets>
  <PermissionSet RoleID="MYEXTENSION" RoleName="My Extension Permissions">
    <Permission>
      <ObjectType>0</ObjectType>
      <ObjectID>50100</ObjectID>
      <ReadPermission>1</ReadPermission>
      <InsertPermission>1</InsertPermission>
      <ModifyPermission>1</ModifyPermission>
      <DeletePermission>1</DeletePermission>
    </Permission>
  </PermissionSet>
</PermissionSets>
```

## Permission Best Practices

### 1. Principle of Least Privilege
- Grant minimum necessary permissions
- Separate permissions by functional area
- Create role-specific permission sets

### 2. Permission Structure
```al
permissionset 50100 "EXT Base"
{
    // Minimal read permissions
}

permissionset 50101 "EXT User"
{
    IncludedPermissionSets = "EXT Base";
    // Standard user operations
}

permissionset 50102 "EXT Admin"
{
    IncludedPermissionSets = "EXT User";
    // Administrative functions
}
```

### 3. Object Permissions

#### Tables
- **R**: Read
- **I**: Insert
- **M**: Modify
- **D**: Delete
- **X**: Execute (for table object)

#### Other Objects
- **X**: Execute/Run
- **0**: No permission

### 4. Security Considerations

1. **Sensitive Data**
   - Restrict access to configuration tables
   - Limit delete permissions
   - Control indirect access

2. **System Tables**
   - Never grant permissions to system tables
   - Use appropriate APIs instead

3. **Validation**
   - Test permission sets thoroughly
   - Verify in different scenarios
   - Document permission requirements

## Implementation Steps

1. **Human Review Gate**: Analyze required permissions and present for approval
2. **After Approval**: Generate base permissions with `al_generate_permissionset_for_extension_objects`
3. **Human Review Gate**: Review generated permissions before applying
4. Create role-based permission sets (requires approval for each role)
5. Implement permission checks in code
6. **Human Review Gate**: Test with different user roles and confirm expected behavior
7. Document permission model and obtain final approval

## Alternative XML Format

For backward compatibility or specific requirements, use:
```
al_generate_permissionset_for_extension_objects_as_xml
```