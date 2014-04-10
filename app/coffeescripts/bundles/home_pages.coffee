require [
  'compiled/views/HomePages/IndexView'
  'compiled/collections/LearnerReviewCollection'
  'compiled/views/HomePages/LearnersReviewsCollectionView'
], (IndexView,LearnerReviewCollection,LearnersReviewsCollectionView) ->

  # Collections

  learnerReviewCollection = new LearnerReviewCollection

  # Views
  learnersReviewCollectionView = new LearnersReviewsCollectionView
    collection: learnerReviewCollection

  @app = new IndexView
    learnersReveiewView: learnersReviewCollectionView
    el: '#content'

  @app.render()
  learnerReviewCollection.fetch()
  #fetch all collection
