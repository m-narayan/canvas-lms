define [
  'compiled/collections/PaginatedCollection'
  'compiled/models/CourseDescription'
], (PaginatedCollection, CourseDescription) ->

  class CoursePricingCollection extends PaginatedCollection
    model: CourseDescription