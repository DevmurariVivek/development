public class Controller1 {
	@AuraEnabled
    public static List<Account> fetchAccts() {
        //Query and return list of Contacts
        List<Account> accList = [SELECT Id,Name,AnnualRevenue,Phone FROM Account];
        return accList;
    }
}