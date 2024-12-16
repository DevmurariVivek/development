@IsTest
public class CTIControllerTest {

    @IsTest
    static void testInitiateCall() {
        // Create a test user with a unique username
        String uniqueUsername = 'testuser_' + DateTime.now().getTime() + '@example.com';
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser@example.com',
            Username = uniqueUsername,
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = UserInfo.getProfileId(),
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;

        // Set up the test data
        Id customerRecordId = '00Q5j000005ESnYEAW'; // Replace with a valid record ID
        String agentNumber = '1234567890';
        String customerNumber = '0987654321';

        // Insert a test custom metadata record
        Greeter_Phone_Field_Mapping__mdt testMapping = new Greeter_Phone_Field_Mapping__mdt(
            Object_Name__c = 'Account',
            Phone_field_Name__c = 'Phone'
        );
        // Insert the test record in a custom metadata type object for testing
        ManagedCodeDev__Greeter_Phone_Field_Mapping__mdt testRecord = new ManagedCodeDev__Greeter_Phone_Field_Mapping__mdt(
            DeveloperName = 'TestRecord',
            MasterLabel = 'TestRecord',
            ManagedCodeDev__Object_Name__c = 'Account',
            ManagedCodeDev__Phone_field_Name__c = 'Phone'
        );
        //insert testRecord;

        // Insert a test phone number for the Account
        Account testAccount = new Account(Name = 'Test Account', Phone = '1234567890');
        insert testAccount;

        // Set the test user as the current user
        System.runAs(testUser) {
            // Start the test
            Test.startTest();

            // Call the initiateCall method
            String result = CTIController.initiateCall(customerRecordId);

            // Stop the test
            Test.stopTest();

            // Assert the result
            System.assertEquals('Success:', result.substring(0, 8));
        }
    }
}
