public without sharing class databaseOperationsClass {

    public List<Account> InsertData (){
        List<Account> acc = new List<Account>();
        acc.add(new Account(name = 'inaki williams'));
        acc.add(new Account(name = 'vinicious jr.'));
        acc.add(new Account());
        System.debug('acc---' + acc);

        Database.SaveResult[] srlist = Database.insert(acc, false);

        for ( Database.SaveResult sr : srlist){
            if (sr.isSuccess ()) {
                System.debug('Records Inserted Successfully, Account Inserted : ' + sr.getId());
            }
            else {
                for (Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occured');
                    System.debug(err.getStatusCode() + ' : ' + err.getMessage());
                    System.debug('Record fields that affected this error : ' + err.getFields());
                }               
            }
        }
        return acc;
    } 
}
// The Database methods are having functions that holds the results : 
// 1. For Insert and Update operations = Database.SaveResult[]
// 2. For Upsert operation = Database.UpsertResult[]
// 3. for Delete operation = Database.DeleteResult[]
// 4. for Undelete operation = Database.UneleteResult[]
// Intially allORNone paramter is set to true - means that if we do not define false as its value, we will not be able to perfomr partial insertion / operaton on records 
// The basic DMl statement will be using try catch blocks to handle & monitor the errors that might be received while processing the DML operations
// Where if we use database methods to perform the DML operations, errors can be handles by ussing Database.Error method