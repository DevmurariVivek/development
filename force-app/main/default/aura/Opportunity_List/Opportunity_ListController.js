({
    doinit : function(component, event, helper) {
        var cols = [
        {  label :"Name" , fieldName: "Name" , type:"text", sortable: true},
        {  label :"Closse Date" , fieldName: "CloseDate" , type:"Date", sortable: true},
        {  label :"Amount" , fieldName: "Amount" , type:"text", sortable: true},
        //{  label :"Community" , fieldName:"Community__c x" , type:"text"},
        // {  label :"Market Area" , fieldName:"Market_Area__c" , type:"text"},

        // {label: 'Community', fieldName: 'linkName', type: 'url',
        //      typeAttributes: { label: { fieldName: 'Community__r.Name' }, target: '_blank', tooltip: { fieldName: 'Community__r.Name' } } },
            
        ];
        component.set('v.columns',cols);
        console.log(cols);
        var action = component.get("c.Opportunity_records");
        var ConId = component.get("v.contactrecordId")
        action.setParams({
            contactrecordId : ConId
        });
        console.log(ConId);
        action.setCallback(this,function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.opportunities', response.getReturnValue());

            }
        
        });
        $A.enqueueAction(action);

    },
    handleSelectedRow : function(component,event,helper){
        var selectedRows = event.getParam('selectedRows');
        console.log('Selected rows '+selectedRows); 
        var setRows = [];
        for ( var i = 0; i < selectedRows.length; i++ ) {
            
            setRows.push(selectedRows[i]);
    
        }
        console.log(setRows[0].Id);
        component.set('v.recordId' ,setRows[0].Id);
    },
    handleSort: function(component, event, helper) {
        
        var sortBy = event.getParam("fieldName");
        var sortDirection = event.getParam("sortDirection");
        component.set("v.sortedBy",sortBy);
        component.set("v.sortDirection",sortDirection);
        helper.sortData(component,sortBy,sortDirection);  

    },

})