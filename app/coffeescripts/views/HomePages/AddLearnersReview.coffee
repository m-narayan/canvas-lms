define [
  'jquery'
  'jst/HomePages/AddLearnersReview'
  'compiled/views/ValidatedFormView'
  'compiled/jquery/fixDialogButtons'
  'jquery.instructure_date_and_time'
  'compiled/tinymce'
  'tinymce.editor_box'
], ($, template, ValidatedFormView) ->

  class AddknowledgePartners extends ValidatedFormView
    template: template
    tagName: 'form'
    id: 'learners_review_form'

    className: 'validated-form-view form-horizontal bootstrap-form'

    afterRender: ->
      super
      @$el.dialog
        title: 'Add Learners Review'
        width:  600
        height: "auto"
        resizable: true
        close: => @$el.remove()
        buttons: [
          class: "btn-primary"
          text:  'Submit'
          'data-text-while-loading': 'Saving...'
          click: => @submit()
        ]
      timeField = @$el.find(".date_field")
      timeField.date_field()
      editor = @$el.find(".rich_editor")
      editor.editorBox()
      setTimeout (->
        tinymce.execCommand "mceAddControl", true, "email_text"
        editor.editorBox()
      ), 0
      @$el.submit (e) =>
        @submit()
        return false
      this

    submit: ->
      this.$el.parent().find('.btn-primary').removeClass('ui-state-hover')
      super

