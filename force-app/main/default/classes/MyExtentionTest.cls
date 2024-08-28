@IsTest
public class MyExtentionTest {
    
    @IsTest
    static void testOutputMethodWithNullParentRecordID() {
        // Set up the test data with a null parentRecordID
        String outputMap = '{'+
            '"dispositionData": {"mobile_number": "1234567890", "value": "CALLBK", "start_date_time_of_call": "2024-08-09 10:00:00", "end_date_time_of_call": "2024-08-09 11:00:00", "name": "Test Agent", "employee_id": "123", "duration": "60", "address3": "Registered Number", "lead_id": "00Q6g000005tPLQ", "recording_url": "http://test.com/recording"},'+
            '"statusMap": {"CALLBK": "Call Back"},'+
            '"recordId": null ,'+ // Simulate null parentRecordID
            '"NoMatchObject": "Lead"'+
        '}';
        
        Lead newlead = new Lead();
        newlead.LastName = 'test';
        newlead.Phone = '1234567890';
        newlead.Company='default';
        Insert newlead;
        // Mock the metadata records
        DialShreeCTI2__Call_Log_Configurations__mdt mappingMeta = new DialShreeCTI2__Call_Log_Configurations__mdt(
            MasterLabel = 'Communication Mappings',
            DeveloperName = 'Communication_Mappings',
            DialShreeCTI2__Object_Name__c = 'Task',
            DialShreeCTI2__Parent_Object_Names__c = 'Lead,Account',
            DialShreeCTI2__Parent_object_relationship_fields__c = 'WhoId,WhatId',
            DialShreeCTI2__IsActive__c = true,
            DialShreeCTI2__Agent_details__c = 'Description',
            DialShreeCTI2__Duration_of_the_call__c = 'CallDurationInMinutes',
            DialShreeCTI2__Start_date_time_of_call__c = 'CreatedDate',
            DialShreeCTI2__End_date_time_of_call__c = 'LastModifiedDate',
            DialShreeCTI2__Mobile_number_customer_is_calling_from__c = 'Phone',
            DialShreeCTI2__Registered_mobile_number__c = 'MobilePhone',
            DialShreeCTI2__Lead_Id__c = 'LeadSource',
            DialShreeCTI2__Link_of_recording__c = 'RecordingURL',
            DialShreeCTI2__Disposition_status__c = 'Status'
        );
        
        Test.startTest();
        // Call the method
        String result = MyExtention.output(outputMap);
        Test.stopTest();

        // Assertions
        System.assertEquals('', result);
    }

    @IsTest
    static void testOutputMethodWithNullParentObjectNames() {
        // Set up the test data with a valid parentRecordID but null Parent_Object_Names
        String outputMap = '{'+
            '"dispositionData": {"mobile_number": "1234567890", "value": "CALLBK", "start_date_time_of_call": "2024-08-09 10:00:00", "end_date_time_of_call": "2024-08-09 11:00:00", "name": "Test Agent", "employee_id": "123", "duration": "60", "address3": "Registered Number", "lead_id": "00Q6g000005tPLQ", "recording_url": "http://test.com/recording"},'+
            '"statusMap": {"CALLBK": "Call Back"},'+
            '"recordId": "0016g00000O5ReY",'+
            '"NoMatchObject": null'+
        '}';

        Lead newlead = new Lead();
        newlead.LastName = 'test';
        newlead.Phone = '1234567890';
        newlead.Company='default';
        Insert newlead;
        // Mock the metadata records with null Parent_Object_Names
        DialShreeCTI2__Call_Log_Configurations__mdt mappingMeta = new DialShreeCTI2__Call_Log_Configurations__mdt(
            MasterLabel = 'Communication Mappings',
            DeveloperName = 'Communication_Mappings',
            DialShreeCTI2__Object_Name__c = 'Task',
            DialShreeCTI2__Parent_Object_Names__c = null, // Simulate null Parent_Object_Names
            DialShreeCTI2__Parent_object_relationship_fields__c = 'WhoId,WhatId',
            DialShreeCTI2__IsActive__c = true,
            DialShreeCTI2__Agent_details__c = 'Description',
            DialShreeCTI2__Duration_of_the_call__c = 'CallDurationInMinutes',
            DialShreeCTI2__Start_date_time_of_call__c = 'CreatedDate',
            DialShreeCTI2__End_date_time_of_call__c = 'LastModifiedDate',
            DialShreeCTI2__Mobile_number_customer_is_calling_from__c = 'Phone',
            DialShreeCTI2__Registered_mobile_number__c = 'MobilePhone',
            DialShreeCTI2__Lead_Id__c = 'LeadSource',
            DialShreeCTI2__Link_of_recording__c = 'RecordingURL',
            DialShreeCTI2__Disposition_status__c = 'Status'
        );
        
        Test.startTest();
        // Call the method
        String result = MyExtention.output(outputMap);
        Test.stopTest();

        // Assertions
        System.assertEquals('', result);
    }
}