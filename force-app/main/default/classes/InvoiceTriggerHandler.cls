public with sharing class InvoiceTriggerHandler {

    public static void onBeforeInsert(List<Invoice> newInvoices) {

        System.debug('In onBeforeInsert');
    }
    
    public static void onAfterInsert(List<Invoice> newInvoices, Map<Id, Invoice> newInvoiceMap) {

        System.debug('In onAfterInsert');   
    }

    public static void onBeforeUpdate(List<Invoice> newInvoices, List<Invoice> oldInvoices, Map<Id,Invoice> newInvoiceMap, Map<Id,Invoice> oldInvoiceMap) {

        System.debug('In onBeforeUpdate');
    }

    public static void onAfterUpdate(List<Invoice> newInvoices, List<Invoice> oldInvoices, Map<Id,Invoice> newInvoiceMap, Map<Id,Invoice> oldInvoiceMap)  {

        System.debug('In onAfterUpdate');
    }

    public static void onBeforeDelete(List<Invoice> oldInvoices, Map<Id,Invoice> oldInvoiceMap)  {

        System.debug('In onBeforeDelete');
        customRollupBeforeDelete(oldInvoices, oldInvoiceMap);
    }

    public static void onAfterDelete(List<Invoice> oldInvoices, Map<Id,Invoice> oldInvoiceMap)  {

        System.debug('In onAfterDelete');
        customRollupAfterDelete(oldInvoices, oldInvoiceMap);
    }

    public static void onAfterUnDelete(List<Invoice> newInvoices, Map<Id, Invoice> newInvoiceMap)  {

        System.debug('In onAfterUndelete');
        customRollupAfterUnDelete(newInvoices, newInvoiceMap);
    }

    public static void customRollupBeforeDelete(List<Invoice> oldInvoices, Map<Id,Invoice> oldInvoiceMap){

        
    }

    public static void customRollupAfterDelete(List<Invoice> oldInvoices, Map<Id,Invoice> oldInvoiceMap){

    }

    public static void customRollupAfterUnDelete(List<Invoice> newInvoices, Map<Id, Invoice> newInvoiceMap){

    }

}