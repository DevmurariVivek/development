@RestResource (urlMapping='/Opportunities/*')
global with sharing class ApexRestOpportunityManagement {

    @HttpGet
    global static Opportunity OpportunityGet(){
        RestRequest request = RestContext.request;

        String oppId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Opportunity result = [SELECT Name,StageName,LeadSource,Closedate,Probability FROM Opportunity WHERE Id =:oppId];
        return result;

    }

    @HttpPost
    global static Id OpportunityPost( String name, String stage, String closedate, String source ){

        Opportunity newOpportunity = new opportunity( Name = name, StageName = stage, Closedate =Date.valueOf(closedate), LeadSource=source);
        insert newOpportunity;
        return newOpportunity.Id;
        


        
    }
}