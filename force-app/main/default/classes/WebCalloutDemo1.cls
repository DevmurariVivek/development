public with sharing class WebCalloutDemo1 {
    public static void WebCalloutClass() {

        //Creates HTTP object
        Http http = new Http();
        //Passes the HTTP request to fetch desired data by creating a instance of HttpRequest class
        HttpRequest request = new HttpRequest();
        //Sets Endpoint URL from where we are requesting the data
        request.setEndpoint('https://youtube.googleapis.com/youtube/v3/channels?part=id&part=statistics&part=status&part=contentOwnerDetails&forUsername=Salesforce%20Apex%20Hours&key=AIzaSyA5u3haNtPz-cnqyixxBEzSO8Y4M72XxNgHTTP/1.1');
        //Specifies the request type here we used GET
        request.setMethod('GET');
        //Passes the output into HttpResponse class
        HttpResponse response = http.send(request);

        //if the request is successful, parse the JSON response
             // Method 1 to fetch the details into salesforce: using Wrapper class (here : YoutubeAPIClass)
                // if (response.getStatusCode() == 200) {
                //     // Check what is the response we get 
                //     System.debug('Response:::' + response.getBody());

                //     //Passing the output to another Class
                //     // in this metthod wrapperclass.parse method will automatically generate the key value pair for us
                //     YoutubeAPIClass result = YoutubeAPIClass.parse(response.getBody());
                //     for ( YoutubeAPIClass.Items itm : result.Items) {
                //         System.debug('Fetched Following Response');
                //         System.debug(itm.statistics);               
                //     }        
                // }
                // else{
                //     System.debug('Response:::'+response.getStatus());  
                // }

            // Method 2 to fetch the details into salesforce: using Deserialize JSON into Collection of primitive data type
            // As in this method we have to type caste the response and write a bit lengthy code
                if (response.getStatusCode() == 200) {
                    Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
                    
                    // pass the key, here the key is items (as items was in form of Array) which we will get in JSON format
                    List<Object> items = (List<Object>) results.get('items');

                    for (Object item : items) {
                        Map<String, Object> childMap =(Map<String,Object>)item;
                        System.debug('Fetched Following Response');
                        System.debug(childMap.get('statistics'));                      
                    }
                }
                else{
                    System.debug('Response:::'+response.getStatus()); 
                }
    }
}