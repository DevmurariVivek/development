public class BatchClassDemo implements Database.Batchable<sObject>, Database.Stateful {

    //defined integer to track processed data using Database.Stateful
    public Integer recordsProcessed = 0;
    // Define the query records to be processed in execute methodf
    public Database.QueryLocator start(Database.BatchableContext bc){
        // return data from database - queried Account and Contacts records where Account's Billing 
         return Database.getQueryLocator([SELECT Id,Name,BillingStreet, BillingCity,
                                         BillingState,BillingPostalCode,BillingCountry, 
                                         (SELECT Id,Name,MailingStreet, MailingCity, MailingState,MailingPostalCode,MailingCountry FROM Contacts) 
                                         FROM Account WHERE BillingCountry = 'USA']);
        // Below is a SOQL query of String type
        // return Database.getQueryLocator(
        //     'SELECT ID, BillingStreet, BillingCity, BillingState, ' +
        //     'BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, ' +
        //     'MailingState, MailingPostalCode FROM Contacts) FROM Account ' +
        //     'Where BillingCountry = \'USA\''
        // );
        
    }
    // process each batch of records
    public void execute(Database.BatchableContext bc, List<Account> scope){
        List<Contact> contacts = new List<Contact>();

        for (Account account : scope) {
            for (Contact contact : account.contacts) {
                
                //transfering values from accounts billing addresses to contact's mailling addresses
                contact.MailingCity       = account.BillingCity;
                contact.MailingPostalCode = account.BillingPostalCode;
                contact.MailingState      = account.BillingState;
                contact.MailingStreet     = account.BillingStreet;
                contact.MailingCountry    = account.BillingCountry;

                // add contact to list to be updated
                contacts.add(contact);

                //increasing processed records
                recordsProcessed = recordsProcessed + 1;
            }          
        }
        update contacts;
       
    }
    // execute any post-processing operations
    public void finish(Database.BatchableContext bc){
        System.debug('recordsProcessed:' + recordsProcessed);

        //Query on created batch job to detch its details at finish method
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,JobItemsProcessed,TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = :bc.getJobId()];

        system.debug('batch job details :'+job);

        
    }
    // Created a new apex class - "BatchClassDemoSchedule" to schedule the batch class to run

}



// public class UpdateContactAddresses implements
//     Database.Batchable<sObject>, Database.Stateful {
//     // instance member to retain state across transactions
//     public Integer recordsProcessed = 0;
//     public Database.QueryLocator start(Database.BatchableContext bc) {
//         return Database.getQueryLocator(
//             'SELECT ID, BillingStreet, BillingCity, BillingState, ' +
//             'BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, ' +
//             'MailingState, MailingPostalCode FROM Contacts) FROM Account ' +
//             'Where BillingCountry = \'USA\''
//         );
//     }
//     public void execute(Database.BatchableContext bc, List<Account> scope){
//         // process each batch of records
//         List<Contact> contacts = new List<Contact>();
//         for (Account account : scope) {
//             for (Contact contact : account.contacts) {
//                 contact.MailingStreet = account.BillingStreet;
//                 contact.MailingCity = account.BillingCity;
//                 contact.MailingState = account.BillingState;
//                 contact.MailingPostalCode = account.BillingPostalCode;
//                 // add contact to list to be updated
//                 contacts.add(contact);
//                 // increment the instance member counter
//                 recordsProcessed = recordsProcessed + 1;
//             }
//         }
//         update contacts;
//     }
//     public void finish(Database.BatchableContext bc){
//         System.debug(recordsProcessed + ' records processed. Shazam!');
//         AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
//             JobItemsProcessed,
//             TotalJobItems, CreatedBy.Email
//             FROM AsyncApexJob
//             WHERE Id = :bc.getJobId()];
//         // call some utility to send email
//         EmailUtils.sendMessage(job, recordsProcessed);
//     }
// }