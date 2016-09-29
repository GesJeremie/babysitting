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

        Keen.ready =>

            @showCount({
                eventCollection: 'classified.new',
                timeframe: 'this_10_years',
                selector: 'total-classified',
                title: 'Total Classified'
            })


            @showCount({
                eventCollection: 'classified.new',
                timeframe: 'this_7_days',
                selector: 'total-classified-7-days',
                title: 'Added this week'
            })

            @showCount({
                eventCollection: 'classified.new',
                timeframe: 'this_1_days',
                selector: 'total-classified-today',
                title: 'Added today'
            })

            @showCount({
                eventCollection: 'show_phone',
                timeframe: 'this_10_years',
                selector: 'total-show-phone',
                title: 'Total phone shown (classified)'
            })
    
    showCount: (options) ->

        query = new Keen.Query 'count', {
            eventCollection: options.eventCollection
            timeframe: options.timeframe,
            timezone: "UTC"
        }

        new Keenio().client.draw(query, document.getElementById(options.selector), {
            title: options.title,
            colors: ['#897FBA']
        })
        





# Export
module.exports = Dashboard_Analytics_Index
