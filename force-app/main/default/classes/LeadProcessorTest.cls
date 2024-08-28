@isTest
public with sharing class LeadProcessorTest {
    @isTest
    private static void testBatchClass() {

        //Load Test Data::
        List<Lead> leads = new List<Lead>();
        for (integer i=0;i<200;i++) {
                leads.add(new Lead(LastName='Pragnesh',Company='GOC'));

        }
        insert leads;

        //Perform test::
        Test.startTest();
        LeadProcessor LP = new LeadProcessor();
        Id batchId = Database.executeBatch(LP,200);
        Test.stopTest();

        //Check Results::
        List<Lead> updateleads = [SELECT Id FROM lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updateleads.size());


    }
}