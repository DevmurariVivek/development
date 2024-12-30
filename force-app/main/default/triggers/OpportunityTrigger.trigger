trigger OpportunityTrigger on Opportunity (after insert, after update, before update, after delete, before delete, after undelete) {

    if(Trigger.IsAfter){
        if(Trigger.isInsert){

            OpportunityTriggerHandler.onAfterInsert(Trigger.new);

        }else if(Trigger.isUpdate){

            OpportunityTriggerHandler.onAfterUpdate(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
        
        }else if(Trigger.IsDelete){

            OpportunityTriggerHandler.onAfterDelete(Trigger.old, Trigger.oldMap);
        
        }else if(Trigger.isUndelete){

            OpportunityTriggerHandler.onAfterUnDelete(Trigger.new, Trigger.newMap);
        }

    }else if(Trigger.IsBefore){
        if(Trigger.isInsert){

            OpportunityTriggerHandler.onBeforeInsert(Trigger.new);

        }else if (Trigger.IsUpdate){

            OpportunityTriggerHandler.onBeforeUpdate(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);

        }else if(Trigger.IsDelete){

            OpportunityTriggerHandler.onBeforeDelete(Trigger.old, Trigger.oldMap);
        }

    }

}