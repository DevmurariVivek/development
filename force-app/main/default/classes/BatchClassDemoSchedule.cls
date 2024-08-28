public class BatchClassDemoSchedule implements Schedulable{

        public static void execute(SchedulableContext sc){
            BatchClassDemo BCD = new BatchClassDemo();
            database.executebatch(BCD);


            BatchClassDemoSchedule BCDS = new BatchClassDemoSchedule();
            string expression ='0 50 18 10 11 ? 2022';
            system.schedule('SchedulingBatch', expression, BCDS);
        }

       

        
}