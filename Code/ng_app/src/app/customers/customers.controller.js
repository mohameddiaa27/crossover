(function() {
	'use strict';

	angular
		.module('ngApp')
		.controller('CustomersController', CustomersController);

	/** @ngInject */
	function CustomersController($timeout, webDevTec, toastr, Customer, $log) {
		var vm = this;
		vm.filters = {};
		var updateCustomers = function() {
			vm.index = Customer.index(vm.filters);
		}

		updateCustomers();
	}
})();