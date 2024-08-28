public with sharing class AccountProcessor {
    @future
    public  static void countContacts(List<Id> ListOfIds) {
        List<Account> ListOfAccounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN: ListOfIds];

        for (Account LoopforContacts : ListOfAccounts) {
            LoopforContacts.Number_Of_Contacts__c = LoopforContacts.Contacts.size();
            
        }
        if(!ListOfAccounts.isEmpty()){
        update ListOfAccounts;
        }

    }
}