define [
  'jquery'
  'str/htmlEscape'
  'jst/HomePages/KnowledgePartnersCollectionView'
  'compiled/views/HomePages/KnowledgePartnerView'
  'compiled/views/PaginatedCollectionView'
], ($, htmlEscape, template, KnowledgePartnerView, PaginatedCollectionView) ->

  class KnowledgePartnersCollectionView extends PaginatedCollectionView

    template: template
    itemView: KnowledgePartnerView