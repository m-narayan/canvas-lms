define [
  'compiled/collections/PaginatedCollection'
  'compiled/models/LearnerReview'
], (PaginatedCollection, LearnerReview) ->

  class LearnersReviewCollection extends PaginatedCollection
    model: LearnerReview