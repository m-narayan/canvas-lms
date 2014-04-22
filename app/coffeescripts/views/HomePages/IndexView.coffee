define [
  'jquery'
  'i18n!home_pages'
  'jst/HomePages/IndexView'
  'compiled/views/HomePages/AddAccountSlider'
  'compiled/models/AccountSlider'
  'compiled/collections/AccountSlidersCollection'
  'compiled/views/HomePages/AccountSliderCollectionView'
  'slider'
], ($, I18n, template, AddAccontSliders, AccountSlider,AccountSliderCollection,AccountSliderCollectionView) ->

  class IndexView extends Backbone.View

    @child 'accountSliderCollectionView',  '[data-view=sliders]'

    template: template

    events:
      'click #add_account_sliders' : 'addAccountSlider'

    addAccountSlider: ->
      newAccountSliderView = new AccountSlider
      @addAccountSliderView = new AddAccontSliders
        model: newAccountSliderView
      @addAccountSliderView.render()




