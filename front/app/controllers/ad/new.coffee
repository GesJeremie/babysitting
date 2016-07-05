# Require the controller library of Gotham
Controller = require 'core/controller'


class AdNew extends Controller

  ##
  # Before
  #
  # Executed before the run action. You can use
  # @stop() in this method to stop the execution
  # of the controller
  #
  ##
  before: ->

    @on 'keyup', '#ad_description', @changeCharsCount

  ##
  # Run
  #
  # The main entry of the controller.
  # Your code start here
  #
  ##
  run: ->

    @initBirthdayMask()
    @initCharsCount()
    @initAutosize()

  ##
  # Init the mark birthday to help the user to format correctly his answer
  ##
  initBirthdayMask: =>

    $('#ad_birthday').inputmask('99/99/9999', {placeholder: "jj/mm/aaaa"})

  ##
  # Set the counter of chars to his initial state
  ##
  initCharsCount: =>

    length = $('#ad_description').val().length

    @setCharsCount(length)

  ##
  # When the description change
  ##
  changeCharsCount: =>

    count = $('#ad_description').val().length

    @setCharsCount(count)

  ##
  # Set a new state for the counter
  ##
  setCharsCount: (number) => 

    $chars = $('#chars')
    minimum = $chars.data('min')

    text = $chars.data('text-number') + ': ' + number + ' (' + $chars.data('text-minimum') + ': ' + minimum + ')'

    $chars.html text

    if number < minimum
      $chars.css('color', '#E3000E') # Red
    else
      $chars.css('color', '#71BA51') # Green

  ##
  # Will autoresize the description when the user write his description
  ##
  initAutosize: =>
    autosize($('#ad_description'))

# Export
module.exports = AdNew
