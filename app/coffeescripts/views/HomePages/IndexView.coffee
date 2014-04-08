define [
  'jquery'
  'i18n!knowledge_partners'
  'str/htmlEscape'
  'jst/HomePages/IndexView'
  'compiled/views/HomePages/AddknowledgePartners'
  'compiled/views/HomePages/AddLearnersReviews'
  'compiled/models/KnowledgePartner'
], ($, I18n, htmlEscape, template, AddknowledgePartner, AddLearnersReviews, KnowledgePartner) ->

  class IndexView extends Backbone.View

    @child 'knowledgePartnersView',  '[data-view=knowledgePartners]'
    @child 'LearnersReveiewView',    '[data-view=learnersReviews]'

    template: template

    events:
      'click #add_knowledge_partners' : 'addknowledgePartner'

    afterRender: ->
      @showAccountHeaderViews()

    showAccountHeaderViews: =>
      @knowledgePartnersView.collection.fetch()
      @knowledgePartnersView.show()

    addknowledgePartner: ->
      newKnowledgepartner = new KnowledgePartner
      newKnowledgepartner.on 'sync', @onKnowledgepartnerSync
      @addKnowledgePartnerView = new AddknowledgePartner
        model: newKnowledgepartner
      @addKnowledgePartnerView.render()

    onKnowledgepartnerSync: =>
      @addKnowledgePartnerView.remove() if @addKnowledgePartnerView
      @showAccountHeaderViews()
      $.flashMessage(htmlEscape(I18n.t('knowledge_partners_saved_message', "Knowledge Partners saved successfully!")))
