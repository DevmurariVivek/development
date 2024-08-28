public with sharing class flexCardApex {
    @AuraEnabled
    public static List<Contact> fetchContact() {
        List<Contact> conlist = [SELECT Id, Name, MailingStreet, Phone, Email, LeadSource FROM Contact LIMIT 10];
        return conlist;

    }
}