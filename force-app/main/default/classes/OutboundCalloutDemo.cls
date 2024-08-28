@RestResource(urlMapping='/Opportunity/*')
global with sharing class OutboundCalloutDemo {
    
    @HttpGet
    global static Opportunity getOpportunity() {

        //Pass the request and response from the context of data 
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        // Get the Id of requested Opportunity from the last input of the endpoint
        String OpportunityId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

        // Query Id,Name,Phone and website of Opportunity with The Id we get from endpoint
        Opportunity result = [SELECT Id,Name,AccountId, CloseDate FROM Opportunity WHERE Id =: OpportunityId];
        return result;

    }
}