@isTest
private with sharing class AddPrimaryContactTest {
    @isTest
    private static void testQueueableClass() {

        //Load Test Data
        List<Account> accounts = new List<Account>();
        for (Integer i=0;i<500;i++) {
            Account testAccount = new Account(Name='Test Account');
            if (i<250) {
                testAccount.BillingState = 'NY';
              
            }else {
                testAccount.BillingState = 'CA';
            }
            accounts.add(testAccount);
            
        }
        insert accounts;

        Contact contacts = new Contact(FirstName='VIVEK' , LastName='DEVMURARI');
        insert contacts;


        //Execute the test
        Test.startTest();
        Id jobId = System.enqueueJob(new AddPrimaryContact(contacts , 'CA'));
        Test.stopTest();

        //Test The Result
        List<Contact> contactsnew = [SELECT Id FROM Contact WHERE Contact.Account.BillingState = 'CA'];
        System.assertEquals(200, contactsnew.size() ,  'ERROR : No contacts found');

    }
}