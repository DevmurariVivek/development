public without sharing class CTIController {

    @AuraEnabled
    public static String initiateCall(Id customerRecordId) {
        try {
            // Step 1: Fetch agent number and customer number
            Map<String, String> phoneNumbers = fetchPhoneNumbers(customerRecordId);
            
            String agentNumber = phoneNumbers.get('agentNumber');
            String customerNumber = phoneNumbers.get('customerNumber');
            
            // Step 2: Perform the API call using the fetched phone numbers
            if (agentNumber != null && customerNumber != null) {
                return performApiCall(agentNumber, customerNumber, customerRecordId);
            } else {
                throw new CalloutException('Invalid agent or customer phone number.');
            }

        } catch (Exception ex) {
            System.debug('Received Error --' + ex.getMessage());
            return 'Error: ' + ex.getMessage();
        }
    }
    
    // New Method to handle fetching agent and customer phone numbers
    public static Map<String, String> fetchPhoneNumbers(Id customerRecordId) {
        Map<String, String> phoneNumbers = new Map<String, String>();
        
        try {
            // Fetch the current user's agent phone number
            String username = UserInfo.getUserName();
            System.debug('Current user\'s username ---> ' + username);

            User userdetails = [SELECT Id, Phone, username FROM User WHERE username = :username WITH SECURITY_ENFORCED];
            System.debug('Fetched user details ---> ' + userdetails);

            String agentNumber = userdetails.Phone;
            System.debug('Agent phone number --->' + agentNumber);

            // Fetch the object name based on the record ID
            String sObjName = customerRecordId.getSObjectType().getDescribe().getName();
            System.debug('sObjName ---> ' + sObjName);

            // Fetch phone field mapping from custom metadata
            Greeter_Phone_Field_Mapping__mdt phoneFieldMappings = [
                SELECT Id, Object_Name__c, Phone_field_Name__c 
                FROM Greeter_Phone_Field_Mapping__mdt 
                WHERE Object_Name__c LIKE :('%' + sObjName + '%') 
                WITH SECURITY_ENFORCED
            ];
            System.debug('Phone field mappings ---> ' + phoneFieldMappings);

            if (phoneFieldMappings != null && phoneFieldMappings.Phone_field_Name__c != null) {
                // Construct dynamic SOQL query to fetch customer phone number
                String phoneFieldAPIName = phoneFieldMappings.Phone_field_Name__c;
                String query = 'SELECT Id, ' + phoneFieldAPIName + ' FROM ' + sObjName + ' WHERE Id = :customerRecordId';
                System.debug('Dynamic Query ---> ' + query);

                SObject resultRecord = Database.query(query);
                System.debug('Result Record ---> ' + resultRecord);

                // Get customer phone number
                String customerNumber = (String) resultRecord.get(phoneFieldAPIName);
                System.debug('Customer Phone Number ---> ' + customerNumber);

                // Store agentNumber and customerNumber in a map to return
                phoneNumbers.put('agentNumber', agentNumber);
                phoneNumbers.put('customerNumber', customerNumber);
            } else {
                System.debug('No valid phone field mapping found.');
            }

        } catch (Exception ex) {
            System.debug('Error while fetching phone numbers: ' + ex.getMessage());
        }

        return phoneNumbers;
    }

    // New Method to handle API call
    public static String performApiCall(String agentNumber, String customerNumber, Id customerRecordId) {
        try {
            // Set up the API call
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://greeter.co.in/api/click2call');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            
            // Construct the request body
            String body = JSON.serialize(new Map<String, Object>{
                'user_id' => '258218',
                'number' => '41',
                'agen_number' => agentNumber,
                'customer_number' => customerNumber,
                'Customer_CRM_ID' => customerRecordId
            });
            req.setBody(body);

            Http http = new Http();
            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                System.debug('The Response ---> ' + res.getBody());
                return 'Success: ' + res.getBody();
            } else {
                throw new CalloutException('Failed to initiate call: ' + res.getBody());
            }

        } catch (Exception ex) {
            System.debug('API Call Error: ' + ex.getMessage());
            throw new CalloutException('API Call Error: ' + ex.getMessage());
        }
    }
}
