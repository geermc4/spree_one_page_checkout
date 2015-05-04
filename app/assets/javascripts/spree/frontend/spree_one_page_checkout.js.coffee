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

  #Delivery
  $('.change_rate').click (event) ->
    event.preventDefault()
    $('.change_rate').addClass('disabled')
    $('.list-group li').removeClass('hidden')
    $('#delivery_submit').removeClass('hidden')

    $('#delivery_submit [data-hook="buttons"] .btn').click (rate_event) ->
      rate_event.preventDefault()
      $('#checkout_form_delivery').ajaxForm(form_options)
      $('#checkout_form_delivery').submit()

  $('#cancel_delivery').click (event) ->
    event.preventDefault()
    $('.change_rate').removeClass('disabled')
    $('.list-group li').addClass('hidden')
    $('#delivery_submit').addClass('hidden')
    $('.list-group li input[type="radio"]:checked').parents("li").removeClass("hidden")
