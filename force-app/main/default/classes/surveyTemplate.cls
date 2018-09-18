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
            String name = (String)params.get('name');
            String q1 = (String)params.get('q1');
            String q2 = (String)params.get('q2');
            String q3 = (String)params.get('q3');
            String q4 = (String)params.get('q4');
            String q5 = (String)params.get('q5');

            Survey__c newSurvey = new Survey__c(
                Name = name
            );

            Question__c q = new Question__c(

            );
          
      } catch (Exception e) {
          
      }
      return rd.getJsonString();
    }

    @AuraEnabled
    public static string getSurveyTemplate(String recordId){
        responseData rd = new responseData();
        System.debug('line 38');
        try {
            List<Survey_Template__c> templateInfo = [SELECT Name, Number_of_Questions__c, Answers_Per_Question__c
                                                     FROM Survey_Template__c
                                                     WHERE Id = :recordId];
            System.debug('line 43 templateInfo ' + templateInfo);
            rd.put('templateInfo', templateInfo);                                        
        } catch (Exception e) { 
            rd.addError(e.getMessage());
        }
        return rd.getJsonString();
    }
}

