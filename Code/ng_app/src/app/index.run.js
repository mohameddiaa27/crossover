(function() {
	'use strict';

	angular
		.module('ngApp')
		.run(runBlock);

	/** @ngInject */
	function runBlock(ngTiddleAuthProvider, ngTiddleSessionService, $location, $log) {
		ngTiddleAuthProvider.setApiRoot('http://localhost:3000');
		ngTiddleAuthProvider.setApiResourcePath('auth');
		ngTiddleAuthProvider.setSignInStrategy('email');
		ngTiddleAuthProvider.setKeepLoggedIn('true');

		ngTiddleAuthProvider.onAuthorize = function(auth_data){
			$log.info(ngTiddleSessionService.getResource());
  		$location.path('/app/home');
		}
		ngTiddleAuthProvider.onUnauthorized = function(){$location.path('/login');}
	}

})();