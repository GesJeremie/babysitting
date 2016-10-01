#--------------------------------------------------------------------------
# Initialize
#--------------------------------------------------------------------------
#
# It's the main entry of your gotham application. We will require the
# bootstrap file and run gotham.
##
Bootstrap = require 'core/bootstrap'

boot = ->
  bootstrap = new Bootstrap()
  bootstrap.run()

# Hey sir, is the document ready ?
$ ->

  ##
  # SmoothState
  #
  # Init smoothstate to avoid "blink" pages during transitions
  ##
  $('#main').smoothState({
    debug: true
    blacklist: '.js-no-smoothstate'
    cacheLength: 0
    forms: 'form'
    onStart: {
      duration: 0,
      render: ($container) ->
        NProgress.start()
    }
    onAfter: ($container, $newContent) ->

      NProgress.done()

      # Let's clear the cache (else the form are fucked up.)
      $('#main').smoothState().data('smoothState').clear()

      # Let's scroll back to the top
      $('html, body').animate({ scrollTop: 0 }, 0);
      
      # The content just changed
      # let's reboot.
      boot()
  })

  # Let's boot
  boot()