public with sharing class ImagesPageController {
     
    @AuraEnabled
    public static List<ImageResponse> getImageRecords() {
        try {
            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setMethod('GET');
            httpRequest.setEndpoint('callout:ImagesEndpoint');
            Http http = new Http();
            HttpResponse httpResponse = http.send(httpRequest);
            return (List<ImageResponse>) JSON.deserialize(httpResponse.getBody(), List<ImageResponse>.class);
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
 
    public class ImageResponse {
        @AuraEnabled
        public Integer albumId { get; set; }
        @AuraEnabled
        public Integer id { get; set; }
        @AuraEnabled
        public String title { get; set; }
        @AuraEnabled
        public String url { get; set; }
        @AuraEnabled
        public String thumbnailUrl { get; set; }
    }
}