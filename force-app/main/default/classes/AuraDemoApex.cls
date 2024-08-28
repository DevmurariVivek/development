public with sharing class AuraDemoApex {
    @AuraEnabled
    public static void servermethod(String myString) {

        System.debug(myString);
    }
}