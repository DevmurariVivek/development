public with sharing class spoonacularFuture {
    
    //@InvocableMethod (category ='Custom Object Apex' description = 'Will be used to pass on the recepie name in spoonacular API object' label ='Spoonacular Invocable Class' )
   // public static  String ;
    public static String spoonacularMethod1() {
        String RecipesName;
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.spoonacular.com/recipes/random/?apiKey=4c0814c7326d430f942daa62ea947436');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        System.debug('Response:::' + res.getBody());
        if (res.getStatusCode()==200) {
        
            Map<String,Object> result = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            System.debug('RESULT**'+result);
            
            List<Object> recepie = (List<Object>) result.get('recipes');
            System.debug('recepie size**'+recepie.size());
            
            for(Object r: recepie){
                System.debug('Single Object***'+ r);
                Map<String,Object> result1 = (Map<String,Object>) r;
             	System.debug(result1.get('sourceName'));
                RecipesName = String.valueOf(result1.get('sourceName'));
                System.debug(RecipesName);   
            }
           
        }
        return RecipesName;
    }

    public static void triggerMethod(List<spoonacular_API__c> newList) {

       // To pass the returned string from above method in this method
       String inputString = spoonacularMethod1();
       System.debug('InputString::'+ inputString);
        for(spoonacular_API__c data : newList){
            if(data.Name!= null){
                data.Recipes_Name__c = inputString;
            }
            
           // lst.add(data);

        }
        // Insert lst;
    }

}

// -------------------------------- using trigger Method - Trigger = spoonacularTrigger
//public with sharing class spoonacularFuture {
    
//     //@InvocableMethod (category ='Custom Object Apex' description = 'Will be used to pass on the recepie name in spoonacular API object' label ='Spoonacular Invocable Class' )
//     public static  String RecipesName;
//     public static String spoonacularMethod1() {
        
        
//         //List<spoonacular_API__c> spoonacularlst = [SELECT Id,Name,Recipes_Name__c FROM spoonacular_API__c LIMIT 1];
//         Http http = new Http();
//         HttpRequest req = new HttpRequest();
//         req.setEndpoint('https://api.spoonacular.com/recipes/random/?apiKey=4c0814c7326d430f942daa62ea947436');
//         req.setMethod('GET');
//         HttpResponse res = http.send(req);
//         System.debug('Response:::' + res.getBody());
//         if (res.getStatusCode()==200) {
//          /*   Map<String,Object> result = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
//             List<Object> recepie = (List<Object>) result.get('recipes');
    
//             JSONParser parser = JSON.createParser('recepies');
//             System.debug(parser);*/
//             Map<String,Object> result = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            
//            // List<Object> result = (List<Object>) JSON.deserializeUntyped(res.getBody());
//             System.debug('RESULT**'+result);
//             List<Object> recepie = (List<Object>) result.get('recipes');
//             System.debug('recepie size**'+recepie.size());
//             // String RecipesName;
//             for(Object r: recepie){
//                 System.debug('Single Object***'+r);

//                 // Typecasting to access the values within Object Datatyped List within receipes Array
//                 Map<String,Object> result1 = (Map<String,Object>) r;
//              	System.debug(result1.get('sourceName'));

//                 // String RecipesName == result1.get('sourceName');
//                 RecipesName = String.valueOf(result1.get('sourceName'));
//                 System.debug(RecipesName);
                
//             }

//             // spoonacularWrapper wrapperData = spoonacularWrapper.parse(result);
//           /*  System.debug('Output::' + recepie);       
            
//             List<Object> values =  result.values();
            
//             System.debug('values::' + values);*/
//             //for(Integer i = 0 ; i<1 ; i++){
//             //    spoonacularlst[0].Recipes_Name__c = values.[0];
//             //    System.debug('Values: ' + spoonacularlst[0].Recipes_Name__c);               
//             //}   
//             //insert spoonacularlst;
//            // triggerMethod(spoonacularlst,RecipesName);
//         }
//     }

//     public static void triggerMethod(List<spoonacular_API__c> newList) {

//        // List<spoonacular_API__c> lst= new List<spoonacular_API__c>();
//        String na = spoonacularMethod1();
//         for(spoonacular_API__c data : newList){
//             if(data.Name!= null){
//                 data.Recipes_Name__c = RecipesName;
//             }
            
//            // lst.add(data);

//         }
//         // Insert lst;
//     }

// }