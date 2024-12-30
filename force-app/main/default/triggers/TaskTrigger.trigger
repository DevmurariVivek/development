trigger TaskTrigger on Task (after insert, after update) {

    // The scenario is to update the parent contact record's activity date field whenver the task record gets marked as 'completed'
    // So the operations will be on related object and hence we can only use the after insert / update operation

    if(Trigger.IsAfter){

        if(Trigger.isInsert){
            TaskTriggerHandler.onAfterInsert(Trigger.new);
        }else {
            TaskTriggerHandler.onAfterUpdate(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
        }
    }
}