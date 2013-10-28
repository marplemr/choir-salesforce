public with sharing class ChoirController {
	public ChoirIO__Settings__c settings {get;set;}
	
	public ChoirController(){
        settings = ChoirIO__Settings__c.getOrgDefaults();
        if(settings == null) {
        	settings = new ChoirIO__Settings__c();
        }
    }
	public void sendTest() {
		
	}	

	public void save() {
		if(settings.id == null) {
			insert settings;
		} else {
			update settings;
		}
	}
}