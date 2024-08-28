({
    handleAppEvent : function(component, event, helper) {
        var inputfromsource = event.getParam("agentLeadId");
        console.log(inputfromsource);

        component.set("v.agentLeadId" , inputfromsource);

    }
})