({
	doInit : function(component, event, helper) {
       
        var action = component.get("c.fetchStudents");
        console.log( 'New List :'+action);
        
        action.setParams({ clgId : component.get("v.recordId") });
        console.log(component.get("v.recordId"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {

                var data = JSON.parse(JSON.stringify(response.getReturnValue()))
                console.log({data});
                component.set("v.studentList", data);
                console.log(component.get("v.studentList"));  
               
            } else {
                 
                console.log("error: "+errors[0].message);
            } 
        });
  
        $A.enqueueAction(action);
	},
    handleSelect: function (cmp, event) {           
        var selectedMenuItemValue2 = event.getParam("value");
        var res = selectedMenuItemValue2.split(";");
        var selectedMenuItemValue = res[1];
        var currentId = res[0];
        cmp.set('v.currentId', currentId);
        console.log(selectedMenuItemValue+'----currentId-----'+currentId); 
        switch (selectedMenuItemValue) {
            case 'Edit':                   
                var editRecordEvent = $A.get("e.force:editRecord");
                editRecordEvent.setParams({
                    "recordId": currentId
                });
                editRecordEvent.fire();
                $A.get('e.force:refreshView').fire();
                break;

            case 'Delete':
                cmp.set('v.showConfirmDialog', true);
                   
    }},
    reloadRecords: function (cmp, event,helper) {
        console.log('testing');
        helper.getRelatedData(cmp,event);
    },
    handleConfirmDialogYes : function(cmp, event, helper) {
        console.log('here 59');
      var currentId = cmp.get('v.currentId');
      console.log('here 59 @@@',currentId);

        var action = cmp.get("c.deleterecord");
        console.log('here 59');
        console.log(currentId);
        action.setParams({
                prjId: currentId
            });
        console.log(currentId);
            
        action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS" ) {  
            console.log('Yes');
            cmp.set('v.showConfirmDialog', false);
            var toastEvent = $A.get("e.force:showToast");
            
        
            if(response.getReturnValue()==='DONE'){

                console.log(response.getReturnValue);
                
                toastEvent.setParams({
                "title": "Success!",
                "message": "The record has been delete successfully.",
                "type" : "success"                    
            }); 
            }else{
            toastEvent.setParams({
                "title": "Failed!",
                "message": response.getReturnValue(),
                "type" : "error"});   
            }                                       
            toastEvent.fire();
            $A.get('e.force:refreshView').fire();       
        }
    });
    $A.enqueueAction(action);

    },
    handleConfirmDialogNo : function(cmp, event, helper) {
        console.log('No');
        cmp.set('v.showConfirmDialog', false);
    },
   
})