({
    init: function(cmp, event, helper) {
        try {

            var sendConfirmation = cmp.get("c.incomingCallNotified"); 
            console.log('sendConfirmation ---> '+ sendConfirmation);       
            sendConfirmation.setParams({
                notified: true,
                recordId: 'a24J4000000PmBIIA0',
            });

            sendConfirmation.setCallback(this, function(response) {
                console.log('The Incoming call detail is been marked notified');
            });

            let callbackfun = function(response) {
                console.log("response is success ---> " + response.success);

                if (response.success) {
                    console.log("return value ---> " + response.returnValue);
                    console.log("The Phone fields are clickable");

                    // Register click-to-dial listener and pass helper
                    cmp.set("v.statusMessage", "Click on any Phone Number to call...");
                    helper.registerClickListener(cmp, helper);

                    //this.registerIncomingcalls(cmp, helper);
                    console.log("detailsFetched before---> " + cmp.get ('v.detailsFetched')); 

                    // Initiate the callApex method
                    helper.callApex(cmp, helper);

                    //execute callApexMethod() again after 5 sec each
                    if(!cmp.get("v.isPolling") && !cmp.get("v.detailsFetched")){
                        cmp.set("v.isPolling", true);
                        window.setInterval(
                            $A.getCallback(function() { 
                                if (!cmp.get("v.detailsFetched")) {
                                    helper.callApex(cmp, helper);
                                } else {
                                    //clearInterval(interval); // Clear the interval
                                    cmp.set("v.isPolling", false);
                                }
                            }), 2000
                        );
                    }

                    console.log("detailsFetched after---> " + cmp.get ('v.detailsFetched')); 

                } else {
                    console.error("error --->" + response.error);
                }
            };

            sforce.opencti.enableClickToDial({
                callback: callbackfun
            });

        } catch (error) {
            console.log('Error at init method of callCenterAuraController --- ', JSON.stringify(error));
            console.log('Error message --- ', JSON.stringify(error.message));
        }
    }
})