@isTest
public class tst_surveyHistory {
    @isTest static void getSurveyHistoryTest() {
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
       
        Survey_History__c history1 = new Survey_History__c(
            Survey_Name__c = s1.Name,
            Survey__c = s1.Id,
            Number_of_Questions__c = 2,
            User__c = userinfo.getUserId()
        );

        Survey_History__c history2 = new Survey_History__c(
            Survey_Name__c = s1.Name,
            Survey__c = s1.Id,
            Number_of_Questions__c = 2,
            User__c = userinfo.getUserId()
        );

        insert history1;
        insert history2;

        Survey_Response__c sr1 = new Survey_Response__c(
            Answer__c = a1.Name__c,
            Question__c = q1.Name__c,
            Survey_History__c = history1.Id,
            Sequence__c = q1.Question_Number__c
        );

         Survey_Response__c sr2 = new Survey_Response__c(
            Answer__c = a2.Name__c,
            Question__c = q2.Name__c,
            Survey_History__c = history1.Id,
            Sequence__c = q2.Question_Number__c
        );

        Survey_Response__c sr3 = new Survey_Response__c(
            Answer__c = a3.Name__c,
            Question__c = q1.Name__c,
            Survey_History__c = history2.Id,
            Sequence__c = q1.Question_Number__c
        );

         Survey_Response__c sr4 = new Survey_Response__c(
            Answer__c = a4.Name__c,
            Question__c = q2.Name__c,
            Survey_History__c = history2.Id,
            Sequence__c = q2.Question_Number__c
        );

        List<Survey_Response__c > responses = new List<Survey_Response__c >{
            sr1, sr2, sr3, sr4
        };

        insert responses;

        String recordId = s1.Id;

        Test.startTest();
        String response = surveyHistory.getSurveyHistory(recordId);
        Test.stopTest();

        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);
        Boolean isSuccess = (Boolean)responseMap.get('isSuccess');

        System.assertEquals(true, isSuccess);
    }
}