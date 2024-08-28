({
    calculate : function(component, event, helper) {
        console.log('inside calculate method - 3');
        var num1 = component.get("v.number1");
        var num2 = component.get("v.number2");
        var recordId = component.get("v.recordId");
        console.log('recordId --- ' + component.get("v.recordId"));
        console.log('inside calculate method - 7');

        var action = component.get("c.saveMultiplicationResult");
        console.log('inside calculate method - 10');
        action.setParams({
            "recordId": recordId,
            "number1": num1,
            "number2": num2
        });

        console.log('inside calculate method - 17');
        action.setCallback(this, (response) => {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('inside calculate method - 21');
                var result = response.getReturnValue();
                console.log('inside calculate method - 21' , result);
                component.set("v.result", result);
                component.set("v.showInput", false);
                console.log('inside calculate method - 26');
                helper.callApex(component, result);
                console.log('inside calculate method - 28');
                // Refresh the page
                $A.get('e.force:refreshView').fire();
            } else {
                console.log("Error: " + JSON.stringify(response.getError()));
            }
            
        });

        $A.enqueueAction(action);
    }

})