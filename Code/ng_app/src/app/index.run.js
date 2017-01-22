(function() {
	'use strict';

	angular
		.module('ngApp')
		.run(runBlock);

	/** @ngInject */
	function runBlock(ngTiddleAuthProvider, ngTiddleSessionService, $location, $log, $http, $state, $rootScope, $cookies, toasty) {

		var type = $cookies.getObject('type');
		$rootScope.endSession = function() {
			$rootScope.currentUser = null;
			if (type) {
				$state.go(type + '_login');
				$cookies.remove('type');
			} else {
				$state.go('customer_login');
			}
		};

		ngTiddleAuthProvider.setApiRoot('http://localhost:3000');
		ngTiddleAuthProvider.setApiResourcePath('auth');
		ngTiddleAuthProvider.setSignInStrategy('email');
		ngTiddleAuthProvider.setKeepLoggedIn('true');
		if (type) {
			ngTiddleAuthProvider.setModelName(type);
		}
		$rootScope.currentUser = ngTiddleSessionService.getResource();

		if (!$rootScope.currentUser && $state.current.name.indexOf("_login") !== -1) {
			$rootScope.endSession();
		}

		ngTiddleAuthProvider.onAuthorize = function(auth_data) {
			$rootScope.currentUser = ngTiddleSessionService.getResource();
			$cookies.putObject('type', $rootScope.currentUser.type);
			$log.info($cookies.getObject('type'));
			$rootScope.token = auth_data.token
			$state.go("dashboard");
			toasty.success({
            title: 'Welcome Back!',
            msg: $rootScope.currentUser.name
      });
		}
		ngTiddleAuthProvider.onUnauthorized = function() {
			$rootScope.endSession();
		}

	}

})();