trigger spoonacularTrigger on spoonacular_API__c (before insert) {
    if(Trigger.isInsert){
        if(Trigger.isbefore){
            spoonacularFuture.triggerMethod(trigger.new);
        }
    }

}