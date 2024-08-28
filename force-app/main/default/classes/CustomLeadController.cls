public with sharing class CustomLeadController {
    @AuraEnabled
    public static Id saveLead(Lead lead) {
        insert lead;
        return lead.Id;
    }
}