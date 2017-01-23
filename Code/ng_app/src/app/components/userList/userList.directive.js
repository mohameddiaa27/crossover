(function() {
  'use strict';

  angular
    .module('ngApp')
    .directive('userList', userList);

  /** @ngInject */
  function userList() {
    var directive = {
      restrict: 'E',
      templateUrl: 'app/components/userList/userList.html',
      scope: {
        index: '=',
        type: '='
      },
      controller: UserListController,
      controllerAs: 'us',
      bindToController: true
    };
    return directive;

    /** @ngInject */
    function UserListController(moment, $rootScope, toasty, Customer, Agent) {
      var vm = this;

      vm.pendingFeature = function() {
        toasty.warning({
          title: 'This Feature',
          msg: 'is in development phase'
        });
      }

      vm.paginate = function(page) {
        var params = {
          page: vm.index.meta[page]
        };
        if (vm.type == 'customer') {
          vm.index = Customer.index(params);
        } else {
          vm.index = Agent.index(params);
        }
      }
    }
  }

})();