({
    clickCreateSurvey : function(component, event, helper) {
        console.log('line 3 id ', component.get('v.recordId'));
        var action = component.get('c.getSurveyTemplate');
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var parsedRes = JSON.parse(response.getReturnValue());
            var results = parsedRes.results.templateInfo;
            if (parsedRes.isSuccess) {
                component.set('v.surveyName', results.name);
                var numberOfQuestions = results.Number_of_Questions__c;
                var answersPerQuestions = results.Answers_Per_Question__c;
            } else {
                //error handle
            }
        });
        $A.enqueueAction(action);
    }
})
