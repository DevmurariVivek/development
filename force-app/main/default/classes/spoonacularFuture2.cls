public with sharing class spoonacularFuture2 {

    @InvocableMethod (category ='Custom Object Apex' description = 'Will be used to pass on the recepie name in spoonacular API object' label ='Spoonacular Invocable Class' )
    public static void spoonacularFuture2Method1(List<String> Ids) {
        // List<spoonacular_API__c> data = [SELECT Id,Name,Recipes_Name__c FROM spoonacular_API__c WHERE Id=: recordId];
        // SYstem.debug(data);
        // return data;
        List<spoonacular_API__c> dataToUpdate = new List<spoonacular_API__c>();
        List<spoonacular_API__c> data= [SELECT Id,Name,Recipes_Name__c FROM spoonacular_API__c WHERE Id in : Ids];
        for(spoonacular_API__c loopdata : data){
            loopdata.Recipes_Name__c = 'New Name';
            dataToUpdate.add(loopdata);

        }
        System.debug(dataToUpdate);
        //update dataToUpdate;
    }

    public class InputValues{
        @InvocableVariable(required = true)
        public List<String> recordId;
      //  public String recordId;
    }
    

}