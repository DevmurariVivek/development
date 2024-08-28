public with sharing class lwcExample1Controller {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(String accName) {

        System.debug('the accName --- ' + accName);
        List<Account> acclist = [SELECT Id,Name,CreatedDate FROM Account WHERE Name LIKE :('%' + accName + '%')  WITH SECURITY_ENFORCED ORDER BY CreatedDate DESC];
        System.debug('the acclist --- ' + acclist);
        return acclist;
    }
}