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
    @initCharsCount()

    @on 'keyup', '#offer_description', @changeCharsCount

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

  initCharsCount: =>

    @setCharsCount(0)

  changeCharsCount: =>

    count = $('#offer_description').val().length

    @setCharsCount(count)

  setCharsCount: (number) => 

    $chars = $('#chars')
    minimum = $chars.data('min')

    text = $chars.data('text-number') + ': ' + number + ' (' + $chars.data('text-minimum') + ': ' + minimum + ')'

    $chars.html text

    if number < minimum
      $chars.css('color', '#E3000E') # Red
    else
      $chars.css('color', '#71BA51') # Green



# Export
module.exports = OfferNew
