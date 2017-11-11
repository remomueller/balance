@moveYear = (offset) ->
  year_selector = $('#year')
  next_year = parseInt(year_selector.val()) + offset
  if $("#year option[value=#{next_year}]").length != 0
    year_selector.val(next_year)
    year_selector.change()

@goBackOneYear = ->
  moveYear(-1)

@goForwardOneYear = ->
  moveYear(1)
