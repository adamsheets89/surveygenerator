({
    init : function(component, event, helper) {
        var action = component.get('c.getSurveyInfo');
        action.setParams({ 
            recordId: component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            var parsedRes = JSON.parse(response.getReturnValue());
            if (parsedRes.isSuccess){
                component.set('v.questionswithAnswers', parsedRes.results.questionswithAnswers);
                component.set('v.surveyName', parsedRes.results.surveyName);
            } else {
                console.log(parsedRes.error);
            }
        });
        $A.enqueueAction(action);
    },

    submitSurvey : function(component, event, helper) {
        var surveyResults = component.get('v.questionswithAnswers');
        var recordId = component.get('v.recordId');
        var surveyResponses = [];

        for (var i=0; i<surveyResults.length; i++) {
            var response = {
                question: surveyResults[i].Name__c,
                answer: '',
                sequence: surveyResults[i].Question_Number__c
            };
            var answers = surveyResults[i].Answers__r.records
            for (var j=0; j<answers.length; j++) {
                if (answers[j].isChecked === true) {
                    response.answer = answers[j].Name__c;
                } 
            }
            surveyResponses.push(response)
        }

        var params = {
            surveyResponses : surveyResponses,
            surveyName : component.get('v.surveyName'),
            recordId : recordId
        };
        var action = component.get('c.saveSurveyResponse');
        action.setParams({
            jsonString: JSON.stringify(params)
        });
        action.setCallback(this, function(response){
            var parsedRes = JSON.parse(response.getReturnValue());
            if (parsedRes.isSuccess){
                var evt = sforce.one.navigateToSObject(recordId)
                evt.fire();
            } else {
                console.log(parsedRes.error)
            }
        });
        $A.enqueueAction(action);
    }
})