public with sharing class SampleApex {

    public static void getAccountCreateOneOpportunity() {
        List<Account> acclist = new List<Account>();
        acclist = [SELECT Id,Name FROM Account WHERE CreatedDate=THIS_YEAR];
        System.debug('acclist---' +acclist);

        List<Opportunity> opplist = new List<Opportunity>();
        for (Account acc : acclist) {
            Opportunity opp = new Opportunity();
            opp.AccountId = acc.Id;
            opp.Name = acc.Name;
            opp.StageName = 'Visited';
            opp.CloseDate = System.today();
            opplist.add(opp);
        }
        System.debug('opplist count---' +opplist.size());
        insert opplist;
    }

    public static void getAccountCreateFiveOpportunity() {
        List<Account> acclist = new List<Account>();
        acclist = [SELECT Id,Name FROM Account WHERE CreatedDate=THIS_YEAR];
        System.debug('acclist---' +acclist);

        List<Opportunity> opplist = new  List<Opportunity>();

        try {
            System.debug('inside try block');
            if (!acclist.IsEmpty()) {
                for (Account acc : acclist){
                    System.debug('acc---' +acc);
                    for(integer i=1; i<=5; i++){
        
                        Opportunity opp = new Opportunity ();
                        opp.AccountId = acc.Id;
                        opp.Name = acc.Name + ' ' +i;
                        opp.StageName = 'Visited';
                        opp.CloseDate = system.today();
                        opplist.add(opp);
                        System.debug('opp---' + opp);
                    }           
                }                  
            System.debug('opplist---' +opplist);
            insert opplist;
            }
            
        } catch (Exception e) {
            System.debug('Exception---' +e.getMessage());
        }
    }

    public static void getOpportunityUpdateDescription(){

        List<Opportunity> opplist = [SELECT Id,Name,StageName FROM Opportunity WHERE CreatedDate=THIS_YEAR];
        List<Opportunity> oppToUpdate = new List<Opportunity>();

        try {
            System.debug('inside try block');
            if(opplist.size()>0){
                for(Opportunity opp : opplist){
                    if(opp.StageName == 'Visited'){
                        opp.Description = 'Opportunity at Visited stage';
                        System.debug('opp at visited---' +opp);
                        oppToUpdate.add(opp);
                    }else if (opp.StageName == 'Closed Won'){
                        opp.Description = 'Opportunity at Closed Won Stage';
                        System.debug('opp at won---' +opp);
                        oppToUpdate.add(opp);
                    }
                }
                System.debug('oppToUpdate---' +oppToUpdate);
                update opplist;
            }
            
        } catch (Exception e) {
            System.debug('Exception---' +e.getMessage());
            
        }
        
    }

    public static void getContactUpdateContact(){

        List<Contact> conlist = [SELECT Id,Phone,LastName,FirstName,Account.Phone, Account.Id FROM Contact WHERE CreatedDate=THIS_YEAR];
        List<Contact> conToUpdate = new List<Contact>();

        try {
            System.debug('inside try block');
            if(conlist.size()>0){
                for(Contact con : conlist){
                    if(con.Phone == null && con.Account.Phone != null){
                        con.Phone = con.Account.Phone;
                        System.debug('updated con' +con);
                        conToUpdate.add(con);
                    }else if (con.Phone != null){
                        System.debug('This record does not needs to be updated ---' +con);
                    }
                }
                System.debug('conToUpdate---' +conToUpdate);
                update conlist;
            }
            
        } catch (Exception e) {
            System.debug('Exception---' +e.getMessage());
            
        }
    }

    public static void parentToChildPrints(){

        List<Account> acclist = [SELECT Id,Name, (SELECT Id,LastName,FirstName,Account.Id FROM Contacts) FROM Account WHERE CreatedDate=THIS_YEAR];
        List<Contact> contoDisplay = new List<Contact> ();
        Map<String , List<Contact>> AccConMap = new Map<String , List<Contact>>();
        Integer i=0;


        for (Account acc : acclist){
            if(acc.Contacts.size()>0){
                i +=1;
                for (Contact con : acc.Contacts){
                    contoDisplay.add(con);
                    AccConMap.put(acc.Id , contoDisplay);
                }
            }
        }

        System.debug('AccConMap---' +AccConMap);
        System.debug('Total Contact processed---' +i);

        Set<String> firstAccountId = AccConMap.keySet();
        System.debug(firstAccountId);

    }

    public static string CommunicationWithinClassMethod1(){

        String AccountID;
        List<Account> acclist = [SELECT Id,Name FROM Account WHERE Name LIKE 'AB%'];

        AccountID = acclist[0].Id;
        System.debug(AccountID);
        CommunicationWithinClassMethod2(AccountID);

        return AccountID;
    }

    public static void CommunicationWithinClassMethod2(String AccountID){
        String recordID = AccountID;
        System.debug('recordID---' +recordID);

        List<Account> acclist = new List<Account>();
        acclist = [SELECT Id,Name, (SELECT Id,Name FROM Opportunities) FROM Account WHERE Id =:recordID ];
        System.debug('acclist---' +acclist);
    } 
}