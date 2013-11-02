trigger Choir_User_trigger on User (after insert) {
    // Container for the payload sent to the server.
    List<Map<String, Object>> payloads = new List<Map<String, Object>>();

    // Loop through each changed/inserted record. Pull the object
    // details into the payload.
    for (Integer i = 0; i < trigger.size; i++) {
        Map<String, Object> payload = new Map<String, Object>();
        User curr = trigger.new[i];

        payload.put('curr', curr);
        payload.put('is_update', false);
        payload.put('base_url', URL.getSalesforceBaseUrl().toExternalForm());
        payloads.add(payload);
    }

    // Convert the whole thing into a JSON and send it to server side.
    ChoirCallout.sendWebhookRequest('user', JSON.serializePretty(payloads));
}
