trigger ContactTrigger1 on Contact (after insert) {

    if(Trigger.IsInsert){
        if(Trigger.IsAfter){
            ContactTrigger1Handler.afterInsert(Trigger.new);
        }
    }
}