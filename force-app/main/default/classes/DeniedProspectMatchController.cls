public without sharing class  DeniedProspectMatchController {
    @AuraEnabled
    public static List<Student__c> fetchStudents(Id clgId){
        List <Student__c> conlist = [Select id,Name,Match_Stage__c,College_Name__c,LastModifiedDate from Student__c where 
        Match_Stage__c IN ('Match Denied', 'Match Denied by SP', 'Match Denied by GP', 'Match Lost', 'Cancelled') AND College_Name__c = :clgId order by LastModifiedDate DESC Limit 30];
        System.debug('conlist :' + conlist);
        return conlist;
     }
     @AuraEnabled
     public static string deleterecord(Id prjId){
        System.debug('conlist : 21 '+ prjId );
        List <Student__c> dellist =[Select id from Student__c where id=:prjId];
        System.debug(dellist);
         try{
             Delete dellist;
             return 'DONE';        }
         catch(exception e){
             return e.getMessage();
         }}

}