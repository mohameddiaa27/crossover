'use strict';

/**
 * @ngdoc service
 * @name ngAppApp.$tickets
 * @description
 * # $tickets
 * Factory in the ngAppApp.
 */
angular.module('ngApp')
  .factory('Agent', function($resource, $rootScope) {

    var baseUrl = 'http://localhost:3000/ng/v1/';
    var path = '/agents/:id.json';

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
      }
    };
  });