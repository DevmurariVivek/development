@RestResource(urlMapping='/callDetails/*')
global with sharing class CallDetailsAPI {

    @HttpPost
    global static String receiveCallDetails() {
        RestRequest req = RestContext.request;

        // Parse the JSON request body into a map
        String requestBody = req.requestBody.toString();
        Map<String, Object> requestData = (Map<String, Object>) JSON.deserializeUntyped(requestBody);

        try {
            // Helper method to convert any type to String
            String caller = getStringValue(requestData.get('caller'));
            System.debug('caller ---> ' + caller);
            String receiver = getStringValue(requestData.get('receiver'));
            System.debug('receiver ---> ' + receiver);
            String callDate = getStringValue(requestData.get('callDate'));
            System.debug('callDate ---> ' + callDate);
            String duration = getStringValue(requestData.get('duration'));
            System.debug('duration ---> ' + duration);
            String status = getStringValue(requestData.get('status'));
            System.debug('status ---> ' + status);
            String recordingLink = getStringValue(requestData.get('recordingLink'));
            System.debug('recordingLink ---> ' + recordingLink);
            String crmId = getStringValue(requestData.get('crmId'));
            System.debug('crmId ---> ' + crmId);


            // Insert or update the record in Salesforce (e.g., Call_Log__c custom object)
            Call_Log__c callLog = new Call_Log__c(
                caller__c = caller,
                receiver__c = receiver,
                callDate__c = callDate,
                duration__c = duration,
                Status__c = status,
                recordingLink__c = recordingLink,
                crmId__c = crmId,
                Lead__c = crmId
            );

            insert callLog;
            Map<String, Object> response = new Map<String, Object>();
            response.put('message', 'Success: Call details recorded');
            response.put('crmId', crmId);
            return response.toString();

            //return 'Success: Call details recorded';
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
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
