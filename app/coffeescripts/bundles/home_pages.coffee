require [
  'compiled/views/HomePages/IndexView'
  'compiled/collections/AccountSlidersCollection'
  'compiled/collections/PopularCoursesCollection'
  'compiled/views/HomePages/AccountSliderCollectionView'
  'compiled/views/HomePages/AccountStatisticsView'
  'compiled/views/HomePages/PopularCourseCollectionView'
], (IndexView,AccountSliderCollection,PopularCoursesCollection,AccountSliderCollectionView,AccountStatisticsView,
    PopularCourseCollectionView) ->

  # Collections

  accountSliderCollection = new AccountSliderCollection
  popularCourseCollection = new PopularCoursesCollection

  # Views
  accountSliderCollectionView = new AccountSliderCollectionView
    collection: accountSliderCollection
  accountStatisticsView = new AccountStatisticsView
  popularCourseCollectionView = new PopularCourseCollectionView
    collection: popularCourseCollection

  @app = new IndexView
    accountSliderCollectionView: accountSliderCollectionView
    accountStatisticsView: accountStatisticsView
    popularCourseCollectionView: popularCourseCollectionView
    el: '#content'

  @app.render()
  accountSliderCollection.fetch(
    success:->
      $("div#demo1").jContent
        orientation: "horizontal"
        easing: "easeOutCirc"
        duration: 500
        auto: true
        direction: "next" #or 'prev'
        pause: 1500
        pause_on_hover: true

      $("div#demo2").jContent
        orientation: "horizontal"
        easing: "easeOutCirc"
        duration: 500
        auto: true
        direction: "next" #or 'prev'
        pause: 1500
        pause_on_hover: true
  )
  popularCourseCollection.fetch()


