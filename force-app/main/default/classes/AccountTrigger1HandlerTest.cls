@isTest
public class AccountTrigger1HandlerTest {
    
    @isTest public static void bothMethod () {
        
        List<Account> accList = new List<Account>();
        for(Integer i=0;i<2;i++){
            Account acc = new Account();
            acc.Name='Test Account'+i;
            acc.Phone='7265922448';
            acc.Industry='Banking';
            acc.Rating='Hot';
            acc.Description='Description';
          	accList.add(acc);
        }
        
        insert accList;
       

        accList[0].Phone='72654922449';
        
       
        update accList[0];
     
        
        Account acc1 = new Account();
        acc1.Name='Test Account';
        acc1.Phone='7265922448';
        acc1.Industry='Education';
        //acc1.Rating='Hot';
        acc1.Description='Description';
        insert acc1;

        Account updatedAcc = [SELECT Id,Description,Rating FROM Account WHERE Id =: accList[0].Id];
        System.assertEquals(accList[0].Rating, updatedAcc.Rating, 'Values does not get updated'); 


        Opportunity opp = new Opportunity();
        opp.Name= accList[0].name +'Opportunity';
        opp.AccountId= accList[0].Id;
        opp.StageName='Prospecting';
        opp.CloseDate= System.today();
        opp.Description='Opportunity Description';
        
        
        insert opp;
       

    }


}