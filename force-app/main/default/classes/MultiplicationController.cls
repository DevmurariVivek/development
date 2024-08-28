public class MultiplicationController {
    @AuraEnabled
    public static Decimal saveMultiplicationResult(Id recordId, Integer number1, Integer number2) {

        Debug_logger__c DL1 = new Debug_logger__c();
        DL1.Class_Component_Name__c = 'MultiplicationController' ; 
        DL1.Line_number__c = '9' ; 
        DL1.Method_Name__c = 'saveMultiplicationResult' ;
        insert DL1; 

        Integer result = number1 * number2;
        
        Managing_Object__c managingObj = new Managing_Object__c();
        managingObj.Id = recordId; // Set the Id of the current record
        managingObj.Number_1__c = number1;
        managingObj.Number_2__c = number2;
        managingObj.Output__c = result;

        Debug_logger__c DL2 = new Debug_logger__c();
        DL2.Class_Component_Name__c = 'MultiplicationController' ; 
        DL2.Line_number__c = '23' ; 
        DL2.Method_Name__c = 'saveMultiplicationResult' ;
        insert DL2; 
        
        try {
            update managingObj; // Update the current record with the calculated values

            Debug_logger__c DL3 = new Debug_logger__c();
            DL3.Class_Component_Name__c = 'MultiplicationController' ; 
            DL3.Line_number__c = '32' ; 
            DL3.Method_Name__c = 'saveMultiplicationResult' ;
            insert DL3; 

            InternalClassCall(result);

            Debug_logger__c DL4 = new Debug_logger__c();
            DL4.Class_Component_Name__c = 'MultiplicationController' ; 
            DL4.Line_number__c = '40' ; 
            DL4.Method_Name__c = 'saveMultiplicationResult' ;
            insert DL4; 

            return result;
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
            return null;
        }
    }

    @AuraEnabled
    public static String InternalClassCall(Decimal Total){
        String message = 'returned from InternalClassCall';

        Debug_logger__c DL5 = new Debug_logger__c();
        DL5.Class_Component_Name__c = 'MultiplicationController' ; 
        DL5.Line_number__c = '54' ; 
        DL5.Method_Name__c = 'InternalClassCall' ;
        insert DL5; 

        try {
            InterfaceMultiplicationController.callinterfaceMethod(Total);
            
        } catch (Exception ex) {
            Debug_logger__c DL6 = new Debug_logger__c();
            DL6.Class_Component_Name__c = 'MultiplicationController' ; 
            DL6.Line_number__c = '65 - ' + ex.getMessage() ; 
            DL6.Method_Name__c = 'InternalClassCall';
            insert DL6;  
        }
        return message;
    }
}