define [
  'jquery'
  'jst/HomePages/AddPopularCourse'
  'jst/HomePages/AddPopularCourse'
  'compiled/jquery/fixDialogButtons'
  'compiled'

], ($, template) ->

  class AddPopularCourse extends ValidatedFormView
    template: template
    tagname:'form'
    id:'add_popular_course_form'

    className: 'validated-form-view form-horizontal bootstrap-form'

    afterRender: ->
      super
      @$el.dialog
        title: 'Add Account Slider'
        width:  650
        height: 600
        close: => @$el.remove()
      @showallAccountCourses()

    showallAccountCourses: =>
      accountSliderCollection = new AccountSliderCollection
      totalaccountSliderCollectionView = new TotalAccountSliderCollectionView
        collection: accountSliderCollection
        el: '#all_sliders'
      totalaccountSliderCollectionView.collection.fetch()
      totalaccountSliderCollectionView.render()
