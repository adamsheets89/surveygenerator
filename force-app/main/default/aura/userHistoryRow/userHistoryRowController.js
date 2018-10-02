({
    changeState : function(component, event, helper) {
        component.set('v.isExpanded', !component.get('v.isExpanded'));
    },
    navigateToRecord : function(component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
          "recordId": component.get('v.history.survey'),
        });
        navEvt.fire();
    }
})