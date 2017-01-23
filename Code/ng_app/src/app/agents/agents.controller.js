(function() {
	'use strict';

	angular
		.module('ngApp')
		.controller('AgentsController', AgentsController);

	/** @ngInject */
	function AgentsController($timeout, webDevTec, toastr, Agent, ngDialog) {
		var vm = this;
		vm.filters = {};
		var updateAgents = function() {
			vm.index = Agent.index(vm.filters);
		}
		updateAgents();

	vm.newAgent = function() {
		ngDialog.open({
			template: 'app/newAgent/newAgent.html',
			controller: 'NewAgentController',
			controllerAs: 'an',
			width: '40%'
		});
	}
}
})();