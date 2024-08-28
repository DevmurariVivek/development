public class LeadPriority {
    public static String checkPriority(String LeadState) {

        if (String.isBlank(LeadState) || LeadState.length()>2) {
            return null;
            
        }

        String taskpriority;
        if (LeadState == 'CA') {
            taskpriority='High';
            
        }
        else {
            taskpriority='Low';
        }
        return taskpriority;

    }
}