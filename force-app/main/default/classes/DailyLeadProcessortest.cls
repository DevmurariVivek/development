@isTest
public class DailyLeadProcessortest{

    @isTest
    private static void TestigLeadUpdates(){

        //Load data 
        List<Lead> leads = new List<Lead>();
        for (Integer i=0;i<500;i++) {
            if (i<250) {
                leads.add(new Lead(LastName='Vivek' , Company='GOC'));
            }else {
                leads.add(new Lead(LastName='Vivek' , Company='GOC' , LeadSource='Other'));
            }
            
        }
        insert leads;
        String sch = '0 0 23 * * ?';
        //Perform Test
        Test.startTest();
        String jobId = System.schedule('lead process' , sch , new DailyLeadProcessor());
        Test.stopTest();

        //Check Result
        List<Lead> updatelist = [SELECT Id, LeadSource FROM Lead WHERE LeadSource='Dreamforce'];
        System.assertEquals(200 , updatelist.size());

        //Chech Scheduled Time
        List<CronTrigger> cts = [SELECT id, TimesTriggered , NextFireTime FROM CronTrigger WHERE Id=:jobId];    
        System.debug('Next Fire Time' + cts[0].NextFireTime);
    }
}