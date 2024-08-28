public with sharing class ClickupAutomation {
    @InvocableMethod (label='ClickupAutomation' description='Will be used to automate clickup process on project' category='Project')
    public static List<Outputlist> GetCall(List<Inputlist> iplist) {

        // Fetching Access Token from Client Id, Client Secret and Code
        String AccToken;
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://api.clickup.com/api/v2/oauth/token?client_id='+'P0SDRH09GJO3IPE5B531QND2TDCR3E0W'+'&client_secret='+'LOP7UV1UQQ0WFNX6CPQ5IPP64LMR37BYE1PFSKR0AAS7UG8PQYKAATXUT7WRCZVU'+'&code='+'4Y73G4W7H34YVOQAVPR88B50KX9KF9T9');

        HttpResponse res = new HttpResponse();
        res = http.send(req);
        String getAccessTokenBody = res.getBody();
        System.debug('getAccessTokenBody:::' + getAccessTokenBody);
        System.debug('ResponseStatus:::' + res.getStatusCode());

        if (res.getStatusCode() == 200) {

            Map <String, Object> AccesstokenMap = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            System.debug( ' MAP --' + AccesstokenMap.get('access_token'));
            AccToken = String.valueOf(AccesstokenMap.get('access_token'));
        }

        // Fetching the TeamId (Workspace Id)
        req.setMethod('POST');
        req.setEndpoint('');
        res = http.send(req);
        String getTeamBody = res.getBody();
        System.debug('getAccessTokenBody:::' + getAccessTokenBody);
        System.debug('ResponseStatus:::' + res.getStatusCode());


        // Calling another method for further callout
        ClickupAutomation.PostCall(AccToken);
        List<Outputlist> oplist = new List<Outputlist>();
        return oplist;

    }
    public static void PostCall(String AccToken) {

    }

    public class Inputlist{
        @InvocableVariable (label='Name' required=true)
        public String pName;

    }
    public class Outputlist{
        @InvocableVariable (label='Output')
        public String output;
        
    }
}