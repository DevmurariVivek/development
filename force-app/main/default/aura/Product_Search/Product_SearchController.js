({
    doinit : function(component, event, helper) {
        var cols = [
        {  label :"Opportunity Name" , fieldName: "Name" , type:"text", sortable: true},
        {  label :"Closse Date" , fieldName: "CloseDate" , type:"Date", sortable: true},
        {  label: "Account Name", fieldName: 'linkName', type: 'url',
               typeAttributes: {label: { fieldName: 'accountName' }, target: '_self'}},
        {  label :"Contact 1" , fieldName: "Contact_1__c" , type:"text", sortable: true},
        {  label :"Contact 2" , fieldName: "Contact_2__c" , type:"text", sortable: true},
        {  label :"Contact 3" , fieldName: "Contact_3__c" , type:"text", sortable: true}

        ];

        
        component.set('v.columns',cols);
        console.log(cols);
        var action = component.get("c.Opportunity_records");


        // var temp = component.get("v.Product_Name");
        var ProductId = component.get("v.Product_Record_ID");
        console.log({ProductId});
        action.setParams({
            Product_Record_ID : ProductId
        });
     
        action.setCallback(this,function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var opportunityFilterData = response.getReturnValue();

                if(opportunityFilterData.length >0){
                    opportunityFilterData.forEach(function(record){
                        record.linkName = '/'+record.Account.Id;
                        record.accountName = record.Account.Name;
                    });

                }
                console.log({opportunityFilterData});
                component.set('v.opportunities', opportunityFilterData);
                console.log('opportunity data :',response.getReturnValue());

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