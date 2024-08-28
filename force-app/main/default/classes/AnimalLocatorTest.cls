@isTest
private class AnimalLocatorTest {
    @isTest static void getAnimalBYIdTest(){
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String result = AnimalLocator.getAnimalNameById(1);
        
        System.assertEquals('chicken', result);
        
    }

}