##
# Setup the base configuration of Noty
##
class Initializers_Noty

  init: ->
    $.noty.defaults.timeout = 2500
    $.noty.defaults.animation.open = 'animated flipInX'
    $.noty.defaults.animation.close = 'animated flipOutX'
    $.noty.defaults.maxVisible = 1
    $.noty.defaults.killer = true
    $.noty.defaults.dismissQueue = false

module.exports = Initializers_Noty
