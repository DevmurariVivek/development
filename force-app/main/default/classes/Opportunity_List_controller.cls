public with sharing class Opportunity_List_controller {
    @AuraEnabled

    public static List<Opportunity> Opportunity_records(String contactrecordId) {
        List<Opportunity> ocr_list =[

         SELECT Id, Name, Amount, CloseDate FROM Opportunity WHERE Id IN (SELECT OpportunityId 
                                                          FROM OpportunityContactRole 
                                                          WHERE ContactId =:contactrecordId)];
                
        return ocr_list;
        
   
}
}