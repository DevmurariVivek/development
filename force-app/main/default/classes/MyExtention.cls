// This external class will be used to listen to the output shared by Interface class of DialShree CTI 
global with sharing class MyExtention implements DialShreeCTI2.DialShreeInterface.Extention{
    global static String output(String outputMap){
        String outputString = ''; // Initialize outputString
        
        try {
            Map<String,Object> communicationData = (Map<String,Object>) JSON.deserializeUntyped(outputMap);
            System.debug('communicationData --- ' + communicationData);
            Map<String,Object> communicationDataMap = (Map<String,Object>)communicationData.get('dispositionData');
            System.debug('communicationDataMap --- ' + communicationDataMap);
            Map<String,Object> statusMap = (Map<String,Object>)communicationData.get('statusMap');
            System.debug('statusMap --- ' + statusMap);
            Id parentRecordID = (String)communicationData.get('recordId');
            System.debug('parentRecordID --- ' + parentRecordID);
            String noMatchObject = (String)communicationData.get('NoMatchObject');
            System.debug('noMatchObject --- ' + noMatchObject);
            String startDateInputText;
            String endDateInputText;
            Datetime startDateInput;
            Datetime endDateInput;

            DialShreeCTI2__Call_Log_Configurations__mdt mapppingMeta = [SELECT MasterLabel,
                                                                Label,
                                                                DeveloperName,
                                                                DialShreeCTI2__Agent_details__c,
                                                                DialShreeCTI2__Apex_Class_Name__c,
                                                                DialShreeCTI2__Disposition_status__c,
                                                                DialShreeCTI2__Duration_of_the_call__c,
                                                                DialShreeCTI2__End_date_time_of_call__c,
                                                                DialShreeCTI2__IsActive__c,
                                                                DialShreeCTI2__Mobile_number_customer_is_calling_from__c,
                                                                DialShreeCTI2__Registered_mobile_number__c,
                                                                DialShreeCTI2__Object_Name__c,
                                                                DialShreeCTI2__Start_date_time_of_call__c,
                                                                DialShreeCTI2__Lead_Id__c,
                                                                DialShreeCTI2__Link_of_recording__c,
                                                                DialShreeCTI2__Parent_Object_Names__c,
                                                                DialShreeCTI2__Parent_object_relationship_fields__c
                                                            FROM DialShreeCTI2__Call_Log_Configurations__mdt 
                                                            WHERE DeveloperName = 'Communication_Mappings' WITH SECURITY_ENFORCED limit 1 ];
        
            String objectName = mapppingMeta.DialShreeCTI2__Object_Name__c;
            Type objectType = Type.forName(objectName);
            System.debug('object to track call logs in --- ' + objectType);
            List<String> parentObjectNames = mapppingMeta.DialShreeCTI2__Parent_Object_Names__c.split(',');
            List<String> parentObjectRelationshipFields = mapppingMeta.DialShreeCTI2__Parent_object_relationship_fields__c.split(',');
            String phoneNumber = String.valueOf(communicationDataMap.get('mobile_number'));
            String sObjName;
            Map<String, String> objectFieldMap = new Map<String, String>();
            SObject parentRecord;
            String soqlQueryString;
            String dispositionStatus;
            String recordName;
            
            if (objectName != null && mapppingMeta.DialShreeCTI2__IsActive__c == true) {
                SObject newRecord = (SObject)objectType.newInstance();

                if (statusMap != null && statusMap.containsKey(String.valueOf(communicationDataMap.get('value')))) {
                    dispositionStatus = (String)statusMap.get(String.valueOf(communicationDataMap.get('value')));
                } else if (String.valueOf(communicationDataMap.get('value')).contains('CALLBK')) {
                    dispositionStatus = 'Call Back';
                }
 
                if (communicationDataMap.get('start_date_time_of_call') != null) {
                    String startdateTimeValue = String.valueOf(communicationDataMap.get('start_date_time_of_call'));
                    List<String> filterLogicSplittedbySpaceStart = startdateTimeValue.split(' ');
                    String updatedDateTimeStart = filterLogicSplittedbySpaceStart[0] + 'T' + filterLogicSplittedbySpaceStart[1];
                    startDateInput = (DateTime)Json.deserialize('"' + updatedDateTimeStart + '"', DateTime.class);
                    //System.debug('startDateInput --- ' + startDateInput);
                    
                    startDateInputText = startDateInput.formatGMT('yyyy-MM-dd HH:mm:ss');
                    System.debug('startDateInputText --- ' + startDateInputText);
                }
                if (communicationDataMap.get('end_date_time_of_call') != null) {
                    String enddateTimeValue = String.valueOf(communicationDataMap.get('end_date_time_of_call'));
                    List<String> filterLogicSplittedbySpaceEnd = enddateTimeValue.split(' ');
                    String updatedDateTimeEnd = filterLogicSplittedbySpaceEnd[0] + 'T' + filterLogicSplittedbySpaceEnd[1];
                    endDateInput = (DateTime)Json.deserialize('"' + updatedDateTimeEnd + '"', DateTime.class);
                    //System.debug('endDateInput --- ' + endDateInput);

                    endDateInputText = endDateInput.formatGMT('yyyy-MM-dd HH:mm:ss');
                    System.debug('endDateInputText --- ' + endDateInputText);
                }
                if (mapppingMeta.DialShreeCTI2__Agent_details__c != null) {
                    String agentDetails = communicationDataMap.get('name') + ' , ' + communicationDataMap.get('employee_id');
                    newRecord.put(mapppingMeta.DialShreeCTI2__Agent_details__c, agentDetails);
                }
                if (mapppingMeta.DialShreeCTI2__Duration_of_the_call__c != null) {
                    newRecord.put(mapppingMeta.DialShreeCTI2__Duration_of_the_call__c, communicationDataMap.get('duration'));
                }
                if (mapppingMeta.DialShreeCTI2__Start_date_time_of_call__c != null) {
                    newRecord.put(mapppingMeta.DialShreeCTI2__Start_date_time_of_call__c, startDateInputText);
                }
                if (mapppingMeta.DialShreeCTI2__End_date_time_of_call__c != null) {
                    newRecord.put(mapppingMeta.DialShreeCTI2__End_date_time_of_call__c, endDateInputText);
                }
                if (mapppingMeta.DialShreeCTI2__Mobile_number_customer_is_calling_from__c != null) {
                    newRecord.put(mapppingMeta.DialShreeCTI2__Mobile_number_customer_is_calling_from__c, communicationDataMap.get('mobile_number'));
                }
                if (mapppingMeta.DialShreeCTI2__Registered_mobile_number__c != null) {
                    newRecord.put(mapppingMeta.DialShreeCTI2__Registered_mobile_number__c, communicationDataMap.get('address3'));
                }  
                if (mapppingMeta.DialShreeCTI2__Lead_Id__c != null) {
                    newRecord.put(mapppingMeta.DialShreeCTI2__Lead_Id__c, communicationDataMap.get('lead_id'));
                }
                if (mapppingMeta.DialShreeCTI2__Link_of_recording__c != null) {
                    newRecord.put(mapppingMeta.DialShreeCTI2__Link_of_recording__c, communicationDataMap.get('recording_url'));
                }
                if (mapppingMeta.DialShreeCTI2__Disposition_status__c != null) {
                    newRecord.put(mapppingMeta.DialShreeCTI2__Disposition_status__c, dispositionStatus);
                }
                
                if (parentRecordID != null && mapppingMeta.DialShreeCTI2__Parent_Object_Names__c != null && mapppingMeta.DialShreeCTI2__Parent_object_relationship_fields__c != null) {
                    
                    try {
                        sObjName = parentRecordID.getSObjectType().getDescribe().getName();
                        System.debug('Parent records object name when parent record exists --- ' + sObjName);

                        soqlQueryString = 'SELECT Id, Name FROM ' + sObjName + ' WHERE Id =:parentRecordID' ;
                        System.debug('soqlQueryString when parent record id exist --- ' + soqlQueryString);

                        parentRecord = Database.query(String.escapeSingleQuotes(soqlQueryString));
                        System.debug('parentRecord when parent record exists --- ' + parentRecord);
        
                        for (Integer i = 0; i < parentObjectNames.size(); i++) {
                            objectFieldMap.put(parentObjectNames[i], parentObjectRelationshipFields[i]);
                        }

                        newRecord.put(objectFieldMap.get(sObjName), parentRecordID);
                    
                        TimeZone userTimeZone = UserInfo.getTimeZone();
                        Datetime datetimeUTC = System.now();
                        String currentTime = datetimeUTC.format('yyyy-MM-dd HH:mm:ss', String.valueOf(userTimeZone));
                        System.debug('currentTime 126 --- ' + currentTime);
                        recordName = parentRecord.get('Name') + ' - Call log - ' + currentTime;

                    } catch (Exception e) {
                        System.debug('Received Error when tried to link to be created record with available Parent Record Id --- ' + e.getMessage());
                    }    
                    
                } else {
                    try {
                        if (noMatchObject == 'Lead') {

                            soqlQueryString = 'SELECT Id, Name, Phone, CreatedDate FROM ' + noMatchObject + ' WHERE Phone = :phoneNumber ORDER BY CreatedDate DESC LIMIT 1';
                            System.debug('soqlQueryString --- ' + soqlQueryString);

                            parentRecord = Database.query(String.escapeSingleQuotes(soqlQueryString));
                            System.debug('parentRecord --- ' + parentRecord);

                            sObjName = parentRecord.Id.getSObjectType().getDescribe().getName();
                            System.debug('Parent records object name when parent record do not exists--- ' + sObjName);

                            for (Integer i = 0; i < parentObjectNames.size(); i++) {
                                objectFieldMap.put(parentObjectNames[i], parentObjectRelationshipFields[i]);
                            }

                            newRecord.put(objectFieldMap.get(sObjName), parentRecord.Id);

                            TimeZone userTimeZone = UserInfo.getTimeZone();
                            Datetime datetimeUTC = System.now();
                            String currentTime = datetimeUTC.format('yyyy-MM-dd HH:mm:ss', String.valueOf(userTimeZone));
                            System.debug('currentTime 154 --- ' + currentTime);
                            recordName = parentRecord.get('Name') + ' - Call log - ' + currentTime;
                        }

                    } catch (Exception e) {
                        System.debug('Received Error when tried to link to be created record with newly created Record --- ' + e.getMessage());
                    }
                }

                if (objectName == 'Task') {
                    newRecord.put('Subject', recordName);
                    System.debug('recordName for task --- ' + recordName);
                } else {
                    newRecord.put('Name', recordName);
                    System.debug('recordName for else --- ' + recordName);
                }

                try {
                    if (objectFieldMap.get(sObjName) != null) {
                        System.debug('174' + newRecord.get(mapppingMeta.DialShreeCTI2__Start_date_time_of_call__c));
                        insert newRecord;
                        System.debug('New Record to be created --- ' + newRecord);
                    } else {
                        System.debug('New Record cannot be created as there is no parent relationship assigned to noMatchObject or to objects added in searchlist in Call Log Configuration');
                    }
                } catch (Exception e) {
                    System.debug('Received error while creating new call log tracking record ---' + e.getMessage());
                }
            }
        } catch (Exception ex) {
            System.debug('Received Error --' + ex.getMessage());
        }
        return outputString;   
    }
}