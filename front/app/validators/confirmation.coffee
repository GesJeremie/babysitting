#--------------------------------------------------------------------------
# Birthday
#--------------------------------------------------------------------------
#
##
Validator.rule 'confirmation', (attribute, value, params) ->
  if value is undefined or value is ''
    return true

  matchValue = $(params[0]).val()

  if matchValue == value
    return true

  return false
