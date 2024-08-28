@isTest
public with sharing class TemperatureConverterTest {
    @isTest static void testWarmTemp () {
        Decimal celsius = TemperatureConverter.fahrenheitToCelsius(70);
        System.assertEquals(21.11, celsius,'Fahrenheit to Celsius converted');
    }
}