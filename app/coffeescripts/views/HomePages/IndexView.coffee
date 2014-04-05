define [
  'jquery'
  'jst/HomePages/IndexView'
], ($,  template) ->

  class IndexView extends Backbone.View

    @child 'knowledgePartnersView',     '[data-view=knowledgePartners]'
