// SaveToCaseDescriptionController.cls
public class SaveToCaseDescriptionController {
    @AuraEnabled
    public static void saveCaseRecord(String InputValue) {
        System.debug(InputValue);
    }
}