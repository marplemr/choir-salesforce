public with sharing class ChoirCallout {

    @future (callout=true)
    public static void sendNotification(String klass, String payload) {
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
 
        req.setEndpoint('http://requestb.in/1k50qwo1');
        req.setMethod('POST');
        req.setBody(klass+'='+EncodingUtil.urlEncode(payload, 'UTF-8'));
 
        try {
            res = http.send(req);
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e + res.toString());
        }
    }
}