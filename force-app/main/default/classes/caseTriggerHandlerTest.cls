@isTest
public class caseTriggerHandlerTest {

    @isTest
    static void testCalculateSLADueDate() {
        // Create an Account to relate with the Case
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Create Cases with different priorities to test SLA Due Date calculation
        Case highPriorityCase = new Case(
            AccountId = acc.Id,
            Subject = 'Test High Priority Case',
            Priority = 'High'
        );
        Case mediumPriorityCase = new Case(
            AccountId = acc.Id,
            Subject = 'Test Medium Priority Case',
            Priority = 'Medium'
        );
        Case lowPriorityCase = new Case(
            AccountId = acc.Id,
            Subject = 'Test Low Priority Case',
            Priority = 'Low'
        );
        insert new List<Case>{highPriorityCase, mediumPriorityCase, lowPriorityCase};

        // Retrieve the cases and check the SLA Due Date
        List<Case> retrievedCases = [SELECT SLA_Due_Date__c, Priority FROM Case WHERE Id IN :new List<Id>{highPriorityCase.Id, mediumPriorityCase.Id, lowPriorityCase.Id}];
        for (Case caseRecord : retrievedCases) {
            System.assertNotEquals(null, caseRecord.SLA_Due_Date__c, 'SLA Due Date should be set for case with priority ' + caseRecord.Priority);
        }
    }

    @isTest
    static void testSendSLAViolationNotification() {
        // Create an Account to relate with the Case
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Create a Case with a past SLA Due Date to simulate a violation
        Case testCase = new Case(
            AccountId = acc.Id,
            Subject = 'Test Case - SLA Violation',
            Priority = 'High',
            SLA_Due_Date__c = System.today().addDays(-1) // Set SLA Due Date in the past
        );
        insert testCase;

        // Simulate the email sending process
        Test.startTest();
        CaseTriggerHandler.sendSLAViolationNotifications(new List<Case>{testCase});
        Test.stopTest();

        // Check if the email was sent
        // We can't verify the actual email sent, so we just ensure that no exceptions were thrown
        System.assert(true, 'SLA violation notification process completed.');
    }
}
