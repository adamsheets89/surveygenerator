({
    init : function(component, event, helper) {
        var action = component.get('c.getUserHistory');
        action.setCallback(this, function(response){
            var parsedRes = JSON.parse(response.getReturnValue());
            if (parsedRes.isSuccess){
                var surveys = parsedRes.results.surveys;
                if (!$A.util.isEmpty(surveys)) {
                    component.set('v.surveyHistory', surveys);
                    component.set('v.user', surveys[0].user);
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
    }
})