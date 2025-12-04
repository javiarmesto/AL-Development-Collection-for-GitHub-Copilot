---
agent: agent
description: 'Create AI generation codeunit for Copilot capability in Business Central. Auto-discovers workspace settings (namespace, IDs, structure), intelligently infers configuration, asks only essential questions. Implements Azure OpenAI chat completion with system/user prompts, JSON response parsing, and comprehensive error handling.'
tools: ['vscode', 'execute', 'read', 'edit', 'search', 'web', 'azure-mcp/search', 'agent', 'ms-dynamics-smb.al/al_build', 'ms-dynamics-smb.al/al_insert_event', 'ms-dynamics-smb.al/al_incremental_publish', 'ms-vscode.vscode-websearchforcopilot/websearch', 'todo']
model: Claude Sonnet 4.5
---

# Copilot AI Generation Codeunit Workflow

Complete workflow to create an AI generation codeunit that integrates Azure OpenAI for a Copilot capability in Business Central.

## Objective

Create a complete AI generation codeunit with **intelligent auto-discovery**:

1. **Auto-discover** workspace configuration (namespace, ID ranges, existing patterns)
2. **Infer** technical details (object IDs, folder structure, dependencies)
3. **Ask** only essential business questions (capability purpose, data sources, rules)
4. **Generate** production-ready code:
   - Temporary result table matching JSON output
   - Azure OpenAI integration codeunit
   - Optimized system and user prompts
   - JSON response parser with error handling
   - Comprehensive error messages

**Philosophy**: Minimize cognitive load - let AI discover technical details, user focuses on business logic.

## Context Loading Phase

**Smart Inference Strategy**:
- ✅ **Auto-discover**: Namespace, object IDs, folder patterns, existing capabilities
- ❓ **Ask essential**: Capability name, business purpose, data sources, rules
- 🔍 **Search first**: Check `app.json`, existing `.al` files, `IsolatedStorageWrapper`
- 💡 **Suggest defaults**: Standard JSON structure, naming conventions, best practices

Before starting, the workflow will:
- Search workspace for `app.json` to extract namespace and ID ranges
- Scan existing `*.EnumExt.al` files for Copilot capabilities
- Check for `IsolatedStorageWrapper.Codeunit.al`
- Detect folder organization pattern (feature-based vs object-type)
- Suggest next available object IDs based on existing objects

**External references** (for prompt engineering patterns):
- [Microsoft Docs: Azure OpenAI Integration](https://learn.microsoft.com/en-us/dynamics365/business-central/application/system-application/codeunit/system.ai.azure-openai)
- [BCTech Sample: Item Substitution](https://github.com/microsoft/BCTech/blob/master/samples/AzureOpenAI/2-ItemSubstitution/CopilotCodeunits/GenerateItemSubProposal.Codeunit.al)
- [Microsoft Docs: AI Build Capability in AL](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/ai-build-capability-in-al)


## Prerequisites

- Copilot capability registered (use `@workspace use al-copilot-capability` if not)
- Temporary record table for AI proposals
- Available object ID range
- Azure OpenAI access configured

## Step-by-Step Process

### Phase 1: Auto-Discovery & Information Gathering

**Step 1.1: Infer from workspace** (automatic)

Search and extract:
- [ ] **Namespace**: Read from `app.json` → `"name"` field or existing `.al` files
- [ ] **Object ID Range**: Read from `app.json` → `"idRanges"` field
- [ ] **Next Available IDs**: Scan existing objects, suggest next in sequence
- [ ] **Existing Capability**: Search for `*CopilotCapability*.EnumExt.al` files
- [ ] **IsolatedStorage Wrapper**: Check if `IsolatedStorageWrapper.Codeunit.al` exists
- [ ] **Folder Structure**: Detect organization pattern (feature-based vs object-based)

**Step 1.2: Present inferred data for confirmation**

Display findings:
```
📊 Workspace Analysis:
- Namespace: <Detected> (e.g., "MyCompany.BCExtension")
- Available ID Range: <Start>-<End> (e.g., 50100-50199)
- Suggested Table ID: <Next> (e.g., 50120)
- Suggested Codeunit ID: <Next+1> (e.g., 50121)
- Existing Copilot Capabilities: <List or "None">
- IsolatedStorage Wrapper: <Exists/Not Found>
```

**Step 1.3: Ask only essential questions**

1. **Capability Name** (REQUIRED):
   - What is the name of this Copilot feature?
   - Example: "Sales Forecasting", "Inventory Optimization", "Customer Segmentation"
   - This will be used in enum extension caption and code

2. **Capability Purpose** (REQUIRED):
   - Briefly describe what this AI feature does (1-2 sentences)
   - Example: "Analyzes historical sales data to predict future demand patterns"

3. **User Input Data** (REQUIRED):
   - What does the user provide as input?
   - Example: "Customer name", "Date range", "Product category"
   - Format: Field name + Type
     - Input 1: _________________ (Text/Code/Date/Decimal/Integer)
     - Input 2: _________________ (optional)

4. **Business Central Context Data** (REQUIRED):
   - Which BC tables provide context for AI?
   - Example: "Sales Line", "Item", "Customer"
   - For each table:
     - Table name: _________________
     - Key fields to include: _________________
     - Filters to apply: _________________

5. **JSON Output Structure** (OPTIONAL - suggest standard):
   
   **Suggested structure** (based on Item Substitution pattern):
   ```json
   {
     "items": [
       {
         "primaryKey": "<Primary identifier>",
         "description": "<Human-readable description>",
         "explanation": "<AI reasoning>",
         "confidence": <0.0-1.0>
       }
     ]
   }
   ```
   
   Accept suggested structure? (Y/N)
   
   If **No**, specify custom fields:
   - Field 1: Name _______ Type _______ (Text/Code/Integer/Decimal)
   - Field 2: Name _______ Type _______
   - Field 3: Name _______ Type _______

6. **Business Rules** (OPTIONAL):
   - Any constraints AI must follow?
   - Example: "Only suggest in-stock items", "Limit to same region"
   - Rule 1: _________________ (optional)
   - Rule 2: _________________ (optional)

**Step 1.4: Confirmation Gate** 🚨

Display complete plan:
```
📋 Generation Plan:

Files to create:
1. <CapabilityName>AIProposal.Table.al (ID: <Inferred>)
2. Generate<CapabilityName>Proposal.Codeunit.al (ID: <Inferred>)
3. IsolatedStorageWrapper.Codeunit.al (if not exists)

Configuration:
- Namespace: <Inferred>
- Capability: Enum::"Copilot Capability"::"<User Input>"
- Authorization: Own Azure OpenAI subscription (development)
- Input: <User specified>
- Context: <BC tables specified>
- Output: <JSON structure>
- Business Rules: <Specified or "None">
```

Proceed? (Y/N)

### Phase 2: Create Temporary Result Table (if not exists)

**File**: `<FeatureName>AIProposal.Table.al`

**Template**:
```al
namespace <Namespace>;

table <ObjectID> "<Feature Name> AI Proposal"
{
    TableType = Temporary;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        // Add fields matching JSON output structure
        field(10; "Primary Key Field"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(20; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(30; Explanation; Text[250])
        {
            Caption = 'Short Explanation';
        }
        field(31; "Full Explanation"; Blob)
        {
            Caption = 'Full Explanation';
        }
        field(40; "Confidence Score"; Decimal)
        {
            Caption = 'Confidence';
            DecimalPlaces = 0:2;
        }
        // Add more fields as needed
    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
```

### Phase 3: Create AI Generation Codeunit

**File**: `Generate<FeatureName>Proposal.Codeunit.al`

**Template Structure**:

```al
namespace <Namespace>;

using System.AI;
using System.Utilities;

codeunit <ObjectID> "Generate <Feature Name> Proposal"
{
    trigger OnRun()
    begin
        GenerateProposal();
    end;

    /// <summary>
    /// Set the user's input prompt/criteria
    /// </summary>
    procedure SetUserPrompt(InputUserPrompt: Text)
    begin
        UserPrompt := InputUserPrompt;
    end;

    /// <summary>
    /// Get the AI-generated results
    /// </summary>
    procedure GetResult(var Tmp<Feature>AIProposal2: Record "<Feature Name> AI Proposal" temporary)
    begin
        Tmp<Feature>AIProposal2.Copy(Tmp<Feature>AIProposal, true);
    end;

    /// <summary>
    /// Get the raw completion result from AI (for debugging/logging)
    /// </summary>
    internal procedure GetCompletionResult(): Text
    begin
        exit(CompletionResult);
    end;

    local procedure GenerateProposal()
    var
        JResTok: JsonToken;
        JResItemsTok: JsonToken;
        JsonArray: JsonArray;
        JItem: JsonToken;
        i: Integer;
    begin
        CompletionResult := '';
        
        // Call Azure OpenAI
        CompletionResult := Chat(GetSystemPrompt(), GetUserPrompt(UserPrompt));
        
        // Parse JSON response
        if not JResTok.ReadFrom(CompletionResult) then
            Error('Failed to parse AI response as JSON.');
            
        if not JResTok.AsObject().Get('items', JResItemsTok) then
            Error('AI response missing "items" array.');
            
        JsonArray := JResItemsTok.AsArray();
        
        if JsonArray.Count() > 0 then
            ParseJsonResults(JsonArray);
    end;

    local procedure ParseJsonResults(JsonArray: JsonArray)
    var
        JItem: JsonToken;
        i: Integer;
    begin
        for i := 0 to JsonArray.Count() - 1 do begin
            JsonArray.Get(i, JItem);
            ParseSingleResult(JItem);
        end;
    end;

    local procedure ParseSingleResult(JItem: JsonToken)
    var
        JToken: JsonToken;
        OutStr: OutStream;
    begin
        Tmp<Feature>AIProposal.Init();
        
        // Parse primary key field
        if JItem.AsObject().Get('number', JToken) then
            Tmp<Feature>AIProposal."Primary Key Field" := 
                UpperCase(CopyStr(JToken.AsValue().AsText(), 1, MaxStrLen(Tmp<Feature>AIProposal."Primary Key Field")));
        
        // Parse description
        if JItem.AsObject().Get('description', JToken) then
            Tmp<Feature>AIProposal.Description := 
                CopyStr(JToken.AsValue().AsText(), 1, MaxStrLen(Tmp<Feature>AIProposal.Description));
        
        // Parse explanation (short + full)
        if JItem.AsObject().Get('explanation', JToken) then begin
            Tmp<Feature>AIProposal.Explanation := 
                CopyStr(JToken.AsValue().AsText(), 1, MaxStrLen(Tmp<Feature>AIProposal.Explanation));
            
            // Store full explanation in Blob
            Tmp<Feature>AIProposal."Full Explanation".CreateOutStream(OutStr);
            OutStr.WriteText(JToken.AsValue().AsText());
        end;
        
        // Parse numeric fields
        if JItem.AsObject().Get('confidence', JToken) then
            Tmp<Feature>AIProposal."Confidence Score" := JToken.AsValue().AsDecimal();
        
        // Add more field parsing as needed
        
        Tmp<Feature>AIProposal.Insert();
    end;

    local procedure Chat(ChatSystemPrompt: Text; ChatUserPrompt: Text): Text
    var
        AzureOpenAI: Codeunit "Azure OpenAI";
        AOAIOperationResponse: Codeunit "AOAI Operation Response";
        AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AOAIChatMessages: Codeunit "AOAI Chat Messages";
        AOAIDeployments: Codeunit "AOAI Deployments";
        Result: Text;
    begin
        // Configure authorization
        // For managed resources (production):
        AzureOpenAI.SetManagedResourceAuthorization(
            Enum::"AOAI Model Type"::"Chat Completions", 
            AOAIDeployments.GetGPT41Latest()
        );
        
        // For own subscription (development):
        // AzureOpenAI.SetAuthorization(
        //     Enum::"AOAI Model Type"::"Chat Completions", 
        //     GetEndpoint(), 
        //     GetDeployment(), 
        //     GetSecretKey()
        // );
        
        // Set the Copilot capability
        AzureOpenAI.SetCopilotCapability(Enum::"Copilot Capability"::"<Your Capability Name>");
        
        // Configure chat parameters
        AOAIChatCompletionParams.SetMaxTokens(2500);
        AOAIChatCompletionParams.SetTemperature(0); // 0 = deterministic, 1 = creative
        AOAIChatCompletionParams.SetJsonMode(true); // Force JSON output
        
        // Build messages
        AOAIChatMessages.AddSystemMessage(ChatSystemPrompt);
        AOAIChatMessages.AddUserMessage(ChatUserPrompt);
        
        // Generate completion
        AzureOpenAI.GenerateChatCompletion(AOAIChatMessages, AOAIChatCompletionParams, AOAIOperationResponse);
        
        if AOAIOperationResponse.IsSuccess() then begin
            Result := AOAIChatMessages.GetLastMessage();
            CompletionResult := Result;
            exit(Result);
        end;
        
        // Handle errors
        HandleAIErrors(AOAIOperationResponse);
    end;

    local procedure HandleAIErrors(AOAIOperationResponse: Codeunit "AOAI Operation Response")
    begin
        case AOAIOperationResponse.GetStatusCode() of
            402: // Payment Required
                Error(
                    'Your Entra Tenant ran out of AI quota. ' +
                    'Make sure your Business Central environment is linked to a Power Platform environment, and billing is set up correctly. ' +
                    'Consult the Business Central documentation for more information.'
                );
            429: // Too Many Requests
                Error(
                    'You have been using Copilot very fast! ' +
                    'So fast that we suspect you might have some automation or scheduled task that calls Copilot a lot. ' +
                    'Have a look at your Job Queues, scheduled tasks, and automations, and make sure that everything looks fine. ' +
                    'And don''t worry, you''ll be able to use Copilot again in less than a minute!'
                );
            503: // Service Unavailable
                Error(
                    'It seems like our services are under heavy load right now. ' +
                    'This happens very rarely, and our engineers are notified whenever this happens. ' +
                    'We are probably already working on it as soon as you are done reading this message!'
                );
            else
                Error('An error occurred calling Azure OpenAI: %1', AOAIOperationResponse.GetError());
        end;
    end;

    local procedure GetUserPrompt(InputUserPrompt: Text) FinalUserPrompt: Text
    var
        <ContextRecord>: Record "<Context Table>";
        Newline: Char;
    begin
        Newline := 10;
        
        // Build context from BC data
        FinalUserPrompt := 'Available data:' + Newline;
        
        if <ContextRecord>.FindSet() then
            repeat
                // Calculate fields if needed
                <ContextRecord>.CalcFields(<Field1>, <Field2>);
                
                // Format data for AI
                FinalUserPrompt += StrSubstNo(
                    'ID: %1, Name: %2, Value: %3' + Newline,
                    <ContextRecord>."No.",
                    <ContextRecord>.Description,
                    <ContextRecord>.<Value>
                );
            until <ContextRecord>.Next() = 0;
        
        FinalUserPrompt += Newline;
        
        // Add user's specific request
        FinalUserPrompt += StrSubstNo('User request: %1', InputUserPrompt);
        
        // Add any constraints
        FinalUserPrompt += Newline + 'Constraints: <Any business rules>';
    end;

    local procedure GetSystemPrompt() SystemPrompt: Text
    begin
        // Define AI's role and task
        SystemPrompt := 'You are an expert assistant for <business domain>.';
        SystemPrompt += ' The user will provide <input description>.';
        SystemPrompt += ' Your task is to <specific AI task>.';
        
        // Add business rules
        SystemPrompt += ' <Business rule 1>.';
        SystemPrompt += ' <Business rule 2>.';
        
        // Define output format
        SystemPrompt += ' The output must be valid JSON with this structure:';
        SystemPrompt += ' { "items": [ { "field1": "value", "field2": 123, ... } ] }';
        
        // Specify field requirements
        SystemPrompt += ' Each item must have:';
        SystemPrompt += ' - number: <field description>';
        SystemPrompt += ' - description: <field description>';
        SystemPrompt += ' - explanation: <field description> (no line breaks or special characters)';
        SystemPrompt += ' - confidence: decimal between 0 and 1';
        
        // Add quality guidelines
        SystemPrompt += ' Provide clear, concise explanations.';
        SystemPrompt += ' Order results by relevance/confidence.';
    end;

    var
        Tmp<Feature>AIProposal: Record "<Feature Name> AI Proposal" temporary;
        UserPrompt: Text;
        CompletionResult: Text;
}
```

### Phase 4: Validation Checklist

**Code Quality**:
- [ ] All JSON fields are parsed with proper error handling
- [ ] MaxStrLen() is used to prevent overflow
- [ ] UpperCase() applied where needed (e.g., primary keys)
- [ ] Blob fields used for long text (explanations)
- [ ] Temporary table properly initialized and inserted

**Prompt Engineering**:
- [ ] System prompt clearly defines AI's role
- [ ] User prompt includes relevant BC data context
- [ ] Output format is explicitly specified as JSON
- [ ] Business rules are clearly stated
- [ ] Field descriptions are unambiguous

**Error Handling**:
- [ ] All Azure OpenAI error codes handled (402, 429, 503)
- [ ] JSON parsing errors caught
- [ ] Missing fields handled gracefully
- [ ] User-friendly error messages

**Performance**:
- [ ] Context data is filtered (SetLoadFields if needed)
- [ ] Maximum tokens set appropriately (2500 default)
- [ ] Temperature optimized (0 = consistent, 1 = creative)

### Phase 5: Advanced Features (Optional)

**Add configuration options**:

```al
procedure SetOnlySuggestAvailableItems()
begin
    OnlyAvailableItems := true;
end;

procedure SetMaxResults(MaxResults: Integer)
begin
    MaxResultCount := MaxResults;
end;

procedure SetTemperature(Temperature: Decimal)
begin
    AITemperature := Temperature;
end;
```

**Update prompts to use configuration**:

```al
local procedure GetSystemPrompt() SystemPrompt: Text
begin
    SystemPrompt := '...';
    
    if OnlyAvailableItems then
        SystemPrompt += ' Only suggest items with available inventory.';
    
    if MaxResultCount > 0 then
        SystemPrompt += StrSubstNo(' Limit results to %1 items.', MaxResultCount);
end;
```

### Phase 6: Build and Test

1. **Compile**:
   ```
   Use al_build tool
   ```

2. **Test JSON parsing**:
   - Create unit test with mock JSON response
   - Verify all fields parse correctly
   - Test error cases (malformed JSON, missing fields)

3. **Test AI integration**:
   - Publish to sandbox: `al_incremental_publish`
   - Call from PromptDialog page
   - Verify results appear correctly

4. **Test error handling**:
   - Simulate quota exceeded (402)
   - Simulate rate limit (429)
   - Verify user-friendly messages

## Structured Output Requirements

Deliver the following:
- [ ] `<FeatureName>AIProposal.Table.al` - Temporary result table (if not exists)
- [ ] `Generate<FeatureName>Proposal.Codeunit.al` - AI generation logic
- [ ] Unit tests for JSON parsing
- [ ] Documentation of system/user prompt design

## Human Validation Gate 🚨

**STOP**: Before proceeding, confirm:
- [ ] JSON structure matches business requirements
- [ ] System prompt accurately describes the task
- [ ] User prompt includes all necessary context
- [ ] Error messages are user-friendly
- [ ] Code compiles without errors
- [ ] Test with sample data produces expected results

## Common Issues & Solutions

### Issue: AI returns invalid JSON
**Solution**: 
- Set `AOAIChatCompletionParams.SetJsonMode(true)`
- Explicitly specify JSON structure in system prompt
- Add "The output must be valid JSON" to system prompt

### Issue: AI ignores business rules
**Solution**:
- Make rules more explicit in system prompt
- Repeat critical rules in user prompt
- Provide examples of valid/invalid results

### Issue: Explanations too long/short
**Solution**:
- Specify length requirement in system prompt
- Use "concise" or "detailed" adjectives
- Set max_tokens appropriately

### Issue: Confidence scores not useful
**Solution**:
- Define what confidence means in your context
- Ask AI to explain scoring criteria
- Consider removing if not adding value

## Next Steps

After creating AI generation codeunit:
1. Create PromptDialog page: `@workspace use al-copilot-promptdialog`
2. Integrate with existing UI (page extensions, actions)
3. Add comprehensive tests: `@workspace use al-copilot-test`
4. Monitor and refine prompts based on user feedback

## Success Criteria

- [ ] Codeunit compiles successfully
- [ ] Azure OpenAI integration works (managed or own subscription)
- [ ] JSON responses parse correctly into temporary records
- [ ] All error cases handled gracefully
- [ ] System and user prompts produce quality results
- [ ] Code follows AL performance best practices
- [ ] Unit tests pass

## Reference Example

Based on Microsoft's Item Substitution sample:
- **System Prompt**: Defines task as "find substitute items"
- **User Prompt**: Lists available items with inventory + substitution request
- **JSON Output**: Array of items with number, description, inventory, explanation
- **Error Handling**: All Azure OpenAI error codes covered
- **Features**: Optional "only available items" constraint

---

**Framework Compliance**: This workflow implements AI-Native Instructions Architecture Layer 2 (Agent Primitives - Agentic Workflows) with Context Loading, Human Validation Gates, and Structured Output Requirements.
