public with sharing class AccountController_DataTable{
    @AuraEnabled
    public static list<Account> AccountData() {
        list<Account> acclst = [SELECT Id,Name,AnnualRevenue,Phone,	Website FROM Account];
        return acclst;  
    }  

   /* @AuraEnabled
    public static list<Account> AccountData(String searchKey ,String AccName) {

        AccName = '%' + searchKey + '%';
        List<Account> acclst =  [SELECT Id,Name,AnnualRevenue,Phone,Website FROM Account WHERE Name Like 'searchKey%'];
        return acclst;
    } */


    @AuraEnabled
    public static void delAccount(Account accountRec){
        delete accountRec;
    } 
    @AuraEnabled
    public static List<Account> findByName(String searchKey) {
        String name =  + searchKey + '%';
        system.debug('searchkey'+searchkey);
        return [SELECT id,Name,AnnualRevenue,Phone,Website FROM Account WHERE name LIKE :name];
    }
    @AuraEnabled  
        public static boolean updateAccts( List < Account > updatedAccountList ) {    
            
            try {  
                update updatedAccountList;  
                return true;
                
            } catch(Exception e) {  
              
                return false;       
            }  
        }
}