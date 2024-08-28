public with sharing class InvocableFlowAction_Email {
    @InvocableMethod (label='Send Email to Contact' description='Send Email to Contact when Case origin is Email' category='Case' )
    public static void sendEmailtoContact(List<Requests> requestList) {

        String contactId =requestList.get(0).contactId;
        String caseNumber = requestList.get(0).caseNumber;


        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[]{contactId};
        message.subject = 'Your case is been submitted in our system: ' + caseNumber;
        message.plainTextBody = 'Your case is been submitted in our system';
        message.setSaveAsActivity(true);
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEMail(messages);
        if(results[0].success){
            System.debug('The EMail is sent Successfully');
        }
        else{
            System.debug('The Email failed to send:' + results[0].errors[0].message);
        }

    }
    public class Requests {
        @InvocableVariable (label='Record Id' description='The Id Of the Record' required=true)
        public String caseId;
        @InvocableVariable (label='Contact Id' description='The Id Of the Contact record' required=true)
        public String contactId;
        @InvocableVariable (label='Case Number' description='The Case Number' required=true)
        public String caseNumber;
    }
    public class FlowOutputs{
        @InvocableVariable public String objectname;
    }
}