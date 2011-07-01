// HIGHCHART CHARTS
function drawHighChartHistogramChart(element_id, values, params, categories){
  var counts = {}
  var my_series = new Array();
  var i=0;

  $.each(values, function(key, value) {
     my_series.push({name: key,
                     data: value.map(function(val){
                             return parseInt(val,10)/100.0
                           })
                   });
  });
  
  sub_title = document.ontouchstart === undefined ? 'Click and drag in the plot area to zoom in' : 'Drag your finger over the plot to zoom in'
  
  new Highcharts.Chart({
    chart: {
      renderTo: element_id,
      // defaultSeriesType: 'spline',
      defaultSeriesType: 'column',
      zoomType: 'x'
    },
    credits: {
      enabled: false
    },
    title: {
      text: params['title']
    },
    subtitle: {
      text: sub_title
    },
    tooltip: {
      formatter: function() {
        return '<b>$ ' + this.y.toFixed(2) + '</b> ' + this.series.name + ' in <b>' + this.x + '</b>';
      }
    },
    xAxis: {
      categories: categories,
      labels: {
                  step: Math.ceil(categories.length/12)
              },
      minPadding: 0.05,
      maxPadding: 0.05
    },
    yAxis: {
      maxPadding: 0.01,
      minPadding: 0.01,
      title:{
        text: 'Dollars'
      }
    },
    series: my_series,
    plotOptions: {
      series: {
        marker: {
          radius: 2
        }
      }
    }
  });
}
