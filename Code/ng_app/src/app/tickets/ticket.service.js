'use strict';

/**
 * @ngdoc service
 * @name ngAppApp.$tickets
 * @description
 * # $tickets
 * Factory in the ngAppApp.
 */
angular.module('ngApp')
  .factory('Ticket', function($resource, $rootScope, moment) {

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
      lastMonth: function() {
        return $resource(baseUrl + $rootScope.currentUser.type + path_prefix + 'last_month.json').query();
      },
      updateAttrs: function(oldTicket, newTicket) {
        Object.keys(newTicket).forEach(function(key) {
          oldTicket[key] = newTicket[key];
        });
      },
      exportPdf: function(ticks) {
        var title1 = {
          text: 'Report',
          style: 'header'
        };
        var sec3 = {
          text: 'This report includes all the closed tickets.',
          style: 'pStyle'
        };
        var sec1 = {
          text: 'Summary',
          style: 'HStyle'
        };
        var sec2 = {
          // to treat a paragraph as a bulleted list, set an array of items under the ul key
          ul: [
            'Month: ' + moment().subtract(1, 'months').format('MMMM'),
            'Agent: ' + $rootScope.currentUser.name,
            'Tickets Solved: ' + ticks.length
          ]
        };
        var sec4 = {
          layout: 'lightHorizontalLines', // optional
          table: {
            headerRows: 1,
            widths: ['*', 'auto', 'auto', 'auto'],
            body: [
              ['Id', 'Title', 'Customer', 'Closed At']
            ]
          }
        };

        var docDefinition = {
          content: [title1, sec1, sec2, sec3, sec4],
          styles: {
            header: {
              fontSize: 22,
              bold: true,
              alignment: 'center'
            },
            HStyle: {
              alignment: 'left',
              fontSize: 16,
              bold: true,
            },
            pStyle: {
              italics: true,
              alignment: 'left',
              margin: 5
            }
          }
        };
        ticks.forEach(function(t) {
          var date = moment(t.closed_at).format('DD-MMM-YYYY');
          var tr = [t.id, t.title, t.customer.name, date];
          docDefinition.content[4].table.body.push(tr);
        });
        return docDefinition;
      }
    };
  });