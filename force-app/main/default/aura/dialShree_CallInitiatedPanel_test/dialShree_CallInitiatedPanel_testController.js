// saveToCaseDescriptionController.js
({
    saveToCaseDescription : function(component, event, helper) {
        console.log(component.get("v.inputText"));
        var inputvalue = component.get("v.inputText");

        // Call Apex controller method to save the Case record
        var action = component.get("c.saveCaseRecord");
        action.setParams({
            "InputValue": inputvalue
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Success message or any further actions
                console.log('Case record updated successfully');
            }
            else {
                // Handle error
                console.log('Error updating Case record: ' + response.getError());
            }
        });
        $A.enqueueAction(action);
    }
})