define [
  'compiled/collections/PaginatedCollection'
  'compiled/models/AccountSlider'
], (PaginatedCollection, AccountSlider) ->

  class AccountSliderCollection extends PaginatedCollection
    model: AccountSlider