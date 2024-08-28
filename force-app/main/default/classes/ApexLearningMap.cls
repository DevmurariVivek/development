public class ApexLearningMap {
    public void MapMethod() {     

        // below is code where Key is Integer and values are String, we are inserting new records using put method and debugging to see keys and values stored in that Map
        Map<Integer, String> intTostring = new Map<Integer, String>();
        intTostring.put(1,'First');
        intTostring.put(2,'Second');
        System.debug('intTostring : '+ intTostring);
     
        // Passed List of Account as Value directly into Map - 'mapfromList'
        Map<Id, Account> mapfromList = new Map<Id, Account>([SELECT Id,Name FROM Account LIMIT 2]);
        System.debug('Map of Account '  + mapfromList);

        //Created a Set of same datatype as Key of corresponding Map to store Map's Keys to Set , and than we can use that set of Keys(Ids) further use
        Set<Id> IdSet = new Set<Id>();
        IdSet = mapfromList.keyset();
        System.debug('Ids of Map in Set: '  + IdSet);

        // to transfer Stored Key values from Set to List , created a new list of Ids and transfered to that list
        List<Id> IdList = new List<Id>(); 
        IdList.addAll(IdSet);
        System.debug('Ids of Map in List: ' + IdList);
   
        // Use of If condition on and values method to return all the stored values in mapfromList Map
        // IF(mapfromList != null)
        // {
             
        //     System.debug('Values:' + mapfromList.values());
        // }

        Account a = new Account(Name='Acme', BillingCity='New York');
        Account b = new Account(Name='Edge', BillingCity='India');

        		Map<Integer, Account> map1 = new Map<Integer, Account> {};
                map1.put(1, a);
        		System.debug(map1);
        
        		Map<Integer, Account> map3 = new Map<Integer, Account> {};
            	map3.put(2, b);
       			System.debug(map3);

       		    Map<Integer, Account> map2 = map1.clone();
                map1.get(1).BillingCity = 'San Francisco';
        	    System.debug(map2);

                System.assertEquals('San Francisco', map1.get(1).BillingCity);
        		System.debug(map1);

                System.assertEquals('San Francisco', map2.get(1).BillingCity);
        		System.debug(map1);

    }
}