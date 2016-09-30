#--------------------------------------------------------------------------
# Initialize
#--------------------------------------------------------------------------
#
# It's the main entry of your gotham application. We will require the
# bootstrap file and run gotham.
##
Bootstrap = require 'core/bootstrap'



# Hey sir, is the document ready ?
$ ->

  ##
  # SmoothState
  #
  # Init smoothstate to avoid "blink" pages during transitions
  ##
  $('#main').smoothState({
    debug: true,
    scroll: true,
    blacklist: '.js-no-smoothstate',
    cacheLength: 0,
    forms: 'form',
    onStart: {
      duration: 0,
      render: ($container) ->
       # NProgress.start()
    },
    onAfter: ($container, $newContent) ->

      $('#main').smoothState().data('smoothState').clear()

      $('html, body').animate({ scrollTop: 0 }, 0);
      
      # Re run the js logic
      bootstrap = new Bootstrap()
      bootstrap.run()
  })

  # Yep ! We will run gotham !
  bootstrap = new Bootstrap()
  bootstrap.run()
