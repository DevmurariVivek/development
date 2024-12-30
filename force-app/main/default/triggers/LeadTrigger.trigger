trigger LeadTrigger on Lead (before insert, before update) {

    if(Trigger.IsBefore){

        if(Trigger.IsInsert){

            LeadTriggerHandler.onBeforeInsert(Trigger.new, Trigger.newMap);

        }else if(Trigger.IsUpdate){

            LeadTriggerHandler.onBeforeUpdate(Trigger.new, Trigger.newMap);

        }
    }
}