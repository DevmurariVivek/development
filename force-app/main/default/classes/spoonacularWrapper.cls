global with sharing class spoonacularWrapper {
    
    global List<spoonacular_API__c> spoonacularData;
    global Integer statusCode;
    global Map<String,Object> food;

    global static void spoonacularWrappermethod(Map<String,Object> food) {

        spoonacularWrapper parse =new spoonacularWrapper();
        // for(){
        //     spoonacularData = new List<spoonacular_API__c>();
        // }
        

    }
}