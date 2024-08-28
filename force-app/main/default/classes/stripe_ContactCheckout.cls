public with sharing class stripe_ContactCheckout {
    @InvocableMethod (label='Stripe Session Details' description='Will take inputs from Screen flow to maka an API Call' category='Stripe Integration' )
    //Defined the CheckoutURL as global in order to use pass the response URL in it and than retuen it to another class to use to redirect the user.
    public static List<OutputValues>  InvokeMethod(List<InputValues> inputList) {

        String AccountId =inputList[0].AccountId ;
        String ContactId =inputList[0].ContactId;
        String OrderId =inputList[0].OrderId;
        String ProductId =inputList[0].ProductId;
        String OrderProductId =inputList[0].OrderProductId;

        System.debug(AccountId);
        System.debug(ContactId);
        System.debug(OrderId);
        System.debug(ProductId);
        System.debug(OrderProductId);

        List<Contact> conlst = [SELECT Id, Name, Customer_ID__c, CurrencyIsoCode FROM Contact WHERE Id =: ContactId];
        String ConCurrency = conlst[0].CurrencyIsoCode;
        String CustomerID = conlst[0].Customer_ID__c;

        List<Product2> prodlst = [SELECT Id, Name FROM Product2 WHERE Id =: ProductId];
        String ProductName = prodlst[0].Name;

        List<OrderItem> orderprodlst = [SELECT Id, Quantity, UnitPrice  FROM OrderItem WHERE Id =: OrderProductId];
        Decimal Quantity = orderprodlst[0].Quantity;
        Integer Qunt = Integer.valueOf(Quantity);

        Decimal UnitPrice = orderprodlst[0].UnitPrice;
        Integer Unit_amount = Integer.valueOf(UnitPrice);

        List<OutputValues> outputList = new List<OutputValues>();
        // Defined a list of output to pass on the values back to flow 
        OutputValues output = new OutputValues();
        // Created an instance of output class to access its fields values and assign values from the returned string from another method
        String url = WebCallProduct(ConCurrency, CustomerID, ProductName, Qunt, Unit_amount );
        // stored the returned value from WebCallProduct method in url to use in further operations
        System.debug(url);
        output.CheckoutURL = url;
        // Provided the value of CheckoutURL field 
        outputList.add(output);
        // Added the field's value to list of output to pass on the values back to flow 
        // System.debug(CheckoutURL);
         return outputList;

    }
    public class InputValues{
        @InvocableVariable(label='AccountId')
        public String AccountId;
        @InvocableVariable(label='ContactId' )
        public String ContactId;
        @InvocableVariable(label='OrderId' ) 
        public String OrderId; 
        @InvocableVariable(label='ProductId' ) 
        public String ProductId;
        @InvocableVariable(label='OrderProductId' ) 
        public String OrderProductId;
        @InvocableVariable(label='inputURL')
        public String inputCheckoutURL;
    }
    public class OutputValues{
        @InvocableVariable(label='URL')
        public String CheckoutURL;
    }

    // @future (callout=true)
    public static String WebCallProduct(String ConCurrency, String CustomerID, String ProductName, Integer Qunt, Integer Unit_amount ) {
        System.debug('Debug of WebCall');
        String accessToken = 'sk_test_51MChKXSIWJ2ih3x9Lb1tF29N1qaTQ67FRYJA8do8fWxCH6KcjGAjpx7Dr1AnLgZKO4MGmSNDhy76TLqpdDfPhb64005LL4iYch';
        String stripe_ProductId;
        String stripe_PriceId;

        System.debug(ConCurrency);
        System.debug(CustomerID);
        System.debug(ProductName);
        System.debug(Qunt);
        System.debug(Unit_amount);

    /////////////////////////////////////////////////////////////////////////////////////////////////////
        Http httpProd = new Http();
        HttpRequest reqProd = new HttpRequest();
        HttpResponse resProd = new HttpResponse();
 
        String bodyProd ='&name='+ProductName; 
        reqProd.setBody(bodyProd);
        System.debug(bodyProd);

        reqProd.setEndpoint('https://api.stripe.com/v1/products');                  
        reqProd.setMethod('POST');
        reqProd.setHeader('Content-Type','application/x-www-form-urlencoded');
        reqProd.setHeader('Authorization','Bearer ' + accessToken );

        resProd = httpProd.send(reqProd);

        String responseBodyProd = resProd.getBody();
        
        System.debug('responseBodyProd:::' + responseBodyProd);
        if (resProd.getStatusCode() == 200) {
           
            Map <String, Object> resultProd = (Map<String,Object>) JSON.deserializeUntyped(resProd.getBody());
            System.debug( 'stripe_ProductId -- ' + resultProd.get('id'));
            stripe_ProductId = String.valueOf(resultProd.get('id'));
            
        }
    /////////////////////////////////////////////////////////////////////////////////////////////////////

        Http httpPrice = new Http();
        HttpRequest reqPrice = new HttpRequest();
        HttpResponse resPrice = new HttpResponse();
 
        String bodyPrice ='currency='+ConCurrency+'&product='+stripe_ProductId+'&unit_amount='+Unit_amount;
        reqPrice.setBody(bodyPrice);
        System.debug(bodyPrice);

        reqPrice.setEndpoint('https://api.stripe.com/v1/prices');                  
        reqPrice.setMethod('POST');
        reqPrice.setHeader('Content-Type','application/x-www-form-urlencoded');
        reqPrice.setHeader('Authorization','Bearer ' + accessToken );

        resPrice = httpPrice.send(reqPrice);

        String responseBodyPrice = resPrice.getBody();
        
        System.debug('responseBodyPrice:::' + responseBodyPrice);
        if (resPrice.getStatusCode() == 200) {
           
            Map <String, Object> resultPrice = (Map<String,Object>) JSON.deserializeUntyped(resPrice.getBody());
            System.debug( 'stripe_PriceId -- ' + resultPrice.get('id'));
            stripe_PriceId = String.valueOf(resultPrice.get('id'));
            
        }
    /////////////////////////////////////////////////////////////////////////////////////////////////////

        String Cancel_URL = 'https://getoncrmsolutions9-dev-ed.my.site.com/OrderCalcle/s/';
        String Success_URL = 'https://getoncrmsolutions9-dev-ed.my.site.com/OrderSuccess/s/';
        String Mode ='payment';
        String CheckoutURL;
        
        Http httpSession = new Http();
        HttpRequest reqSession = new HttpRequest();
        HttpResponse resSession = new HttpResponse();

        String bodySession ='cancel_url='+Cancel_URL+'&success_url='+Success_URL+'&customer='+CustomerID+'&mode='+Mode+'&line_items[0][price]='+stripe_PriceId+'&line_items[0][quantity]='+Qunt; 
        reqSession.setBody(bodySession);
        System.debug(bodySession);

        reqSession.setEndpoint('https://api.stripe.com/v1/checkout/sessions');                  
        reqSession.setMethod('POST');
        reqSession.setHeader('Content-Type','application/x-www-form-urlencoded');
        reqSession.setHeader('Authorization','Bearer ' + accessToken );

        resSession = httpSession.send(reqSession);

        String responseBodySession = resSession.getBody();
        
        System.debug('responseBodySession:::' + responseBodySession);
        if (resSession.getStatusCode() == 200) {
        
            Map <String, Object> resultSession = (Map<String,Object>) JSON.deserializeUntyped(resSession.getBody());
            CheckoutURL = String.valueOf(resultSession.get('url'));
            System.debug(CheckoutURL);
            
        }
        return CheckoutURL;
        // InvokeMethod(CheckoutURL);
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    
}