define [
  'jquery'
  'i18n!home_pages'
  'str/htmlEscape'
  'jst/HomePages/AddPopularCourse'
  'compiled/models/PopularCourse'
  'compiled/collections/PopularCoursesCollection'
  'compiled/views/HomePages/AccountCourseCollectionView'
  'compiled/views/ValidatedFormView'
  'jquery.disableWhileLoading'
  'jqueryui/jquery.jcontent.0.8',
  'jqueryui/jquery.easing.1.3'
], ($,I18n,htmlEscape, template,PopularCoure,PopularCoursesCollection,AccountCourseCollectionView,ValidatedFormView) ->

  class AddPopularCourse extends ValidatedFormView
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
      $.flashMessage(htmlEscape(I18n.t('popular_courses_created_message', " Popular Courses Added Suceessfully!")))

    onSuccessdelete = (event) ->
      $.flashMessage(htmlEscape(I18n.t('popular_courses_deleted_message', " Popular Courses Deleted Suceessfully!")))

    onError = => @onSaveFail()

    addpopularcourse:(event)->
      popularcourse = @$(event.currentTarget).closest('.popular_course_item').data('view')
      popularcourseitem = popularcourse.model
      if this.$(event.currentTarget.firstElementChild).attr('id') == "is_a_popular_course"
        popular_id = this.$(event.currentTarget.firstElementChild).attr('data-id')
        id = popular_id
      else
        id = popularcourseitem.id
      data =
        popular_course_data:
          popular_course_id: id
          account_id: ENV.account_id
      if this.$(event.currentTarget.firstElementChild).attr('id') == "is_a_popular_course"
        popular_id = this.$(event.currentTarget.firstElementChild).attr('data-id')
        console.log(popular_id)
        deletemsg = "Are you sure want to remove this Course from Popular Courses?"
        dialog = $("<div>#{deletemsg}</div>").dialog
          modal: true,
          resizable: false
          title: I18n.t('delete', 'Delete popular Course')
          buttons: [
            text: 'Cancel'
            click: => dialog.dialog 'close'
          ,
            text: 'Delete'
            click: =>
              url = "api/v1/accounts/"+ENV.account_id+"/popular_courses/"+ id
              console.log(url)
              @$el.disableWhileLoading($.ajaxJSON url, 'DELETE',data, onSuccessdelete,onError)
              dialog.dialog 'close'
              @showallAccountCourses()
          ]
      else
        url = "api/v1/accounts/"+ENV.account_id+"/popular_courses"
        @$el.disableWhileLoading($.ajaxJSON url,'POST',data, onSuccess,onError)
        @showallAccountCourses()