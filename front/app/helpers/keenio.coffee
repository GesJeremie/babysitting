Config = require 'config'

class Helpers_Keenio

    constructor: ->

        @keys = Config.keenio[Config.env()]

        @client = new Keen({
            projectId: @keys.projectId
            readKey: @keys.readKey
            })

module.exports = Helpers_Keenio
