({
    changeChildState : function(component, event, helper) {
        component.set('v.isChildExpanded', !component.get('v.isChildExpanded'));
    },
    navigateToRecord : function(component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
          "recordId": component.get('v.history.survey'),
        });
        navEvt.fire();
    }
})