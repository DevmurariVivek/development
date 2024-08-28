public with sharing class stripe_Contact_to_CustomerTriggerHandler {
    
    public static void beforeInsert(List<Contact> newList) {

    }
    public static void afterInsert(List<Contact> newList) {
        String Body;
        String ConId;
        String Name; 
        String Email; 
        String Phone; 
        Decimal Balance; 
        String CurrencyIsoCode;
       

        ConId = newList[0].Id;
        Name = newList[0].LastName;
        Email = newList[0].Email;
        Phone = newList[0].Phone;
        Balance = newList[0].Balance__c;



        System.debug(ConId);
        System.debug(Name);
        System.debug(Email);
        System.debug(Phone);
        System.debug(Balance);
        System.debug(CurrencyIsoCode);


        stripe_Contact_to_CustomerWebCall.WebCallPostMethod(Name, Email, Phone, Balance, CurrencyIsoCode,ConId);
        // stripe_Contact_to_CustomerWebCall.WebCallGetMethod(ConId, Name);
    }
}