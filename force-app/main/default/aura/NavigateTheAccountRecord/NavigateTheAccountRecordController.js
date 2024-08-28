({
invoke : function(component, event, helper) {
var redirectToNewRecord = $A.get( "e.force:navigateToSObject" );

redirectToNewRecord.setParams({
"recordId": component.get( "v.accountId" ),
"slideDevName": "detail"
});
redirectToNewRecord.fire();
}
})