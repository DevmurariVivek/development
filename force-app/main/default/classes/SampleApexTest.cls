/*
* @Author - Vivek
* @Date - 5 April 2024
* @Description - This Test Class will be used to validate coe coverge for SampleApex class 

* Modification History 
* ******************** @Author ************************ @Date ************************** @Description *******************************
* ******************** Vivek  ************************* 5/2/24 ************************* Initial Code ********************************
*/


@isTest
public class SampleApexTest {

    // This test class is tailored to cover test cases of SampleApex class's all methods individually 
    @isTest
    public static void getAccountCreateOneOpportunityTest() {

    // Using Normal method when we define the data in this current method only

        // Account acc = new Account();
        // acc.Name = 'test account';
        // insert acc;

        // Opportunity opp = new Opportunity();
        // opp.Name = acc.Name;
        // opp.StageName = 'Draft';
        // opp.CloseDate = system.today();
        // opp.AccountId = acc.Id;
        // insert opp;

        // Test.StartTest();
        // SampleApex.getAccountCreateOneOpportunity();
        // Test.StopTest();

    // Using data from TestDataFactory

        List<Account> acclist = TestDataFactory.SampleApexTestMethod('Test account',1,false,'Account');
        System.debug('acclist---'+acclist);
        List<Opportunity> opplist = TestDataFactory.SampleApexTestMethod('Test opportunity',1,false,'Opportunity');
        System.debug('opplist---' +opplist);
        List<Opportunity> oppInsert = new List<Opportunity>();
        for(integer i=1; i<2; i++){
           // opplist[i].AccountId = acclist[0].Id;
            opplist[i].Name = 'Test opp -' +i;
            opplist[i].StageName = 'Draft' ;
            opplist[i].CloseDate = system.today();
            oppInsert.add(opplist[i]);
        }
        Insert oppInsert;

        Test.StartTest();
        SampleApex.getAccountCreateOneOpportunity();
        Test.StopTest();
    }
    @isTest
    public static void getAccountCreateFiveOpportunityTest() {

            //     System.debug('inside getAccountCreateFiveOpportunityTest method' );
            //     Boolean ExceptionCaught = false;


            //     Account acc = new Account();
            //     acc.Name = 'test account';
            //     insert acc;

            //     Contact con = new Contact();
            //     con.LastName = 'lastname test'; 
            //     con.AccountId = acc.Id;
            //     insert con;

            //     Opportunity opp = new Opportunity(); // Creating Opportunity record for try block
            //     opp.Name = acc.Name;
            //     opp.StageName = 'Draft';
            //     opp.CloseDate = system.today();
            //     opp.AccountId = acc.Id;
            //     insert opp;

            //     Opportunity opp1 = new Opportunity(); // Creating Opportunity record that will produce the error in catch block
            //     opp1.Name = acc.Name;
            //     opp1.StageName = 'Draft';
            //     opp1.CloseDate = system.today();
            //     opp1.AccountId = acc.Id;
            //     insert opp1;

            //     Test.StartTest();
            //     SampleApex.getAccountCreateFiveOpportunity();
            //     Test.StopTest();

        // Using data from TestDataFactory

        // List<Account> acclist = TestDataFactory.SampleApexTestMethod('Test account',1,false,'Account');
        List<Opportunity> opplist = TestDataFactory.SampleApexTestMethod('Test opportunity',5,true,'Opportunity');
        system.debug(opplist);

        Test.StartTest();
        SampleApex.getAccountCreateFiveOpportunity();
        Test.StopTest();
    }

    // @isTest
    // public static void getOpportunityUpdateDescriptionTest(){

    //     System.debug('inside getOpportunityUpdateDescriptionTest method' );

    //     List<Opportunity> oppToInsert = new List<Opportunity>();
    //     List<Opportunity> oppToUpdate = new List<Opportunity>();

    //     Opportunity opp = new Opportunity();
    //     opp.Name = 'test Opportunity 1';
    //     opp.StageName = 'Visited';
    //     opp.Description = 'Opportunity at Visited stage';
    //     opp.CloseDate = system.today();
    //     System.debug('opp---' +opp);
    //     oppToInsert.add(opp);
    //     System.debug('oppToInsert---' +oppToInsert);

    //     Opportunity opp1 = new Opportunity();
    //     opp1.Name = 'test Opportunity 2';
    //     opp1.StageName = 'Closed Won';
    //     opp.Description = 'Opportunity at Closed Won stage';
    //     opp1.CloseDate = system.today();
    //     System.debug('opp1---' +opp1);
    //     oppToInsert.add(opp1);
    //     System.debug('oppToInsert---' +oppToInsert);

    //     insert oppToInsert;

    //     if(oppToInsert.size()>0){
    //         for(Opportunity currentItem : oppToInsert){

    //             if(currentItem.StageName == 'Visited'){
    //                 currentItem.Description = 'Opportunity at Visited stage';
    //                 System.debug('opp at visited---' +currentItem);
    //                 oppToUpdate.add(currentItem);
    //             }else if (currentItem.StageName == 'Closed Won'){
    //                 currentItem.Description = 'Opportunity at Closed Won Stage';
    //                 System.debug('opp at won---' +currentItem);
    //                 oppToUpdate.add(currentItem);
    //             }
    //         }
    //         System.debug('oppToUpdate---' +oppToUpdate);
    //         update oppToUpdate;
    //     }
        
    //     Test.StartTest();
    //     SampleApex.getOpportunityUpdateDescription();
    //     Test.StopTest();
    // }

    // @istest 
    // public static void getContactUpdateContactTest(){

    //     List<Contact> conToInsert = new List<Contact>();
    //     List<Contact> conToUpdate = new List<Contact>();

    //     Account acc = new Account();
    //     acc.Name = 'test Account';
    //     acc.Phone = '00000000000';
    //     Insert acc;

    //     Contact con = new Contact();
    //     con.LastName = 'test con Lastname';
    //     con.AccountId = acc.Id;
    //     conToInsert.add(con);

    //     Contact con1 = new Contact();
    //     con1.LastName = 'test con1 lastname';
    //     con1.AccountId = acc.Id;
    //     conToInsert.add(con1);

    //     Contact con2 = new Contact();
    //     con2.LastName = 'test con2 lastname';
    //     con2.Phone = '00000000000';
    //     con2.AccountId = acc.Id;
    //     conToInsert.add(con2);

    //     insert conToInsert;

    //     if(conToInsert.size()>0){
    //         for(Contact currentItem : conToInsert){
    //             if(currentItem.Phone == null && currentItem.Account.Phone != null){
    //                 currentItem.Phone = currentItem.Account.Phone;
    //                 conToUpdate.add(currentItem);
    //                 System.debug('currentItem---' +currentItem);
    //             } else if (currentItem.Phone != null ){
    //                 System.debug('Inside else part of loop, contact has phone no.');
    //             }
    //         }
    //         System.debug(conToUpdate);
    //         update conToUpdate;

    //         Test.StartTest();
    //         SampleApex.getContactUpdateContact();
    //         Test.StopTest();
    //     }        
    // }

    // @isTest 
    // public static void parentToChildPrints(){

    //     List<Account> acclist = new List<Account>();
    //     List<Contact> conToInsert = new List<Contact>();
    //     List<Contact> conToDisplay = new List<Contact>();
    //     Map<String , List<Contact>> AccConMap = new Map<String , List<Contact>>();

    //     integer i = 0;

    //     Account acc = new Account();
    //     acc.Name = 'New Test Account';
    //     acclist.add(acc);
    //     insert acclist;

    //     Contact con = new Contact();
    //     con.LastName = 'test contact 1';
    //     con.FirstName = 'fname';
    //     con.AccountId = acc.Id;
    //     conToInsert.add(con);

    //     Contact con1 = new Contact();
    //     con1.LastName = 'test contact 2';
    //     con1.FirstName = 'fname';
    //     con1.AccountId = acc.Id;
    //     conToInsert.add(con1);

    //     insert conToInsert;

    //     for (Account currentItemAcc : acclist){
    //         if(currentItemAcc.Contacts.size()>0){
    //             for(Contact currentItemCon : currentItemAcc.Contacts){
    //                 conToDisplay.add(currentItemCon);
    //                 AccConMap.put(currentItemAcc.Id ,conToDisplay);
    //             }
    //         }
    //     }
    //     System.debug(AccConMap);

    //     Test.StartTest();
    //     SampleApex.parentToChildPrints();
    //     Test.StopTest();
        
    // }

    // @isTest 
    // public static String CommunicationWithinClassMethod1Test(){
        
    //     String AccountID;
    //     Account acc = new Account();
    //     acc.Name = 'AB test';
    //     Insert acc; 
    //     AccountID = acc.Id;

    //     Test.StartTest();
    //     SampleApex.CommunicationWithinClassMethod1();
    //     Test.StopTest();

        
    //     return AccountID;
    // }
}