@isTest
public with sharing class DailyOpportunityProcessorTest {
    
    @isTest
    private static void TestscheduledApex() {
        List<Opportunity> oppList = new List<Opportunity>();

        // taking cron expression
        String Sch = '0 0 0 ? * * * ';

        //Insert test data

        for (Integer i=0;i<500;i++) {
            if (i<250) {
                oppList.add(new Opportunity(Name = 'Test ' + i , StageName='Prospecting' ,CloseDate=System.today()));   
                
            }else {
                oppList.add(new Opportunity (Name = 'Test ' + i , StageName='Prospecting' ,CloseDate=System.today() , LeadSource='Other'));

            }
        }
        insert oppList;

            //Start Test

            Test.startTest();
            String jobId = System.schedule('process 1',Sch, new DailyOpportunityProcessor());
            Test.stopTest();

           //Test data

           List<Opportunity> updatedoppList = [SELECT Id , LeadSource FROM Opportunity WHERE LeadSource='Web'];
           system.assertEquals(200, updatedoppList.size());

    }

}