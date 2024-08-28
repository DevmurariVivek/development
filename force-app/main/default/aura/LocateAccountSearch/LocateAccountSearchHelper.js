({
    handleSearch : function(component,searchTerm) {
        var action = component.get("{!c.getAccounts}");
        action.setParams({
            searchTerm:searchTerm
        });
        action.setCallback( this, function( response ) {
            var event = $A.get( "e.c:LocateAccountEvent" );
            event.setParams({
                "accounts": response.getReturnValue()
            });
            event.fire();
        });
        $A.enqueueAction(action);
    }
})