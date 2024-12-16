@RestResource(urlMapping='/incomingCalls/*')
global with sharing class IncomingCallsAPI {

    @HttpPost
    global static String receiveCallDetails() {
        RestRequest req = RestContext.request;
        System.debug('The req ---> ' + req);

        //Parse the JSON request body into a map
        String requestBody = req.requestBody.toString();
        System.debug('The requestBody ---> ' + requestBody);
        Map<String, Object> requestData = (Map<String, Object>) JSON.deserializeUntyped(requestBody);
        System.debug('The requestData ---> ' + requestData);

        try {

            String agentNumber = getStringValue(requestData.get('caller'));
            System.debug('agentNumber ---> ' + agentNumber);
            String recipientNumber = getStringValue(requestData.get('receiver'));
            System.debug('recipientNumber ---> ' + recipientNumber);

            if (agentNumber != null && recipientNumber != null) {
                System.debug('Both agentNumber and recipientNumber are received. Proceeding to call transmit the data.');

                // approach 1
                // Call the getIncomingDetails method in callCenterAuraController
                // String result = CallCenterAuraController.getIncomingDetails(agentNumber, recipientNumber);
                // System.debug('Result from getIncomingDetails ---> ' + result);

                // approach 2
                // Publish the Greeter_Communicate event to transmit data
                // publishEvent(agentNumber, recipientNumber);

                // approach 3
                // Create a new IncomingCallGreeter record to temparoryly store details 
                // A scheduled job will delete these created records
                IncomingCallsGreeter__c icg = new IncomingCallsGreeter__c();
                icg.Caller__c = agentNumber;
                icg.Receiver__c = recipientNumber;
                insert icg;

                System.debug('The records created successfully ---> ' + icg);
            }

            Map<String, Object> response = new Map<String, Object>();
            response.put('message', 'Success: Incoming Call details received successfully');
            return JSON.serialize(response);

        } catch (Exception e) {
            System.debug('Error occurred: ' + e.getMessage());
            return JSON.serialize(new Map<String, Object>{
                'message' => 'Error: ' + e.getMessage()
            });
        }
    }

    // Utility method to handle various data types and safely convert them to String
    private static String getStringValue(Object value) {
        if (value == null) {
            return null;
        }
        try {
            if (value instanceof String) {
                return (String) value;
            } else if (value instanceof Decimal || value instanceof Integer || value instanceof Long || value instanceof Double) {
                return String.valueOf(value);
            } else if (value instanceof DateTime) {
                return ((DateTime) value).format(); 
            } else if (value instanceof Boolean) {
                return String.valueOf(value);
            } else {
                return String.valueOf(value);  // Fallback for other types
            }
        } catch (Exception e) {
            return null;  // Handle potential conversion errors
        }
    }
}
