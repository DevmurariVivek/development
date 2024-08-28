@IsTest
public class RestResourceExposedTestDataFactory {

    // public static Account createAccount(Boolean doInsert) {
	// 	return createAccount('testAccount', doInsert);
	// }

    public static Account createAccount(String name,Decimal annualRevenue, Boolean doInsert) {
		Account acc = new Account();
        acc.Name = name;
        acc.AnnualRevenue = annualRevenue;
		if(doInsert) {
			insert acc;
		}
		return acc;
	}

    
}