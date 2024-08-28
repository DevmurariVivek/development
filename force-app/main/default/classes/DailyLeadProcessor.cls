public with sharing class DailyLeadProcessor implements Schedulable{

    public void execute(SchedulableContext sc) {
        // take 200 lead records and update lead source to dreamforce

        List<Lead> leads  = [SELECT Id , LeadSource FROM Lead WHERE LeadSource= null LIMIT 200];
        for (Lead l: leads) {
            l.LeadSource='Dreamforce';
        }
        // update lead records
        update leads;
    }
}