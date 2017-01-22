(function() {
	'use strict';

	angular
		.module('ngApp')
		.controller('TicketsController', TicketsController);

	/** @ngInject */
	function TicketsController($timeout, webDevTec, toastr, $log, Ticket) {
		var vm = this
		vm.filters = {
			status: 'all'
		};
		vm.tickets = [];
		var updateTickets = function() {
			vm.index = Ticket.index(vm.filters);
		}

		vm.filterStatus = function(status) {
			vm.filters.page = 1;
			vm.filters.status = status;
			updateTickets();
		}

		vm.paginate = function(page) {
			vm.filters.page = vm.index.meta[page];
			updateTickets();
		}

		vm.filterMine = function() {
			vm.filters.page = 1;
			if (vm.filters.status == 'initiated') {
				vm.filters.status = 'all';
			}
			updateTickets();
		}

		updateTickets();
	}
})();