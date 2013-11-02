trigger Choir_Opportunity_trigger on Opportunity (after update) {
   // Container for the payload sent to the server. 
    List<Map<String, Object>> payloads = new List<Map<String, Object>>();
    
    // Pull all the user's information from database so that we can 
    // streamline queries and avoid governor limits. 
    List<SObject> modifiedrList =  [SELECT Id, Name, City, Country, Department, Division, CompanyName, Email, Phone 
        FROM User WHERE Id IN (SELECT LastModifiedById FROM Lead WHERE Id in :trigger.newMap.keySet())];
    Map<Id, SObject> modifiedrMap = new Map<Id, SObject>();
    for (SObject modifier: modifiedrList) {
        modifiedrMap.put(modifier.Id, modifier);
    }
    
    // Loop through each changed/inserted record. Pull the object
    // details into the payload. 
    for (Integer i = 0; i < trigger.size; i++) {
        Map<String, Object> payload = new Map<String, Object>();
        Opportunity curr = trigger.new[i];
        payload.put('user', modifiedrMap.get(curr.LastModifiedById));
        
        payload.put('curr', curr);
        payload.put('prev', trigger.old[i]);
        payload.put('is_update', true);
        payload.put('base_url', URL.getSalesforceBaseUrl().toExternalForm());
        payloads.add(payload);
    }
    
    // Convert the whole thing into a JSON and send it to server side.
    ChoirCallout.sendWebhookRequest('opportunity', JSON.serializePretty(payloads));
}
