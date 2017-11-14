@setFocusToField = (element_id) ->
  val = $(element_id).val()
  $(element_id).focus().val('').val(val)

@globalReady = ->
  $('#user_email').focus()
  $('#entry_name').focus()
  $('#account_name').focus()
  $('#charge_type_name').focus()
  setFocusToField("#search")

@extensionsReady = ->
  datepickerReady()
  tooltipsReady()
  typeaheadReady()

@componentsReady = ->
  false

@objectsReady = ->
  templatesReady()

# These functions get called on initial page visit and on turbolink page changes
@turbolinksReady = ->
  globalReady()
  entriesReady()
  graphsReady()
  extensionsReady()
  componentsReady()
  objectsReady()

# These functions only get called on the initial page visit (no turbolinks).
# Browsers that don't support turbolinks will initialize all functions in
# turbolinks on page load. Those that do support Turbolinks won't call these
# methods here, but instead will wait for `turbolinks:load` event to prevent
# running the functions twice.
@initialLoadReady = ->
  turbolinksReady() unless Turbolinks.supported

$(document).ready(initialLoadReady)
$(document)
  .on('turbolinks:load', turbolinksReady)
  .on('click', '[data-object~="submit"]', ->
    element = $($(this).data('target'))[0]
    Rails.fire(element, 'submit')
    false
  )
  .on('click', '[data-object~="set-value"]', ->
    $($(this).data('target')).val($(this).data('value'))
    $($(this).data('form')).submit()
  )
  .on('click', '[data-object~="remove"]', ->
    $($(this).data('target')).remove()
    false
  )
