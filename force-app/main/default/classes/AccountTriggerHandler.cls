public with sharing class AccountTriggerHandler {
    public static void onBeforeInsert(List<Account> newAccounts) {

        System.debug('In onBeforeInsert');
    }
    public static void onAfterInsert(List<Account> newAccounts) {

        System.debug('In onAfterInsert');   
    }
    public static void onBeforeUpdate(List<Account> newAccounts, List<Account> oldAccounts, Map<Id,Account> newAccountMap, Map<Id,Account> oldAccountMap) {

        System.debug('In onBeforeUpdate');
        //processUpdateValidation(newAccounts , oldAccountMap);
    }
    public static void onAfterUpdate(List<Account> newAccounts, List<Account> oldAccounts, Map<Id,Account> newAccountMap, Map<Id,Account> oldAccountMap)  {

        System.debug('In onAfterUpdate');
        //processAfterUpdateOperations(newAccounts, oldAccountMap);
        createContactsFromAccount(newAccounts, oldAccountMap);
    }

    public static void createContactsFromAccount(List<Account> newAccounts, Map<Id,Account> oldAccountMap){

        System.debug('Inside the createContactsFromAccount');

        //Map<Id , Decimal> accountsToContactMap = new Map<Id , Decimal>();
        List<Contact> contactsToInsert = new List<Contact>();
     
        for(Account acc : newAccounts){
            if(acc.No_of_Location__c != null && acc.No_of_Location__c != oldAccountMap.get(acc.Id).No_of_Location__c){
                //accountsToContactMap.put(acc.Id , acc.No_of_Location__c);

                for(Integer i=1; i<=acc.No_of_Location__c; i++){
                    Contact con = new Contact(); 
                    con.LastName = 'LastName for Account  - ' +acc.Name;
                    con.AccountId = acc.Id;
                    contactsToInsert.add(con);
                }
            }
        }

        if(!contactsToInsert.IsEmpty()){
            System.debug('The contactsToInsert ---> ' + contactsToInsert);
            insert contactsToInsert;
        }
    }

    public static void processAfterUpdateOperations (List<Account> newAccounts , Map<Id, Account> oldAccountMap){

        System.debug('Inside the processAfterUpdateOperations');

        Map<Id, String> accountIdToWebsite = new Map<Id, String>();
        List<Contact> contactsToUpdate = new List<Contact>();

        for (Account acc : newAccounts){

            if(acc.Website != null && oldAccountMap.get(acc.Id).Website != acc.Website){
                accountIdToWebsite.put(acc.Id , acc.Website);
            }
        }

        System.debug('The accountIdToWebsite keys --->  ' + accountIdToWebsite.keySet());
        for (Contact con : [SELECT Id, Website__c, AccountId FROM Contact WHERE AccountId IN : accountIdToWebsite.keySet() WITH SECURITY_ENFORCED]){
            con.Website__c = accountIdToWebsite.get(con.AccountId);
            contactsToUpdate.add(con);
        }

        if(!contactsToUpdate.IsEmpty()){
            System.debug('The Updated Contacts ----> ' + contactsToUpdate);
            Update contactsToUpdate;
        }
    }

    public static void processUpdateValidation(List<Account> newAccounts, Map<Id,Account> oldAccountMap){

        System.debug(' Inside the processUpdateValidation');

        for(Account acc : newAccounts){
            if(acc.Industry == 'Agriculture' && acc.Type == 'Prospect'){
                if(acc.Ownership != oldAccountMap.get(acc.Id).Ownership && acc.Ownership == 'Private'){
                    acc.addError('The account can not be set to Private, if Industry is set to Agriculture and Type is set to Prospect');
                }
            }
        }
    }
}