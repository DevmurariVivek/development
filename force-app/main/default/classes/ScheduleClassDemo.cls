// Schedulable class must imlement the Schedulable keyword 
public class ScheduleClassDemo implements Schedulable {

    //Must include execute method along with SchedulableContext in parameter section
    public static void execute(SchedulableContext sc){

        //Perform code logic 
        List<Lead> leadlist = new List<Lead>();
        leadlist=[SELECT Id,Name,LeadSource FROM Lead WHERE LeadSource='Other' ORDER BY Name ASC LIMIT 3 ];
        system.debug('leadlist: '+leadlist);

        delete leadlist;

        // Manual Scheduling at desired time using CRON expression and system.schedule method
        ScheduleClassDemo sa = new ScheduleClassDemo();
        string expression='0 12 15 4 11 ? 2022';
        system.schedule('deleteleads1',expression,sa);
    }
   

}