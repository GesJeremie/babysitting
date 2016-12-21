##
# Textarea suck. Let's improve them.
##
class Initializers_Confirm

  init: ->
    @events()

  events: ->
    $('[data-confirm]').on 'click', @displayAlert

  displayAlert: (e) ->
    e.preventDefault()

    text = $(this).data('confirm')
    url = $(this).attr('href')

    swal({
      title: $('#app-config').data('confirm-title') || '',
      text: text
      type: 'warning',
      showCancelButton: true
    }, ->
      window.location.href = url
    )


module.exports = Initializers_Confirm
