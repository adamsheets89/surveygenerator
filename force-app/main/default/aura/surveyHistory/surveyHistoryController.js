({
    init : function(component, event, helper) {
        var action = component.get('c.getSurveyHistory');
        action.setParams({
            recordId: component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            var parsedRes = JSON.parse(response.getReturnValue());
            if(parsedRes.isSuccess) {
                component.set('v.surveyHistory', parsedRes.results.surveyList);

            } else {
                parsedRes.error
            }
        });
        $A.enqueueAction(action);
    }
})
