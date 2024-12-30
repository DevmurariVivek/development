public with sharing class CustomCaseTriggerHandler {
    public static void onBeforeInsert (List<Case> newCases) {

        // something here 
        //validateCases(newCases);
        checkForRelatedContact(newCases);
    }
    public static void onAfterInsert (List<Case> newCases) {
        // Some code here
        System.debug('In onAfterInsert');
    }
    public static void onBeforeUpdate (List<Case> newCases, List<Case> oldCase, Map<ID, Case> newCaseMap , Map<ID, Case> oldCaseMap) {

        // something here 
        //validateCases(newCases);
        checkForRelatedContact(newCases);
    }
    public static void onAfterUpdate (List<Case> newCases, List<Case> oldCase, Map<ID, Case> newCaseMap , Map<ID, Case> oldCaseMap) {
        // Some code here
        System.debug('In onAfterUpdate');
    }

    public static void checkForRelatedContact(List<Case> newCases){

        Set<Id> contactIds = new Set<Id>();
        for (Case cs : newCases){
            // validate if contactId is not null in insert context and ischanged in update context, as this metod works for both of those 
            if(cs.ContactId != null){

                System.debug('Related contact is active ? --- '  + cs.Contact.active__c);
                // Not possible to query the details of parent record's fields as the trigger is running on case and not contact
                contactIds.add(cs.ContactId);
            }
        }

        System.debug('the contactIds ---> ' + contactIds);


        List<Contact> conlist = [SELECT Id,active__c FROM Contact WHERE ID IN : contactIds AND active__c = false WITH SECURITY_ENFORCED];
        System.debug(' The conlist ---> ' + conlist);

        Map<Id, Boolean> contactIdToActive = new Map<Id, Boolean>();
        for (Contact con : conlist){
            contactIdToActive.put(con.Id , con.active__c);
        }

        System.debug(' The contactIdToActive ---> ' + contactIdToActive);

        for (Case cs :newCases){

            if(cs.ContactId != null && contactIdToActive.containsKey(cs.ContactId)){
                if(contactIdToActive.get(cs.ContactId) == false){
                    cs.addError('The Reated Contact record is not active !!');
                }
            }
        }
    }

    // The common class between both before insert and before update context.
    public static void validateCases(List<Case> newCases){

        // First store all the case's contact ids in a set
        Set<Id> contactIds = new Set<Id>();
        for (Case c : newCases){
            contactIds.add(c.ContactId);
            System.debug('contactIds ---> ' + contactIds);
        }


        // Using the stored contact id, get list of contacts having active=true 
        Map<Id, Contact> conMap = new Map<Id, Contact>();
        List<Contact> conlist = [SELECT Id,active__c FROM Contact WHERE Id IN : contactIds WITH SECURITY_ENFORCED];
        System.debug('The contact records ---> ' + conlist);

        if (!contactIds.isEmpty()) {
            for (Contact con : conlist){
                conMap.put(con.Id, con);
            }
        }
        System.debug('conMap ---> ' + conMap);

        // No we can validate if the to - be created / updated case record's conatct is active or not

        for (Case c : newCases){
            if(c.ContactId != null){

                Contact conRecord = conMap.get(c.ContactId); // Get the Contact record
                System.debug('conRecord ---> ' + conRecord);
                Boolean isActive = conRecord.active__c;
                System.debug('isActive ---> ' + isActive);
                if(isActive == null || !isActive){
                    c.addError('The associated Contact must have the "Active" checkbox set to true.');
                }
            }
        }
    }
}