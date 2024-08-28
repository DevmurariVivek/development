trigger AccountTrigger1 on Account (before insert, after insert, before update, after update) {

    if(Trigger.isInsert){
        if(Trigger.isBefore){
        AccountTrigger1Handler.beforeInsert(Trigger.new);
    }
    else if (Trigger.isAfter) {
        AccountTrigger1Handler.afterInsert(Trigger.new);       
    }
    }

  if(Trigger.isUpdate){
    if(Trigger.isBefore){
        AccountTrigger1Handler.beforeUpdate(Trigger.new, Trigger.oldMap);
    }
    else if (Trigger.isAfter){
        AccountTrigger1Handler.afterUpdate(Trigger.new, Trigger.oldMap);
        
    }
    }

}