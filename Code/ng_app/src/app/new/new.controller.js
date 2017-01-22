(function() {
	'use strict';

	angular
		.module('ngApp')
		.controller('NewController', NewController);

	/** @ngInject */
	function NewController(Ticket, toasty, $state) {
		var vm = this
		vm.ticket = {
			body: '',
			title: ''
		};
		vm.create = function() {
			var err = false;
			if (vm.ticket.body.length < 10) {
				toasty.error({
					title: 'Details',
					msg: 'should me more descriptive'
				});
				err = true;
			}
			if (vm.ticket.title.length < 6) {
				toasty.error({
					title: 'Title',
					msg: 'is too short'
				});
				err = true;
			}
			if (err) {
				return
			}
			Ticket.create(vm.ticket).$promise.then(function(t) {
				toasty.success({
					title: 'We recieved your ticket'
				});
				$state.go('dashboard');
			}, function(t) {
				toasty.error({
					title: 'Failed to save'
				});
			});
		}
	}
})();