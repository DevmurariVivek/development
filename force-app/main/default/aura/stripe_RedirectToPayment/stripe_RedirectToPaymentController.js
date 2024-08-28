({
    redirect : function(component, event, helper) {
    //Find the text value of the component with aura:id set to "address"
    var redirectURL = component.get("v.CheckoutURL");
    var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
    "url": redirectURL 
    });
    urlEvent.fire();

    }
    // $A.enqueueAction(action);
})