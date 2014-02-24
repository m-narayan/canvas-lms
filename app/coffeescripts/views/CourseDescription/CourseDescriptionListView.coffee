define [
  'jquery'
  'jst/CourseDescription/CourseDescriptionList'
], ($, template) ->

  class CourseDescriptionListView extends Backbone.View

    template: template
    tagName: 'tr'
    className: 'course_descriptions_item'

    afterRender: ->
      @$el.attr('id', 'course_descriptions_' + @model.get('id'))
      this