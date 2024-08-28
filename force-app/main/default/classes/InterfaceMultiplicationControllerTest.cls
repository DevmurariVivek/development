@isTest
public class InterfaceMultiplicationControllerTest {

    @isTest
    static void testCallInterfaceMethod_WithExternalClass() {
        // Test data setup
        Decimal total = 10;
        
        // Mock the External_Apex_Class__c record
        External_Apex_Class__c externalApex = new External_Apex_Class__c(
            ManagedCodeDev__ClassName__c = 'YourExternalClass',
            ManagedCodeDev__IsActive__c = true
        );
        insert externalApex;
        
        Test.startTest();
        // Test the callinterfaceMethod method when the external class exists
        Decimal result = InterfaceMultiplicationController.callinterfaceMethod(total);
        Test.stopTest();
        
        // Assertion
        System.assertNotEquals(null, result, 'Result should not be null when the external class exists');
        // Add more assertions as needed
    }
    
    @isTest
    static void testCallInterfaceMethod_WithoutExternalClass() {
        // Test data setup
        Decimal total = 10;
        
        // Mock the External_Apex_Class__c record as inactive or doesn't exist
        External_Apex_Class__c externalApex = new External_Apex_Class__c(
            ManagedCodeDev__ClassName__c = null,
            ManagedCodeDev__IsActive__c = false
        );
        insert externalApex;
        
        Test.startTest();
        // Test the callinterfaceMethod method when the external class doesn't exist
        Decimal result = InterfaceMultiplicationController.callinterfaceMethod(total);
        Test.stopTest();
        
        // Assertion
        System.assertEquals(null, result, 'Result should be null when the external class does not exist');
        // Add more assertions as needed
    }
}