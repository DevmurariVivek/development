@RestResource(urlMapping='/callDetails/*')
global with sharing class CallDetailsAPI {

    @HttpPost
    global static String receiveCallDetails() {
        RestRequest req = RestContext.request;

        // Parse the JSON request body into a map
        String requestBody = req.requestBody.toString();
        Map<String, Object> requestData = (Map<String, Object>) JSON.deserializeUntyped(requestBody);
        System.debug('requested data --->' + requestData);

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
            String callType = getStringValue(requestData.get('callType'));
            System.debug('callType ---> ' + callType);

            User callerAgent;
            Id crmId;
            if(requestData.containsKey('crmId') && !String.isBlank((String) requestData.get('crmId'))){
                crmId = getStringValue(requestData.get('crmId'));
                System.debug('crmId ---> ' + crmId);
            } else {
                crmId = null;
                System.debug('crmId is either missing or blank.');
            }

            // Fetch the call log tracking object details 
            Greeter_Call_logs_Mappings__mdt callLogs = [
                SELECT Id, Object_Name__c, Parent_Object_Names__c, Parent_object_relationship_fields__c 
                FROM Greeter_Call_logs_Mappings__mdt
                WITH SECURITY_ENFORCED
                LIMIT 1
            ];

            if (callLogs == null || String.isBlank(callLogs.Parent_Object_Names__c)) {
                throw new CustomException('No Parent object found to link the call log record');
            }
            // Here i have retrived the object name from the custom metadata but never used in code, 
            // needs to use this data when proposing a solution that can have different object created for tracking call logs other than call_log__c

            List<String> parentObjectNames = callLogs.Parent_Object_Names__c.split(',');
            System.debug('parentObjectNames ---> ' + parentObjectNames);
            List<String> parentObjectRelationshipFields = callLogs.Parent_object_relationship_fields__c.split(',');
            System.debug('parentObjectRelationshipFields ---> ' + parentObjectRelationshipFields);

            if (parentObjectNames.size() != parentObjectRelationshipFields.size()) {
                throw new CustomException('Mismatch in parent object names and relationship fields.');
            }

            if(callType == 'Inbound' && crmId == null ){
                
                callerAgent = [SELECT Id, MobilePhone, username FROM User WHERE MobilePhone = :receiver WITH SECURITY_ENFORCED LIMIT 1];
                System.debug('callerAgent for Inbound calls---> ' + callerAgent);

                String soslQueryString = 'FIND \'' + caller + '\' IN PHONE FIELDS RETURNING ';
                String objQueryString ;

                for (String parentObjectName : parentObjectNames) {
                    if(objQueryString == null){
                        objQueryString = parentObjectName + '(Id,Name,CreatedDate ORDER BY CreatedDate DESC)';
                    }else{
                        objQueryString = objQueryString +','+ parentObjectName + '(Id,Name,CreatedDate ORDER BY CreatedDate DESC)';
                    }
                }

                soslQueryString = soslQueryString + objQueryString;
                System.debug('soslQueryString --- ' + soslQueryString);
                List<List<SObject>> searchList = search.query(soslQueryString);
                System.debug('searchList --- ' + searchList);

                for (Integer i = 0; i < parentObjectNames.size(); i++) {
                    String parentObjectName = parentObjectNames[i];
                    if (!searchList.isEmpty()) {
                        List<SObject> resultsForObject = searchList[i];  // Each list corresponds to each object in `parentObjectNames`
            
                        // Check if there is any record found for this object type
                        if (!resultsForObject.isEmpty()) {
                            SObject foundRecord = resultsForObject[0];  // Take the first record found for this object type
                            crmId = (Id) foundRecord.get('Id');  // Set the crmId to the first record's Id
                            System.debug('Found Id in ' + parentObjectName + ' ---> ' + crmId);
                            break;  // Exit the loop as we found the first record based on priority
                        }
                    }
                }

                if (crmId == null) {
                    System.debug('No matching record found for any specified object types in Parent_Object_Names__c');
                }

            }else {
                callerAgent = [SELECT Id, MobilePhone, username FROM User WHERE MobilePhone = :caller WITH SECURITY_ENFORCED LIMIT 1];
                System.debug('callerAgent for C2C calls---> ' + callerAgent);

                // if (callerAgent == null) {
                //     throw new CustomException('The caller attribute does not match with the mobile number of available agents: ' + crmId);
                // }
            }

            // Identify the correct parent object and relationship field using crmId
            String parentObjectName = null;
            String relationshipField = null;
            SObject parentRecord = null;

            System.debug('parentObjectNames size ---> ' + parentObjectNames.size());

            for (Integer i = 0; i < parentObjectNames.size(); i++) {
                String query = 'SELECT Id FROM ' + parentObjectNames[i] + ' WHERE Id = :crmId LIMIT 1';
                System.debug('query --->' + query);

                try {
                    parentRecord = Database.query(query);
                    System.debug('parentRecord --->' +parentRecord);

                    if (parentRecord != null) {
                        parentObjectName = parentObjectNames[i];
                        relationshipField = parentObjectRelationshipFields[i];
                        break;  // Exit loop as we found a matching record
                    }                                                                       
                } catch (Exception e) {
                    System.debug('Error querying ' + parentObjectNames[i] + ': ' + e.getMessage());
                }
            }

            if (parentRecord == null) {
                throw new CustomException('Parent record not found for crmId: ' + crmId);
            }

            // fetch the user to mark

            System.debug('Parent Object Name ---> ' + parentObjectName);
            System.debug('Relationship Field ---> ' + relationshipField);

            // Insert or update the record in Salesforce (e.g., Call_Log__c custom object)
            String objectName = callLogs.Object_Name__c;
            Type objectType = Type.forName(objectName);
            SObject callLog = (SObject)objectType.newInstance();
            callLog.put('caller__c', caller);
            callLog.put('receiver__c', receiver);
            callLog.put('callDate__c', callDate);
            callLog.put('duration__c', duration);
            callLog.put('Status__c', status);
            callLog.put('recordingLink__c', recordingLink);
            callLog.put('crmId__c', crmId);
            callLog.put('callType__c', callType);
            callLog.put(relationshipField, parentRecord.Id);
            callLog.put('Agent__c', callerAgent.Id);

            insert callLog;
            System.debug('The Call Log Record ---> ' + callLog);
             
            Map<String, Object> response = new Map<String, Object>();
            response.put('message', 'Success: Call details recorded');
            response.put('crmId', crmId);
            return response.toString();

            //return 'Success: Call details recorded';
        } catch (Exception e) {
            System.debug('error line ---> ' +e.getLineNumber());
            System.debug('error message ---> ' +e.getMessage());
            System.debug('error stack ---> ' +e.getStackTraceString());
            System.debug('error type ---> ' +e.getTypeName());
            return 'Error occured --->' + e.getMessage();
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

    // Custom exception to handle specific errors
    global class CustomException extends Exception {}
}