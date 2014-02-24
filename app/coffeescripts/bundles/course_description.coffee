require [
  'compiled/collections/CourseDescriptionCollection',
  'compiled/views/CourseDescription/IndexView'
  'compiled/views/CourseDescription/CourseDescriptionsCollectionView'
], (CoursedescriptionCollection, IndexView, CourseDescriptionsCollectionView) ->

  # Collections

  courseDescriptionCollection = new CoursedescriptionCollection

  courseDescriptionsCollectionView = new CourseDescriptionsCollectionView
    collection: courseDescriptionCollection

  @app = new IndexView
    courseDescriptionsCollectionView: courseDescriptionsCollectionView
    el: '#course_descriptions'

  @app.render()
  courseDescriptionCollection.fetch()