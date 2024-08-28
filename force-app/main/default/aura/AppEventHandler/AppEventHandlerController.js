({
    handleAppEvent : function(component, event, helper) {

        var msgfromNotifier = event.getParam("message");
        console.log(msgfromNotifier);
        
        component.set("v.msgfromNotifier" , msgfromNotifier);
    }
})