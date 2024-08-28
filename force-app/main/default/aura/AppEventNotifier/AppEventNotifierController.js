({
    fireapplicationEvent : function(component, event, helper) {

        var action = $A.get("e.c:applicationEvent");
        action.setParams({

            "message" : "This is passed from AppEventNotifier"
        });

        action.fire();
    }
})