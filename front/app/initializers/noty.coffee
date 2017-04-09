##
# Setup the base configuration of Noty
##
class Initializers_Noty

  init: ->
    $.noty.defaults.timeout = 3000
    $.noty.defaults.animation.open = 'animated flipInX'
    $.noty.defaults.animation.close = 'animated flipOutX'
    $.noty.defaults.maxVisible = 1
    $.noty.defaults.killer = true
    $.noty.defaults.dismissQueue = true

module.exports = Initializers_Noty
