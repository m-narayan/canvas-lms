define [
  'Backbone'
  'underscore'
], ({Model}, _) ->
  class AccountSlider extends Model

    resourceName: "account_sliders"

    urlRoot: -> "account_sliders"

    validate: (attrs) ->
      errors = {}
      errors unless _.isEmpty errors