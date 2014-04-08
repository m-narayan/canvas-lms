define [
  'compiled/collections/PaginatedCollection'
  'compiled/models/KnowledgePartner'
], (PaginatedCollection, KnowledgePartner) ->

  class KnowledgePartnerCollection extends PaginatedCollection
    model: KnowledgePartner