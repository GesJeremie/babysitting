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
    @setupStats()

  ##
  # Run
  #
  # The main entry of the controller.
  # Your code start here
  #
  ##
  run: ->

  setupStats: ->

    @showCount({
      eventCollection: 'classified.show_phone',
      timeframe: 'this_10_years',
      selector: 'total-show-phone',
      title: 'Total phone displayed (every cities)',
      filters: [
        {
          "operator": "exists",
          "property_name": "classified_id",
          "property_value": true
        },
        {
          "operator": "exists",
          "property_name": "tenant_id",
          "property_value": true
        }
      ]
    })

    # Display count show phone for each tenant
    _.each $('#app').data('tenants'), (name, id) =>
      @showCount({
        eventCollection: 'classified.show_phone',
        timeframe: 'this_10_years',
        selector: 'total-show-phone-' + name,
        title: 'Total phone displayed in ' + name,
        filters: [{
          "operator": "eq",
          "property_name": "tenant_id",
          "property_value": id
        }]
      })

  ##
  # Render metric count for the data provided
  ##
  showCount: (options) ->

    # Create block content where the graph will be injected
    $('#graphs').append('<div id="' + options.selector + '" class="grid-4 graph__item"></div>')

    query = new Keen.Query 'count', {
      eventCollection: options.eventCollection
      timeframe: options.timeframe,
      timezone: "UTC",
      filters: options.filters || []
    }

    new Keenio().client.draw(query, document.getElementById(options.selector), {
      title: options.title,
      colors: ['#897FBA']
    })

# Export
module.exports = Dashboard_Analytics_Index
