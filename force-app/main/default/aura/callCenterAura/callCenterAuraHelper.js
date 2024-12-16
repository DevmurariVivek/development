({
    registerClickListener: function(cmp, helper) {
        try {

            // console.log("before calling pollIncomingDetails");
            // helper.pollIncomingDetails(cmp, helper);
            // console.log("after calling pollIncomingDetails");
        
            console.log("Registering the click-to-dial event listener");

            // Register the click-to-dial event listener
            sforce.opencti.onClickToDial({
                listener: function(payload) { 
                    var phoneNumber = payload.number.replace(/\D/g, ""); // Remove non-digit characters
                    //var phoneNumber = payload.number.replaceFirst('^\\+\\d+', '').trim();
                    console.log("The clicked number ---> " + phoneNumber);

                    var recordId = payload.recordId;
                    console.log("The recordid ---> " + recordId);

                    cmp.set("v.statusMessage", "Call is in progress...");
                    //cmp.set("v.spinner", false);

                    sforce.opencti.setSoftphonePanelVisibility({
                        visible:true, 
                    });

                    // Initiate server-side call
                    window.setTimeout(
                        $A.getCallback(function() {
                            helper.handleCalls(cmp, phoneNumber, recordId);
                        }), 2000
                    );
                }
            });
        } catch (error) {
            console.log('Error message at registerClickListener method of callCenterAuraHelper --- ', JSON.stringify(error.message));
        }
    },

    handleCalls: function(cmp, phoneNumber, recordId) {
        try {
            console.log("The handleCalls method for phone number ---> " + phoneNumber);

            var action = cmp.get("c.initiateCall");  // Get the Apex controller method

            action.setParams({
                phoneNumber: phoneNumber,
                recordId : recordId  // Pass the phone number
            });

            // Set the callback for when the server returns a response
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    console.log("Server-side call success");
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors && errors[0] && errors[0].message) {
                        console.error("Error message: " + errors[0].message);
                    } else {
                        console.error("Unknown error");
                    }
                }
            });

            $A.enqueueAction(action);  // Enqueue the action for the server call

        } catch (error) {
            console.log('Error message at handleCalls method of callCenterAuraHelper --- ', JSON.stringify(error.message));
        }
    },

    callApex: function(cmp, helper) {

        try {
            console.log('inside callApex');

            var action = cmp.get("c.getIncomingdetails"); 
            //console.log('action ---> '+ action);       
            action.setCallback(this, function(response) {
                
                var responseValue = response.getReturnValue();
                console.log('the response ---> ' + responseValue);

                // Parse the JSON string into a JavaScript object
                let responseObject = JSON.parse(responseValue);
                console.log('responseObject ---> ' + responseObject);

                if(responseObject != null && responseObject.caller != null && responseObject.receiver != null){

                    let caller = responseObject.caller;
                    console.log('caller ---> ' + caller);
                    
                    let receiver = responseObject.receiver;
                    console.log('receiver ---> ' + receiver);

                    let recordId = responseObject.id;
                    console.log('recordId ---> ' + recordId);

                    cmp.set('v.detailsFetched', true);

                    sforce.opencti.setSoftphonePanelVisibility({
                        visible:true, 
                    });

                    cmp.set("v.statusMessage", "You have an Incoming call from : " + caller );

                    this.sendIncomingCallConfirmation(cmp, helper, recordId);
                    
                }

            });
            $A.enqueueAction(action); 
        } catch (error) {
            console.log('Error message at callApex method of callCenterAuraHelper --- ', JSON.stringify(error.message));
        }
    }, 

    sendIncomingCallConfirmation: function(cmp, helper, recordId) {
        try {
            console.log('Inside the sendIncomingCallConfirmation');
            console.log('recordId --->  '+ recordId);

            
            var sendIncomingCallConfirmation = cmp.get("c.incomingCallNotified"); 
                console.log('sendIncomingCallConfirmation ---> '+ sendIncomingCallConfirmation);       
                sendIncomingCallConfirmation.setParams({
                    notified: true,
                    recordId: recordId,
                });

                sendIncomingCallConfirmation.setCallback(this, function(response) {
                    if(response != null){
                        console.log('The Incoming call detail is been marked notified');

                    }
                });
            
            $A.enqueueAction(sendIncomingCallConfirmation); 

        } catch (error) {
            
        }
    }
})