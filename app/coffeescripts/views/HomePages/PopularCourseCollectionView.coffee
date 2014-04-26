define [
  'jquery'
  'jst/HomePages/PopularCourseCollectionView'
  'compiled/views/HomePages/PopularCourseView'
  'compiled/views/PaginatedCollectionView'
], ($, template, PopularCourseView, PaginatedCollectionView) ->

  class PopularCourseCollectionView extends PaginatedCollectionView

    template: template
    itemView: PopularCourseView