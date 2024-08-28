({
    saveInvoice : function(component, event, helper) {
        
        var recordId =  component.get("v.recordId");
		var action = component.get("c.savePdf");
        action.setParams({recordId : recordId});
        action.setCallback(this,function(res){
           var state =  res.getState();
            console.log(state);
            if(state === "SUCCESS")
            {
                $A.get("e.force:closeQuickAction").fire();
                $A.get('e.force:refreshView').fire();
                var toastEvent = $A.get("e.force:showToast");
    				toastEvent.setParams({
                    "title": "Success!",
                    "type": 'success',
                    "message": "PDF Save"
    				});
    				toastEvent.fire();
            }
        })
        $A.enqueueAction(action);
    },
    
    handleClose : function(component,event,helper)
    {
        $A.get("e.force:closeQuickAction").fire();
    }
})