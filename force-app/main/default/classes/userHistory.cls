public with sharing class userHistory {
    @AuraEnabled
    public static string getUserHistory(){
        responseData rd = new responseData();

        try {
            String userId = userinfo.getUserId();

            List<Survey_History__c> userSurveyList = [SELECT Id, Survey__c, Survey_Name__c, Name,
                                                     (SELECT Id, Question__c, Answer__c
                                                      FROM Survey_Responses__r)
                                                      FROM Survey_History__c
                                                      WHERE User__c=:userId
                                                      ORDER BY CreatedDate DESC];

            rd.put('userSurveyList', userSurveyList);
        } catch (Exception e) {
            rd.addError(e.getMessage());
        }
        return rd.getJsonString();
    }
}