# Require the controller library of Gotham
Controller = require 'core/controller'
Config = require 'config'

class Classified_New extends Controller

  ##
  # Before
  #
  # Executed before the run action. You can use
  # @stop() in this method to stop the execution
  # of the controller
  #
  ##
  before: ->

    @on 'keyup', '#classified_description', @changeCharsCount
    @on 'submit', '#classified-form', @onSubmitForm

  ##
  # Run
  #
  # The main entry of the controller.
  # Your code start here
  #
  ##
  run: ->

    @initBirthdayMask()
    @initCharsCount()
    @initAutosize()

  ##
  # When classified form is submitted
  ##
  onSubmitForm: (e) =>
    e.preventDefault()

    $this = $(e.currentTarget)
    e.preventDefault()

    this.eraseErrorsForm()

    validation = new Validator()
    validation.make(this.dataForm(), this.rulesForm())

    if validation.fails()
      this.showErrorsForm(validation)
      return

    if $('#app').data('is-tenant-bordeaux')
      this.askPayment()
      return

    this.submitFormBackend()

  ##
  # Open the stripe modal to ask for the card
  # details of the customer
  ##
  askPayment: =>
    handler = StripeCheckout.configure({
      key: Config.stripe[Config.env()]
      image: '/images/tenants/bordeaux/thumbnail.jpg'
      locale: 'fr_FR'
      token: (token) =>
        $('[name="classified[stripe_token]"]').val(token.id)
        this.submitFormBackend()
    })

    handler.open({
      name: 'Baby Sitting Bordeaux',
      description: 'Nouvelle annonce',
      currency: 'EUR',
      amount: 250,
      email: $('[name="classified[email]"').val()
    })

  ##
  # Shutdown the listener submit and
  # submit to the backend
  ##
  submitFormBackend: ->
    this.addLoaderButton()
    $('#classified-form').off('submit').submit()

  ##
  # Add a simple loading button to the submit
  # button to avoid the user to double click and
  # let him know it's processing
  ##
  addLoaderButton: ->
    $('#classified-submit')
        .attr('disabled', 'disabled')
        .addClass('--muted')
        .html('Loading ...')

    NProgress.start()

  ##
  # Reset errors form
  ##
  eraseErrorsForm: ->
    $('.form__help.--error').remove()

  ##
  # Display errors of the form
  ##
  showErrorsForm: (validation) ->
    _.map this.dataForm(), (_, name) =>
      if validation.errors.has(name)
        this.showError(name, validation.errors.first(name))

    this.showAlertError()

  ##
  # Display global error
  ##
  showAlertError: ->
    noty({
      type: 'error'
      text: $('#app-config').data('error-form')
    })

  ##
  # Display a fancy error
  ##
  showError: (name, error) ->
    error = '<span class="form__help --error">' + error + '</span>'
    $('[name="' + name + '"]').after(error)

  ##
  # Get the values of the inputs of the form
  ##
  dataForm: ->
    data = (new Syphon())
      .exclude(['_csrf_token', '_utf8'])
      .get('#classified-form')

    # Syphon doesn't handle the file inputs yet.
    data['classified[avatar]'] = $('[name="classified[avatar]').val() || ''

    return data

  ##
  # Validation rules
  ##
  rulesForm: ->
    {
      'classified[firstname]': 'required',
      'classified[lastname]': 'required',
      'classified[birthday]': 'required|birthday',
      'classified[description]': 'required|min_length:280',
      'classified[email]': 'required|email',
      'classified[phone]': 'required',
      'classified[password]': 'required|min_length:6|confirmation:[name="classified[password_confirmation]"]',
      'classified[password_confirmation]': 'required',
      'classified[avatar]': 'required'
    }

  ##
  # Init the mark birthday to help the user to format correctly his answer
  ##
  initBirthdayMask: =>
    placeholder = $('#classified_birthday').data('placeholder')
    $('#classified_birthday').inputmask('99/99/9999', {placeholder: placeholder})

  ##
  # Set the counter of chars to his initial state
  ##
  initCharsCount: =>

    length = $('#classified_description').val().length
    @setCharsCount(length)

  ##
  # When the description change
  ##
  changeCharsCount: =>

    count = $('#classified_description').val().length
    @setCharsCount(count)

  ##
  # Set a new state for the counter
  ##
  setCharsCount: (number) =>

    $chars = $('#chars')
    minimum = $chars.data('min')

    text = $chars.data('text-number') + ': ' + number + ' (' + $chars.data('text-minimum') + ': ' + minimum + ')'

    $chars.html text

    if number < minimum
        $chars.css('color', '#E3000E') # Red
    else
        $chars.css('color', '#71BA51') # Green

  ##
  # Will autoresize the description when the user write his description
  ##
  initAutosize: =>
    autosize($('#classified_description'))

# Export
module.exports = Classified_New
