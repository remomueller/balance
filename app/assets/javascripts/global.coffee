@showMessage = (elements) ->
  $.each(elements, (index, value) ->
    element = $(value)
    element.fadeIn(2000)
  )

@increaseSelectedIndex = (element) ->
  num_options = $(element + ' option').size()
  element = $(element)
  next_index = 0
  if element.attr('selectedIndex') <= 0
    return false
  else
    next_index = element.attr('selectedIndex') - 1
  element.attr('selectedIndex', next_index)
  element.change()

@decreaseSelectedIndex = (element) ->
  num_options = $(element + ' option').size()
  element = $(element)
  next_index = 0
  if element.attr('selectedIndex') < num_options - 1
    next_index = element.attr('selectedIndex') + 1
  else
    return false
  element.attr('selectedIndex', next_index)
  element.change()


@toggleCheckboxGroup = (index) ->
  mode = $('.rule_group_'+index+'_parent').is(':checked');
  $('.rule_group_'+index).each( ->
    if mode then $(this).attr('checked','checked') else $(this).removeAttr('checked')
  )

@toggleCheckboxGroupParent = (index) ->
  mode = true
  $('.rule_group_'+index).each( ->
    unless $(this).is(':checked')
      mode = false
  )
  if mode then $('.rule_group_'+index+'_parent').attr('checked','checked') else $('.rule_group_'+index+'_parent').removeAttr('checked')

@confirmMessage = (message) ->
  unless confirm(message)
    return false
  return true

@getToday = ->
  now = new Date()
  $('#selected_date').val((now.getMonth() + 1) + "/" + now.getDate() + "/" + now.getFullYear())
  $('#calendar-form').submit()

@setFocusToField = (element_id) ->
  val = $(element_id).val()
  $(element_id).focus().val('').val(val)

@globalReady = ->
  $('#user_email').focus()
  $('#entry_name').focus()
  $('#account_name').focus()
  $('#charge_type_name').focus()
  setFocusToField("#search")
  templatesReady()
  $('[data-object~="form-load"]').submit()

@extensionsReady = ->
  datepickerReady()
  tooltipsReady()
  typeaheadReady()

@ready = ->
  globalReady()
  entriesReady()
  graphsReady()
  extensionsReady()

$(document).ready(ready)
$(document)
  .on('turbolinks:load', ready)
  .on('click', '[data-object~="submit"]', ->
    $($(this).data('target')).submit()
    false
  )
  .on('click', '[data-object~="set-value"]', ->
    $($(this).data('target')).val($(this).data('value'))
    $($(this).data('form')).submit()
  )
