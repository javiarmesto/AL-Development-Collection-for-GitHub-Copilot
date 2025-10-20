---
mode: 'agent'
description: 'Design and customize Business Central pages using the AL Page Designer for enhanced user experience.'
tools: ['edit', 'runNotebooks', 'search', 'new', 'runCommands', 'runTasks', 'github/github-mcp-server/*', 'microsoft-docs/*', 'runSubagent', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'openSimpleBrowser', 'fetch', 'githubRepo', 'ms-dynamics-smb.al/al_build', 'ms-dynamics-smb.al/al_incremental_publish', 'extensions', 'todos', 'runTests']
model: gpt-4
---

# AL Page Designer Customization

Your goal is to design or customize a Business Central page for `${input:PagePurpose}`.

## Page Designer Workflow

### 1. Open Page Designer
```
al_open_Page_Designer
```

### 2. Page Design Options

#### Creating New Pages
1. **Card Pages** - For single record display
   ```al
   page 50100 "Customer Enhancement Card"
   {
       PageType = Card;
       SourceTable = Customer;
       Caption = 'Customer Enhancement';
       
       layout
       {
           area(Content)
           {
               group(General)
               {
                   field("No."; Rec."No.") { }
                   field(Name; Rec.Name) { }
               }
           }
       }
   }
   ```

2. **List Pages** - For multiple records
3. **Document Pages** - For header/lines structure
4. **Worksheet Pages** - For data entry
5. **Role Centers** - For user dashboards

#### Modifying Existing Pages
1. Use `al_open_Page_Designer` to:
   - Rearrange fields visually
   - Add/remove fields
   - Create new groups
   - Modify field properties
   - Add actions

### 3. Advanced Customizations

#### Field Customizations
```al
field(CustomField; Rec.CustomField)
{
    ApplicationArea = All;
    Importance = Promoted;
    Style = Strong;
    StyleExpr = StyleExpression;
    
    trigger OnValidate()
    begin
        // Custom validation
    end;
}
```

#### Dynamic UI Elements
- Conditional visibility
- Dynamic styling
- Field interactions
- Custom controls

#### Page Extensions
```al
pageextension 50100 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group(CustomGroup)
            {
                Caption = 'Custom Information';
                field(CustomField; Rec.CustomField)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        addafter(NewSalesOrder)
        {
            action(CustomAction)
            {
                Caption = 'Custom Process';
                Image = Process;
                
                trigger OnAction()
                begin
                    // Custom logic
                end;
            }
        }
    }
}
```

### 4. Best Practices

#### Layout Organization
1. **Logical Grouping**
   - Related fields together
   - Most important first
   - Consistent ordering

2. **FastTabs Usage**
   - General information first
   - Details in expandable sections
   - Hide rarely used fields

3. **Action Placement**
   - Primary actions promoted
   - Related actions grouped
   - Consistent positioning

#### Performance Considerations
- Limit FlowFields on lists
- Use appropriate field loading
- Optimize factboxes
- Lazy load complex data

### 5. Testing and Deployment

1. **Build Changes**
   ```
   al_build
   ```

2. **Quick Deploy**
   ```
   al_incremental_publish
   ```

3. **User Testing**
   - Navigation flow
   - Data entry efficiency
   - Visual clarity
   - Performance impact

## Common Scenarios

### Simplifying Complex Pages
1. Hide technical fields
2. Group related information
3. Add helpful tooltips
4. Streamline actions

### Mobile Optimization
1. Priority fields first
2. Minimize scrolling
3. Touch-friendly controls
4. Simplified layouts

### Role-Based Customization
1. Show/hide based on permissions
2. Department-specific layouts
3. Personalization options
4. Saved views support

## Workflow

1. Read Page object.
2. Propose visual changes
3. Test and iterate