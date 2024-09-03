trigger caseResolutionTrigger on Case_Resolution__c (after insert, after update) {
    caseResolutionTriggerHandler.handleCaseResolution(Trigger.new);
}
