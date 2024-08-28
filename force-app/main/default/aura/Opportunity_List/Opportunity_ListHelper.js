({
    sortData : function(component,fieldName,sortDirection){
        var data = component.get("v.opportunities");
        var key = function(a) { return a[fieldName]; }
        var reverse = sortDirection == 'asc' ? 1: -1;
 
        if(fieldName == 'Phone'){ 
            data.sort(function(a,b){
                var a = key(a) ? key(a) : '';
                var b = key(b) ? key(b) : '';
                return reverse * ((a>b) - (b>a));
            }); 
        }
        else{
            data.sort(function(a,b){ 
                var a = key(a) ? key(a).toLowerCase() : '';
                var b = key(b) ? key(b).toLowerCase() : '';
                return reverse * ((a>b) - (b>a));
            });    
    }
        component.set("v.opportunities",data);
    }, 

})