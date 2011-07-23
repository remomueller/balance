jQuery ->
  $(".last-month").live("click", () -> goBackOneMonth())
  $(".next-month").live("click", () -> goForwardOneMonth())
  

@goBackOneYear = () -> 
  year_selector = $('#year')
  if year_selector.val() != 0
    year_selector.val(year_selector.attr('selectedIndex') - 1)

@goForwardOneYear = () ->
  year_selector = $('#year')
  num_years = $(year_selector + ' option').size()
  if year_selector.attr('selectedIndex') != num_years - 1
    year_selector.attr('selectedIndex', year_selector.attr('selectedIndex') + 1)

@goBackOneMonth = () ->
  month_selector = $("#month")
  year_selector = $("#year")
  if month_selector.val() == '1'
    if year_selector.val() != '1'
      month_selector.val('12')
      year_selector.val(year_selector.val() - 1)
  else
    month_selector.val(month_selector.val() - 1)
  month_selector.change()

@goForwardOneMonth = () ->
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

@goToCurrentMonth = () ->
  month_selector = $('#month')
  year_selector = $('#year')
  today = new Date()
  month_selector.attr('selectedIndex', today.getMonth())
  available_years = new Array()
  available_years.push(item.value) for item in year_selector.options
  year_selector.attr('selectedIndex', available_years.indexOf(today.getFullYear().toString(10)))

@calculateEndOfMonthSpending = () ->
  per_day_spending = 0
  days_left_until_end_of_month = parseInt($('#days_left_until_end_of_month').val())
  amount_left = parseFloat($('#amount_left').val() || 0) # Amount left currently in checking
  estimated_spending = parseFloat($('#estimated_spending').val() || 0) # Amount you estimate to spend through end of month
  amount_left_over = parseFloat($('#amount_left_over').val() || 0)  # Amount that you want to have left over at end of month
  per_day_spending = ((amount_left - estimated_spending - amount_left_over) / days_left_until_end_of_month)  
  $('#left_to_spend_per_day_this_month').html('$ ' + per_day_spending.toFixed(2))