@isTest
public with sharing class UpdateAccountRecordTest {
    @TestSetup
    static void setup(){
        List<Account> accList= new List<Account>();

        accList.add(new Account (Name='Parent'));

        for (integer i=0;i<100;i++) {
            accList.add(new Account(Name='Test Account' +i));

            
        }
        insert accList;

    }
    @isTest
    private static void TestQueueable(){
        Id parentId =[SELECT Id FROM Account WHERE  NAme='Parent'][0].Id;   

        List<Account> accList = [SELECT Id , Name FROM Account WHERE Name Like 'Test Account%' ];

        UpdateAccountRecord updatejob = new UpdateAccountRecord(accList , parentId);
        
        Test.startTest();
        system.enqueueJob(updatejob);
        Test.stopTest();

        System.assertEquals(100, [SELECT COUNT() FROM Account WHERE parentId =: parentId]);

    }

}