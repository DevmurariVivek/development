public with sharing class SOSL_DML {
    public static void method1() {

        // This is related to the solutions that we need for the dialshree sosl query
        // which is, 
        // There will be one phone number that we will get as input so we have to store that in a variable
        // than there will be 
       
        List<List<sObject>> searchlist = [FIND '+91 72659 22448' IN PHONE FIELDS RETURNING Account, Contact, Lead];
        System.debug('searchlist---' +searchlist);



    } 
}