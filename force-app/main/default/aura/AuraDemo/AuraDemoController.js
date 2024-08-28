({
    doAction : function(component, event, helper) {
        // we can use the Component.Find action in order to find the attribute defmed with the aura:id tag
        var inputcmp = component.find("inputcomp");
        // we are fetching the value which a user is going to insert in the input component
        var value = inputcmp.get("v.value");
        console.log(value);

        if(value == "Vivek"){
            component.set("v.flag" , true);

        }else{
            component.set("v.flag" , false);
        }

    },
    callServer: function(component, event, helper) {
        var value = component.get("v.inputcomp");
        
        var action = component.get("c.servermethod");
        action.setParam ({"myString" : value});
        action.setCallback(this , function(response){
            var state = response.getState();
            if(response == "Success"){
                console.log("Successful Transaction");
            }else{
                console.log(state);
            }
        });
        $A.enqueueAction(action);
    }
})