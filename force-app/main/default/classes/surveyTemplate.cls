public with sharing class surveyTemplate {
    public String namespace { get; set; }

    public surveyTemplate() {
        namespace = constants.NAMESPACE;
    }

    @AuraEnabled
    public static string saveSurvey(String jsonString){
      responseData rd = new responseData();

      try {

      } catch (Exception e) {
          
      }
      return rd.getJsonString();
    }
}

