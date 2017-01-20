(function() {
  'use strict';

  angular
    .module('ngApp')
    .controller('SessionsController', SessionsController);

  /** @ngInject */
  function SessionsController($scope, $log, $state, ngTiddleAuthService, ngTiddleAuthProvider) {
    var vm = this

    vm.handleSignIn = function(loginForm){
      ngTiddleAuthService.sign_in_params = {}
      ngTiddleAuthService.signOut();
      ngTiddleAuthProvider.setModelName($state.current.name.replace("_login", ""));
      ngTiddleAuthService.signIn({ email: loginForm.email, password: loginForm.password} );
    }
  }
})();
