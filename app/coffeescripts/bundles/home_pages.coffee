require [
  'compiled/views/HomePages/IndexView'
  'compiled/collections/KnowledgePartnerCollection'
  'compiled/collections/LearnersReviewCollection'
  'compiled/views/HomePages/KnowledgePartnersCollectionView'
  'compiled/views/HomePages/LearnersReviewsCollectionView'
  ], (IndexView, KnowledgePartnerCollections,learnerReviewCollections,KnowledgePartnersCollectionView,LearnersReviewsCollectionView) ->


  # Collections
  KnowledegePartnerCollections = new KnowledgePartnerCollections
  LearnersReviewCollections = new LearnersReviewCollections

  # Views
  knowledgePartnersCollectionView =  new KnowledgePartnersCollectionView
  LearnersReviewCollectionView = new LearnersReviewsCollectionView

  @app = new IndexView
    knowledgePartnersView: knowledgePartnersCollectionView
    LearnersReveiewView: LearnersReviewCollectionView
    el: '#content'

  @app.render()
  KnowledegePartnerCollections.fetch()
  LearnersReviewCollections.fetch()
  #fetch all collection
