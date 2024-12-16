public with sharing class callCenterVFController {
    public List<PhoneFieldWrapper> phoneFields { get; private set; }
    private SObject record;
    
    public callCenterVFController(ApexPages.StandardController controller) {
        record = controller.getRecord();
        phoneFields = new List<PhoneFieldWrapper>();
        // Retrieve phone fields dynamically based on the SObject type
        populatePhoneFields();
    }

    private void populatePhoneFields() {
        Schema.SObjectType objType = record.getSObjectType();
        Map<String, Schema.SObjectField> fieldMap = objType.getDescribe().fields.getMap();

        for (String fieldName : fieldMap.keySet()) {
            if (fieldMap.get(fieldName).getDescribe().getType() == Schema.DisplayType.Phone) {
                Object fieldValue = record.get(fieldName);
                if (fieldValue != null) {
                    phoneFields.add(new PhoneFieldWrapper(fieldMap.get(fieldName).getDescribe().getLabel(), String.valueOf(fieldValue)));
                }
            }
        }
    }

    public class PhoneFieldWrapper {
        public String label { get; set; }
        public String value { get; set; }

        public PhoneFieldWrapper(String label, String value) {
            this.label = label;
            this.value = value;
        }
    }
}
