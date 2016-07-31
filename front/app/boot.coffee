#--------------------------------------------------------------------------
# Boot
#--------------------------------------------------------------------------
#
# It's the right place to put some code to execute globally like 
# the init of jQuery plugins, etc.
##

# Noty configuration
$.noty.defaults.timeout = 2500
$.noty.defaults.animation.open = 'animated flipInX'
$.noty.defaults.animation.close = 'animated flipOutX'
$.noty.defaults.maxVisible = 1
$.noty.defaults.killer = true
$.noty.defaults.dismissQueue = false


# Flash system
if $('[data-flash]').length && $('[data-flash]').first().text() != ""

    $flash = $('[data-flash').first()
    type = $flash.data('flash')
    text = $flash.html()

    noty({
      type: type
      text: text
    })

