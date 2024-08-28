public with sharing class Product_Search_Controller {
    @AuraEnabled

    public static List<Opportunity> Opportunity_records(String Product_Record_ID) {
        System.debug(Product_Record_ID);
        List<Opportunity> opp_list =[

            SELECT Id, Name, Account.Name, Contact_1__c, Contact_2__c, Contact_3__c, CloseDate FROM Opportunity WHERE Id IN (SELECT OpportunityId 
                                                                             FROM OpportunityLineItem 
                                                                             WHERE Product2Id =:Product_Record_ID)];
                System.debug('opp_list' + opp_list);
        return opp_list;
        
    
}

}