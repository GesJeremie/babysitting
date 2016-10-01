# Require the controller library of Gotham
Controller = require 'core/controller'
Keenio = require 'helpers/keenio'


class Classified_Show extends Controller

    ##
    # Before
    #
    # Executed before the run action. You can use
    # @stop() in this method to stop the execution
    # of the controller
    #
    ##
    before: ->

        @on 'click', '#show-phone', @onShowPhone

    ##
    # Run
    #
    # The main entry of the controller.
    # Your code start here
    #
    ##
    run: ->

      # Send event new show classified
      client = new Keenio().client.addEvent("classified.show", {
        classified_id: $('#app').data('classified')
      })

    ##
    # Display full phone
    ##
    onShowPhone: ->

      # Display phone
      $phone = $('#phone')
      $phone.html($phone.data('phone'))

      # Remove button
      $(this).remove()

      # Send event keen.io
      client = new Keenio().client.addEvent("classified.show_phone", {
        classified_id: $('#app').data('classified')
      })


# Export
module.exports = Classified_Show
