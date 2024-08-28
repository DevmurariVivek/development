({
    callApex : function(component, result){
        console.log('inside callApex method - 3');
        var action = component.get("c.InternalClassCall");
        console.log('inside callApex method - 5');
        action.setParams({
            Total: result
        });

        action.setCallback(this, (response) => {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Handle success
                var returnValue = response.getReturnValue();
                console.log('inside callApex method - 15 ' , returnValue);
                // Do something with the return value
            } else {
                // Handle error 
                var errors = response.getError();
                console.log('inside callApex method - 20 ' , errors);
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.error("Error message: " + errors[0].message);
                    }
                } else {
                    console.error("Unknown error");
                }
            }
        });

        $A.enqueueAction(action);

    }
})