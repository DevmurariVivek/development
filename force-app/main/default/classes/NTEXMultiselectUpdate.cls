public with sharing class NTEXMultiselectUpdate {
    @InvocableMethod(label='N-TEX_Multiselect' description='Will be used to implement logic of merging the single picklist values into multiselect picklist' category='Lead')
    
    public static void MultiselectUpdate(List<List<Lead>> Lead_Collection) {

            List<Lead> UpdatedLeads = new List<Lead>();
            for (Lead LeadLoop : Lead_Collection[0]) {
               string m =LeadLoop.Multi_Select_Industry_Picklist__c;
               string s =LeadLoop.Single_Industry_Picklist__c;
               string[] part;
               part=m.split('\\;');
               System.debug(LeadLoop.Id +''+ part);


            if (LeadLoop.Multi_Select_Industry_Picklist__c != null && LeadLoop.Multi_Select_Industry_Picklist__c != LeadLoop.Single_Industry_Picklist__c) {
                LeadLoop.Multi_Select_Industry_Picklist__c =LeadLoop.Multi_Select_Industry_Picklist__c +';'+ LeadLoop.Single_Industry_Picklist__c;
                UpdatedLeads.add(LeadLoop);
               // System.debug(UpdatedLeads);

                
            } else{
                LeadLoop.Multi_Select_Industry_Picklist__c = LeadLoop.Single_Industry_Picklist__c;
                UpdatedLeads.add(LeadLoop);
            }
            
        }
        update UpdatedLeads;
    }
}

    
        
    // }