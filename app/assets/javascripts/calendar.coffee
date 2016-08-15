@moveYear = (offset) ->
  year_selector = $('#year')
  num_years = $(year_selector).find('option').size()
  next_year = parseInt(year_selector.val()) + offset
  if $("#year option[value=#{next_year}]").length != 0
    year_selector.val(next_year)
    year_selector.change()

@goBackOneYear = ->
  moveYear(-1)

@goForwardOneYear = ->
  moveYear(1)

@goBackOneMonth = ->
  month_selector = $("#month")
  year_selector = $("#year")
  if month_selector.val() == '1'
    if year_selector.val() != '1'
      month_selector.val('12')
      year_selector.val(year_selector.val() - 1)
  else
    month_selector.val(month_selector.val() - 1)
  month_selector.change()

@goForwardOneMonth = ->
  month_selector = $('#month')
  year_selector = $('#year')
  num_years = $(year_selector).find('option').size()
  if month_selector.val() == '12'
    if year_selector.val() != num_years - 1
      month_selector.val('1')
      year_selector.val(parseInt(year_selector.val()) + 1)
  else
    month_selector.val(parseInt(month_selector.val()) + 1)
  month_selector.change()

@goToCurrentMonth = ->
  month_selector = $('#month')
  year_selector = $('#year')
  today = new Date()
  month_selector.attr('selectedIndex', today.getMonth())
  available_years = new Array()
  available_years.push(item.value) for item in year_selector.options
  year_selector.attr('selectedIndex', available_years.indexOf(today.getFullYear().toString(10)))
