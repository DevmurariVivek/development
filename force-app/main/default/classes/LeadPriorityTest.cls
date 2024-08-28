@isTest
public class LeadPriorityTest {
    @isTest static void testPriority() {

        String Highpriority = LeadPriority.checkPriority('CA');
        System.assertEquals('High',Highpriority,'Priority is as expected');
        
        String Lowpriority = LeadPriority.checkPriority('NY');
        System.assertEquals('Low',Lowpriority,'State is not CA');
        
        String Nullpriority = LeadPriority.checkPriority('USA');
        System.assertEquals(null,Nullpriority,'Length of state is bit too long');
        

    }

}