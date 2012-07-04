Amount =
  cleanAmount: (number) -> number.replace /[$ ]/g, ""

  validAmount: (number) -> false

@openCalendarPopup = (selected_date) ->
  $('#entry_billing_date').val(selected_date)
  $('#new-entry-dialog').modal( dynamic: true )

jQuery ->
  $("#entry_name")
    .bind("keydown", (event) ->
      if event.keyCode == $.ui.keyCode.TAB && $(this).data("autocomplete").menu.active
        event.preventDefault()
    )
    .autocomplete(
      source: root_url + "entries/autocomplete",
      html: true
    )

  $("#search-form")
    .bind("change", (event) ->
      $.get($("#search-form").attr("action"), $("#search-form").serialize(), null, "script")
    )

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

  # $("#entry_name").bind( "keydown", ( event ) ->
  #   if event.keyCode === $.ui.keyCode.TAB && $(this).data("autocomplete").menu.active
  #     event.preventDefault();
  # )
#     .autocomplete(
# #     source: "<%= auto_complete_for_entry_name_path(autocomplete: true) %>",
#       selectFirst: true,
#       html: true,
#   });
