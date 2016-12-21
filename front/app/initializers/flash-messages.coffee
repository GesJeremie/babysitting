##
# When a flash message is present in the DOM
# let's display it in a noty alert
##
class Initializers_FlashMessages

  init: ->

    # Flash system
    $flash =
      $('[data-flash]').filter (index, value) ->
        $(value).text() != ''

    unless $flash.length
      return

    type = $flash.first().data('flash')
    text = $flash.first().html()

    # Trigger the notification
    noty({
      type: type
      text: text
    })

module.exports = Initializers_FlashMessages
