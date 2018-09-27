({
    init : function(component, event, helper) {
        var action = component.get('c.getUserHistory');
        action.setCallback(this, function(response){
            var parsedRes = JSON.parse(response.getReturnValue());
            var userSurveyList = parsedRes.results.userSurveyList;
            if (parsedRes.isSuccess){
                if (!$A.util.isEmpty(userSurveyList)) {
                    component.set('v.surveyHistory', userSurveyList);
                    component.set('v.user', userSurveyList[0].User__r.Name);
                } else {
                    //show error toast
                    console.log('EMPTY');
                }
            } else {
                console.log(parsedRes.error)
            }
        });
        $A.enqueueAction(action);
    }
})