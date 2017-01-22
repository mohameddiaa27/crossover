(function() {
  'use strict';

  angular
    .module('ngApp')
    .controller('SessionsController', SessionsController);

  /** @ngInject */
  function SessionsController($scope, $log, $state, ngTiddleAuthService, ngTiddleAuthProvider, $rootScope) {
    var vm = this
    vm.modelName = $state.current.name.replace("_login", "");
    vm.handleSignIn = function(loginForm) {
      ngTiddleAuthService.sign_in_params = {}
      $rootScope.currentUser = null;
      ngTiddleAuthService.signOut();
      ngTiddleAuthProvider.setModelName(vm.modelName);
      ngTiddleAuthService.signIn({
        email: loginForm.email,
        password: loginForm.password
      });
    }
  }
})();