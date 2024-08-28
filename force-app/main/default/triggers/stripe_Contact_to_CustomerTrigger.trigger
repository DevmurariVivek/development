trigger stripe_Contact_to_CustomerTrigger on Contact (before insert, after insert) {
    
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            system.debug('*****Trigger is before');
            stripe_Contact_to_CustomerTriggerHandler.beforeInsert(Trigger.new);
        }
        else if (Trigger.isAfter) {
            system.debug('*****Trigger is after');
            stripe_Contact_to_CustomerTriggerHandler.afterInsert(Trigger.new);       
        }
    }
}