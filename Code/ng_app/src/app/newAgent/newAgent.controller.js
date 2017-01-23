(function() {
	'use strict';

	angular
		.module('ngApp')
		.controller('NewAgentController', NewAgentController);

	/** @ngInject */
	function NewAgentController(Agent, toasty, ngDialog) {
		var vm = this;
		vm.agent = {
			name: '',
			email: '',
			password: ''
		};
		vm.create = function() {
			Agent.create(vm.agent).$promise.then(function(t) {
				toasty.success({
					title: 'Agent saved'
				});
				ngDialog.closeAll();
			}, function(t) {
				toasty.error({
					title: 'Failed to save'
				});
			});
		}
	}
})();