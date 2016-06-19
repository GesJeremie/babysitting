# Require the controller library of Gotham
Controller = require 'core/controller'


class OfferNew extends Controller

  ##
  # Before
  #
  # Executed before the run action. You can use
  # @stop() in this method to stop the execution
  # of the controller
  #
  ##
  before: ->

    @initBirthdayMask()

  ##
  # Run
  #
  # The main entry of the controller.
  # Your code start here
  #
  ##
  run: ->

  initBirthdayMask: =>

    console.log $('#offer_birthday').inputmask('99/99/9999', {placeholder: "jj/mm/aaaa"})

# Export
module.exports = OfferNew
