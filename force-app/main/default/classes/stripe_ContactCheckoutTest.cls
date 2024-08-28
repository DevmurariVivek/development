@isTest
public class stripe_ContactCheckoutTest {
    @isTest
    static void testInvokeMethod() {
        // Create test records
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;
        
        Contact testContact = new Contact(
            FirstName='Test',
            LastName='Contact',
            AccountId=testAccount.Id,
            CurrencyIsoCode='USD',
            Customer_ID__c='cus_test'
        );
        insert testContact;
        
        Product2 testProduct = new Product2(Name='Test Product');
        insert testProduct;
        
        Order testOrder = new Order(
            AccountId=testAccount.Id,
            //ContactId=testContact.Id,
            CurrencyIsoCode='USD',
            Status='Draft'
        );
        insert testOrder;
        
        OrderItem testOrderItem = new OrderItem(
            OrderId=testOrder.Id,
            Product2Id=testProduct.Id,
            Quantity=1,
            UnitPrice=10
        );
        insert testOrderItem;
        
        // Call the InvokeMethod method
        List<stripe_ContactCheckout.InputValues> inputList = new List<stripe_ContactCheckout.InputValues>();
       /* inputList.add(new stripe_ContactCheckout.InputValues(
            AccountId=testAccount.Id,
            ContactId=testContact.Id,
            OrderId=testOrder.Id,
            ProductId=testProduct.Id,
            OrderProductId=testOrderItem.Id
        ));*/
        
        Test.startTest();
        stripe_ContactCheckout.InvokeMethod(inputList);
        Test.stopTest();
        
        // Verify that the method was called successfully
        // and that the correct values were passed to the method
        List<Contact> conlst = [SELECT Id, Name, Customer_ID__c, CurrencyIsoCode FROM Contact WHERE Id =: testContact.Id];
        String ConCurrency = conlst[0].CurrencyIsoCode;
        String CustomerID = conlst[0].Customer_ID__c;
        
        List<Product2> prodlst = [SELECT Id, Name FROM Product2 WHERE Id =: testProduct.Id];
        String ProductName = prodlst[0].Name;
        
        List<OrderItem> orderprodlst = [SELECT Id, Quantity, UnitPrice  FROM OrderItem WHERE Id =: testOrderItem.Id];
        Decimal Quantity = orderprodlst[0].Quantity;
        Integer Qunt = Integer.valueOf(Quantity);
        
        Decimal UnitPrice = orderprodlst[0].UnitPrice;
        Integer Unit_amount = Integer.valueOf(UnitPrice);
        
        System.assertEquals(testContact.CurrencyIsoCode, ConCurrency);
        System.assertEquals(testContact.Customer_ID__c, CustomerID);
        System.assertEquals(testProduct.Name, ProductName);
        System.assertEquals(testOrderItem.Quantity, Qunt);
        System.assertEquals(testOrderItem.UnitPrice, Unit_amount);
    }
    
}