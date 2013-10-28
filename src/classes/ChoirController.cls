public with sharing class ChoirController {
	public ChoirIO__Settings__c settings {get;set;}
	
	public ChoirController(){
        settings = ChoirIO__Settings__c.getOrgDefaults();
        if(settings == null) {
        	settings = new ChoirIO__Settings__c();
        }
    }
	public void sendTest() {
		ChoirCallout.sendTest('Choir.io for Salesforce has been installed successfully');
	}	

	public void save() {
		if(settings.id == null) {
			insert settings;
		} else {
			update settings;
		}
	}
}