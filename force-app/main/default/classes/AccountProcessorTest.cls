@isTest
public with sharing class AccountProcessorTest {
    @isTest
     private static void countContactsTest() {
     List<Account> AccountsToTest = new List<Account>();

     for(Integer i=0;i<10;i++){
        AccountsToTest.add(new Account (Name = 'Test ' + i));   

     }
     insert AccountsToTest;

     List<Contact> ContactsToTest = new List<Contact>();
     List<Id> accountIds = new List<Id>();

     for (Account LoopOfAccount :AccountsToTest) {
        ContactsToTest.add(new Contact (FirstName='Test', LastName=LoopOfAccount.Name,  AccountId=LoopOfAccount.Id));
         accountIds.add(LoopOfAccount.Id);
     }
     insert ContactsToTest;

     Test.startTest();
     AccountProcessor.countContacts(accountIds);
     Test.stopTest();

     List<Account> checkResult = new List<Account>();
      for (Account ACCCS : checkResult) {
      System.assertEquals(1,ACCCS.Number_Of_Contacts__c);
   }

    }
}