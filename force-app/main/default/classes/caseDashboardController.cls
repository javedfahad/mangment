public with sharing class caseDashboardController {

    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(String priority, String status, Date slaDueDate) {
        String query = 'SELECT Id, CaseNumber, Subject, Priority, Status, SLA_Due_Date__c ' +
                       'FROM Case WHERE Status != \'Closed\'';
        
        if (priority != null && priority != '') {
            query += ' AND Priority = \'' + String.escapeSingleQuotes(priority) + '\'';
        }
        if (status != null && status != '') {
            query += ' AND Status = \'' + String.escapeSingleQuotes(status) + '\'';
        }
        if (slaDueDate != null) {
            query += ' AND SLA_Due_Date__c = :slaDueDate';
        }

        List<Case> cases = Database.query(query);
        return cases;
    }
}
