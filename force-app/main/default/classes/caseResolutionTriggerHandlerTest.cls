@isTest
public class caseResolutionTriggerHandlerTest {
    
    @isTest
    static void testSuccessfulCaseResolution() {
        // Step 1: Create an Account to relate with the Case
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Step 2: Create a Case with an initial status
        Case testCase = new Case(
            AccountId = acc.Id,
            Subject = 'Test Case for Resolution',
            Status = 'New'
        );
        insert testCase;
        
        // Debug log to check the initial status of the Case
        System.debug('Initial Case Status: ' + testCase.Status);
        
        // Step 3: Create a Case Resolution with 'Successful' status
        Case_Resolution__c successfulResolution = new Case_Resolution__c(
            Case__c = testCase.Id,
            Resolution_Status__c = 'Successful'
        );
        insert successfulResolution;
        
        // Step 4: Retrieve the Case and check if its status has been updated to 'Closed'
        testCase = [SELECT Status FROM Case WHERE Id = :testCase.Id];
        System.debug('Updated Case Status: ' + testCase.Status);
        System.assertEquals('Closed', testCase.Status, 'Case should be closed when the resolution is successful.');
    }
    
    @isTest
    static void testUnsuccessfulCaseResolution() {
        // Step 1: Create an Account to relate with the Case
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Step 2: Create a Case with an initial status
        Case anotherTestCase = new Case(
            AccountId = acc.Id,
            Subject = 'Test Case for Unsuccessful Resolution',
            Status = 'New'
        );
        insert anotherTestCase;
        
        // Step 3: Create a Case Resolution with 'Unsuccessful' status
        Case_Resolution__c unsuccessfulResolution = new Case_Resolution__c(
            Case__c = anotherTestCase.Id,
            Resolution_Status__c = 'Unsuccessful'
        );
        insert unsuccessfulResolution;
        
        // Step 4: Retrieve the Case and check if its status has been updated to 'Reopened'
        anotherTestCase = [SELECT Status FROM Case WHERE Id = :anotherTestCase.Id];
        System.assertEquals('Reopened', anotherTestCase.Status, 'Case should be reopened when the resolution is unsuccessful.');
    }
}
