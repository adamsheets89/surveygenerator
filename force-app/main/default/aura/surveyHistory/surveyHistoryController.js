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
                component.set('v.surveyHistory', surveyList);
                component.set('v.surveyName', surveyList[0].surveyName);
            } else {
                console.log(parsedRes.error);
            }
        });
        $A.enqueueAction(action);
    },
    changeParentState : function(component, event, helper) {
        component.set('v.isParentExpanded', !component.get('v.isParentExpanded'));
    }
})
