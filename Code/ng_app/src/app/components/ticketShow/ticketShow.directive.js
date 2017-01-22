(function() {
  'use strict';

  angular
    .module('ngApp')
    .directive('ticketShow', ticketShow);

  /** @ngInject */
  function ticketShow() {
    var directive = {
      restrict: 'E',
      templateUrl: 'app/components/ticketShow/ticketShow.html',
      scope: {
        ticket: '=',
        tickets: '='
      },
      controller: TicketShowController,
      controllerAs: 'ts',
      bindToController: true
    };
    return directive;

    /** @ngInject */
    function TicketShowController(moment, $rootScope, Ticket, $log, toasty) {
      var vm = this;
      Ticket.show(vm.ticket).$promise.then(function(t){
        Ticket.updateAttrs(vm.ticket, t);
      });
      vm.newComment = {
        body: ''
      };

      vm.addComment = function() {
        if(!vm.newComment.body) {
          return toasty.error({
            title: 'Comment',
            msg: 'is too short'
          });
        }
        vm.newComment.ticket_id = vm.ticket.id;
        Ticket.addComment(vm.newComment).$promise.then(function(comment) {
          if (comment.id) {
            vm.ticket.comments.push(comment);
            vm.newComment = {};
          }
        });
      }
      vm.deleteComment = function(comment) {
        if (confirm("Are you sure you want to delete this comment?")) {
          Ticket.deleteComment(comment, vm.ticket.id).$promise.then(function(c) {
            if (comment.id == c.id) {
              var index = vm.ticket.comments.indexOf(comment);
              vm.ticket.comments.splice(index, 1);
              toasty.warning({
                title: 'Comment Deleted'
              });
            }
          });
        }
      }

      vm.updateStatus = function(status) {
        var tmpTicket = {
          status: status,
          id: vm.ticket.id
        };
        Ticket.update(tmpTicket).$promise.then(function(t) {
          Ticket.updateAttrs(vm.ticket ,t);
        });
      }

      vm.delete = function() {
        Ticket.destroy(vm.ticket, vm.ticket.id).$promise.then(function(t) {
          var index = vm.tickets.indexOf(vm.ticket);
          vm.tickets.splice(index, 1);
          toasty.warning({
            title: 'Ticket Deleted'
          });
        });
      }

    }
  }

})();