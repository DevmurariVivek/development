public with sharing class InvocableFlowAction1 {
    @InvocableMethod (label='Delete Related Opportunities'
                      description='Delete Opportunities from passed record ID'
                      category='Account' )
    public static void deleteOpportunities (List<String> ids) {

        List <Opportunity> Opplist = [SELECT Id,Name FROM Opportunity WHERE AccountId =: ids AND StageName = 'Closed Won'];
        // delete Opplist;

    }
    public class FlowOutput{
        @InvocableVariable public String outputRecordId;
        public FlowOutput(String objName) {this.outputRecordId = objName;}
      }

}