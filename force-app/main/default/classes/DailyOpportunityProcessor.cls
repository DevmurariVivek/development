public with sharing class DailyOpportunityProcessor implements Schedulable {

    public void execute(SchedulableContext cx ){
        List<Opportunity> oppList = [SELECT Id , LeadSource FROM Opportunity WHERE LeadSource = null LIMIT 200 ];

        for (Opportunity oppLoop : oppList) {
            oppLoop.LeadSource='Web';
            
        }
        update oppList;

    }
}