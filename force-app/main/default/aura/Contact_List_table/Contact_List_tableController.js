({
    doinit : function(component, event, helper) {
        var cols = [{ label : 'Full Name' , fieldName : 'Name' , type : 'text'},
                    { label : 'Email' , fieldName : 'Email' , type : 'text'},
                    { label : 'Phone No' , fieldName : 'Phone' , type : 'text'},

        ];
        component.set('v.columns',cols);

},

handleSelectedRow : function(component,event,helper){
    
    // var selectedRows = event.getParam('selectedRows');
    // var row = event.getParam('row');
    // var recordId = row.Id;
    // console.log(recordId);


    // cmp.set('v.selectedRowsCount', selectedRows.length);

  
    var selectedRows = event.getParam('selectedRows');
    console.log('Selected rows '+selectedRows); 
    var setRows = [];
    for ( var i = 0; i < selectedRows.length; i++ ) {
        
        setRows.push(selectedRows[i]);

    }
    console.log(setRows[0].Id);
    // let obj =[];
    //     for(var i =0; i<selectedRows.length; i++){
    //         obj.push(selectedRows[i]);
    //         console.log('Selected rows name '+selectedRows[i].Id);
    //         //Here you can get all the needed fields output and print on the next page
    //     }
    //     component.set("v.selectedSearchableList", obj);
       component.set('v.recordId' ,setRows[0].Id);
},

ContinueButtonAction : function(component,event,helper){
    alert("You clicked: " + event.getSource().get("v.label"));
    var evt = event.getParam('selectedRows');
        evt.setParams({
            "selectedProvidersList" : component.get("v.selectedSearchableList")
        });
        evt.fire();
        console.log(selectedRows[i].Name);
        alert("You Clicked button");
        

   
    
  
},
NewButtonAction : function(component,event,helper){
    var createRecordEvent = $A.get('e.force:createRecord');
    if ( createRecordEvent ) {
        createRecordEvent.setParams({
            'entityApiName': 'Contact'

        });
        createRecordEvent.fire();
    } else {
        /* Create Record Event is not supported */
        alert("Contact creation not supported");
    }
}


})