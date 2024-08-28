({
    doinit : function(component, event, helper) {
        var cols = [{ label : 'Contact Name' , fieldName : 'Name' , type : 'text'},
                    { label : 'Phone No' , fieldName : 'Phone' , type : 'text'},
                    { label : 'Email' , fieldName : 'Email' , type : 'text'},

        ];
        component.set('v.columns',cols);
    /*   var i=  component.get('v.contacts');
       var op = [];
       i.forEach(element => {
           let ab = JSON.parse(JSON.stringify(element));
           op.push(ab);
       })
       console.log(op);
       component.set('v.contacts',op); */
},

})