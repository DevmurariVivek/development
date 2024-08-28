({
    doInit : function(component, event, helper) {
        helper.loadRecords(component);
    },

    handlechange: function(component, event, helper) {
        var contact = component.get("!v.contact");
        var contactList = component.get("v.contactList");

        var selected = event.getSource().get("v.value");

        var filter = [];
        var k = 0;
        for (var i=0; i<contactList.length; i++){
            var c = contactList[i];
            if(selected != "Others"){
                if( c.LeadSource == selected){
                    filter[k] = c;
                    k++;

                };
            }
            else{
                filter=contactList;
            }
        }
        component.set("v.contact", filter);
        helper.updateTotal(component);

    }

});