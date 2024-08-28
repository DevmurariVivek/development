@IsTest
public with sharing class RestResourceExposedTest {

    @IsTest
    public static void testdoGetMethodAll() {

        Account acc = new Account();
        acc.Name = 'TestAccount';
        acc.AnnualRevenue = 1000.0;
        Insert acc;

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI ='https://getoncrmsolutions9-dev-ed.my.salesforce.com/services/apexrest/RestResourceExposed/Account/GetAll';
        request.httpMethod = 'GET';
        response.addHeader('Content-Type', 'application/json');

        RestContext.request = request;
        RestContext.response = response;
        request.requestBody = Blob.valueof(JSON.serialize(acc));
  
        RestResourceExposed.doGetMethod();
    }

    @IsTest
    public static void testdoGetMethodSingle(){

        Account acc = new Account();
        acc.Name = 'TestAccount';
        acc.AnnualRevenue = 1000.0;
        Insert acc;

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI ='https://getoncrmsolutions9-dev-ed.my.salesforce.com/services/apexrest/RestResourceExposed/Account/' + acc.Id;
        request.httpMethod = 'GET';
        response.addHeader('Content-Type', 'application/json');

        RestContext.request = request;
        RestContext.response = response;
        request.requestBody = Blob.valueof(JSON.serialize(acc));
  
        RestResourceExposed.doGetMethod();
    }

    @IsTest
    public static void testdoGetMethodAllExceptions() {
        Account acc = new Account();
        acc.Name = 'TestAccount';
        acc.AnnualRevenue = 1000.0;
        Insert acc;

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI ='https://getoncrmsolutions9-dev-ed.my.salesforce.com/services/apexrest/RestResourceExposed/Account/Invalid';
        request.httpMethod = 'GET';
        response.addHeader('Content-Type', 'application/json');

        RestContext.request = request;
        RestContext.response = response;
        request.requestBody = Blob.valueof(JSON.serialize(acc));
        
        RestResourceExposed.doGetMethod();

        System.assertEquals(404, response.statusCode);
    }

    @IsTest
    public static void testdoPostMethod() {
        Account acc = new Account();
        acc.Name = 'TestAccount';
        acc.AnnualRevenue = 1000.0;
        Insert acc;

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI ='https://getoncrmsolutions9-dev-ed.my.salesforce.com/services/apexrest/RestResourceExposed/Account/CreateAccount';
        request.httpMethod = 'POST';
        // request.responseBody = Blob.valueof(JSON.serialize(acc));
        response.addHeader('Content-Type', 'application/json');

        RestContext.request = request;
        RestContext.response = response;
        request.requestBody = Blob.valueof(JSON.serialize(acc));
    
        RestResourceExposed.doPostMethod();

        System.assertEquals(200, response.statusCode);
    }

    @IsTest
    public static void testdoDeleteMethod() {
        Account acc = new Account();
        acc.Name = 'TestAccount';
        acc.AnnualRevenue = 1000.0;
        insert acc;

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        // Map<String , String> responseMAp = new  Map<String , String>();
        // try {
        //     delete deleteAcc;
        //     responseMAp.put('200' , 'Records are Deleted');
        // } catch (DmlException ex) {
        //     responseMAp.put('404', 'Requested Record does not exist');
        // }

        request.requestURI ='https://getoncrmsolutions9-dev-ed.my.salesforce.com/services/apexrest/RestResourceExposed/Account/' + acc.Id;
        request.httpMethod = 'DELETE';
        // request.responseBody = Blob.valueof(JSON.serialize(acc));
        response.addHeader('Content-Type', 'application/json');

        Account deleteAcc = new Account();
        deleteAcc = [select id,name,AnnualRevenue from Account where Id =:acc.Id];

        RestContext.request = request;
        RestContext.response = response;
        response.statusCode =200;
        delete deleteAcc;
        request.requestBody = Blob.valueof(JSON.serialize(deleteAcc));
    
        RestResourceExposed.doDeleteMethod();

        System.assertEquals(200, response.statusCode);
    }

    @IsTest
    public static void testdoPutUpdateMethod() {
        Account acc = new Account();
        acc.Name = 'TestAccount';
        acc.AnnualRevenue = 1000.0;
        insert acc;

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI ='https://getoncrmsolutions9-dev-ed.my.salesforce.com/services/apexrest/RestResourceExposed/Account/' + acc.Id;
        request.httpMethod = 'PUT';
        response.addHeader('Content-Type', 'application/json');

        RestContext.request = request;
        RestContext.response = response;
        request.requestBody = Blob.valueof(JSON.serialize(acc));
    
        RestResourceExposed.doPutMethod();

        System.assertEquals(200, response.statusCode);
    }

    @IsTest
    public static void testdoPutInsertMethod() {
        Account acc = new Account();
        acc.Name = 'TestAccount';
        acc.AnnualRevenue = 1000.0;
        insert acc;

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI ='https://getoncrmsolutions9-dev-ed.my.salesforce.com/services/apexrest/RestResourceExposed/Account/';
        request.httpMethod = 'PUT';
        response.addHeader('Content-Type', 'application/json');

        RestContext.request = request;
        RestContext.response = response;
        request.requestBody = Blob.valueof(JSON.serialize(acc));
    
        RestResourceExposed.doPutMethod();

        System.assertEquals(200, response.statusCode);
    }




}