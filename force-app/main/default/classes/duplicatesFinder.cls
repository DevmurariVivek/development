public with sharing class duplicatesFinder {

    @AuraEnabled(cacheable=true)
    public static Map<String, List<SObject>> checkForDuplicates(Id recordId, String ObjectTofetch) {


        // Get the Object Type  
        Schema.SObjectType objectType = recordId.getSobjectType();
        String sobjectName = objectType.getDescribe().getName(); 

        // Get the current record
        SObject record = Database.query('Select Id, Name, CreatedDate, LastModifiedDate  From ' + sobjectName + ' Where Id = :recordId');
        System.debug('record---' +record);

        String currentRecordId = String.valueOf(record.get('Id'));
        System.debug('currentRecordId---' +currentRecordId);
        
        
        List<SObject> matchingRecord = new List<SObject>();
        List<SObject> allRecords =  Database.query('Select Id, Name, CreatedDate, LastModifiedDate From ' + sobjectName + ' Where Name <> null');
        System.debug('allRecords---' +allRecords);

        for (SObject loopRecord : allRecords) {
            if (loopRecord.get('Name') == record.get('Name') && loopRecord.get('Id') <> record.get('Id')) {
                matchingRecord.add(loopRecord);
            }
        }
        System.debug('matchingRecord---' + matchingRecord);

        // Create a map to store the results
        Map<String, List<SObject>> resultMap = new Map<String, List<SObject>>();
        
        // Add the current record to the map
        resultMap.put('currentrecord', new List<SObject>{record});
        
        // Add the matching records to the map
        resultMap.put('matchedrecords', matchingRecord);

        System.debug('resultMap---' +resultMap);
        return resultMap;
}}