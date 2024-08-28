public with sharing class ContactSearchController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId){
        try {
            return [SELECT ID, Name, AccountId, Account.Name, FirstName, LastName
                    FROM Contact 
                    WHERE AccountId=:accId
                    WITH SECURITY_ENFORCED];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}