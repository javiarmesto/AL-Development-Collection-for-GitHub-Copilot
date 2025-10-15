---
mode: 'agent'
description: 'Create and manage AL test automation including unit tests, UI tests, and test coverage.'
tools: ['al_build', 'al_incremental_publish', 'editFiles', 'search', 'codebase', 'runTasks', 'problems', 'al_generate_cpu_profile_file']
---

# AL Test Automation

Your goal is to create comprehensive test automation for `${input:TestScope}`.

## Test Framework Setup

### 1. Test Codeunit Structure
```al
codeunit 50100 "My Feature Tests"
{
    Subtype = Test;
    TestPermissions = Disabled;
    
    [Test]
    procedure TestScenario_ExpectedResult()
    var
        Customer: Record Customer;
        LibrarySales: Codeunit "Library - Sales";
    begin
        // [GIVEN] Initial conditions
        Initialize();
        LibrarySales.CreateCustomer(Customer);
        
        // [WHEN] Action is performed
        Customer.Validate("Credit Limit (LCY)", 10000);
        Customer.Modify(true);
        
        // [THEN] Expected result occurs
        Customer.TestField("Credit Limit (LCY)", 10000);
    end;
    
    local procedure Initialize()
    begin
        // Reset test data
    end;
}
```

### 2. Test Types

#### Unit Tests
```al
[Test]
procedure CalculateDiscount_WithValidAmount_ReturnsCorrectDiscount()
var
    DiscountMgt: Codeunit "Discount Management";
    Amount: Decimal;
    Discount: Decimal;
begin
    // [GIVEN] Amount of 1000
    Amount := 1000;
    
    // [WHEN] Calculate discount
    Discount := DiscountMgt.CalculateDiscount(Amount);
    
    // [THEN] Discount should be 10%
    Assert.AreEqual(100, Discount, 'Incorrect discount calculation');
end;
```

#### Integration Tests
```al
[Test]
[HandlerFunctions('MessageHandler')]
procedure PostSalesOrder_WithValidData_CreatesPostedInvoice()
var
    SalesHeader: Record "Sales Header";
    PostedInvoice: Record "Sales Invoice Header";
    LibrarySales: Codeunit "Library - Sales";
begin
    // [GIVEN] Valid sales order
    CreateSalesOrderWithLines(SalesHeader);
    
    // [WHEN] Post the order
    LibrarySales.PostSalesDocument(SalesHeader, true, true);
    
    // [THEN] Posted invoice exists
    PostedInvoice.SetRange("Order No.", SalesHeader."No.");
    Assert.RecordIsNotEmpty(PostedInvoice);
end;
```

#### UI Tests
```al
[Test]
[HandlerFunctions('CustomerCardPageHandler')]
procedure OpenCustomerCard_WithValidCustomer_DisplaysCorrectData()
var
    Customer: Record Customer;
    CustomerCard: TestPage "Customer Card";
begin
    // [GIVEN] Existing customer
    Customer.Get('10000');
    
    // [WHEN] Open customer card
    CustomerCard.OpenView();
    CustomerCard.GoToRecord(Customer);
    
    // [THEN] Data is displayed correctly
    CustomerCard.Name.AssertEquals(Customer.Name);
end;
```

### 3. Test Helpers

#### Library Codeunits
```al
codeunit 50101 "Library - My Feature"
{
    procedure CreateTestData(var RecVar: Record "My Table")
    begin
        RecVar.Init();
        RecVar."Entry No." := GetNextEntryNo();
        RecVar.Description := 'Test ' + Format(RecVar."Entry No.");
        RecVar.Insert(true);
    end;
    
    local procedure GetNextEntryNo(): Integer
    begin
        exit(Random(10000));
    end;
}
```

#### Handler Functions
```al
[MessageHandler]
procedure MessageHandler(Message: Text[1024])
begin
    // Handle expected messages
end;

[ConfirmHandler]
procedure ConfirmHandler(Question: Text[1024]; var Reply: Boolean)
begin
    Reply := true; // Auto-confirm
end;

[PageHandler]
procedure CustomerCardPageHandler(var CustomerCard: TestPage "Customer Card")
begin
    CustomerCard.OK.Invoke();
end;
```

### 4. Test Data Management

#### Setup and Teardown
```al
[Test]
procedure MyTest()
begin
    // Setup
    InitializeTestData();
    
    // Test execution
    ExecuteTest();
    
    // Cleanup (automatic with TestPermissions = Disabled)
end;

local procedure InitializeTestData()
var
    Setup: Record "My Setup";
begin
    if not Setup.Get() then begin
        Setup.Init();
        Setup."Primary Key" := '';
        Setup.Insert();
    end;
end;
```

### 5. Test Coverage

#### Running Tests with Coverage
1. Build tests:
   ```
   al_build
   ```

2. Execute with coverage analysis:
   ```al
   // In launch.json
   {
       "enableCodeCoverage": true,
       "assemblyProbingPaths": ["./.alpackages"]
   }
   ```

3. Analyze results:
   ```
   al_generate_cpu_profile_file
   ```

#### Coverage Best Practices
- Aim for >80% code coverage
- Focus on critical business logic
- Test edge cases and errors
- Document untestable code

### 6. Continuous Integration

#### Test Automation Pipeline
```yaml
# Example test configuration
tests:
  - name: "Unit Tests"
    codeunit: 50100..50199
    expected: pass
    
  - name: "Integration Tests"  
    codeunit: 50200..50299
    expected: pass
    
  - name: "UI Tests"
    codeunit: 50300..50399
    expected: pass
```

### 7. Performance Testing

```al
[Test]
procedure PerformanceTest_LargeDataSet()
var
    StartTime: DateTime;
    Duration: Duration;
begin
    // [GIVEN] Large dataset
    CreateLargeDataSet(10000);
    
    // [WHEN] Process data
    StartTime := CurrentDateTime();
    ProcessData();
    Duration := CurrentDateTime() - StartTime;
    
    // [THEN] Should complete within threshold
    Assert.IsTrue(Duration < 5000, 'Performance threshold exceeded');
end;
```

## Test Patterns

### Arrange-Act-Assert (AAA)
- **Arrange**: Set up test data
- **Act**: Execute functionality
- **Assert**: Verify results

### Given-When-Then (GWT)
- **Given**: Initial context
- **When**: Action occurs
- **Then**: Expected outcome

### Test Isolation
- Each test independent
- No shared state
- Predictable results
- Parallel execution safe