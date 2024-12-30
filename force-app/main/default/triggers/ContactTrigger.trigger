trigger ContactTrigger on Contact (before insert, before update, after insert, after update){

    if( Trigger.isInsert ){
        if(Trigger.isBefore) {
            CustomContactTriggerHandler.onBeforeInsert(trigger.New);
        }
        else {
            CustomContactTriggerHandler.onAfterInsert(trigger.New);
        }
    }
    else if ( Trigger.isUpdate ) {
        if(Trigger.isBefore){
            CustomContactTriggerHandler.onBeforeUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
        }
        else{
            CustomContactTriggerHandler.onAfterUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
        }
    }
}