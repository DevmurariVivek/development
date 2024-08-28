public with sharing class TestDataFactory {
    // This first method tailored to cover test cases of SampleApex class's all methods in a single method 
    public static List<sObject> SampleApexTestMethod(String Name, Integer Count, Boolean isInsert, String ObjectName) {

        System.debug('Name,Count,isInsert,ObjectName---' + Name + Count + isInsert + ObjectName);

        Map<String, List<sObject>> objectMap = new Map<String, List<sObject>>();
        
        List<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        List<Opportunity> opplist = new List<Opportunity>();

        for(Integer i=1; i<count; i++){

            // Insert Account
            Account acc = new Account ();
            acc.Name = 'Test Account ' +i ;
            acc.Phone = '0000000000';
            acclist.add(acc);

            // Insert Contact
            Contact Con = new Contact();
            con.LastName = 'Lastname' +i;
            con.AccountId = acc.Id;
            con.FirstName = 'FirstName' +i;
            if(i==0){
                con.Phone = '0000000000';
            }else{
                con.Phone = null;
            }
            conlist.add(con);

            // Insert Opportunity
            Opportunity opp = new Opportunity();
            opp.Name = 'Opportunity' +i;
            opp.CloseDate = system.today();
            opp.AccountId = acc.id;
            if(i==0){
                opp.StageName = 'Visited';
            }
            else {
                opp.StageName = 'Closed Won';
            }
            opplist.add(opp);
        }

        if(isInsert == true){
            if(ObjectName == 'Account'){

                system.debug(acclist);
                insert acclist;
                objectMap.put('Account' , acclist);

            }else if (ObjectName == 'Contact'){

                system.debug(conlist);
                insert conlist;
                objectMap.put('Account' , conlist);
                

            }else if (ObjectName == 'Opportunity'){

                system.debug(opplist);
                insert opplist;
                objectMap.put('Account' , opplist); 

            }
        }
        return objectMap.get(ObjectName);
    }
}