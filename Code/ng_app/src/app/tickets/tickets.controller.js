(function() {
	'use strict';

	angular
		.module('ngApp')
		.controller('TicketsController', TicketsController);

	/** @ngInject */
	function TicketsController($timeout, toastr, Ticket, ngDialog, pdfMake) {
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

		vm.newTicket = function() {
			ngDialog.open({
				template: 'app/newTicket/newTicket.html',
				controller: 'NewTicketController',
				controllerAs: 'tn',
				width: '60%'
			});
		}

		vm.exportPdf = function(){
			Ticket.lastMonth().$promise.then(function(ts){
				var docDefinition = Ticket.exportPdf(ts);
				pdfMake.createPdf(docDefinition).open();
			});
		}

		updateTickets();
	}
})();