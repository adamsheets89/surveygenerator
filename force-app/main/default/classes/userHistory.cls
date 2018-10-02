public with sharing class userHistory {
    @AuraEnabled
    public static string getUserHistory(){
        responseData rd = new responseData();

        try {
            String userId = userinfo.getUserId();

            List<Survey_History__c> userSurveyList = [SELECT Id, Survey__c, Survey_Name__c, Name, CreatedDate, 
                                                      Survey__r.CreatedDate, User__r.Name, Number_of_Questions__c,
                                                          (
                                                              SELECT Id, Question__c, Answer__c
                                                              FROM Survey_Responses__r
                                                              ORDER BY Sequence__c
                                                          )
                                                      FROM Survey_History__c
                                                      WHERE User__c=:userId
                                                      ORDER BY CreatedDate DESC];

            List<Object> surveys = new List<Object>();
            for (Survey_History__c sh : userSurveyList) {
                Map<Object, Object> userSurveyMap = new Map<Object, Object>{
                    'id' => sh.Id,
                    'survey' => sh.Survey__c,
                    'surveyName' => sh.Survey_Name__c,
                    'name' => sh.Name,
                    'createdDate' => sh.CreatedDate,
                    'surveyCreatedDate' => sh.Survey__r.CreatedDate,
                    'user' => sh.User__r.Name,
                    'numberOfQuestions' => sh.Number_of_Questions__c
                };
                Map<String, String> questionsWithAnswers = new Map<String, String>();
                for (Survey_Response__c sr : sh.Survey_Responses__r) {
                    String question = sr.Question__c;
                    String answer = sr.Answer__c;
                    if (!questionsWithAnswers.containsKey(question)) {
                        questionsWithAnswers.put(question, answer);
                    } else {
                        String answersString = questionsWithAnswers.get(question) + ', ' + answer;
                        questionsWithAnswers.put(question, answersString);
                    }                   
                }

                List<Object> questionsWithAnswersList = new List<Object>(); 
                Set<String> questionsSet = new Set<String>();
                List<String> answersList = new List<String>();
                questionsSet = questionsWithAnswers.keySet();
                answersList = questionsWithAnswers.values();

                for (String q : questionsSet) {
                    Map<String, String> formattedQuestionsWithAnswers = new Map<String, String>();
                    formattedQuestionsWithAnswers.put('question', q);
                    String a = questionsWithAnswers.get(q);
                    formattedQuestionsWithAnswers.put('answer', a);
                    questionsWithAnswersList.add(formattedQuestionsWithAnswers);
                }
                userSurveyMap.put('questionsWithAnswers', questionsWithAnswersList);
                surveys.add(userSurveyMap);
            }                                         
   
            rd.put('surveys', surveys);
        } catch (Exception e) {
            rd.addError(e.getMessage());
        }
        return rd.getJsonString();
    }
}