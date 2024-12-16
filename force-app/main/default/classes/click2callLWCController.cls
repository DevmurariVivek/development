public with sharing class click2callLWCController {
    @AuraEnabled
    public static void makeCall(String phoneNumber) {
        System.debug('the number ---> ' + phoneNumber);
    }
}