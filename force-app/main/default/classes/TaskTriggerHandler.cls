public with sharing class TaskTriggerHandler {

    public static void onAfterInsert(List<Task> newTasks) {

        System.debug('in onAfterInsert');
        automateContactUpdate(newTasks);
    }

    public static void onAfterUpdate(List<Task> newTasks, List<Task> oldTasks, Map<Id,Task> newTaskMap , Map<Id,Task> oldTaskMap) {

        System.debug('in onAfterUpdate');
        automateContactUpdate(newTasks);
    }

    public static void automateContactUpdate (List<Task> newTasks){

        System.debug('in automateContactUpdate');

        Set<Id> contactIds = new Set<Id>();

        for (Task tsk : newTasks){

            if(tsk.Status == 'Completed'){
                System.debug('The tsk --->' + tsk);
                contactIds.add(tsk.WhoId);
            }  
        }

        System.debug('The contactIds ---> ' + contactIds);

        List<Contact> conToUpdate = new List<Contact>();
        for (Contact con : [SELECT Id,Name,Last_Activity_Date__c FROM Contact WHERE Id In : contactIds WITH SECURITY_ENFORCED]){
            
            System.debug('The con --->' + con);
            con.Last_Activity_Date__c = System.today();
            conToUpdate.add(con);
        }

        if(!conToUpdate.isEmpty()){
            Update conToUpdate;
        }
    }
}