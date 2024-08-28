@isTest
public  class BatchClassDemoTest {
    
    @isTest public static void batchMethod1(){
        List<Account> accList = new List<Account>();
        for (Integer i=0;i<5;i++) {
            Account acc = new Account();
            acc.Name ='Account' + i;
            acc.BillingStreet = 'New Street';
            acc.BillingCity = 'Ahmedabad';
            acc.BillingState = 'Utah';
            acc.BillingPostalCode ='3800009';
            acc.BillingCountry ='United States';
            accList.add(acc);
        }
        insert accList;

        List<Contact> conList = new List<Contact>();
        for(Integer j=0;j<accList.size();j++){
            Account accts = accList[j];
            for (Integer k=0;k<5;k++) {
                Contact con = new Contact();
                con.LastName = accList[j].Name + 'Contact';
                con.AccountId = accList[j].Id;
                con.MailingCity = accList[j].BillingCity; 
                con.MailingPostalCode = accList[j].BillingPostalCode;
                con.MailingState = accList[j].BillingState;
                con.MailingStreet = accList[j].BillingStreet;
                con.MailingCountry = accList[j].BillingCountry;
                conList.add(con);
                
            }

        }
        insert conList;
        System.assertEquals(conList[0].MailingCountry,accList[0].BillingCountry);
        
         Test.startTest();

            BatchClassDemo2 batch = new BatchClassDemo2();
            DataBase.executeBatch(batch); 
            
        Test.stopTest();
        

    }
}