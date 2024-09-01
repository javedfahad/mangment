public with sharing class caseTriggerHandler {

    public static void calculateSLADueDate(List<Case> caseList) {
        for (Case caseRecord : caseList) {
            if (caseRecord.Priority != null) {
                // Basic logic to add hours based on priority
                Integer slaHours;
                
                if (caseRecord.Priority == 'High') {
                    slaHours = 24; // High Priority
                } else if (caseRecord.Priority == 'Medium') {
                    slaHours = 48; // Medium Priority
                } else {
                    slaHours = 72; // Low Priority
                }
                
                // Set the SLA Due Date
                if (slaHours != null) {
                    caseRecord.SLA_Due_Date__c = System.now().addHours(slaHours).date(); // Convert Datetime to Date
                }
            }
        }
    }

    public static void sendSLAViolationNotifications(List<Case> caseList) {
        for (Case caseRecord : caseList) {
            System.debug('Checking case with ID: ' + caseRecord.Id);
            // Check if SLA Due Date is passed (only day part) and send an email
            if (caseRecord.SLA_Due_Date__c != null && caseRecord.SLA_Due_Date__c < System.today()) {
                System.debug('Sending email for case with ID: ' + caseRecord.Id);
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] {'fahadjaved2601@gmail.com'});
                email.setSubject('SLA Violation Alert');
                email.setPlainTextBody('The case ' + caseRecord.CaseNumber + ' has not been updated in time.');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            }
        }
    }
}    