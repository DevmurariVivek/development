public with sharing class LeadTriggerHandler {

    public static void onBeforeInsert(List<Lead> newLead, Map<Id, Lead> newLeadMap) {

        System.debug('In onBeforeInsert of Lead');
        checkForLeadDuplication(newLead, newLeadMap);
    }

    public static void onBeforeUpdate(List<Lead> newLead, Map<Id, Lead> newLeadMap) {

        System.debug('In onBeforeUpdate of Lead');
        checkForLeadDuplication(newLead, newLeadMap);
    }

    public static void checkForLeadDuplication(List<Lead> newLead, Map<Id, Lead> newLeadMap){

        System.debug('In checkForLeadDuplication');

        // get all the existing lead records, compare that to this newly created lead and if match got found, throw and error 
        Map<Id , List<Lead>> leadMap = new  Map<Id , List<Lead>>();
        for (Lead record : newLead){
            if(!leadMap.containsKey(record.Id) && record.Email != null){
                leadMap.put(record.Id, new List<Lead>());
            }
            leadMap.get(record.Id).add(record);
        }
        System.debug('The leadMap ---> ' + leadMap);
    }
}