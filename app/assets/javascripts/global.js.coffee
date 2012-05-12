# Global functions referenced from HTML
@showWaiting = (element_id, text, centered) ->
  element = $(element_id)
  if element && centered
    element.html('<br /><center><img width=\"13\" height=\"13\" src=\"' + root_url + 'assets/ajax-loader.gif\" align=\"absmiddle\" alt=\"...\" />' + text + '</center><br />')
  else if element
    element.html('<img width=\"13\" height=\"13\" src=\"' + root_url + 'assets/ajax-loader.gif\" align=\"absmiddle\" alt=\"...\" />' + text)

# Mouse Out Functions to Show and Hide Divs

# @isTrueMouseOut = (e, handler) ->
#   if e.type != 'mouseout'
#     return false
#
#   # relTarget
#   if e.relatedTarget
#     relTarget = e.relatedTarget
#   else if e.type == 'mouseout'
#     relTarget = e.toElement
#   else
#     relTarget = e.fromElement
#   while relTarget && relTarget != handler
#     relTarget = relTarget.parentNode
#   relTarget != handler
#
# @hideOnMouseOut = (elements) ->
#   $.each(elements, (index, value) ->
#     element = $(value)
#     element.mouseout((e, handler) ->
#       if isTrueMouseOut(e||window.event, this) then element.hide()
#     )
#   )

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
  $('.rule_group_'+index).each( () ->
    if mode then $(this).attr('checked','checked') else $(this).removeAttr('checked')
  )

@toggleCheckboxGroupParent = (index) ->
  mode = true
  $('.rule_group_'+index).each( () ->
    unless $(this).is(':checked')
      mode = false
  )
  if mode then $('.rule_group_'+index+'_parent').attr('checked','checked') else $('.rule_group_'+index+'_parent').removeAttr('checked')

@confirmMessage = (message) ->
  unless confirm(message)
    return false
  return true

@goBackOneMonth = () ->
  now = new Date $('#selected_date').val()
  now = new Date() if isNaN(now.getFullYear())
  new_month = new Date now.getFullYear(), now.getMonth()-1, 1
  $('#selected_date').val((new_month.getMonth() + 1) + "/" + new_month.getDate() + "/" + new_month.getFullYear())
  $('#direction').val(-1)
  $('#selected_date').change()

@goForwardOneMonth = () ->
  now = new Date $('#selected_date').val()
  now = new Date() if isNaN(now.getFullYear())
  new_month = new Date now.getFullYear(), now.getMonth()+1, 1
  $('#selected_date').val((new_month.getMonth() + 1) + "/" + new_month.getDate() + "/" + new_month.getFullYear())
  $('#direction').val(1)
  $('#selected_date').change()

@getToday = () ->
  now = new Date()
  $('#selected_date').val((now.getMonth() + 1) + "/" + now.getDate() + "/" + now.getFullYear())
  $('#direction').val(0)
  $('#selected_date').change()
