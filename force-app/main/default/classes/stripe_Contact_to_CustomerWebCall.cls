public with sharing class stripe_Contact_to_CustomerWebCall {
    @future (callout=true)
    public static void WebCallPostMethod( String Name, String Email, String Phone, Decimal Balance, String CurrencyIsoCode, String ConId) {
        
        String accessToken = 'sk_test_51MChKXSIWJ2ih3x9Lb1tF29N1qaTQ67FRYJA8do8fWxCH6KcjGAjpx7Dr1AnLgZKO4MGmSNDhy76TLqpdDfPhb64005LL4iYch';

        System.debug(Name);
        System.debug(Email);
        System.debug(Phone);
        System.debug(Balance);
        System.debug(CurrencyIsoCode);
        System.debug(ConId);

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
 
        String body ='email='+Email+'&name='+Name+'&balance='+Balance+'&phone='+Phone; 
        req.setBody(body);
        System.debug(body);

        req.setEndpoint('https://api.stripe.com/v1/customers');                  
        req.setMethod('POST');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setHeader('Authorization','Bearer ' + accessToken );

        res = http.send(req);
        String responseBody = res.getBody();
        System.debug('responseBody:::' + responseBody);
        System.debug('Response:::' + req.getBody());
        System.debug('ResponseStatus:::' + res.getStatusCode());

        if (res.getStatusCode() == 200) {

            Map <String, Object> result = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            System.debug( ' MAP --' + result.get('id'));

            List<Contact> conlist = [SELECT Id, Name, Customer_ID__c, Email, Phone, Balance__c, CurrencyIsoCode FROM Contact WHERE Id =: ConId ];
            System.debug(conlist );
            conlist[0].Customer_ID__c = String.valueOf(result.get('id'));
            Update conlist; 

                // Stripe_Customer__c CS = Stripe_Customer__c.getInstance();
                // CS.Customer_ID__c = String.valueOf(result.get('id'));
                // CS.Name = Name;
                // CS.SetupOwnerId  = UserInfo.getOrganizationId();
                // System.debug(CS.Customer_ID__c);
                // insert CS;  

        }
        // stripe_Contact_to_CustomerSystemCall.InsertData(ConId, Name);

    }
    
    // public static void WebCallGetMethod( String ConId, String Name ) {
       
    //     String searchString ='\'' +Name+ '\'';
    //     System.debug(searchString);

    //     // List<Stripe_Customer__c> CSout = Stripe_Customer__c.getValues(searchString);
    //     // System.debug(CSout[0].Customer_ID__c); 

    //     if(CSout.size() != 0){
    //         System.debug(CSout[0].Customer_ID__c); 
    //     }
    //     List<Stripe_Customer__c> CSout = [SELECT Id,Name, Customer_ID__c  FROM Stripe_Customer__c WHERE Name =:searchString];

    //     stripe_Contact_to_CustomerSystemCall.InsertData(searchString);
                     
        // List<Contact> conlist = [SELECT Id, Name, Customer_ID__c, Email, Phone, Balance__c, CurrencyIsoCode FROM Contact WHERE Id =: ConId ];
        // System.debug(conlist );
        // conlist[0].Customer_ID__c = CSout[0].Customer_ID__c;
        // Update conlist;

        // String accessToken = 'sk_test_51MChKXSIWJ2ih3x9Lb1tF29N1qaTQ67FRYJA8do8fWxCH6KcjGAjpx7Dr1AnLgZKO4MGmSNDhy76TLqpdDfPhb64005LL4iYch';
        // Http http = new Http();
        // HttpRequest req = new HttpRequest();
        // HttpResponse res = new HttpResponse();

        // // Stripe_Customer__c CS = Stripe_Customer__c.getValues('Customer_ID__c');

        // req.setHeader('Content-Type','application/x-www-form-urlencoded');
        // req.setHeader('Authorization','Bearer ' + accessToken );
        // req.setEndpoint('https://api.stripe.com/v1/customers/'+ CSout[0].Customer_ID__c);                  
        // req.setMethod('GET');
        
        // res = http.send(req);
        // String responseBody = res.getBody();
        // System.debug('responseBody:::' + responseBody);
}   
// cus_My279AC1Pp7ED6