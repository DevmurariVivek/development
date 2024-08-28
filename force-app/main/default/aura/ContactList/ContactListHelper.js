({
    loadRecords : function(component) {
        
        var action = component.get("c.fetchContact");
        action.setCallback(this, function(response){
            var state = response.getState();
            if( state = "SUCCESS"){
                component.set('v.contact', response.getReturnValue());
                console.log("line 9" + !v.contact)
                component.set('v.contactList' , response.getReturnValue());
                this.updateTotal;length(component);
            }

            var toastEvent = $A.get("e.force:showToast");
            if(state="SUCCESS"){
                toastEvent.setParams({
                    "title" : "SUCCESS",
                    "messeage" : "Your Contacts Are Updates Successfully"
                });
            }
            else {
                toastEvent.setParams({
                    "title" : "ERROR",
                    "messeage" : "Something went Wrong"
                });
            }
            toastEvent.fire();
       });
      $A.enqueueAction(action);
 },
 updateTotal : function(component){
    var contact = component.get("v.contact");
    component.set("v.totalContacts" , contact.length);

 }

})