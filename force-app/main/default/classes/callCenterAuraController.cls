public with sharing class callCenterAuraController {
    
    // Constants for easier maintenance
    private static final String ENDPOINT_URL = 'https://greeter.co.in/api/click2call';
    private static final String USER_ID = '258218';

    /**
     * Initiates a call by making an API call to the click-to-call service.
     *
     * @param phoneNumber   Customer's phone number
     * @param recordId      Salesforce record ID for tracking
     * @return              Success or error message
     * @throws CalloutException if the API call fails
     */
    @AuraEnabled
    public static String initiateCall(String phoneNumber, String recordId) {
        System.debug('Initiating call process...');

        try {
            // Fetch current user details
            User currentUser = [SELECT Id, MobilePhone, Username 
                                FROM User 
                                WHERE Username = :UserInfo.getUserName() 
                                WITH SECURITY_ENFORCED];
            if (String.isBlank(currentUser.MobilePhone)) {
                throw new CalloutException('User phone number not found.');
            }

            String agentNumber = currentUser.MobilePhone.replaceFirst('^\\+\\d+', '').trim();
            System.debug('agent number ---> ' + agentNumber);

            // Prepare the HTTP request for API call
            HttpRequest request = buildHttpRequest(agentNumber, phoneNumber, recordId);
            HttpResponse response = new Http().send(request);

            // Handle HTTP response
            return handleHttpResponse(response);

        } catch (Exception ex) {
            System.debug('API call error: ' + ex.getMessage());
            throw new CalloutException('Error initiating call: ' + ex.getMessage());
        }
    }

    /**
     * Builds the HTTP request for the call initiation API.
     *
     * @param agentNumber    The phone number of the agent (current user)
     * @param customerPhone The customer's phone number
     * @param recordId      Salesforce record ID
     * @return              HttpRequest configured for the API call
     */
    private static HttpRequest buildHttpRequest(String agentNumber, String customerPhone, String recordId) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ENDPOINT_URL);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

        // Construct JSON body
        Map<String, Object> requestBody = new Map<String, Object>{
            'user_id' => USER_ID,
            'number' => '41',
            'agen_number' => agentNumber,
            'customer_number' => customerPhone,
            'Customer_CRM_ID' => recordId
        };
        req.setBody(JSON.serialize(requestBody));
        
        System.debug('Request body: ' + req.getBody());
        return req;
    }

    /**
     * Handles the HTTP response from the call initiation API.
     *
     * @param response      HttpResponse from the API
     * @return              Success message if call initiated successfully
     * @throws CalloutException if the API response indicates a failure
     */
    private static String handleHttpResponse(HttpResponse response) {
        if (response.getStatusCode() == 200) {
            System.debug('Call initiation successful. Response: ' + response.getBody());
            return 'Success: ' + response.getBody();
        } else {
            System.debug('Call initiation failed with status: ' + response.getStatusCode());
            throw new CalloutException('Failed to initiate call: ' + response.getBody());
        }
    }

    @AuraEnabled
    public static string getIncomingdetails(){
        try {

            User currentUser = [SELECT Id, MobilePhone, Username 
                                FROM User 
                                WHERE Username = :UserInfo.getUserName() 
                                WITH SECURITY_ENFORCED];
            System.debug('the current user ---> ' + currentUser);

            IncomingCallsGreeter__c icg = [SELECT Id, Caller__c, Receiver__c, Notified__c, CreatedDate 
                                           FROM IncomingCallsGreeter__c 
                                           WHERE Receiver__c =:currentUser.MobilePhone 
                                           AND Notified__c = false
                                           WITH SECURITY_ENFORCED 
                                           ORDER BY CreatedDate desc 
                                           LIMIT 1];
            System.debug('incoming calls details ---> ' + icg);


            Map<String, String> numberDetailsMap = new Map<String, String>();
            
            System.debug(' icg.Caller__c ---> ' + icg.Caller__c );
            System.debug(' icg.Receiver__c ---> ' + icg.Receiver__c);

            if (icg.Caller__c != null && icg.Receiver__c != null) {
                numberDetailsMap.put('caller', icg.Caller__c);
                numberDetailsMap.put('receiver', icg.Receiver__c);
                numberDetailsMap.put('id', icg.Id);
            }

            // Return the map as a JSON string
            return JSON.serialize(numberDetailsMap);
        } catch (Exception e) {
             throw new AuraHandledException('Error in getIncomingdetails: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static string incomingCallNotified(Boolean notified, Id recordId){
        try {
            System.debug('The incomingCallNotified called !!');
            String response;
            IncomingCallsGreeter__c icg = [SELECT Caller__c, Receiver__c, Notified__c, CreatedDate 
                                           FROM IncomingCallsGreeter__c 
                                           WHERE Id = : recordId
                                           WITH SECURITY_ENFORCED 
                                        ];
            System.debug('incoming calls details ---> ' + icg);

            if(notified){
                icg.Notified__c = true;
                response = 'Success: Incoming call details are been updated';
                update icg;
            }

            // Return the map as a JSON string
            return response;
        } catch (Exception e) {
             throw new AuraHandledException('Error in getIncomingdetails: ' + e.getMessage());
        }
    }
}
