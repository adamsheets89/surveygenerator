({
    init : function(component, event, helper) {
        var action = component.get('c.getSurveyHistory');
        action.setParams({
            recordId: component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            var parsedRes = JSON.parse(response.getReturnValue());
            if(parsedRes.isSuccess) {
                var surveyList = parsedRes.results.surveyList;
                surveyList.forEach(function(survey) {
                    survey.CreatedDate = new Date(survey.CreatedDate).getTime();
                    survey.Survey__r.CreatedDate = new Date(survey.Survey__r.CreatedDate).getTime();
                });
                component.set('v.surveyHistory', surveyList);
            } else {
                console.log(parsedRes.error);
            }
        });
        $A.enqueueAction(action);
    }
})
