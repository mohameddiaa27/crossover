(function() {
  'use strict';

  angular
    .module('ngApp')
    .config(routerConfig);

  /** @ngInject */
  function routerConfig($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'app/main/main.html',
        controller: 'MainController',
        controllerAs: 'main'
      })
      .state('admin_login', {
        url: '/admin/login',
        templateUrl: 'app/sessions/login.html',
        controller: 'SessionsController',
        controllerAs: 'sessions'
      })
      .state('agent_login', {
        url: '/agent/login',
        templateUrl: 'app/sessions/login.html',
        controller: 'SessionsController',
        controllerAs: 'sessions'
      })
      .state('customer_login', {
        url: '/login',
        templateUrl: 'app/sessions/login.html',
        controller: 'SessionsController',
        controllerAs: 'sessions'
      })
      ;

    $urlRouterProvider.otherwise('/');
  }

})();
