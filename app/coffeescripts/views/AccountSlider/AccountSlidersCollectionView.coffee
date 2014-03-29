define [
  'jquery'
  'str/htmlEscape'
  'jst/AccountSlider/AccountSlidersCollectionView'
  'compiled/views/AccountSlider/AccountSliderListView'
  'compiled/views/PaginatedCollectionView'
], ($, htmlEscape, template, AccountSliderListView, PaginatedCollectionView) ->

  class AccountSlidersCollectionView extends PaginatedCollectionView

    template: template
    itemView: AccountSliderListView