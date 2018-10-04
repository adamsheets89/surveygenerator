({
    init : function(component, event, helper) {
        var action = component.get('c.getSurveyInfo');
        action.setParams({ 
            recordId: component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            var parsedRes = JSON.parse(response.getReturnValue());
            if (parsedRes.isSuccess){
                var questionsWithAnswers = parsedRes.results.questionsWithAnswers;
                if (!$A.util.isEmpty(questionsWithAnswers)) {
                    component.set('v.questionsWithAnswers', questionsWithAnswers);
                    component.set('v.surveyName', parsedRes.results.surveyName);
                }
                component.set('v.isLoading', false);
            } else {
                helper.renderToast(component, {
                    message: parsedRes.error,
                    type: 'error',
                    mode: 'sticky'
				});
            }
        });
        $A.enqueueAction(action);
    },
    submitSurvey : function(component, event, helper) {
        var surveyResults = component.get('v.questionsWithAnswers');
        var recordId = component.get('v.recordId');
        var surveyResponses = [];
        var numberOfQuestions = 0;

        for (var i=0; i<surveyResults.length; i++) {
            numberOfQuestions++;
            var isAnswered = false;
            var answers = surveyResults[i].Answers__r.records
            for (var j=0; j<answers.length; j++) {
                var response = {
                    question: surveyResults[i].Name__c,
                    answer: '',
                    sequence: surveyResults[i].Question_Number__c
                };
                if (answers[j].isChecked === true) {
                    isAnswered = true;
                    response.answer = answers[j].Name__c;
                    surveyResponses.push(response);
                };
            }
            if (!isAnswered) {
                response.answer = "N/A";
                surveyResponses.push(response);
            };
        }
        var params = {
            surveyResponses : surveyResponses,
            surveyName : component.get('v.surveyName'),
            recordId : recordId,
            numberOfQuestions: numberOfQuestions
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
                helper.renderToast(component, {
                    message: parsedRes.error,
                    type: 'error',
                    mode: 'sticky'
				});s
            }
        });
        $A.enqueueAction(action);
    }
})