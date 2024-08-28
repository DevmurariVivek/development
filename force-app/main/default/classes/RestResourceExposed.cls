@RestResource(urlMapping='/RestResourceExposed/Account/*')
global with sharing class RestResourceExposed {

  @httpGet
    global static void doGetMethod(){
    Account acc= new Account();
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;

    System.Debug('>>req.headers<<'+req.headers);
    System.Debug('>>req.httpMethod<<'+req.httpMethod);
    System.Debug('>>req.params<<'+req.params);
    System.Debug('>>req.remoteAddress<<'+req.remoteAddress);
    System.Debug('>>req.requestBody<<'+req.requestBody);
    System.Debug('>>req.requestURI<<'+req.requestURI);
    System.Debug('>>req.resourcePath<<'+req.resourcePath);

    System.debug(req);
    Map<String,String> paramsMap = RestContext.request.params;

    String input = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
    System.debug(input);

    if (input == 'GetAll') {

        try {

          List<Account> acclst = new  List<Account> ();
          acclst = [select id,name,AnnualRevenue from Account];

          List<Object> accountWrapperDataList = new List<Object>();
          for(Account singleAccountData : acclst){
              RestResponseWrapperGET RestWrap =  new RestResponseWrapperGET (singleAccountData);
              accountWrapperDataList.add(RestWrap);
          }

          Map<String,List<Object>> accMap = new Map<String, List<Object>> ();
          accMap.put('Accounts',accountWrapperDataList);
          res.addHeader('Content-Type', 'application/json');
          res.responseBody = Blob.valueOf(JSON.serialize(accMap));
          System.debug(res.responseBody);
          
        } catch (Exception ex) {
          res.statusCode = 400;

          SalesforceError[] error = new SalesforceError[]{ 
            new SalesforceError('BAD_REQUEST', 'No Accounts Available, Check the endpoint')
          };

          res.addHeader('Content-Type', 'application/json');
          res.responseBody = Blob.valueOf(JSON.serialize(error));

         }
                
     }else if(input.length()== 18 && input != 'GetAll' ){

        try {

          List<Account> singleList = [SELECT Id,name,AnnualRevenue,CreatedDate FROM  Account WHERE Id =:input];
          // Map<String,List<Object>> singleMap = new Map<String, List<Object>> ();
          // singleMap.put('Account',singleList);
          res.addHeader('Content-Type', 'application/json');
          RestResponseWrapperGET RestWrap =  new RestResponseWrapperGET (singleList[0]);
          res.responseBody = Blob.valueOf(JSON.serialize(RestWrap));
          System.debug(RestWrap);
          
        } catch (Exception ex) {
          res.statusCode = 400;

          SalesforceError[] error = new SalesforceError[]{ 
            new SalesforceError('BAD_REQUEST', 'Please Enter Valid Account Record ID')
          };

          res.addHeader('Content-Type', 'application/json');
          res.responseBody = Blob.valueOf(JSON.serialize(error));
          
        }
       
    }else if(input.length()!= 18 && input != 'GetAll' ) {

      try {

        res.statusCode = 404;
        SalesforceError[] error = new SalesforceError[]{ 
          new SalesforceError('BAD_REQUEST', 'Please Enter Valid Account Record ID')
        };

        res.addHeader('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(error));
        System.debug('94');
        
      }catch (Exception ex) {}
   }
 }

  @httpPost
    global static void  doPostMethod(){

    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;

    System.Debug('>>req.headers<<'+req.headers);
    System.Debug('>>req.httpMethod<<'+req.httpMethod);
    System.Debug('>>req.params<<'+req.params);
    System.Debug('>>req.remoteAddress<<'+req.remoteAddress);
    System.Debug('>>req.requestBody<<'+req.requestBody);
    System.Debug('>>req.requestURI<<'+req.requestURI);
    System.Debug('>>req.resourcePath<<'+req.resourcePath);

    System.debug(req);

    String input = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
    System.debug(input);

    if (input == 'CreateAccount') {

      try {

        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(req.requestbody.tostring());
        System.debug(params);
        //String AccountName = params.getValue('Name');
        String AccountName = String.valueOf(params.get('Name')) ;
        System.debug(AccountName);
        //String AccountAnnualRevenue = params.getValue('AnnualRevenue');
        String AccountAnnualRevenue = String.valueOf(params.get('AnnualRevenue')) ;
        Integer AccountAnnualRevenueInt = Integer.valueOf(AccountAnnualRevenue);
        System.debug(AccountAnnualRevenueInt);

        // List<Object> createLotRecordDataList = (List<Object>) params.get('data');

        Account newAcc = new Account();
        newAcc.Name = AccountName;
        newAcc.AnnualRevenue = AccountAnnualRevenueInt;
        System.debug(newAcc);
        insert newAcc;

        String AccId = newAcc.Id;
        System.debug(AccId);

        List<Account> AccLST = [SELECT Id, Name , AnnualRevenue FROM Account WHERE Id =: AccId];
        RestResponseWrapperPOST RestPost = new RestResponseWrapperPOST (AccLST[0]);
        res.responseBody = Blob.valueOf(JSON.serialize(RestPost));
        res.addHeader('Content-Type', 'application/json');

      } 
      catch (System.DmlException ex) {
        System.debug(ex);
        res.statusCode = 401;
        String errorDmlType = String.valueof(ex.getDmlType(0));
        String errorDmlFields = String.valueOf(ex.getDmlFields(0));
            SalesforceError[] error = new SalesforceError[]{ 
                new SalesforceError(errorDmlType, errorDmlFields.replace('__c',' ').replace('_',' '))
        };
            res.addHeader('Content-Type', 'application/json');
            res.responseBody = Blob.valueOf(JSON.serialize(error));

      }catch (Exception ex) {
        System.debug('ex 1 :'+ex);
        res.statusCode=404;
        SalesforceError[] error = new SalesforceError[]{ 
            new SalesforceError('BAD_REQUEST', 'Please Enter Valid JSON Formate')
        };

        res.addHeader('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(error));
        
      }
    }  
  }
    
  @httpDelete
    global static void doDeleteMethod(){

    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;

    System.Debug('>>req.headers<<'+req.headers);
    System.Debug('>>req.httpMethod<<'+req.httpMethod);
    System.Debug('>>req.params<<'+req.params);
    System.Debug('>>req.remoteAddress<<'+req.remoteAddress);
    System.Debug('>>req.requestBody<<'+req.requestBody);
    System.Debug('>>req.requestURI<<'+req.requestURI);
    System.Debug('>>req.resourcePath<<'+req.resourcePath);

    String input = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
    System.debug(input);

    if (input.length() == 18) {

      try {

        Account deleteAcc= new Account();
        deleteAcc = [select id,name,AnnualRevenue from Account where Id =:input];
        System.debug(deleteAcc);

        RestResponseWrapperDELETE RestDelete = new RestResponseWrapperDELETE (deleteAcc);
        System.debug(RestDelete);

        delete deleteAcc;
        res.statusCode =200;
        res.addHeader('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(RestDelete));

      } catch (Exception ex) {
        res.statusCode = 404;
        SalesforceError[] error = new SalesforceError[] {
          new SalesforceError('BAD_REQUEST', 'Requested Record does not exist')
        };

        res.addHeader('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(error));
        
      }
      
    }else if (input.length() != 18) {

      try {

        res.statusCode = 400;
        SalesforceError[] error = new SalesforceError[] {
          new SalesforceError('BAD_REQUEST', 'Please Enter Valid Account Record Id')
        };
        res.addHeader('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(error));
        System.debug('218 :: the length of passed record id was short');
        
      } catch (Exception ex) {
        
      }
    }  
  }
 
  @httpPut
    global static Void doPutMethod(){

    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;

    System.Debug('>>req.headers<<'+req.headers);
    System.Debug('>>req.httpMethod<<'+req.httpMethod);
    System.Debug('>>req.params<<'+req.params);
    System.Debug('>>req.remoteAddress<<'+req.remoteAddress);
    System.Debug('>>req.requestBody<<'+req.requestBody);
    System.Debug('>>req.requestURI<<'+req.requestURI);
    System.Debug('>>req.resourcePath<<'+req.resourcePath);

    String input = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
    System.debug(input);
    Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(req.requestbody.tostring());
    System.debug(params);

    // If the User is passing both Record Id and body means it is an UPDATE command
    if (input.length() == 18 && params.size() != null) {
      System.debug('Inside Update Command');

      try {
        System.debug('Inside Update Try Command');
        // In this we will ckeck the passed record ID with the list of records of Account, if mathced update the records otherwise throw exception of not a valid ID

        String nameUpdate = String.valueOf(params.get('Name'));
        System.debug(nameUpdate);
        String annualRevenueUpdate = String.valueOf(params.get('AnnualRevenue'));
        Integer annualRevenueUpdateINT = Integer.valueOf(annualRevenueUpdate);
        System.debug(annualRevenueUpdate);
        String idupdate = input;
        System.debug(idupdate);

        List<Account> acclst = [SELECT Id, Name, AnnualRevenue FROM Account WHERE Id =: idupdate];
        acclst[0].Name = nameUpdate;
        acclst[0].AnnualRevenue = annualRevenueUpdateINT;
        Update acclst;

        // Using The RestResponseWrapperPUT Wrapper for operation
        RestResponseWrapperPUT Restput = new RestResponseWrapperPUT(acclst[0]);
        System.debug(Restput);

        res.addHeader('Content-Type', 'application/json');
        res.statusCode = 200;
        res.responseBody =  Blob.valueOf(JSON.serialize(Restput));
        
      } catch (Exception ex) {
        res.statusCode=404;
        SalesforceError[] error = new SalesforceError[]{ 
            new SalesforceError('BAD_REQUEST', 'Please enter valid Account record Id')
        };

        res.addHeader('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(error));
        
      }

    // If the User is passing only body means it is an INSERT command
    }else if(input.length() != 18 && params.size() != null) {
      System.debug('Inside Insert Command');

      try {
        System.debug('Inside Insert Try Command');

        String nameUpdate = String.valueOf(params.get('Name'));
        System.debug(nameUpdate);
        String annualRevenueUpdate = String.valueOf(params.get('AnnualRevenue'));
        Integer annualRevenueUpdateINT = Integer.valueOf(annualRevenueUpdate);
        System.debug(annualRevenueUpdate);

        Account newAcc = new Account();
        newAcc.Name = nameUpdate;
        newAcc.AnnualRevenue = annualRevenueUpdateINT;
        Insert newAcc;
        System.debug(newAcc);

        String AccId = newAcc.Id;
        System.debug(AccId);

        List<Account> AccLST = [SELECT Id, Name , AnnualRevenue FROM Account WHERE Id =: AccId];

        // Using The RestResponseWrapperPOST Wrapper for operation
        RestResponseWrapperPOST RestPost = new RestResponseWrapperPOST (AccLST[0]);
        System.debug(RestPost);

        res.statusCode = 200;
        res.addHeader('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(RestPost));

      } catch (Exception ex) {
        res.statusCode=404;
        SalesforceError[] error = new SalesforceError[]{ 
            new SalesforceError('BAD_REQUEST', 'Please enter valid JSON Body')
        };

        res.addHeader('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(error));
        
      }
    }
  }
  // Wrapper Class to generate response JSON for GET request
  Public class RestResponseWrapperGET{
    public String AccountId {get;set;}
    public String Name {get;set;}
    public Decimal AnnualRevenue {get;set;}
    public String SuccessMsg {get;set;}

    public RestResponseWrapperGET(Account accWraplst ){
        SuccessMsg = 'Successfully fetched Account Record';
        AccountId = accWraplst.Id;
        Name = accWraplst.Name;
        AnnualRevenue = accWraplst.AnnualRevenue;     
    }
  }

  // Wrapper Class to generate response JSON for POST request
  Public class RestResponseWrapperPOST{
    public String AccountId {get;set;}
    public String Name {get;set;}
    public Decimal AnnualRevenue {get;set;}
    public String SuccessMsg {get;set;}

    public RestResponseWrapperPOST(Account accWraplst ){
        SuccessMsg = 'Successfully Created Account Record';
        AccountId = accWraplst.Id;
        Name = accWraplst.Name;
        AnnualRevenue = accWraplst.AnnualRevenue;     
    }
  }

  // Wrapper Class to generate response JSON for DELETE request
  Public class RestResponseWrapperDELETE{
    public String AccountId {get;set;}
    public String Name {get;set;}
    public Decimal AnnualRevenue {get;set;}
    public String SuccessMsg {get;set;}

    public RestResponseWrapperDELETE(Account accWraplst ){
        SuccessMsg = 'Successfully Deleted Selected Account Record';
        AccountId = accWraplst.Id;
        Name = accWraplst.Name;
        AnnualRevenue = accWraplst.AnnualRevenue;     
    }
  }

  // Wrapper Class to generate response JSON for PUT request
  Public class RestResponseWrapperPUT{
    public String AccountId {get;set;}
    public String Name {get;set;}
    public Decimal AnnualRevenue {get;set;}
    public String SuccessMsg {get;set;}

    public RestResponseWrapperPUT(Account accWraplst ){
        SuccessMsg = 'Successfully Updated Selected Account Record';
        AccountId = accWraplst.Id;
        Name = accWraplst.Name;
        AnnualRevenue = accWraplst.AnnualRevenue;     
    }
  }

  // Exception Handling Class 
  public class SalesforceError {
    public String errorCode;
    public String message;
    public SalesforceError(String errorCode, string message){
        this.errorCode = errorCode;
        this.message = message;
    }
} 

}