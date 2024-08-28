public  class InvocableFlowAction_Output {
    @InvocableMethod (label='Output Test' description='Apex invocable output' category='Custom Apex' )
    // defined apex class's return type as list of output values to return all values at once to flow, 
    // and given list of input variables to pass values from flows as parameter
    public static List<OutputValues> Message1 (List<InputValues> inputList) {

        String message = '';
        List<OutputValues> outputList = new List<OutputValues>();
        if(inputList.size()>0 && inputList != null){

            InputValues input = inputList.get(0);
            OutputValues output = new OutputValues();
            output.Name  = input.Name;
            output.Age   = input.Age;
            output.Place = input.Place;
            outputList.add(output);
            message = 'Your Name: '+ input.Name + 'Your Age:'+ input.Age + 'Your Place'+ input.Place ;

        }
        return outputList;

    }
    // Created Output variables to pass values from apex class to flow 
    public class OutputValues{
        @InvocableVariable(label='Your Name' description='Input Your Name')
        public String Name;
        @InvocableVariable(label='Your Age' description='Input Your Age')
        public Integer Age;
        @InvocableVariable(label='Your Place' description='Input Your Place') 
        public String Place; 
    }
    // Created Input varibales to pass values from flow to apex class
    public class InputValues{
        @InvocableVariable(label='Your Name' description='Input Your Name')
        public String Name;
        @InvocableVariable(label='Your Age' required=true description='Input Your Age')
        public Integer Age;
        @InvocableVariable(label='Your Place' required=true description='Input Your Place') 
        public String Place; 
    }
}