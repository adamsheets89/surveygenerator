({
    init : function(component, event, helper) {
        var action = component.get('c.getUserHistory');
        action.setCallback(this, function(response){
            var parsedRes = JSON.parse(response.getReturnValue());
            if (parsedRes.isSuccess){
                component.set('v.surveyHistory', parsedRes.results.userSurveyList);
            } else {
                console.log(parsedRes.error)
            }
        });
        $A.enqueueAction(action);
    },
})