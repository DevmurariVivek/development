public class CTIController {

    @AuraEnabled
    public static String initiateCall(String customerNumber, String customerRecordId) {

        Lead leadrecord = [SELECT Id,Name,Phone FROM Lead WHERE Id =: customerRecordId WITH SECURITY_ENFORCED];
        System.debug('The lead record ---> ' + leadrecord);

        String numberToCall = leadrecord.Phone;
        System.debug('The lead Phone number ---> ' + numberToCall);
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://greeter.co.in/api/click2call');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        
        // Optional: Add a keep-alive header to maintain the proxy connection
        // req.setHeader('Proxy-Connection', 'keep-alive');

        // Set a timeout (optional)
        // req.setTimeout(60000);

        // Construct the request body
        String body = JSON.serialize(new Map<String, Object>{
            'user_id' => '258218',
            'number' => '41',
            'agen_number' => '7265922448',
            'customer_number' => numberToCall,
            'Customer_CRM_ID' => customerRecordId
        });
        
        req.setBody(body);

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            return 'Success: ' + res.getBody();
        } else {
            throw new CalloutException('Failed to initiate call: ' + res.getBody());
        }
    }
}