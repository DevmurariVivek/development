// Problem Statement -- We need to update Title on all the child contact reocrds linked to a given account record 
public with sharing class SOQL_DML{

    public static void parentTOChildDML(){

        List<Account> acclist = new List<Account>();
        Id recordId = '0015j00001c2ufJAAQ';
        acclist = [SELECT Id,Name, (SELECT Id,Name,Title FROM Contacts) FROM Account WHERE Id=: recordId];
        System.debug('acclist---' +acclist);

        List<Contact> conlist = new List<Contact>();

        If(acclist.size()>0){
            for(Account acc : acclist){
                System.debug('contacts---' +acc.Contacts.size());

                if(acc.Contacts.size()!= 0){
                    for (Contact con : acc.Contacts){
                        con.title = 'Poplulated from apex';
                        conlist.add(con);
                    }
                }else{
                    System.debug('no data found');
                }
            }
        System.debug('conlist---' +conlist);
        update conlist;
        }
    }

    public static void childToParentDML(){

        List<Contact> conlist = new List<Contact>();
        // List<Account> acclist = new List<Account>();
        Account acc = new Account ();
        Id recordId = '0035j00001QNlo0AAD';
        conlist = [SELECT Id,Name,Account.Id,Account.Name,Account.LastModifiedDate FROM Contact WHERE Id=: recordId];
        // acclist = [SELECT Id,Name FROM Account WHERE Id =:conlist[0].Account.Id];
        acc = [SELECT Id,Name FROM Account WHERE Id =:conlist[0].Account.Id];
        System.debug('acc before update' + acc);
        acc.Name = 'Updated Account- AB Tech';
        System.debug('acc after update' + acc);
        update acc;
    }

    public static void DynamicSOQLwithoutBinding(){

        // Dynamic SOQL without binding 
        String recordId = '0015j00001c2ufJAAQ';
        String objectName = 'Account';
        String dynamicSOQL = 'SELECT Id,Name FROM ' + objectName + ' WHERE Id =: recordId';
        List<Account> acc = Database.query(dynamicSOQL);
        System.debug(acc);
        
    }

    public void DynamicSOQLwithBinding(Id recordId, String objectName){

        // Dynamic SOQL with binding 
        Map<String , Object> queryBinds = new Map<String , Object>();
        queryBinds.put('recordId' , recordId);
        queryBinds.put('objectName' , objectName);

        String query = 'SELECT Id,Name ' +
        			   + ' FROM ' +objectName + 
        			   + ' WHERE Id = :recordId';
                    
        System.debug('query---' +query);

        List<Account> acc = Database.queryWithbinds(query, queryBinds, AccessLevel.USER_MODE);
        System.debug('acc---' +acc);

    }

    public void DynamicSOQLwithBinding2(){

        Map<String , Object> queryBinds = new Map<String , Object>();
        queryBinds.put('Name' , 'AB Tech');

        String query = 'SELECT Id,Name ' +
        			   + ' FROM Account '+ 
        			   + ' WHERE Name = :Name'; 
                    
        System.debug('query---' +query);

        List<Account> acc = Database.queryWithbinds(query, queryBinds, AccessLevel.USER_MODE);
        System.debug('acc---' +acc);

}
}
/// Try defining the record id variable as global meaans try to use the same defined variable in both childToParentDML and parentTOChildDML methods --- Generally custom setting or custome metadata are queried to fulfill this purpose where we will query one desired value just after defining the class and not in any particular method, and than we can utilize those in any of the methods that we define in future in given class