({
    firecomponentEvent : function(component, event, helper) {
        var action = component.getEvent("cmpEvent");
        var msgString = component.get("v.messageString");
        action.setParams({
            message : msgString
        }); 

        msgString = $A.util.isEmpty(msgString) ? "No Message Passed" : msgString;
        //Alternatively we can check above statement using if else as well 
        //if(isEmpty(msgString)){
        //     msgString = "No Message Passed";
        // }else{
        //     msgString = msgString ;
        // }

        action.setParams({
            "message" : msgString
        })
        action.fire();
    }
})