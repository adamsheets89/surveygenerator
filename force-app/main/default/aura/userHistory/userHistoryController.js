({
    init : function(component, event, helper) {
        var action = component.get('c.getUserHistory');
        action.setCallback(this, function(response){
            var parsedRes = JSON.parse(response.getReturnValue());
            var surveys = parsedRes.results.surveys;
            console.log(JSON.stringify(surveys[0]));
            if (parsedRes.isSuccess){
                if (!$A.util.isEmpty(surveys)) {
                    component.set('v.surveyHistory', surveys);
                    component.set('v.user', surveys[0].user);
                } else {
                    //show toast
                    console.log('EMPTY');
                }
            } else {
                //show toast
                console.log(parsedRes.error)
            }
        });
        $A.enqueueAction(action);
    }
})