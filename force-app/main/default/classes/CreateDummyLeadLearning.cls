public class CreateDummyLeadLearning {
    public static void dummyleads(){
        Integer i = 0;
        List<Lead> leadlist= new List<Lead>();
        // List<Lead> newleadlist= new List<Lead>();
        
        for(i=0;i<5;i++){
            Lead l = new Lead();
            l.LastName ='Lead' + '-' + i;
            l.Company = 'Leads Company';
            l.Status = 'Working - Contacted';
            l.LeadSource = 'Other';
            leadlist.add(l);
        }
        insert leadlist;
        system.debug('leadlist:' + leadlist);
    }

}