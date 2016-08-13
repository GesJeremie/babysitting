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

        client = new Keenio().client

        Keen.ready ->

            query = new Keen.Query 'count', {
                eventCollection: 'classified.new'
                timeframe: 'this_10_years'
                timezone: 'UTC'
            };

            client.draw(query, document.getElementById('total-classified'), {
                title: 'Total Classified'
            })


# Export
module.exports = Dashboard_Analytics_Index
