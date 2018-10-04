({
	renderToast: function(component, toast) {
	/*** TOAST ***/
	switch (toast.type) {
		case 'error':
			toast.iconName = 'utility:error';
			break;
		case 'warning':
			toast.iconName = 'utility:warning';
			break;
		case 'success':
			toast.iconName = 'utility:success';
			break;
		case 'info':
			toast.iconName = 'utility:info';
			break;
		default:
			toast.type = 'other';
			toast.iconName = toast.key;
		}

	component.set('v.toast', toast);

	if ('sticky' != toast.mode) {
		if ($A.util.isEmpty(toast.duration)) {
			toast.duration = 5000;
			}	

		setTimeout($A.getCallback(function() {
			component.set('v.toast', null);
			}), toast.duration);
		}
	/*** /TOAST ***/
	component.set('v.isLoading', false)
	}
})