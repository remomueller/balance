Amount =
  cleanAmount: (number) -> number.replace /[$ ]/g, ""

  validAmount: (number) -> false

@openCalendarPopup = (selected_date) ->
  $('#entry_billing_date').val(selected_date)
  $('#new-entry-dialog').modal( dynamic: true )

jQuery ->
  $(document)
    .on('click', '[data-object~="calendar-next-month"]', () ->
      goForwardOneMonth()
      false
    )
    .on('click', '[data-object~="calendar-previous-month"]', () ->
      goBackOneMonth()
      false
    )
    .on('click', '[data-object~="calendar-today"]', () ->
      getToday()
      false
    )
    .on('click', '[data-object~="month-spending-calculate"]', () ->
      calculateEndOfMonthSpending()
      false
    )
    .on('click', '[data-object~="previous-year"]', () ->
      goBackOneYear()
      false
    )
    .on('click', '[data-object~="next-year"]', () ->
      goForwardOneYear()
      false
    )
    .on('click', '[data-object~="copy"]', () ->
      $($(this).data('target')).val($(this).data('amount'))
      false
    )
