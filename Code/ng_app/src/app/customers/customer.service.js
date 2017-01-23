'use strict';

/**
 * @ngdoc service
 * @name ngAppApp.$tickets
 * @description
 * # $tickets
 * Factory in the ngAppApp.
 */
angular.module('ngApp')
  .factory('Customer', function($resource, $rootScope) {

    var baseUrl = 'http://localhost:3000/ng/v1/';
    var path = '/customers/:id.json';

    var resource = function() {
      var url = baseUrl + $rootScope.currentUser.type + path;
      return $resource(url, null, {
        'update': {
          method: 'PUT'
        }
      });
    }

    // Public API here
    return {
      index: function(params) {
        return resource().get(params, function() {});
      },
      create: function(customer) {
        var res = $resource('http://localhost:3000/auth');
        return res.save({
          customer: customer
        }, function() {});
      },
    };
  });