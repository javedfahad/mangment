public class caseResolutionTriggerHandler {

    public static void handleCaseResolution(List<Case_Resolution__c> resolutionList) {
        List<Case> casesToUpdate = new List<Case>();
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Case_Resolution__c resolution : resolutionList) {
            if (resolution.Case__c != null) {
                Case relatedCase = [SELECT Id, Status FROM Case WHERE Id = :resolution.Case__c LIMIT 1];

                if (resolution.Resolution_Status__c == 'Successful' && relatedCase.Status != 'Closed') {
                    relatedCase.Status = 'Closed';
                    casesToUpdate.add(relatedCase);
                } else if (resolution.Resolution_Status__c == 'Unsuccessful' && relatedCase.Status == 'Closed') {
                    relatedCase.Status = 'Reopened';
                    casesToUpdate.add(relatedCase);

                    // Notify the support team
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setToAddresses(new String[] {'fahadjaved2601@gmail.com'}); // Your email address
                    email.setSubject('Case Reopened Due to Unsuccessful Resolution');
                    email.setPlainTextBody('The case ' + relatedCase.Id + ' has been reopened because the resolution was unsuccessful.');
                    emails.add(email);
                }
            }
        }

        if (!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
}
