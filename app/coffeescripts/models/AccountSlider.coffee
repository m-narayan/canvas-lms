define [
  'underscore'
  'Backbone'
], ( _, {Model}) ->

  class AccountSlider extends Model

    resourceName: "account_sliders"

    urlRoot: -> "account_sliders"

    validate: (attrs) ->
      errors = {}
      errors unless _.isEmpty errors