(function() {
  'use strict';

  angular
    .module('ngApp')
    .directive('acmeNavbar', acmeNavbar);

  /** @ngInject */
  function acmeNavbar() {
    var directive = {
      restrict: 'E',
      templateUrl: 'app/components/navbar/navbar.html',
      scope: {
          creationDate: '='
      },
      controller: NavbarController,
      controllerAs: 'vm',
      bindToController: true
    };

    return directive;

    /** @ngInject */
    function NavbarController(moment, $rootScope, ngTiddleAuthService, toasty) {
      var vm = this;
      vm.handleSignOut = function(){
        ngTiddleAuthService.signOut();
        $rootScope.endSession();
        toasty.warning({
          title: 'Signed Out !!',
          msg: 'Happy to serve you'
        });
      }
    }
  }

})();
