(function() {
	'use strict';

	angular
		.module('ngApp')
		.controller('AgentsController', AgentsController);

	/** @ngInject */
	function AgentsController($timeout, webDevTec, toastr, Agent) {
		var vm = this;
		vm.filters = {};
		var updateAgents = function() {
			vm.index = Agent.index(vm.filters);
		}
		updateAgents();
	}
})();