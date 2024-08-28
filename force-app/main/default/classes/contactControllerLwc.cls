public with sharing class contactControllerLwc {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getcontacts(string accId) {

        System.debug('The accId --- ' + accId);

        List<Contact> conlist = new List<Contact>();
        conlist = [SELECT Id,FirstName,LastName,Account.Id FROM Contact WHERE Account.Id = :accId];
        System.debug('The conlist ---' +conlist);
        return conlist;
    }
}