public without sharing class LeadProcessor implements Database.Batchable<sObject>, Database.stateful{

    //Start method is the initial method by which processing of batch class begins
    //Database.QueryLocator return type will store the data on which we will execute our class
    //Database.stateful willl help in counting the records/changes

    public Integer recordcount=0;
    public Database.QueryLocator start (Database.BatchableContext dbc)  {
        return Database.getQueryLocator([SELECT Id , Name FROM Lead]);

    }

    //execute() method takes two parameters 1- Database.BatchableContext and 2- list of records to be impliment
    //This methos is called for each chunk/batch of records

    public void execute(Database.BatchableContext dbc , List<Lead> leads){
        for (Lead l : leads) {
            l.LeadSource='Dreamforce';
            
        }
        update leads;
        recordcount=recordcount+leads.size();
    }   

    //finish() is the last method that will execute at the end , in ghis method we define tasks to be completed after successful complition of batch,
    //like sending mail, other task 

    public void finish(Database.BatchableContext dbc){
        system.debug('Total records proceeded' + recordcount);
    }  
}