// CaseResolutionTrigger.apxt
trigger caseResolutionTrigger on Case_Resolution__c (after insert, after update) {
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        caseResolutionTriggerHandler.handleAfterInsertOrUpdate(Trigger.New);
    }
}