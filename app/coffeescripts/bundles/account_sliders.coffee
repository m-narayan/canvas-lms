require [
  'compiled/collections/AccountSliderCollection',
  'compiled/views/AccountSlider/IndexView'
  'compiled/views/AccountSlider/AccountSlidersCollectionView'
], (AccountSliderCollection,IndexView,AccountSlidersCollectionView) ->

  #collection

  accountslidercollection = new AccountSliderCollection

  accountslidersCollectionView = new AccountSlidersCollectionView
    collection : accountslidercollection

  @app = new IndexView
    accountslidersCollectionView: accountslidersCollectionView
    el: '#account_sliders'

  @app.render()
  accountslidercollection.fetch()