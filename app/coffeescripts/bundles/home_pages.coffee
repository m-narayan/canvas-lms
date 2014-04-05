require [
  'compiled/views/HomePages/IndexView',
  'compiled/views/HomePages/KnowledgePartnersCollectionView'
  ], (IndexView, KnowledgePartnersCollectionView) ->


  # Collections


  # Views
  knowledgePartnersCollectionView =  new KnowledgePartnersCollectionView


  @app = new IndexView
    knowledgePartnersView: knowledgePartnersCollectionView
    el: '#content'

  @app.render()

  #fetch all collection
