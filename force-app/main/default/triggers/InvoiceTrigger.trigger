trigger InvoiceTrigger on Invoice (before insert, before update, after insert, after update, before delete, after delete, after undelete ){

    // Write a trigger that calculates the total Amount of related Invoice records and 
    // updates the TotalAmount__c field on the parent Account record.
    // Here we have to perfrom DML on related object / account hence have to use after context


    if( Trigger.isInsert ){
        if(Trigger.isBefore) {
            InvoiceTriggerHandler.onBeforeInsert(trigger.New);
        }
        else {
            InvoiceTriggerHandler.onAfterInsert(trigger.New, Trigger.NewMap);
        }
    }
    else if ( Trigger.isUpdate ) {
        if(Trigger.isBefore){
            InvoiceTriggerHandler.onBeforeUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
        }
        else{
            InvoiceTriggerHandler.onAfterUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
        }
    }
    else if( Trigger.isDelete){
        if(Trigger.isBefore){
            InvoiceTriggerHandler.onBeforeDelete(Trigger.Old, Trigger.OldMap);
        }else{
            InvoiceTriggerHandler.onAfterDelete(Trigger.Old, Trigger.OldMap);
        }
    }
    else if(Trigger.isUndelete){
        if(Trigger.isAfter){
            InvoiceTriggerHandler.onAfterUnDelete(Trigger.New, Trigger.NewMap);
        }
    }
}