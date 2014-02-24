define [
  'jquery'
  'i18n!course_descriptions'
  'str/htmlEscape'
  'jst/CourseDescription/IndexView'
 ], ($,I18n, htmlEscape, template) ->

  class IndexView extends Backbone.View

    @child 'courseDescriptionsCollectionView', '[data-view=course_descriptions]'

    template: template

    events:
      'click .add_tool_link': 'addCourseDescription'


    afterRender: ->
      @showCourseDescriptionView()

    showCourseDescriptionView: =>
      @courseDescriptionsCollectionView.collection.fetch()
      @courseDescriptionsCollectionView.show()