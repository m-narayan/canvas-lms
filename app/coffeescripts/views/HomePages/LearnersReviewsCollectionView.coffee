define [
  'jquery'
  'str/htmlEscape'
  'jst/HomePages/LearnersReviewCollectionView'
  'compiled/views/HomePages/LearnersReviewView'
  'compiled/views/PaginatedCollectionView'
], ($, htmlEscape, template, LearnersReview, PaginatedCollectionView) ->

  class LearnersReviewCollectionView extends PaginatedCollectionView

    template: template
    itemView: LearnersReview