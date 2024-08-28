trigger ZohoIntOnOpportunity on Opportunity (after insert, after update) {
    
    if(Trigger.isUpdate){
        if(Trigger.isAfter){

            for (Opportunity Opp : Trigger.new) {
                if (Trigger.oldMap !=null && Opp.StageName == 'Closed Won') {
                   System.debug('Opp');
                   ZohoApex.afterUpdate(Trigger.new, Trigger.oldMap);                   
                }
             }            
        }
    }

}