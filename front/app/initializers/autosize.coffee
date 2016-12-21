##
# Textarea suck. Let's improve them.
##
class Initializers_Autosize

  init: ->
    $autosize = $('.js-autosize')

    unless $autosize.length
      return

    autosize($autosize)

module.exports = Initializers_Autosize
