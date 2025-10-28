---
agent: agent
model: Claude Sonnet 4.5
description: 'Create comprehensive tests for Copilot features using AI Test Toolkit. Tests prompt quality, response accuracy, error handling, and user experience.'
tools: ['edit', 'search', 'new', 'Microsoft Docs/*', 'Azure MCP/search', 'usages', 'vscodeAPI', 'problems', 'changes', 'testFailure', 'ms-dynamics-smb.al/al_build', 'ms-dynamics-smb.al/al_view_snapshots', 'runTests']

---

# Copilot Feature Testing Workflow

Complete workflow to create comprehensive tests for Copilot features in Business Central using the AI Test Toolkit, ensuring quality, reliability, and responsible AI practices.

## Objective

Create a full test suite for Copilot features that validates AI response quality, handles edge cases, and ensures consistent user experience.

## Context Loading Phase

Before starting, review:
- [Copilot feature implementation to test]
- [AI Test Toolkit documentation](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-ai-test-toolkit)
- [Existing test patterns in codebase]
- [app.json dependencies]

## Prerequisites

- Copilot feature already implemented (PromptDialog page + generation codeunit)
- AI Test Toolkit dependency added to app.json
- Understanding of expected behavior
- Sample test data

## Step-by-Step Process

### Phase 1: Set Up AI Test Toolkit Dependency

Check if AI Test Toolkit is already in app.json:

**File**: `app.json`

**Required dependency**:
```json
{
  "dependencies": [
    {
      "id": "2156302a-872f-4568-be0b-60968696f0d5",
      "publisher": "Microsoft",
      "name": "AI Test Toolkit",
      "version": "26.0.0.0"
    }
  ]
}
```

If missing, add it and run symbol download.

### Phase 2: Gather Test Information

Ask the user:

1. **Feature to Test**: Which Copilot feature?
   - Feature name, page ID, codeunit ID

2. **Test Scenarios**: What should be tested?
   - Happy path (valid input → expected output)
   - Edge cases (boundary conditions)
   - Error cases (invalid input → graceful handling)
   - Performance (response time)
   - Quality (response accuracy and relevance)

3. **Test Data**: What data is needed?
   - Sample inputs
   - Expected outputs
   - Context data (items, customers, etc.)

4. **Success Criteria**: How to measure success?
   - Response format correct?
   - Required fields populated?
   - Quality score threshold?
   - Performance threshold?

### Phase 3: Create Test Codeunit Structure

**File**: `<FeatureName>CopilotTests.Codeunit.al`

**Basic Template**:
```al
namespace <Namespace>;

using System.AI;
using System.TestLibraries.AI;

codeunit <ObjectID> "<Feature Name> Copilot Tests"
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit "Library Assert";
        AITTestContext: Codeunit "AIT Test Context";
        LibraryRandom: Codeunit "Library - Random";

    [Test]
    procedure Test<Feature>_ValidInput_ReturnsExpectedOutput()
    begin
        // Test happy path
    end;

    [Test]
    procedure Test<Feature>_EdgeCase_HandlesGracefully()
    begin
        // Test edge cases
    end;

    [Test]
    procedure Test<Feature>_InvalidInput_ReturnsError()
    begin
        // Test error handling
    end;

    [Test]
    procedure Test<Feature>_PromptQuality_MeetsThreshold()
    begin
        // Test response quality
    end;

    local procedure Initialize()
    begin
        // Set up test environment
    end;
}
```

### Phase 4: Implement Happy Path Tests

Test that valid input produces expected output:

**Template**:
```al
[Test]
procedure TestCopilot_ValidInput_ReturnsStructuredResponse()
var
    GenerationCodeunit: Codeunit "<Feature Name> Generation";
    TmpResult: Record "<Feature Name> Proposal" temporary;
    TestInput: Text;
begin
    // [SCENARIO] Valid input generates correct suggestions

    // [GIVEN] Test environment is initialized
    Initialize();
    CreateTestData();

    // [GIVEN] Valid user prompt
    TestInput := '<Valid test input>';

    // [WHEN] Generate Copilot suggestions
    GenerationCodeunit.SetUserPrompt(TestInput);
    Assert.IsTrue(GenerationCodeunit.Run(), 'Generation should succeed');
    GenerationCodeunit.GetResult(TmpResult);

    // [THEN] Results are not empty
    Assert.RecordIsNotEmpty(TmpResult);

    // [THEN] Results have required fields populated
    TmpResult.FindFirst();
    Assert.AreNotEqual('', TmpResult."No.", 'Number should be populated');
    Assert.AreNotEqual('', TmpResult.Description, 'Description should be populated');
    Assert.AreNotEqual('', TmpResult.Explanation, 'Explanation should be populated');

    // [THEN] Results make logical sense
    VerifyResultsAreLogical(TmpResult);
end;
```

### Phase 5: Implement Quality Tests

Test AI response quality using AI Test Toolkit:

**Template**:
```al
[Test]
procedure TestCopilot_PromptQuality_MeetsThreshold()
var
    GenerationCodeunit: Codeunit "<Feature Name> Generation";
    TestDataset: Codeunit "AIT Test Dataset";
    TestInput: Text;
    ResponseText: Text;
    QualityScore: Decimal;
begin
    // [SCENARIO] AI responses meet quality threshold

    // [GIVEN] AI Test Context with dataset
    AITTestContext.SetTestDataset(TestDataset);
    TestInput := '<Test prompt>';

    // [GIVEN] Test data
    CreateTestData();

    // [WHEN] Generate response
    GenerationCodeunit.SetUserPrompt(TestInput);
    GenerationCodeunit.Run();
    ResponseText := GenerationCodeunit.GetCompletionResult();

    // [THEN] Response is not empty
    Assert.AreNotEqual('', ResponseText, 'Response should not be empty');

    // [THEN] Response quality meets threshold
    QualityScore := AITTestContext.EvaluateResponseQuality(ResponseText);
    Assert.IsTrue(QualityScore >= 0.8, StrSubstNo('Quality score %1 should be >= 0.8', QualityScore));
end;

[Test]
procedure TestCopilot_ResponseRelevance_IsHighEnough()
var
    GenerationCodeunit: Codeunit "<Feature Name> Generation";
    TestInput: Text;
    ResponseText: Text;
    RelevanceScore: Decimal;
begin
    // [SCENARIO] AI responses are relevant to user input

    // [GIVEN] Specific user request
    TestInput := '<Specific test input>';
    CreateTestData();

    // [WHEN] Generate response
    GenerationCodeunit.SetUserPrompt(TestInput);
    GenerationCodeunit.Run();
    ResponseText := GenerationCodeunit.GetCompletionResult();

    // [THEN] Response is relevant to input
    RelevanceScore := CalculateRelevanceScore(TestInput, ResponseText);
    Assert.IsTrue(RelevanceScore >= 0.7, 'Relevance should be >= 70%');
end;
```

### Phase 6: Implement Edge Case Tests

Test boundary conditions and special cases:

**Template**:
```al
[Test]
procedure TestCopilot_EmptyInput_HandlesGracefully()
var
    GenerationCodeunit: Codeunit "<Feature Name> Generation";
    TmpResult: Record "<Feature Name> Proposal" temporary;
begin
    // [SCENARIO] Empty input is handled gracefully

    // [GIVEN] Empty user prompt
    GenerationCodeunit.SetUserPrompt('');

    // [WHEN] Generate suggestions
    GenerationCodeunit.Run();
    GenerationCodeunit.GetResult(TmpResult);

    // [THEN] No error occurs and result is empty or has clarification message
    // (No asserterror = graceful handling)
end;

[Test]
procedure TestCopilot_VeryLongInput_HandlesCorrectly()
var
    GenerationCodeunit: Codeunit "<Feature Name> Generation";
    TmpResult: Record "<Feature Name> Proposal" temporary;
    LongInput: Text;
begin
    // [SCENARIO] Very long input is handled correctly

    // [GIVEN] Very long user prompt (near token limit)
    LongInput := GenerateLongText(5000); // 5000 characters

    // [WHEN] Generate suggestions
    GenerationCodeunit.SetUserPrompt(LongInput);
    GenerationCodeunit.Run();
    GenerationCodeunit.GetResult(TmpResult);

    // [THEN] Either succeeds or returns helpful error
    // (No crash = correct handling)
end;

[Test]
procedure TestCopilot_SpecialCharacters_HandlesCorrectly()
var
    GenerationCodeunit: Codeunit "<Feature Name> Generation";
    TmpResult: Record "<Feature Name> Proposal" temporary;
    SpecialInput: Text;
begin
    // [SCENARIO] Special characters are handled correctly

    // [GIVEN] Input with special characters
    SpecialInput := 'Test with special chars: !@#$%^&*()[]{}|<>?/\';

    // [WHEN] Generate suggestions
    GenerationCodeunit.SetUserPrompt(SpecialInput);
    GenerationCodeunit.Run();
    GenerationCodeunit.GetResult(TmpResult);

    // [THEN] No errors occur
    // (Successful execution = correct handling)
end;
```

### Phase 7: Implement Error Handling Tests

Test that errors are handled gracefully:

**Template**:
```al
[Test]
procedure TestCopilot_InvalidInput_ReturnsHelpfulMessage()
var
    GenerationCodeunit: Codeunit "<Feature Name> Generation";
    TmpResult: Record "<Feature Name> Proposal" temporary;
    NonsenseInput: Text;
begin
    // [SCENARIO] Nonsensical input produces helpful response

    // [GIVEN] Nonsensical input
    NonsenseInput := 'asdfghjkl12345!@#$%^&*()';

    // [WHEN] Generate suggestions
    GenerationCodeunit.SetUserPrompt(NonsenseInput);
    GenerationCodeunit.Run();
    GenerationCodeunit.GetResult(TmpResult);

    // [THEN] Either returns empty result or asks for clarification
    // No crash = graceful handling
end;

[Test]
procedure TestCopilot_NoTestData_HandlesGracefully()
var
    GenerationCodeunit: Codeunit "<Feature Name> Generation";
    TmpResult: Record "<Feature Name> Proposal" temporary;
begin
    // [SCENARIO] Empty database is handled gracefully

    // [GIVEN] No test data (empty database)
    ClearTestData();

    // [WHEN] Generate suggestions
    GenerationCodeunit.SetUserPrompt('Test with no data');
    GenerationCodeunit.Run();
    GenerationCodeunit.GetResult(TmpResult);

    // [THEN] Returns empty result or helpful message about no data
    // No crash = graceful handling
end;
```

### Phase 8: Implement Performance Tests

Test response time and efficiency:

**Template**:
```al
[Test]
procedure TestCopilot_ResponseTime_IsAcceptable()
var
    GenerationCodeunit: Codeunit "<Feature Name> Generation";
    TmpResult: Record "<Feature Name> Proposal" temporary;
    StartTime: DateTime;
    EndTime: DateTime;
    ElapsedSeconds: Decimal;
begin
    // [SCENARIO] Response time is within acceptable range

    // [GIVEN] Test data
    CreateTestData();

    // [WHEN] Generate suggestions and measure time
    StartTime := CurrentDateTime;
    GenerationCodeunit.SetUserPrompt('Standard test prompt');
    GenerationCodeunit.Run();
    GenerationCodeunit.GetResult(TmpResult);
    EndTime := CurrentDateTime;

    // [THEN] Response time is acceptable (< 10 seconds)
    ElapsedSeconds := (EndTime - StartTime) / 1000;
    Assert.IsTrue(ElapsedSeconds < 10, StrSubstNo('Response time %1s should be < 10s', ElapsedSeconds));
end;
```

### Phase 9: Implement Consistency Tests

Test that similar inputs produce consistent outputs:

**Template**:
```al
[Test]
procedure TestCopilot_SameInput_ProducesConsistentOutput()
var
    GenerationCodeunit: Codeunit "<Feature Name> Generation";
    TmpResult1: Record "<Feature Name> Proposal" temporary;
    TmpResult2: Record "<Feature Name> Proposal" temporary;
    TestInput: Text;
begin
    // [SCENARIO] Same input produces consistent output

    // [GIVEN] Same test input run twice
    TestInput := 'Consistent test input';
    CreateTestData();

    // [WHEN] Generate suggestions twice
    GenerationCodeunit.SetUserPrompt(TestInput);
    GenerationCodeunit.Run();
    GenerationCodeunit.GetResult(TmpResult1);

    GenerationCodeunit.SetUserPrompt(TestInput);
    GenerationCodeunit.Run();
    GenerationCodeunit.GetResult(TmpResult2);

    // [THEN] Results are similar (if Temperature = 0, they should be identical)
    Assert.AreEqual(TmpResult1.Count, TmpResult2.Count, 'Result count should be consistent');
    VerifyResultsSimilarity(TmpResult1, TmpResult2);
end;
```

### Phase 10: Create Test Helper Procedures

**Template**:
```al
local procedure Initialize()
begin
    // Clear previous state
    ClearTestData();

    // Set up AI Test Context if needed
    AITTestContext.Reset();
end;

local procedure CreateTestData()
var
    Item: Record Item;
    Customer: Record Customer;
begin
    // Create test items
    CreateTestItem(Item, 'ITEM001', 'Test Item 1', 100);
    CreateTestItem(Item, 'ITEM002', 'Test Item 2', 50);
    CreateTestItem(Item, 'ITEM003', 'Test Item 3', 25);

    // Create test customers if needed
    // CreateTestCustomer(Customer, 'CUST001', 'Test Customer 1');
end;

local procedure CreateTestItem(var Item: Record Item; No: Code[20]; Description: Text[100]; Inventory: Decimal)
begin
    Item.Init();
    Item."No." := No;
    Item.Description := Description;
    Item.Inventory := Inventory;
    Item."Unit Price" := LibraryRandom.RandDec(100, 2);
    Item.Insert(true);
end;

local procedure ClearTestData()
var
    Item: Record Item;
begin
    Item.DeleteAll();
end;

local procedure VerifyResultsAreLogical(var TmpResult: Record "<Feature Name> Proposal" temporary)
begin
    // Verify results make sense
    TmpResult.FindSet();
    repeat
        // Example: Verify all suggested items exist
        Assert.IsTrue(ItemExists(TmpResult."No."), 'Suggested item should exist');
        // Example: Verify confidence score is in valid range
        Assert.IsTrue(
            (TmpResult."Confidence Score" >= 0) and (TmpResult."Confidence Score" <= 1),
            'Confidence score should be between 0 and 1');
    until TmpResult.Next() = 0;
end;

local procedure ItemExists(ItemNo: Code[20]): Boolean
var
    Item: Record Item;
begin
    exit(Item.Get(ItemNo));
end;

local procedure CalculateRelevanceScore(Input: Text; Output: Text): Decimal
var
    CommonWords: Integer;
    InputWords: Integer;
begin
    // Simple relevance calculation
    // In production, use more sophisticated method
    CommonWords := CountCommonWords(Input, Output);
    InputWords := CountWords(Input);

    if InputWords = 0 then
        exit(0);

    exit(CommonWords / InputWords);
end;

local procedure CountCommonWords(Text1: Text; Text2: Text): Integer
var
    Word: Text;
    Count: Integer;
    Words: List of [Text];
begin
    Words := Text1.Split(' ');
    Count := 0;

    foreach Word in Words do
        if StrPos(Text2.ToLower(), Word.ToLower()) > 0 then
            Count += 1;

    exit(Count);
end;

local procedure CountWords(InputText: Text): Integer
var
    Words: List of [Text];
begin
    Words := InputText.Split(' ');
    exit(Words.Count);
end;

local procedure VerifyResultsSimilarity(var Result1: Record "<Feature Name> Proposal" temporary; var Result2: Record "<Feature Name> Proposal" temporary)
var
    SimilarityCount: Integer;
begin
    // Check how many results are the same
    Result1.FindSet();
    repeat
        Result2.SetRange("No.", Result1."No.");
        if Result2.FindFirst() then
            SimilarityCount += 1;
        Result2.SetRange("No.");
    until Result1.Next() = 0;

    // At least 70% should be similar
    Assert.IsTrue(
        SimilarityCount >= (Result1.Count * 0.7),
        'Results should be at least 70% similar');
end;

local procedure GenerateLongText(Length: Integer): Text
var
    Result: TextBuilder;
    i: Integer;
begin
    for i := 1 to Length div 10 do
        Result.Append('TestText ');
    exit(Result.ToText());
end;
```

### Phase 11: Create Test Suite Summary

Document what's being tested:

**File**: Add comment block to test codeunit:
```al
/// <summary>
/// Test suite for <Feature Name> Copilot functionality
///
/// Test Coverage:
/// - Happy path: Valid input produces expected output
/// - Quality: AI response quality meets threshold (>= 80%)
/// - Relevance: AI responses are relevant to input (>= 70%)
/// - Edge cases: Empty input, very long input, special characters
/// - Error handling: Invalid input, no data
/// - Performance: Response time < 10 seconds
/// - Consistency: Same input produces consistent output
///
/// Test Data:
/// - Items: ITEM001, ITEM002, ITEM003
/// - Scenarios: <List key test scenarios>
///
/// Success Criteria:
/// - All tests pass
/// - Quality score >= 0.8
/// - Relevance score >= 0.7
/// - Response time < 10s
/// - No crashes on invalid input
/// </summary>
```

### Phase 12: Run Tests and Iterate

1. **Build**: Use `al_build`
2. **Run Tests**: Use `runTests` tool
3. **Review Results**: Check test output
4. **Fix Failures**: Iterate on tests or implementation
5. **Re-run**: Verify fixes

## Structured Output Requirements

Deliver:
- [ ] Test codeunit with all test methods
- [ ] Helper procedures for test data creation
- [ ] Test documentation comments
- [ ] Test run results
- [ ] Coverage report (which scenarios are tested)

## Human Validation Gate 🚨

**STOP**: Before completing, verify:
- [ ] All key scenarios are tested
- [ ] Tests pass consistently
- [ ] Test data setup/cleanup works correctly
- [ ] Quality thresholds are met
- [ ] Performance is acceptable
- [ ] Error handling is graceful
- [ ] Tests are maintainable and well-documented

## Common Issues & Solutions

### Issue: AI Test Toolkit not available
**Solution**: Add dependency to app.json and download symbols

### Issue: Tests fail intermittently
**Solution**: AI responses can vary - use ranges and similarity checks instead of exact matches

### Issue: Tests are slow
**Solution**: Minimize data setup, use focused test scenarios

### Issue: Quality score calculation fails
**Solution**: Ensure AI Test Toolkit is properly initialized with dataset

## Success Criteria

- [ ] All test methods implemented
- [ ] Tests cover happy path, edge cases, errors
- [ ] Quality tests pass (score >= 0.8)
- [ ] Performance tests pass (time < 10s)
- [ ] No crashes on invalid input
- [ ] Tests run reliably
- [ ] Documentation is clear

---

**Framework Compliance**: This workflow implements comprehensive Copilot testing following AI Native Development best practices and responsible AI principles.
