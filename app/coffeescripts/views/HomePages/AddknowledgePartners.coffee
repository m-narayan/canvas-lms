define [
  'jquery'
  'jst/HomePages/AddKnowledgePartnersView'
  'compiled/views/ValidatedFormView'
  'compiled/jquery/fixDialogButtons'
], ($, template, ValidatedFormView) ->

  class AddknowledgePartners extends ValidatedFormView
    template: template
    tagName: 'form'
    id: 'knowledge_partners_form'

    className: 'validated-form-view form-horizontal bootstrap-form'

    afterRender: ->
      super
      @$el.dialog
        title: 'Add Knowledge Partners'
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
      @$el.submit (e) =>
        @submit()
        return false
      this

    submit: ->
      this.$el.parent().find('.btn-primary').removeClass('ui-state-hover')
      super