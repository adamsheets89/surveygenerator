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
                                           From Question__C
                                           WHERE Survey__c =:recordId];

            rd.put('surveyInfo', surveyInfo);
        } catch (Exception e) {
           
        }
        return rd.getJsonString();
    }
}
