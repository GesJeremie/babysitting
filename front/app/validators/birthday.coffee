#--------------------------------------------------------------------------
# Birthday
#--------------------------------------------------------------------------
#
##
Validator.rule 'birthday', (attribute, value, params) ->
  if value is undefined or value is ''
    return true

  validBirthday = /[0-9]{2}\/[0-9]{2}\/[0-9]{4}/

  if value.match(validBirthday)
    return true

  return false
