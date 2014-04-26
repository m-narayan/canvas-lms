define [
  'jquery'
  'jst/HomePages/PopularCourseView'
  'i18n!home_pages'
], ($, template, I18n) ->

  class PopularCourseView extends Backbone.View

    template: template
    tagName: 'li'
    className: 'popular_course_item'

    afterRender: ->
      @$el.attr('id', 'popular_course_' + @model.get('id'))
      this