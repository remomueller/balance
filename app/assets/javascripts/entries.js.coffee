@openCalendarPopup = (selected_date) ->
  $('#entry_billing_date').val(selected_date)
  $('#new-entry-dialog').modal( dynamic: true )

@activateEntryDraggables = () ->
  $('.entry_draggable').draggable(
    revert: 'invalid'
    helper: () ->
      $(this).children('[data-object~="entry-helper"]').first().html()
    cursorAt:
      left: 10
  )

@activateDayDroppables = () ->
  $('.day_droppable').droppable(
    hoverClass: "hover"
    tolerance: "pointer"
    drop: ( event, ui ) ->
      billing_date = $(this).data('billing-date')
      element_id = ui.draggable.attr('id')
      entry_id = ui.draggable.data('entry-id')
      $.post(root_url + 'entries/' + entry_id + '/move', "entry[billing_date]="+billing_date, null, "script")
      false
    accept: ( draggable ) ->
      $(this).data('billing-date') != draggable.data('billing-date')
  )

@entriesReady = () ->
  $('[data-object~="typeahead"]').each( () ->
    $this = $(this)
    $this.typeahead(
      remote: $this.data('path') + '?search=%QUERY'
    )
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
  .on('change', '#year', () ->
    $("#earning-spending-form").submit()
  )
  .on('change', '#selected_date', () ->
    $("#calendar-form").submit()
  )
