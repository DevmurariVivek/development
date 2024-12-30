public with sharing class CustomContactTriggerHandler {
    public static void onBeforeInsert(List<Contact> newContacts) {

        System.debug('In onBeforeInsert');

        for (Contact con : newContacts){
            if(con.AccountId == null){
                con.addError('The Contact was saved without populating parent account !!');
            }
        }
    }
    public static void onAfterInsert(List<Contact> newContacts) {

        System.debug('In onAfterInsert');   
    }
    public static void onBeforeUpdate(List<Contact> newContacts, List<Contact> oldContacts, Map<Id,Contact> newContactMap, Map<Id,Contact> oldContactMap) {

        System.debug('In onBeforeUpdate');
        sendEmailOnBalanceChange(newContacts, oldContacts);
    }
    public static void onAfterUpdate(List<Contact> newContacts, List<Contact> oldContacts, Map<Id,Contact> newContactMap, Map<Id,Contact> oldContactMap)  {

        System.debug('In onAfterUpdate');
    }

    public static void sendEmailOnBalanceChange(List<Contact> newContacts, List<Contact> oldContacts){
        System.debug('In sendEmailOnBalanceChange');

        // static Boolean flag = false;
        List<Contact> conList = new List<Contact>();
        for (Contact con : newContacts){


            con.FirstName = 'Name';
            conList.add(con);
        }
        System.debug('The conList ---> ' + conList);

        if(conList != null){
            for(integer i= 0; i<= conList.size(); i++){
                if(conList[i].Email != null){

                    System.debug(' The email of current contact ---> ' + conList[i].Email);
                    
                    // EmailMessage email = new EmailMessage();
                    // email.ToAddress = conList[i].Email;
                    // email.FromAddress = ;
                    // email.FromName = ;
                    // email.Subject = ;
                    // email.TextBody = ;
                    // email.ToAddress = ;
                    // email.MessageDate = ;
                }
            }
        }
        // for sending email there are 2 approahces, 1 with direct looping through the 
        // System.debug('flag ---> ' + flag);

        // for()
        // if(flag == true){

        // }
    }
}