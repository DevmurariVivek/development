({
    saveLead: function (component, event, helper) {
        var lead = component.get("v.lead");
        var action = component.get("c.saveLead");
        action.setParams({ lead: lead });
        
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Handle success, e.g., redirect to the new Lead record
                var urlEvent = $A.get("e.force:navigateToSObject");
                urlEvent.setParams({
                    "recordId": response.getReturnValue()
                });
                urlEvent.fire();
            } else {
                // Handle errors
                var errors = response.getError();
                console.error("Error saving lead: ", errors);
            }
        });
        $A.enqueueAction(action);
    },
    
    cancel: function (component, event, helper) {
        // Handle cancel logic, e.g., navigate back to the Leads list
        var urlEvent = $A.get("e.force:closeQuickAction");
        urlEvent.fire();
    }
})