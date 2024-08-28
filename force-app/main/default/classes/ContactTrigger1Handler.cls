public with sharing class ContactTrigger1Handler {
    public static void afterInsert(List<Contact> conList) {

        System.debug('Contact List ---' + conList);
        List<ManagedCodeDev__Contact_Relationship__c> CRlist = new List<ManagedCodeDev__Contact_Relationship__c>();

        for (Contact con : conList){
            if(con.ManagedCodeDev__Contact_Relationship__c != false){
                ManagedCodeDev__Contact_Relationship__c CR = new ManagedCodeDev__Contact_Relationship__c();
                CR.ManagedCodeDev__Contact__c = con.Id;
                CRlist.add(CR);
            }
        }
        System.debug('CRlist --- ' + CRlist);
        if(CRlist != null){
            Insert CRlist;
        }
        
    }
}