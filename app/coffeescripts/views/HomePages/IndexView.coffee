define [
  'jquery'
  'i18n!home_pages'
  'jst/HomePages/IndexView'
  'compiled/views/HomePages/AddAccountSlider'
  'compiled/models/AccountSlider'
  'compiled/models/PopularCourse'
  'compiled/collections/AccountSlidersCollection'
  'compiled/views/HomePages/AccountSliderCollectionView'
  'compiled/views/HomePages/AddPopularCourse'
  'slider'
], ($, I18n, template, AddAccontSliders, AccountSlider, PopularCourse,
    AccountSliderCollection,AccountSliderCollectionView,AddPopularCourse) ->

  class IndexView extends Backbone.View

    @child 'accountSliderCollectionView',  '[data-view=sliders]'
    @child 'accountStatisticsView', '[data-view=accountStatistics]'
    @child 'popularCourseCollectionView', '[data-view=popularCourses]'

    template: template

    events:
      'click #add_account_sliders' : 'addAccountSlider'
      'click #add_popular_courses' : 'addPopularCourse'

    addAccountSlider: ->
      newAccountSliderView = new AccountSlider
      @addAccountSliderView = new AddAccontSliders
        model: newAccountSliderView
      @addAccountSliderView.render()

    addPopularCourse: ->
      newpopularCourse = new PopularCourse
      @addPopularCourseView = new AddPopularCourse
        model: newpopularCourse
      @addPopularCourseView.render()



