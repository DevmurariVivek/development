public class InvocableFlowAction_MultiOutput {
    @InvocableMethod (label='Multi_Output' description='Will be used to pass multiple value as input and output in screen flow' category='Account')
    // Inserted Return type as Collection to use values into flow, 
    // given list of striings as AccountIds from flow to apex as parameter to filter the data of accounts  
    public static List<List<Account>> message2(List<List<Account>> AccountIds) {
        // Created List of List On Account object (Collection) in order to pass collection of accounts from apex to flow
        List<List<Account>> AccountList = new List<List<Account>>();
        AccountList.add([SELECT Id,Name,Phone FROM Account WHERE Id IN : AccountIds.get(0) LIMIT 10]);
        return AccountList;

    }
}