@templatesReady = ->
  $('#items[data-object~="sortable"]').sortable(handle: '.item-handle')

@showEntryContents = ->
  $('.template-contents').hide()
  $('.entry-contents').show()
  resetEntryTemplateButtons()

@resetEntryTemplateButtons = ->
  $.rails.enableElement($('a[data-disable-with]'))

$(document)
  .on('click', '[data-object~="template-modal"]', ->
    $('.entry-contents').hide()
    $('.template-contents').show()
    false
  )
  .on('click', '[data-object~="entry-modal"]', ->
    showEntryContents()
    false
  )
