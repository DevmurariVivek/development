public class sampleVFpageController
{

    // There are different ways to communicate between APEX and vf page 
    // 1. below code is to automatically handle the inputs that are comming from vf page 

    // public class simplegetset
    // {
    //     public String userinput{get; set;}
    // }


    // 2. below code if to pass any value from apex to vf page in the variable defined in vf page 

    // public String userinput;
    // public string getuserinput(){
    //     return 'john';
    // }
    // public void setuserinput(String userinput){
    //     this.userinput = userinput;
    // }

    // 3. below code is to listen to the inputs received from vf page into apex and see logs of that

    public string userinput;

    public string getuserinput(){
            return userinput;
    }
    public void setuserinput(String userinput) {
        this.userinput = userinput;
        System.debug('Value of userinput: ' + userinput);
    }
}