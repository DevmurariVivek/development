public with sharing class ApexLearningClassFlowAction {
    @InvocableMethod(label ='Apex Action 1' description='Method to fetch collection of contacts from flows' category='Custom Apex')
    
    public static void transferValues (List<List<Opportunity>> Get_all_Opportunity){
    System.debug(Get_all_Opportunity);

        // to transfer values from collection to a list
        List<Opportunity> oppolist = Get_all_Opportunity.get(0);
        System.debug('oppolist'+oppolist);
        System.debug('acc id'+oppolist[0].AccountId);

        // defined anothe list of Account to compare fetched opportunities Account ids an get on;ly relavent records
        List<Account> RelatedAcc = [SELECT Id,Name,type FROM Account WHERE Id =: oppolist[0].AccountId ];
        System.debug(RelatedAcc[0].Name);

        // Get method of List
        String fetchedOppo = oppolist.get(0).Id;
        System.debug('Opportunity 1 Id:'+ fetchedOppo);

        for (Opportunity Opp : oppolist) {
             if (Opp.AccountId != null) 
                {
                    System.debug(Opp.AccountId);

                     Opp.Name = RelatedAcc[0].Name + ' opportunity ' ;
                  
                }
         }
        update oppolist;
    }

}