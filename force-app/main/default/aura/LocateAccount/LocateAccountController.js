({
    fetchAccounts : function(component, event, helper) {
        var actions =[{
            label :'View',
            name:'view',
            iconName:'action:preview'
        },
        {
            label :'Edit',
            name:'edit',
            iconName:'action:edit'
        },
        {
            label:'Delete',
            name:'delete',
            iconName:'action:delete'
        }];
        
        component.set('v.mycolumns', [
            {label: 'Account Name', fieldName: 'linkName', type: 'url',
               typeAttributes: {label: { fieldName: 'Name' }, target: '_blank',editable:true,sortable: true}},
        //    {label: 'Account Name', fieldName: 'Name', type: 'text',editable:'true',sortable: 'true'},
            {label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'text',editable:true},
            {label: 'Phone', fieldName: 'Phone', type: 'phone',editable:true,sortable: true},
            {label: 'Website', fieldName: 'Website', type: 'url',editable:true,sortable: true},
            {type:"action",typeAttributes:{rowActions:actions}}
        ]);
        helper.getData(component, event, helper);

      
    }, 
  
 /*   searchKeyChange: function(component, event) {
        var searchKey = component.find("searchKey").get("v.value");
        console.log('searchKey:::::'+searchKey);
        var action = component.get("c.findByName");
        action.setParams({
            "searchKey": searchKey
        });
        action.setCallback(this, function(a) {
            component.set("v.acclst", a.getReturnValue());
        });
        $A.enqueueAction(action);
    },   */

    new_Account_button : function(component, event, helper){
            var createRecordEvent = $A.get('e.force:createRecord');
            if ( createRecordEvent ) {
                createRecordEvent.setParams({
                    'entityApiName': 'Account'
        
                });
                createRecordEvent.fire();
            } else {
                alert("Account creation not supported");
            }

    },
    pageprocess : function(component, event, helper) {
        component.set("v.currentPageNumber", parseInt(event.target.name));
        helper.setPageDataAsPerPagination(component); //,component.get('v.pageSizeOptions'),helper
    },

    onNext: function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber + 1);
        helper.setPageDataAsPerPagination(component);
    },
     
    onPrev: function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber - 1);
        helper.setPageDataAsPerPagination(component);
    },
     
    onFirst: function(component, event, helper) {        
        component.set("v.currentPageNumber", 1);
        helper.setPageDataAsPerPagination(component);
    },
     
    onLast: function(component, event, helper) {        
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.setPageDataAsPerPagination(component);
    },
 
    onPageSizeChange: function(component, event, helper) {        
        helper.preparePagination(component, component.get('v.tableData'));
    },
    onChangeSearchPhrase : function (component, event, helper)    {
        if ($A.util.isEmpty(component.get("v.searchPhrase"))) {
            let acclst = component.get("v.acclst");
            component.set("v.filteredData", acclst);
            helper.preparePagination(component, acclst);

 
        }
    /* var searchKey = component.find("searchPhrase").get("v.value");
       console.log('searchKey:::::'+searchKey);
       console.log('searchKey:::::');
       if (searchKey.length > 2) {
        var action = component.get("c.findByName");
         
      } else {
        var action = component.get("c.AccountData");
      };

    console.log('searchKey:::::'+searchKey);
    action.setParams({
        "searchKey": searchKey
    });
    action.setCallback(this, function(a) {
        component.set("v.acctList", a.getReturnValue());
        
    });
    $A.enqueueAction(action); */

}, 
 
   handleSearch : function (component, event, helper) {

        helper.searchRecordsBySearchPhrase(component);
    }, 

    handleRowAction: function (component, event, helper) {
        var action = event.getParam('action');
        switch (action.name) {
            case 'view':
                helper.viewRecord(component, event);
                break;
            case 'edit':
                helper.editRecord(component, event);
                break;
            case 'delete':
                helper.deleteRecord(component, event);
                break;
        }
    },
    handleSort: function(component, event, helper) {
        
        var sortBy = event.getParam("fieldName");
        var sortDirection = event.getParam("sortDirection");
        component.set("v.sortedBy",sortBy);
        component.set("v.sortDirection",sortDirection);
        helper.sortData(component,sortBy,sortDirection);  

    },

    onSave : function( component, event, helper ) {         
        var draftValues = event.getParam('draftValues');
        var action = component.get("c.updateAccts");
        action.setParams({"updatedAccountList" : draftValues});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
                console.log(data);
                if(data === true){
                    helper.showSuccessToast(component,event, helper, 'success','Record Updated Successfully');
                    $A.get('e.force:refreshView').fire();  
                }else{
                    helper.showSuccessToast(component,event, helper, 'error','Some Error Occured')
                }
            }
        });
        $A.enqueueAction(action);
    }   
})