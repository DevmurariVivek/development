({
    doInit : function(component,event,helper){
        component.set("v.myColumns", [
            {label: 'SNo.', fieldName: 'sno', type:'number'},
            {label: 'Name of source', fieldName: 'source', type:'text'},
            {label: 'amount' , fieldName:'Amount' , type :'number'}
            
        ]);
        component.set("v.incomes",[{
            sno:1,
            source:'Ragular Job Income',	
            amount:10000
            
        },
        {
            sno:2,
            source:'Marketing',
            amount:30000
        }]);
    }   
 }
)