public with sharing class AccountTrigger1Handler {
    public static void beforeInsert(List<Account> newList) {
        for(Account acc : newList){
            if(acc.Industry!= null && acc.Industry == 'Banking'){
                acc.Rating = 'Hot';
            }else{
                acc.Rating = 'Cold';
            }
        }
    }
    public static void afterInsert(List<Account> newList) {
        
        List<Opportunity> opplist = new List<Opportunity>();

        for(Account acc : newList) {

            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.AccountId = acc.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();

            opplist.add(opp);
        }
        if (!oppList.isEmpty()) {
            insert opplist; 
            
        }
    }
    public static void beforeUpdate(List<Account> newList, Map<Id,Account> oldMap){
        for(Account acc : newList){
            if (oldMap!= null && acc.Phone != oldMap.get(acc.Id).Phone) {
                acc.Description = 'Updated Account when Phone value Changed';
                
            }
        }
    }
    public static void afterUpdate(List<Account> newList, Map<Id,Account> oldMap){

        Map<Id,Account> AccMap = new Map<Id,Account>();
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        for(Account acc : newList){
            if (oldMap!= null && acc.Phone != oldMap.get(acc.Id).Phone) {
            AccMap.put(acc.Id, acc);    
            }
        }
        for (Opportunity opp : [SELECT Id, Name, Description, AccountId FROM Opportunity WHERE AccountId IN : AccMap.keySet()]) {

            Opportunity relatedOpp = new Opportunity();
            if(AccMap.containsKey(opp.AccountId)){
                relatedOpp.Id = opp.Id;
                relatedOpp.Description = AccMap.get(opp.AccountId).Phone;
                oppToUpdate.add(relatedOpp);
            }
            if (!oppToUpdate.isEmpty()) {
                update oppToUpdate;                
            }           
        }
    }
}