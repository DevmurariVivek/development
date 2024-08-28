({
    handlecomponentEvent : function(component, event, helper) {

        var message= event.getParam("message");
        console.log(message);

        component.set("v.MesasgeFromchildAura" , message);
    }
})