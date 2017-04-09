Config = require 'config'

module.exports = ->


  #--------------------------------------------------------------------------
  # Errors
  #--------------------------------------------------------------------------
  #
  # If you want to change / add errors for the Validator library, you can
  # do it here.
  #
  # @see http://gothamjs.io/documentation/1.0.0/validator#custom-error
  ##
  errors = {
    en_GB: ->
      this.en_US()
    en_US: ->
      Validator.errors
        min_length: 'The length of :attribute must be at least :value1 chars'
        birthday: ':attribute must be in this format: dd/mm/yyyy'
        confirmation: ':attribute doesn\'t match the confirmation'
    fr_FR: ->
      Validator.errors
        accepted: ':attribute doit être accepté.'
        alpha: ':attribute ne doit contenir que des lettres.'
        alpha_dash: ':attribute ne doit contenir que des lettres, nombres et tirets.'
        alpha_num: ':attribute ne doit contenir que des lettres et des nombres.'
        array: ':attribute doit être un array.'
        boolean: ':attribute doit être true ou false.'
        email: ':attribute doit être une adresse email valide.'
        in: ':attribute est invalide.'
        not_in: ':attribute est invalide.'
        length: ':attribute doit être de :value1 caractères.'
        number: ':attribute doit être un nombre.'
        required: ':attribute est requis.'
        min_length: ':attribute doit contenir au minimum :value1 caractères'
        birthday: ':attribute doit être de la forme dd/mm/yyyy'
        confirmation: ':attribute ne correspond pas à la confirmation'
  }

  locale = Config.locale()

  if _.has(errors, locale)
    errors[locale]()
  else
    errors.en_US()


  #--------------------------------------------------------------------------
  # Attributes
  #--------------------------------------------------------------------------
  #
  # If you want to change / add attributes for the Validator library, you can
  # do it here.
  #
  # @see http://gothamjs.io/documentation/1.0.0/validator#change-attributes
  ##
  attributes = {
    en_GB: ->
      this.en_US();
    en_US: ->
      Validator.attributes
        'classified[firstname]': 'firstname'
        'classified[lastname]': 'lastname'
        'classified[birthday]': 'birthday'
        'classified[description]': 'description'
        'classified[avatar]': 'avatar'
        'classified[phone]': 'firstname'
        'classified[email]': 'email'
        'classified[password]': 'password'
        'classified[password_confirmation]': 'password confirmation'
    fr_FR: ->
      Validator.attributes
        'classified[firstname]': 'prénom'
        'classified[lastname]': 'nom de famille'
        'classified[birthday]': 'anniversaire'
        'classified[description]': 'description'
        'classified[avatar]': 'photo de profil'
        'classified[phone]': 'téléphone'
        'classified[email]': 'email'
        'classified[password]': 'mot de passe'
        'classified[password_confirmation]': 'confirmation du mot de passe'
  }

  if _.has(attributes, locale)
    attributes[locale]()
  else
    attributes.en_US()


