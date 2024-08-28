({
    getRelatedData : function(component,event) {
        var action = component.get("c.fetchStudents");
        console.log( 'New List :'+action);
        
        action.setParams({ clgId : component.get("v.recordId") });
        console.log(component.get("v.recordId"));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {

                var data = JSON.parse(JSON.stringify(response.getReturnValue()))
                console.log({data});

                var headingInfo = response.getReturnValue();
               
                component.set("v.studentList", data);
                console.log(component.get("v.studentList"));  
               
            } else {
                 
                console.log("error: "+errors[0].message);
            } 
        });
  
        $A.enqueueAction(action);

    },

})