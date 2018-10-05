public with sharing class surveyForm {
    public String namespace { get; set; }

    public surveyForm(ApexPages.StandardController controller) {
        namespace = constants.NAMESPACE;
    }
    @AuraEnabled
    public static string getSurveyInfo(String recordId){
        responseData rd = new responseData();

        try {
            List<Question__c> questionsWithAnswers = [SELECT Id, Name__c, Survey__c, Survey__r.Name, Question_Number__c, 
                                                          (
                                                              SELECT Id, Name__c
                                                              FROM Answers__r
                                                              ORDER BY Answer_Number__c
                                                          )
                                                      FROM Question__c
                                                      WHERE Survey__c =:recordId
                                                      ORDER BY Question_Number__c];

            rd.put('questionsWithAnswers', questionsWithAnswers);
        } catch (Exception e) {
            rd.addError(e.getMessage());
        }
        return rd.getJsonString();
    }

    @AuraEnabled
    public static string saveSurveyResponse(String jsonString){
        responseData rd = new responseData();

        try {
            Map<String,Object> params = (Map <String, Object>)JSON.deserializeUntyped(jsonString);
            String recordId = (String)params.get('recordId');
            String surveyName = (String)params.get('surveyName');
            Integer numberOfQuestions = (Integer)params.get('numberOfQuestions');
            List<Object> surveyResponses = (List<Object>)params.get('surveyResponses');
            List<Survey_Response__c> resList = new List<Survey_Response__c>();

            Survey_History__c history = new Survey_History__c(
                Survey_Name__c = surveyName,
                Survey__c = recordId,
                Number_of_Questions__c = numberOfQuestions,
                User__c = userinfo.getUserId()
            );

            insert history;

            for (Object o : surveyResponses) {
                Map<String,Object> surveyResponse = (Map<String,Object>)o;
                Survey_Response__c sr = new Survey_Response__c(
                    Answer__c = (String)surveyResponse.get('answer'),
                    Question__c = (String)surveyResponse.get('question'),
                    Survey_History__c = history.Id,
                    Sequence__c = (Integer)surveyResponse.get('sequence')
                );
                resList.add(sr);
            }

            insert resList;

        } catch (Exception e) {
            rd.addError(e.getMessage());
        }
        return rd.getJsonString();
    }
}