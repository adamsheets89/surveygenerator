public with sharing class surveyForm {
    public String namespace { get; set; }

    public surveyForm() {
        namespace = constants.NAMESPACE;
    }
    @AuraEnabled
    public static string getSurveyInfo(String recordId){
        responseData rd = new responseData();

        try {
            List<Question__c> surveyInfo = [SELECT Id, Name, Survey__c, 
                                           (SELECT Id, Name
                                           FROM Answers__r)
                                           From Question__c
                                           WHERE Survey__c =:recordId];

            rd.put('surveyInfo', surveyInfo);
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
            List<Object> surveyResponses = (List<Object>)params.get('surveyResponses');
            List<Survey_Response__c> resList = new List<Survey_Response__c>();

            Survey_History__c history = new Survey_History__c(
                Survey__c = recordId
            );
            insert history;

            String historyId = [SELECT Id
                                FROM Survey_History__c
                                WHERE Survey__c=:recordId].Id;

            for (Object o : surveyResponses) {
                Map<String,Object> surveyResponse = (Map<String,Object>)o;
                Survey_Response__c sr = new Survey_Response__c(
                    Answer__c = (String)surveyResponse.get('answer'),
                    Question__c = (String)surveyResponse.get('question'),
                    Survey_History__c = historyId
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