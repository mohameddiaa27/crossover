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
        index: '='
      },
      controller: UserListController,
      controllerAs: 'us',
      bindToController: true
    };
    return directive;

    /** @ngInject */
    function UserListController(moment, $rootScope) {
      var vm = this;
    }
  }

})();
