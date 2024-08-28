global with sharing class InterfaceMultiplicationController {

    global static Decimal callinterfaceMethod(Decimal Total){

        External_Apex_Class__c ExternalApex = External_Apex_Class__c.getInstance();

        Debug_logger__c DL1 = new Debug_logger__c();
        DL1.Class_Component_Name__c = 'InterfaceMultiplicationController' ; 
        DL1.Line_number__c = '11 -' + ExternalApex ; 
        DL1.Method_Name__c = 'callinterfaceMethod' ;
        insert DL1; 

        if(ExternalApex.ManagedCodeDev__ClassName__c != null && ExternalApex.ManagedCodeDev__IsActive__c == true) {

            String ApexClass = ExternalApex.ManagedCodeDev__ClassName__c;

            Debug_logger__c DL2 = new Debug_logger__c();
            DL2.Class_Component_Name__c = 'InterfaceMultiplicationController' ; 
            DL2.Line_number__c = '19 '; 
            DL2.Method_Name__c = 'callinterfaceMethod' ;
            insert DL2; 

            Type t = Type.forName(null , ApexClass);

            Debug_logger__c DL3 = new Debug_logger__c();
            DL3.Class_Component_Name__c = 'InterfaceMultiplicationController' ; 
            DL3.Line_number__c = '27 - ' + t; 
            DL3.Method_Name__c = 'callinterfaceMethod' ;
            insert DL3; 

            Extention implementation = (Extention)t.newInstance();

            return implementation.Output(Total);

        } else {
            return null;
        }
    }

    // Inner interface
    global interface Extention {
        Decimal Output(Decimal Total);
    }


}