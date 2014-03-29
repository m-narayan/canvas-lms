define [
  'jquery'
  'i18n!account_sliders'
  'str/htmlEscape'
  'jst/AccountSlider/IndexView'
  'compiled/views/AccountSlider/AddAccountSlider'
  'compiled/views/AccountSlider/EditView'
  'compiled/models/AccountSlider'
], ($, I18n, htmlEscape, template, AddAccountSlider, EditView, AccountSlider) ->

  class IndexView extends Backbone.View

    @child 'accountslidersCollectionView', '[data-view=account_sliders]'

    template: template

    events:
      'click .add_tool_link': 'addAccountSliders'

    afterRender: ->
      @showAccountSlidersView()

    showAccountSlidersView: =>
      @accountslidersCollectionView.collection.fetch()
      @accountslidersCollectionView.show()

    addAccountSliders: ->
      newAccountSlider = new AccountSlider
      newAccountSlider.on  'sync', @onAccountSliderSync
      @addAccountSliderView = new AddAccountSlider
        model: newAccountSlider
      @addAccountSliderView.render()

    onAccountSliderSync: =>
      @addAccountSliderView.remove() if @addAccountSliderView
      @showAccountSlidersView()
      $.flashMessage(htmlEscape(I18n.t('account_slider_saved_message', "Account Slider details saved successfully!")))