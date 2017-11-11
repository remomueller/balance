@openCalendarPopup = (selected_date) ->
  $('#entry_billing_date').val(selected_date)
  $('#template_billing_date').val(selected_date)
  $('#new-entry-dialog').modal( dynamic: true )

@activateEntryDraggables = ->
  $('.entry-draggable').draggable(
    revert: 'invalid'
    helper: ->
      $(this).children('[data-object~="entry-helper"]').first().html()
    cursorAt:
      left: 10
  )

@activateDayDroppables = ->
  $('.day_droppable').droppable(
    classes:
      'ui-droppable-hover': 'hover'
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

@entriesTypeahead = ->
  $("[data-object~='typeahead-entries']").typeahead('destroy')
  $("[data-object~='typeahead-entries']").each( ->
    $this = $(this)
    bloodhound = new Bloodhound(
      datumTokenizer: Bloodhound.tokenizers.whitespace
      queryTokenizer: Bloodhound.tokenizers.whitespace
      remote:
        url: "#{$this.data('path')}?search=%QUERY"
        wildcard: '%QUERY'
    )
    $this.typeahead({ hint: true }, { source: bloodhound })
  )

@submitEarningSpendingForm = ->
  if $("#earning-spending-form").length > 0
    changes = {}
    changes["year"] = $("#year").val()
    $.post($("#earning-spending-form").attr("action"), changes, null, "script")

@entriesReady = ->
  entriesTypeahead()
  activateEntryDraggables()
  activateDayDroppables()
  submitEarningSpendingForm()

$(document)
  .on('click', '[data-object~="previous-year"]', ->
    goBackOneYear()
    false
  )
  .on('click', '[data-object~="next-year"]', ->
    goForwardOneYear()
    false
  )
  .on('click', '[data-object~="copy"]', ->
    $($(this).data('target')).val($(this).data('amount'))
    false
  )
  .on('change', '#year', ->
    submitEarningSpendingForm()
  )
