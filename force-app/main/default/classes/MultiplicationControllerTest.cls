@isTest
private class MultiplicationControllerTest {
    @isTest
    static void testSaveMultiplicationResult() {
        // Test data setup
        Managing_Object__c testObject = new Managing_Object__c(Number_1__c = 2, Number_2__c = 3);
        insert testObject;
        
        External_Apex_Class__c externalApex = new External_Apex_Class__c(
            ManagedCodeDev__ClassName__c = 'YourExternalClass',
            ManagedCodeDev__IsActive__c = true
        );
        insert externalApex;
        // Test method execution
        Test.startTest();
        Decimal result = MultiplicationController.saveMultiplicationResult(testObject.Id, 2, 3);
        Test.stopTest();
        // Assertion
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals(6, result, 'Result should be 6');
        // Check Debug_logger__c records
        List<Debug_logger__c> debugLogs = [SELECT Method_Name__c FROM Debug_logger__c WHERE Class_Component_Name__c = 'MultiplicationController'];
        System.assertEquals(6, debugLogs.size(), 'Should have created 5 debug logs');
    }
    @isTest
    static void testSaveMultiplicationResultException() {
        // Test data setup
        Managing_Object__c testObject = new Managing_Object__c(Number_1__c = 2, Number_2__c = 3);
        insert testObject;
        // Test method execution with exception
        Test.startTest();
        Decimal result = MultiplicationController.saveMultiplicationResult(null, 2, 3); // Passing null Id to cause exception
        Test.stopTest();
        // Assertion
        System.assertEquals(null, result, 'Result should be null because of exception');
    }
    @isTest
    static void testInternalClassCall() {
        // Test method execution
        Test.startTest();
        MultiplicationController.InternalClassCall(null);
        Test.stopTest();
        // Check Debug_logger__c records
        List<Debug_logger__c> debugLogs = [SELECT Method_Name__c FROM Debug_logger__c WHERE Class_Component_Name__c = 'MultiplicationController'];
        System.assertEquals(1, debugLogs.size(), 'Should have created 1 debug log');
    }
}