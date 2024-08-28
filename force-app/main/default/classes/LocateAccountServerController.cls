public with sharing class LocateAccountServerController {
    @AuraEnabled

    public static List<Account> getAccountList() {
	List<Account> accountList = [SELECT Id, Name, Website, Rating FROM Account];
	
        return accountList;    

    }
}