public with sharing class surveyHistory {
    @AuraEnabled
    public static string getSurveyHistory(String recordId){
        responseData rd = new responseData();
 
        try {
            List<Survey_History__c> surveyList = [SELECT Id, Survey__c, Survey_Name__c, Name, CreatedDate, Survey__r.CreatedDate, User__r.Name, Number_of_Questions__c,
                                                      (
                                                          SELECT Id, Question__c, Answer__c
                                                          FROM Survey_Responses__r
                                                          ORDER BY Sequence__c
                                                      )
                                                  FROM Survey_History__c
                                                  WHERE Survey__c=:recordId
                                                  ORDER BY CreatedDate DESC];
            System.debug('line 16 ' + surveyList);
            rd.put('surveyList', surveyList);
        } catch (Exception e) {
            rd.addError(e.getMessage());
        }
        return rd.getJsonString();
    }
}
