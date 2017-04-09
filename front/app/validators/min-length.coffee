#--------------------------------------------------------------------------
# Min Length
#--------------------------------------------------------------------------
#
##
Validator.rule 'min_length', (attribute, value, params) ->
  if value is undefined or value is ''
    return true

  length = value.toString().length

  if length >= params[0]
    return true

  return false
