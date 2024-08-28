public class Spoonacular {
    private static final String SPOONACULAR_API = 'https://api.spoonacular.com';
    private static final String API_KEY ='4c0814c7326d430f942daa62ea947436';
    
    public static void getRandomReceipe(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API+'/recipes/random?apiKey='+API_KEY);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('respose code' +response.getStatusCode());
        if(response.getStatusCode() == 200)
        {
        system.debug('response' + response.getBody());
        }
    }

		public static void getReceipeByIngredients(String ingredients){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API+'/recipes/findByIngredients?apiKey='+API_KEY+ '&ingredients=' +ingredients);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('respose code' +response.getStatusCode());
        if(response.getStatusCode() == 200)
        {
        system.debug('response' + response.getBody());
        }
}
        public static void getRandomReceipeInformation(String receipeId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API+'/recipes/'+receipeId+'/information?apiKey='+API_KEY);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('respose code' +response.getStatusCode());
        if(response.getStatusCode() == 200)
        {
        system.debug('response' + response.getBody());
        }
    }
}