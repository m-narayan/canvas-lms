define [
  'jquery'
  'jst/AccountSlider/AccountSliderList'
], ($, template) ->

  class AccountSliderListView extends Backbone.View

    template: template
    tagName: 'tr'
    className: 'account_sliders_item'

    afterRender: ->
      @$el.attr('id', 'account_sliders_' + @model.get('id'))
      this