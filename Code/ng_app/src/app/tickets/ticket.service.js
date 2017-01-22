'use strict';

/**
 * @ngdoc service
 * @name ngAppApp.$tickets
 * @description
 * # $tickets
 * Factory in the ngAppApp.
 */
angular.module('ngApp')
  .factory('Ticket', function($resource, $rootScope) {

    var baseUrl = 'http://localhost:3000/ng/v1/';
    var path_prefix = '/tickets/';
    var path = ':id.json';
    var comment_path = '/comments/:id.json'
    var ticketResource = function() {
      var url = baseUrl + $rootScope.currentUser.type + path_prefix + path;
      return $resource(url, null, {
        'update': {
          method: 'PUT'
        }
      });
    }

    var commentResource = function(ticket_id) {
      var url = baseUrl + $rootScope.currentUser.type + path_prefix + ticket_id + comment_path;
      return $resource(url);
    }

    // Public API here
    return {
      index: function(params) {
        return ticketResource().get(params);
      },
      show: function(ticket) {
        return ticketResource().get({
          id: ticket.id
        });
      },
      create: function(ticket) {
        return ticketResource().save({
          ticket: ticket
        }, function() {});
      },
      update: function(ticket) {
        return ticketResource().update({
          id: ticket.id
        }, {
          ticket: ticket
        });
      },
      destroy: function(ticket) {
        return ticketResource().delete({
          id: ticket.id
        });
      },
      addComment: function(newComment) {
        return commentResource(newComment.ticket_id).save({
          comment: newComment
        });
      },
      deleteComment: function(comment, ticket_id) {
        return commentResource(ticket_id).delete({
          id: comment.id
        });
      },
      updateAttrs: function(oldTicket, newTicket) {
        Object.keys(newTicket).forEach(function(key) {
          oldTicket[key] = newTicket[key];
        });
      }
    };
  });