trigger AccountTrigger on Account (before insert, before update, after insert, after update){

    if( Trigger.isInsert ){
        if(Trigger.isBefore) {
            AccountTriggerHandler.onBeforeInsert(trigger.New);
        }
        else {
            AccountTriggerHandler.onAfterInsert(trigger.New);
        }
    }
    else if ( Trigger.isUpdate ) {
        if(Trigger.isBefore){
            AccountTriggerHandler.onBeforeUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
        }
        else{
            AccountTriggerHandler.onAfterUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
        }
    }
}