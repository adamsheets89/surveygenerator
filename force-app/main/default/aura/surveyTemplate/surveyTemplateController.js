({
    init : function(component, event, helper) {

    },

    clickCreate : function(component, event, helper) {
        var action = component.get('c.saveSurvey');
        var params = {
            name: component.get('v.name'),
            q1: component.get('v.q1'),
            q2: component.get('v.q2'),
            q3: component.get('v.q3'),
            q4: component.get('v.q4'),
            q5: component.get('v.q5')
        };
        action.setParams({
            jsonString: JSON.stringify(params)
        });
        action.setCallback(this, function(response) {
            var parsedRes = JSON.parse(response.getReturnValue());
            if (parsedRes.isSuccess) {

            } else {
                //error handle
            }
        });
        $A.enqueueAction(action);
    }
})
