define [
  'Backbone'
  'jquery'
  'i18n!home_pages'
  'str/htmlEscape'
  'jst/HomePages/AddPopularCourse'
  'compiled/models/PopularCourse'
  'compiled/collections/PopularCoursesCollection'
  'compiled/views/HomePages/AccountCourseCollectionView'
], ({View},$,I18n,htmlEscape, template,PopularCoure,PopularCoursesCollection,AccountCourseCollectionView) ->

  class AddPopularCourse extends View
    template: template
    tagname:'form'
    id:'add_popular_course_form'

    events:
     'click .popular_course_item': 'addpopularcourse'

    className: 'validated-form-view form-horizontal bootstrap-form'

    afterRender: ->
      super
      @$el.dialog
        title: 'Add Popular Course'
        width:  1200
        height: 600
        close: => @$el.remove()
      @showallAccountCourses()

    showallAccountCourses: =>
      console.log('show account courses')
      popularCourseCollection = new PopularCoursesCollection
      accountCourseCollectionView = new AccountCourseCollectionView
        collection: popularCourseCollection
        el: '#all_courses'
      console.log(accountCourseCollectionView.collection)
      accountCourseCollectionView.collection.fetch()
      accountCourseCollectionView.render()

    onSaveFail: (xhr) =>
      super
      message = xhr.responseText
      @$el.prepend("<div class='alert alert-error'>#{message}</span>")

    onSuccess = (event) ->
      console.log("inside success event")
      $.flashMessage(htmlEscape(I18n.t('popular_courses_created_message', " Popular Courses Added Suceessfully!")))

    onError = => @onSaveFail()

    addpopularcourse:(event)->
      addpopularcourse = @$(event.currentTarget).closest('.popular_course_item').data('view')
      addpopularcourseitem = addpopularcourse.model
      id = addpopularcourseitem.id
      data =
        popular_course_data:
          popular_course_id: id
          account_id: ENV.account_id
      url = "api/v1/accounts/"+ENV.account_id+"/popular_courses"
      $.ajaxJSON url,'POST',data, onSuccess,onError

