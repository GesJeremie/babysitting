#--------------------------------------------------------------------------
# Boot
#--------------------------------------------------------------------------
#
# It's the right place to put some code to execute globally like
# the init of jQuery plugins, etc.
##
class Boot

  constructor: ->
    @setupNoty()
    @setupFlash()
    @setupAutosize()
    @setupConfirm()

  ##
  # Setup the base configuration of noty
  ##
  setupNoty: ->

    # Noty configuration
    $.noty.defaults.timeout = 2500
    $.noty.defaults.animation.open = 'animated flipInX'
    $.noty.defaults.animation.close = 'animated flipOutX'
    $.noty.defaults.maxVisible = 1
    $.noty.defaults.killer = true
    $.noty.defaults.dismissQueue = false

  ##
  # When a flash message is present in the DOM
  # let's display it in an noty alert
  ##
  setupFlash: ->

    # Flash system
    $flash = $('[data-flash]').filter (i, v) ->
      $(v).text() != ''

    if $flash.length
      type = $flash.first().data('flash')
      text = $flash.first().html()
      
      noty({
        type: type
        text: text
      })

  ##
  # Textarea suck. Let's improve them.
  ##
  setupAutosize: ->

    # Autosize textarea
    if $('.js-autosize').length
      autosize($('.js-autosize'))

  ##
  # Will display an alert confirmation if you click
  # on a data-confirm link
  ##
  setupConfirm: ->

    # Confirm
    $('[data-confirm]').each ->

      text = $(this).data('confirm')
      url = $(this).attr('href')

      $(this).on 'click', (e) ->

        e.preventDefault()

        swal({
          title: $('#app-config').data('confirm-title') || '',
          text: text
          type: 'warning',
          showCancelButton: true
        }, ->
          window.location.href = url
        )

module.exports = Boot
