# Require the controller library of Gotham
Controller = require 'core/controller'
Keenio = require 'helpers/keenio'

class Dashboard_Analytics_Index extends Controller

  ##
  # Before
  #
  # Executed before the run action. You can use
  # @stop() in this method to stop the execution
  # of the controller
  #
  ##
  before: ->

  ##
  # Run
  #
  # The main entry of the controller.
  # Your code start here
  #
  ##
  run: ->
    

# Export
module.exports = Dashboard_Analytics_Index
