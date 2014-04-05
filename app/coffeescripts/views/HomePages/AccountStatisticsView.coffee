define [
  'jquery'
  'jst/HomePages/AccountStatistics'
], ($, template, I18n) ->

  class AccountStatisticsView extends Backbone.View

    initialize: (options) ->
      @account_courses_count = options.account_courses_count


    toJSON: ->

      json = super
      json['account_courses_count'] = @account_courses_count
      json


