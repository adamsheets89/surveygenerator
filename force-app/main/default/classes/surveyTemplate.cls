public with sharing class surveyTemplate {
    public String namespace { get; set; }

    public surveyTemplate() {
        namespace = constants.NAMESPACE;
    }

    @AuraEnabled
    public static string saveSurvey(String jsonString){
        responseData rd = new responseData();

        try {
            Map<String,Object> params = (Map <String, Object>)JSON.deserializeUntyped(jsonString);
            List<Object> objects = (List<Object>)params.get('data');
            List<Question__c> questions = new List<Question__c>();
            List<Answer__c> answers = new List<Answer__c>();
            String recordId = (String)params.get('recordId');

            for (Object o : objects) {
                Map<String,Object> objectMap = (Map<String,Object>)o;
                Map<String,Object> answersMap = (Map<String,Object>)objectMap.get('answers');
                Question__c q = new Question__c(
                    Name = (String)objectMap.get('question'),
                    Survey__c = recordId);
                
                Answer__c a1 = new Answer__c(
                    Name = (String)answersMap.get('answerOne'),
                    Survey__c = recordId);

                Answer__c a2 = new Answer__c(
                    Name = (String)answersMap.get('answerTwo'),
                    Survey__c = recordId);

                Answer__c a3 = new Answer__c(
                    Name = (String)answersMap.get('answerThree'),
                    Survey__c = recordId);

                Answer__c a4 = new Answer__c(
                    Name = (String)answersMap.get('answerFour'),
                    Survey__c = recordId);
                
                questions.add(q);
                answers.add(a1);
                answers.add(a2);
                answers.add(a3);
                answers.add(a4);
            }
            insert questions;
            insert answers;
          
      } catch (Exception e) {
          rd.addError(e.getMessage());
      }
      return rd.getJsonString();
    }

    @AuraEnabled
    public static string getSurveyTemplate(String recordId){
        responseData rd = new responseData();

        try {
            String surveyName = [SELECT Name
                                 FROM Survey__c
                                 WHERE Id = :recordId].Name;
            
            rd.put('surveyName', surveyName); 
            rd.put('surveyDefault', surveyDefault);                                     
        } catch (Exception e) { 
            rd.addError(e.getMessage());
        }
        return rd.getJsonString();
    }

    private static Map<String, String> answersList = new Map<String, String>{
        'answerOne' => '', 
        'answerTwo' => '', 
        'answerThree' => '', 
        'answerFour' => ''
    };

    private static Map<String, Object> questionOneMap = new Map<String, Object>{
        'question' => '',
        'answers' => answersList
    };

    private static Map<String, Object> questionTwoMap = new Map<String, Object>{
        'question' => '',
        'answers' => answersList
    };

    private static Map<String, Object> questionThreeMap = new Map<String, Object>{
        'question' => '',
        'answers' => answersList
    };

    private static Map<String, Object> questionFourMap = new Map<String, Object>{
        'question' => '',
        'answers' => answersList
    };

    private static List<Map<String, Object>> surveyDefault = new List<Map<String, Object>>{
        questionOneMap, questionTwoMap, questionThreeMap, questionFourMap
    };
}