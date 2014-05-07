define [
  'jquery'
  'jst/HomePages/KnowledgePartnerView'
  'i18n!home_pages'
], ($, template, I18n) ->

  class KnowledgePartnerView extends Backbone.View

    template: template
    tagName: 'li'
    className: 'knowledge_partners_item span3'

    afterRender: ->
      @$el.attr('id', 'knowledge_partner_' + @model.get('id'))
      this