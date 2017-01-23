(function() {
	'use strict';

	angular
		.module('ngApp')
		.controller('NewTicketController', NewTicketController);

	/** @ngInject */
	function NewTicketController(Ticket, toasty, ngDialog) {
		var vm = this
		vm.ticket = {
			body: '',
			title: ''
		};
		vm.create = function() {
			Ticket.create(vm.ticket).$promise.then(function(t) {
				toasty.success({
					title: 'We recieved your ticket'
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