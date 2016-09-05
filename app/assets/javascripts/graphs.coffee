@drawChart = (element) ->
  json = $(element).data('chart')
  if json
    $(element).highcharts(
      credits:
        enabled: false
      chart:
        type: 'column'
      title:
        text: json['title']
      xAxis:
        categories: json['categories']
        minPadding: 0.05
        maxPadding: 0.05
      yAxis:
        title:
          text: json['y_title']
      tooltip:
        headerFormat: '<strong>{point.key}</strong><br />'
        pointFormat: '<strong style="color:{series.color}">{series.name}</strong>: $ {point.y:,.2f}'
      plotOptions:
        column:
          # pointPadding: 0.2
          # borderWidth: 0
          dataLabels:
            enabled: false
      series: json['series']
    )
  else
    $('#chart-container').html('')

@graphsReady = ->
  $('[data-object~="chart-container"]').each( ->
    drawChart($(this))
  )
