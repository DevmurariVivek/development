({
    onClick : function(component, event, helper) {
        console.log(component.get("v.agentLeadId"));
        var action = $A.get("e.c:dialshree_ApplicationEvent");
        action.setParams({
            'agentLeadId' : component.get("v.agentLeadId")
        })
        action.fire();
    }
})