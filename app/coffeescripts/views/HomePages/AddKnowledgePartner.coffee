define [
  'Backbone'
  'jquery'
  'i18n!home_pages'
  'str/htmlEscape'
  'jst/HomePages/AddknowledgePartner'
], ({View},$,I18n,htmlEscape, template) ->

  class AddKnowledgePartner extends View
    template: template

    className: 'validated-form-view form-horizontal bootstrap-form'

    afterRender: ->
      super
      @$el.dialog
        title: 'Add knowledge Partner'
        width:  800
        height: 600
        close: => @$el.remove()