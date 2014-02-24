define [
  'jquery'
  'str/htmlEscape'
  'jst/CourseDescription/CourseDescriptionCollectionView'
  'compiled/views/CourseDescription/CourseDescriptionListView'
  'compiled/views/PaginatedCollectionView'
], ($, htmlEscape, template, CourseDescriptionListView, PaginatedCollectionView) ->

  class CourseDescriptionsCollectionView extends PaginatedCollectionView

    template: template
    itemView: CourseDescriptionListView
