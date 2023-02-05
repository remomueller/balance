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
        labels:
          step: json['step']
          rotation: json['rotation']
      yAxis:
        labels:
          formatter: () ->
            return '$' + this.axis.defaultLabelFormatter.call(this)
        title:
          text: json['y_title']
        format: '<b>{yAxis}</b>'
      tooltip:
        useHTML: true
        headerFormat: '<table class="table table-borderless table-striped table-sm mb-0">' +
          '<thead>' +
          '<tr><th colspan="2">{point.key}</th></tr>' +
          '</thead>'
        pointFormatter: () ->
          if (this.y != 0)
            return '<tr>' +
              '<td style="text-align: right">$' + Highcharts.numberFormat(this.y, 2)  + '</td>' +
              '<td style="color: ' + this.series.color + '">' + this.series.name + '</td>' +
              '</tr>'
        footerFormat:
          if json['stacking']
            '<tfoot><tr><th>${point.total:,.2f}</th><th>Total</th></tr></tfoot>' +
            '</table>'
          else
            '</table>'
        shared: true
        crosshairs: json['cross_hairs']
      plotOptions:
        column:
          stacking: json['stacking']
          dataLabels:
            enabled: false
      series: json['series']
    )
  else
    $('#chart-container').html('')

@graphsReady = ->
  Highcharts.setOptions(
    lang:
      thousandsSep: ','
  )
  $('[data-object~="chart-container"]').each( ->
    drawChart($(this))
  )
