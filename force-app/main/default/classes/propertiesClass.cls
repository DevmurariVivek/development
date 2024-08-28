public with sharing class propertiesClass {
    // Property definitions include one or two code blocks, representing a get accessor and a set accessor:
        // --The code in a get accessor executes when the property is read.
        // --The code in a set accessor executes when the property is assigned a new value.
    // If a property has only a get accessor, it’s considered read-only. If a property has only a set accessor, it’s considered write-only. A property with both accessors is considered read-write.

    // Properties can not be defined on Interfaces 

    public Static void propertiesClassMethod() {
        propertiesInnerClass PIC = new propertiesInnerClass();
        PIC.property= [SELECT Id,Name FROM Account WHERE Name LIKE 'AB%'];
        System.debug('property value---' +PIC.property);

    }

    // Defining an Inner class, this inner class will define the properties and these defined peroperties can than be utilized in outerclass (or any other class)
    public class propertiesInnerClass{
        public List<Account> property{
            get{return property;}
            set{property = value;}
        }
    }
}