/* Running the test in Force.com IDE will show 100% coverage but 
	on the server side, we get error: "Methods defined as TestMethod do not support Web service callouts, test skipped". 
	http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_restful_http_testing_httpcalloutmock.htm 
*/

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
}