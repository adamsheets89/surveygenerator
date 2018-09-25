public with sharing class surveyHistory {
    @AuraEnabled
    public static string getSurveyHistory(String recordId){
        responseData rd = new responseData();
        System.debug('line 5 id ' + recordId);
        try {
            List<Survey_History__c> surveyList = [SELECT Id, Name,
                                                 (SELECT Id, Question__c, Answer__c
                                                  FROM Survey_Responses__r)
                                                  FROM Survey_History__c
                                                  WHERE Survey__c=:recordId
                                                  ORDER BY CreatedDate DESC];
            System.debug('line 13 list ' + surveyList);
            rd.put('surveyList', surveyList);
        } catch (Exception e) {
            rd.addError(e.getMessage());
        }
        return rd.getJsonString();
    }
}
