@isTest
public class ChoirTriggerTest {
    public static testmethod void LeadTriggerTest() {
        // Use the mock so that no real callout is performed.
        Map<String, String> responseHeaders = new Map<String, String>{'Content-type'=>'application/json'}; 
        Test.setMock(HttpCalloutMock.class, new SingleRequestMock(200, 
                    'Complete', '{"status": "ok"}', responseHeaders));
        
        // First, add a new lead to test the insert trigger. 
        Lead lead = new Lead(FirstName='Macintosh', LastName='Dong', Company='Cat Corp');
        insert lead;
        
        // Next, let's update the lead to test the update trigger. 
        lead.Status = 'Unqualified';
        lead.Email = 'mac@cat.com';
        update lead;
        
        Lead lTest = [SELECT Id, Email FROM Lead WHERE Id=:lead.Id];
        system.assertEquals('mac@cat.com', lTest.Email);
    }
    
    public static testmethod void UserTriggerTest() {
        // Use the mock so that no real callout is performed.
        Map<String, String> responseHeaders = new Map<String, String>{'Content-type'=>'application/json'}; 
        Test.setMock(HttpCalloutMock.class, new SingleRequestMock(200, 
                    'Complete', '{"status": "ok"}', responseHeaders));
        
        Profile profile = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User user = new User(FirstName='Macintosh', LastName='Dong', 
            Alias='Mac', Email='mac@alexdong.com', 
            TimeZoneSidKey='America/Los_Angeles',
            LocaleSidKey='en_US',
            EmailEncodingKey='ISO-8859-1',
            LanguageLocaleKey='en_US',
            ProfileId=profile.Id,
            Username='mac@alexdong.com', 
            CommunityNickname='mac@alexdong.com');
        insert user;
        
        // Next, let's update the lead to test the update trigger. 
        user.Email = 'mac@cat.com';
        update user;
    }
    
    public static testmethod void CaseTriggerTest() {
        // Use the mock so that no real callout is performed.
        Map<String, String> responseHeaders = new Map<String, String>{'Content-type'=>'application/json'}; 
        Test.setMock(HttpCalloutMock.class, new SingleRequestMock(200, 
                    'Complete', '{"status": "ok"}', responseHeaders));
        
        Case acase = new Case(Subject='SNAFU', Priority='High');
        insert acase;
        
        // Next, let's update the lead to test the update trigger. 
        acase.Status = 'Closed';
        update acase;
    }
            
    public static testmethod void OpportunityTriggerTest() {
        // Use the mock so that no real callout is performed.
        Map<String, String> responseHeaders = new Map<String, String>{'Content-type'=>'application/json'}; 
        Test.setMock(HttpCalloutMock.class, new SingleRequestMock(200, 
                    'Complete', '{"status": "ok"}', responseHeaders));
        
        Opportunity chance = new Opportunity(Name='One more try', 
            StageName='Prospecting',
            CloseDate=Date.today());
        insert chance;
        
        chance.StageName = 'Negotiation/Review';
        update chance;
        
        chance.StageName = 'Closed lost';
        update chance;
    }
    
    public static testmethod void SendTest() {
        // Use the mock so that no real callout is performed.
        Map<String, String> responseHeaders = new Map<String, String>{'Content-type'=>'application/json'}; 
        Test.setMock(HttpCalloutMock.class, new SingleRequestMock(200, 
                    'Complete', '{"status": "ok"}', responseHeaders));
        
        ChoirController ctrl = new ChoirController();
        ctrl.sendTest();
        
        ctrl.settings.API_Key__c = 'blahblahblahblah';
        ctrl.save();
    }
}
