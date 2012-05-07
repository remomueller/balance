
function updateStatus(val, update)
{
  if (val)
    $(update).update('<img src="/assets/ok.png" />')
  else
    $(update).update('<img src="/assets/bad.png" />')
  return val
}

function checkLength(el, update, length)
{
  return updateStatus($F(el).length >= length, update)
}

function checkMatch(el1, el2, update)
{
  return updateStatus($F(el1) == $F(el2), update)
}

//regex=/^[A-Z]{4}[A-Z0-9_]*$/i; (This regex would check for valid login)
function checkRegex(elmnt, update, regex)
{
  return updateStatus(($F(elmnt).match(regex)), update)
}

function showLoading(){if($('loading')){$('loading').show()}}

function hideLoading(){if($('loading')){$('loading').hide()}}

// // HIGHCHART CHARTS
// function drawHighChartHistogramChart(element_id, values, params, categories){
//   var my_series = new Array();
//
//   $H(values).each(function(pair){
//      my_series.push({name: pair.key, data: pair.value.map(function(val){return parseInt(val,10)/100.0})})
//    })
//
//   min = params['min']/100.0;
//   max = params['max']/100.0;
//
//   new Highcharts.Chart({
//     chart: {
//       renderTo: element_id,
//       defaultSeriesType: 'column'
//     },
//     credits: {
//       enabled: false
//     },
//     title: {
//       text: params['title']
//     },
//
//     tooltip: {
//       formatter: function() {
//         return '<b>$ ' + this.y.toFixed(2) + '</b> ' + this.series.name + ' in <b>' + this.x + '</b>';
//       }
//     },
//
//     xAxis: {
//       categories: categories
//     },
//
//     yAxis: {
//       title: {
//         text: null
//       },
//       labels: {
//         formatter: function(){
//           return ('$ ' + this.value);
//         }
//       },
//       min: min,
//       max: max
//     },
//
//     series: my_series,
//   });
// }
