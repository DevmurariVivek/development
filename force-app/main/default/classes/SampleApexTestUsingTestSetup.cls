/*
* @Author - Vivek
* @Date - 7 April 2024
* @Description - This Test Class will be used to validate code coverge for SampleApex class using tesSetup method

* Modification History 
* ******************** @Author ************************ @Date ************************** @Description *******************************
* ******************** Vivek  ************************* 5/2/24 ************************* Initial Code ********************************
*/

@isTest
public class SampleApexTestUsingTestSetup {

    @TestSetup
    static void setupdata(){

        List<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        List<Opportunity> opplist = new List<Opportunity>();

        Account acc = new Account ();
        acc.Name = 'Test Account';
        acc.Phone = '0000000000';
        acclist.add(acc);

        Account acc1 = new Account();
        acc1.Name ='AB Account';
        acc1.Phone = '000000000001';
        acclist.add(acc1);

        insert acclist;

        for(Integer i =0; i<2; i++){

            // Insert Contact
            Contact Con = new Contact();
            con.LastName = 'Lastname' +i;
            con.AccountId = acc.Id;
            con.FirstName = 'FirstName' +i;
            if(i==0){
                con.Phone = '0000000000';
            }else{
                con.Phone = null;
            }
            conlist.add(con);


            // Insert Opportunity
            Opportunity opp = new Opportunity();
            opp.Name = 'Opportunity' +i;
            opp.CloseDate = system.today();
            opp.AccountId = acc.id;
            if(i==0){
                opp.StageName = 'Visited';
            }
            else {
                opp.StageName = 'Closed Won';
            }
            opplist.add(opp);
        }
        insert conlist;
        insert opplist;         
    }

    @isTest
    public static void getAccountCreateOneOpportunityTestSetup(){

        Account acc = [SELECT Id,Name, (SELECT Id,Name,StageName,CloseDate FROM Opportunities) FROM Account WHERE Name = 'Test Account'];
        
        System.debug(acc);
        // Test.StartTest();
        // SampleApex.getAccountCreateOneOpportunity();
        // Test.StopTest();
    }

    @isTest 
    public static void getAccountCreateFiveOpportunityTestSetup(){

        Account acc = [SELECT Id,Name, (SELECT Id,Name,StageName,CloseDate FROM Opportunities) FROM Account WHERE Name = 'Test Account'];
        
        System.debug(acc);
        // Test.StartTest();
        // SampleApex.getAccountCreateFiveOpportunity();
        // Test.StopTest();

    }

    @isTest
    public static void getOpportunityUpdateDescriptionTestSetup(){

        List<Opportunity> opplist = [SELECT Id,Name FROM Opportunity]; /// here i am using the data defined on the testsetup method directly, this way if we have defined data in test setup method it can be directly utilized for testing
        System.debug(opplist);

        // Test.StartTest();
        // SampleApex.getOpportunityUpdateDescription();
        // Test.StopTest();
    }

    @isTest
    public static void getContactUpdateContactTestSetup(){

        List<Contact> conlist = [SELECT Id,Phone,LastName,FirstName,Account.Phone, Account.Id FROM Contact];

        // Test.StartTest();
        // SampleApex.getContactUpdateContact();
        // Test.StopTest();

    }

    @isTest
    public static void parentToChildPrintsTestSetup(){
        List<Account> acclist = [SELECT Id,Name, (SELECT Id,LastName,FirstName,Account.Id FROM Contacts) FROM Account WHERE CreatedDate=THIS_YEAR];

        // Test.StartTest();
        // SampleApex.parentToChildPrints();
        // Test.StopTest();
    }
    
    @isTest
    public static void CommunicationWithinClassMethod1TestMethod(){
        List<Account> acclist = [SELECT Id,Name FROM Account WHERE Name LIKE 'AB%'];

        // Test.StartTest();
        // SampleApex.CommunicationWithinClassMethod1();
        // Test.StopTest();

    }
}