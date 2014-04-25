require [
  'compiled/views/HomePages/IndexView'
  'compiled/collections/AccountSlidersCollection'
  'compiled/views/HomePages/AccountSliderCollectionView'
  'compiled/views/HomePages/AccountStatisticsView'
], (IndexView,AccountSliderCollection,AccountSliderCollectionView,AccountStatisticsView) ->

  # Collections

  accountSliderCollection = new AccountSliderCollection

  # Views
  accountSliderCollectionView = new AccountSliderCollectionView
    collection: accountSliderCollection
  accountStatisticsView = new AccountStatisticsView

  @app = new IndexView
    accountSliderCollectionView: accountSliderCollectionView
    accountStatisticsView: accountStatisticsView
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

