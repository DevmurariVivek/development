public with sharing class ZohoApex {

    // public static void afterInsert(List<Opportunity> newList) {
    //     for(Opportunity opp : newList){
    //         if(opp.StageName = 'Closed Won'){
             
    //     }

    // }}
    public static String afterUpdate(List<Opportunity> newList, Map<Id,Opportunity> oldMap){
    
      String OppID;
      System.debug(oldMap);
      System.debug(newList);
      newList[0].Id = OppID;
      System.debug(OppID);
      return OppID;

        //  for (Opportunity Opp : newList) {
        //      if (oldMap !=null && Opp.StageName == 'Closed Won') {
        //         System.debug('Opp');
                
        //      }
        //   }
            
        }
}