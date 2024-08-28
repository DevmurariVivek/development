@isTest
public class slack_tst_Community {
	@isTest 
	static void testTrigger() {
		Market_Area__c obj1 = new Market_Area__c();
		insert obj1;

		Community__c obj0 = new Community__c(
			Market_Area__c = obj1.Id
		);
		insert obj0;
	}
}