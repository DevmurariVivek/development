trigger CaseTrigger on Case (before insert, before update, after insert, after update){

    if( Trigger.isInsert ){
        if(Trigger.isBefore) {
            CustomCaseTriggerHandler.onBeforeInsert(trigger.New);
        }
        else {
            CustomCaseTriggerHandler.onAfterInsert(trigger.New);
        }
    }
    else if ( Trigger.isUpdate ) {
        if(Trigger.isBefore){
            CustomCaseTriggerHandler.onBeforeUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
        }
        else{
            CustomCaseTriggerHandler.onAfterUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
        }
    }
}