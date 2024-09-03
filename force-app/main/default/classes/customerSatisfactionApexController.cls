public with sharing class customerSatisfactionApexController {
    @AuraEnabled
    public static void submitSurvey(String name, String rating, String comments) {
        // Validate the input
        if (name == null || rating == null || comments == null) {
            throw new AuraHandledException('Name, rating, and comments are required.');
        }
        
        // Create a new survey record
        Customer_Satisfaction_Survey__c survey = new Customer_Satisfaction_Survey__c(
            Name = name,
            Rating__c = rating, 
            Comments__c = comments,
            Survey_Date__c = Date.today()
        );
        insert survey;
    }
}
