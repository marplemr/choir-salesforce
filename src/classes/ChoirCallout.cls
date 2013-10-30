public with sharing class ChoirCallout {

    public static String getAPIKey() {
        return ChoirIO__Settings__c.getOrgDefaults().API_Key__c;
    }

    @future (callout=true)
    public static void sendWebhookRequest(String klass, String payload) {
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
 
        req.setEndpoint('http://hooks.choir.io/' + getAPIKey() + '/salesforce');
        //req.setEndpoint('http://requestb.in/wckmpqwc');
        //req.setEndpoint('http://3znk.localtunnel.com/' + getAPIKey() + '/salesforce');
        req.setMethod('POST');
        req.setBody(klass+'='+EncodingUtil.urlEncode(payload, 'UTF-8'));
 
        try {
            res = http.send(req);
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e + res.toString());
        }
    }
    
    @future (callout=true)
    public static void sendDirectRequest(String sound, String label, String text) {
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        
        //req.setEndpoint('http://requestb.in/wckmpqwc');
        //req.setEndpoint('http://3znk.localtunnel.com/' + getAPIKey());
        req.setEndpoint('http://api.choir.io/' + getAPIKey());
        req.setMethod('POST');
        req.setBody('sound=' + EncodingUtil.urlEncode(sound, 'UTF-8') + 
            '&label=' + EncodingUtil.urlEncode(label, 'UTF-8')+
            '&text=' + EncodingUtil.urlEncode(text, 'UTF-8'));
 
        try {
            res = http.send(req);
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e + res.toString());
        }
    }
}
