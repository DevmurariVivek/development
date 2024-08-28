public with sharing class LocateAccountSearchController {
    @AuraEnabled
    public static List <Account> getAccounts() {
        return [SELECT id,Name,AnnualRevenue,Phone,Rating FROM Account];
    }   
    @AuraEnabled
    public static List<Account> findByName(String searchKey) {
        String name =  + searchKey + '%';
        return [SELECT id,Name,AnnualRevenue,Phone,Rating FROM Account WHERE name LIKE :name];
    }
}