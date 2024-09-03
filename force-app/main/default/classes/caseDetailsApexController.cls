public with sharing class caseDetailsApexController {
    @AuraEnabled(cacheable=true)
    public static Case getCaseDetails(Id caseId) {
        if (caseId == null) {
            throw new AuraHandledException('Case ID cannot be null.');
        }
        return [
            SELECT CaseNumber, Subject, Priority, Status, SLA_Due_Date__c
            FROM Case
            WHERE Id = :caseId
            LIMIT 1
        ];
    }
}
