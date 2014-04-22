require [
  'compiled/views/HomePages/IndexView'
  'compiled/collections/AccountSlidersCollection'
  'compiled/views/HomePages/AccountSliderCollectionView'
], (IndexView,AccountSliderCollection,AccountSliderCollectionView) ->

  # Collections

  accountSliderCollection = new AccountSliderCollection

  # Views
  accountSliderCollectionView = new AccountSliderCollectionView
    collection: accountSliderCollection

  @app = new IndexView
    accountSliderCollectionView: accountSliderCollectionView
    el: '#content'

  @app.render()
  accountSliderCollection.fetch(
    success:->
      $("div#demo").jContent
        orientation: "horizontal"
        easing: "easeOutCirc"
        duration: 500
        auto: true
        direction: "next" #or 'prev'
        pause: 1500
        pause_on_hover: true
  )

