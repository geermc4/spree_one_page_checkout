Spree.ready ->
  form_options = {
    success: ->
      window.location.href = '/buy'
    error: ->
      window.location.href = '/buy'
  }

  #Address
  $('#change_address_button').click (event) ->
    event.preventDefault()
    $('#change_address_button').addClass('disabled')

    $('#address_form').removeClass('hidden')
    $('#short_address').addClass('hidden')

    $('#address_form [data-hook="buttons"] .btn').click (save_event) ->
      save_event.preventDefault()

      $('#checkout_form_address').ajaxForm(form_options)
      $('#checkout_form_address').submit()

  $('#cancel_address').click (event) ->
    event.preventDefault()
    $('#address_form').addClass('hidden')
    $('#short_address').removeClass('hidden')
    $('#change_address_button').removeClass('disabled')
