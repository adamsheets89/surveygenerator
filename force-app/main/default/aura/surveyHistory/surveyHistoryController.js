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
                if (!$A.util.isEmpty(surveyList)) {
                    component.set('v.surveyHistory', surveyList);
                    component.set('v.surveyName', surveyList[0].surveyName);
                } 
                component.set('v.isLoading', false);
            } else {
                component.set('v.toast', {
                    message: parsedRes.error,
                    type: 'error',
                    iconName: 'utility:error'
                });
            }
        });
        $A.enqueueAction(action);
    },
    changeParentState : function(component, event, helper) {
        component.set('v.isParentExpanded', !component.get('v.isParentExpanded'));
    }
})