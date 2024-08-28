@isTest
public class duplicatesFinderTest {

    @isTest
    static void testNoDuplicatesFound() {
        // Create a test record
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Call the method
        Map<String, List<SObject>> result = duplicatesFinder.checkForDuplicates(testAccount.Id, 'Account');

        // Assert that no duplicates are found
        System.assertEquals(1, result.get('currentrecord').size());
        System.assertEquals(0, result.get('matchedrecords').size());
    }

    @isTest
    static void testDuplicatesFound() {
        // Create test records
        Account originalAccount = new Account(Name = 'Test Account');
        insert originalAccount;

        Account duplicateAccount = new Account(Name = 'Test Account');
        insert duplicateAccount;

        // Call the method
        Map<String, List<SObject>> result = duplicatesFinder.checkForDuplicates(originalAccount.Id, 'Account');

        // Assert that duplicates are found
        System.assertEquals(1, result.get('currentrecord').size());
        System.assertEquals(1, result.get('matchedrecords').size());
    }

    @isTest
    static void testNoNameField() {
        // Create a test record without a name
        Account testAccount = new Account();
        insert testAccount;

        // Call the method
        Map<String, List<SObject>> result = duplicatesFinder.checkForDuplicates(testAccount.Id, 'Account');

        // Assert that no duplicates are found since the record has no name
        System.assertEquals(1, result.get('currentrecord').size());
        System.assertEquals(0, result.get('matchedrecords').size());
    }
}