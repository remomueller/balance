@openCalendarPopup = (selected_date) ->
  $('#entry_billing_date').val(selected_date)
  $('#template_billing_date').val(selected_date)
  $('#new-entry-dialog').modal( dynamic: true )

@activateEntryDraggables = () ->
  $('.entry-draggable').draggable(
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
      $.post(
        "#{root_url}entries/#{entry_id}/move",
        "entry[billing_date]=#{billing_date}", null, "script")
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
  activateEntryDraggables()
  activateDayDroppables()


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
  .on('input', '[data-object~="expandable-text-area"]', (e) ->
    numberOfLineBreaks = ($(this).val().match(/\n/g)||[]).length + 1
    if numberOfLineBreaks > 25
      $(this).attr('rows', 25)
    else if numberOfLineBreaks > $(this).data('default-rows')
      $(this).attr('rows', numberOfLineBreaks)
    else
      $(this).attr('rows', $(this).data('default-rows'))
  )
