({
    init : function(component, event, helper) {
        var action = component.get('c.getSurveyInfo');
        action.setParams({ 
            recordId: component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            var parsedRes = JSON.parse(response.getReturnValue());
            if (parsedRes.isSuccess){
                component.set('v.surveyInfo', parsedRes.results.surveyInfo);
            } else {
                console.log(parsedRes.error);
            }
        });
        $A.enqueueAction(action);
    },

    clickSubmitSurvey : function(component, event, helper) {
        
    }
})
