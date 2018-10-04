@isTest
public class tst_surveyForm {
    @isTest static void getSurveyInfoTest() {
        Survey__c s1 = new Survey__c(
        	Name = 'Favorite Food'
        );
        
        insert s1;
        
        Question__c q1 = new Question__c(
        	Name__c = 'What is your favorite Italian food?',
            Question_Number__c = 1,
            Survey__c = s1.Id
        );

        Question__c q2 = new Question__c(
        	Name__c = 'What is your favorite American food?',
            Question_Number__c = 2,
            Survey__c = s1.Id
        );
        
        List<Question__c> questions = new List<Question__c>{
            q1, q2
        };
 
        insert questions;
                
        Answer__c a1 = new Answer__c(
        	Name__c = 'Spaghetti',
            Answer_Number__c = 1,
            Question__c = q1.Id
        );
        
        Answer__c a2 = new Answer__c(
        	Name__c = 'Pizza',
            Answer_Number__c = 2,
            Question__c = q1.Id
        );
        
        Answer__c a3 = new Answer__c(
        	Name__c = 'Linguini',
            Answer_Number__c = 3,
            Question__c = q1.Id
        );
        
        Answer__c a4 = new Answer__c(
        	Name__c = 'Lasagna',
            Answer_Number__c = 4,
            Question__c = q1.Id
        );
        
        Answer__c a5 = new Answer__c(
        	Name__c = 'Hot dog',
            Answer_Number__c = 1,
            Question__c = q2.Id
        );
        
        Answer__c a6 = new Answer__c(
        	Name__c = 'Hamburger',
            Answer_Number__c = 2,
            Question__c = q2.Id
        );
        
        Answer__c a7 = new Answer__c(
        	Name__c = 'Grilled Cheese',
            Answer_Number__c = 3,
            Question__c = q2.Id
        );
        
        Answer__c a8 = new Answer__c(
        	Name__c = 'Sloppy Joe',
            Answer_Number__c = 4,
            Question__c = q2.Id
        );
        
        List<Answer__c> answers = new List<Answer__c>{
            a1, a2, a3, a4, a5, a6, a7, a8
        };

        insert answers;
       
        String recordId = s1.Id;
        
        Test.startTest();
        String response = surveyForm.getSurveyInfo(recordId);
        Test.stopTest();

        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
        Boolean isSuccess = (Boolean)responseMap.get('isSuccess');
        Map<String, Object> results = (Map<String,Object>)responseMap.get('results');
        List<Object> questionsWithAnswers = (List<Object>)results.get('questionsWithAnswers');
        String surveyName = (String)results.get('surveyName');
        System.assertEquals(true, isSuccess);
        System.assertEquals('Favorite Food', surveyName);
    }
    
    @isTest static void saveSurveyResponseTest(){
        Survey__c s1 = new Survey__c(
        	Name = 'Favorite Food'
        );
        
        insert s1;
        
        Map<Object,Object> responseOne = new Map<Object, Object>{
            'question' => 'What is your favorite Italian food?',
            'answer' => 'Pizza',
            'sequence' => 1
        };
        Map<Object,Object> responseTwo = new Map<Object, Object>{
            'question' => 'What is your favorite American food?',
            'answer' => 'Hot dog',
            'sequence' => 2
        };
        List<Object> surveyResponses = new List<Object>{
        	responseOne, responseTwo
        };
        Map<String, Object> params = new Map<String, Object>{
        	'surveyResponses' => surveyResponses,
            'surveyName' => s1.Name,
            'recordId' => s1.Id,
            'numberOfQuestions' => 2
        };
        
		String jsonString = JSON.serialize(params);

		Test.startTest();
        String response = surveyForm.saveSurveyResponse(jsonString);
        Test.stopTest();  
        
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
        Boolean isSuccess = (Boolean)responseMap.get('isSuccess');
        System.assertEquals(true, isSuccess);
    }
}