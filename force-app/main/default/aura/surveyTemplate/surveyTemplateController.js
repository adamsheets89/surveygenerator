({
    init : function(component, event, helper) {
        var action = component.get('c.getSurveyTemplate');
        console.log('line 4 id ', component.get("v.recordId"));
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var parsedRes = JSON.parse(response.getReturnValue());
            console.log('line 10 res ', JSON.stringify(parsedRes));
            if (parsedRes.isSuccess) {
                component.set('v.surveyName', parsedRes.results.surveyName);
                component.set('v.surveyDefault', parsedRes.results.surveyDefault);

            } else {
                //error handle
            }
        });
        $A.enqueueAction(action);
    },

    clickCreate : function(component, event, helper) {
        var surveyInfo = JSON.parse(JSON.stringify(component.get('v.surveyDefault')));
        var data = [];
        for (var i=0; i<surveyInfo.length; i++){
            var infoObject =  {
                question: surveyInfo[i].question,
                answers: {
                    answerOne : surveyInfo[i].answers.answerOne,
                    answerTwo : surveyInfo[i].answers.answerTwo,
                    answerThree : surveyInfo[i].answers.answerThree,
                    answerFour : surveyInfo[i].answers.answerFour
                }
            }
            data.push(infoObject);
        }
        var action = component.get('c.saveSurvey');
        var params = {
            data : data,
            recordId : component.get("v.recordId")
        }
        action.setParams({
            jsonString: JSON.stringify(params)
        });
        action.setCallback(this, function(response) {
            var parsedRes = JSON.parse(response.getReturnValue());
            console.log('parsedRes ', JSON.stringify(parsedRes));
            if (parsedRes.isSuccess) {
                var evt = $A.get("e.force:navigateToSObject");
                evt.setParams({
                    "recordId": component.get("v.recordId"),
                });
                evt.fire();
            } else {
                //error handle
            }
        });
        $A.enqueueAction(action);
    }
})
