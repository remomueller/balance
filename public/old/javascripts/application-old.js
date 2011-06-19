$(function(){

  $(".datepicker").datepicker({ showOtherMonths: true, selectOtherMonths: true, changeMonth: true, changeYear: true });  
  $("#ui-datepicker-div").hide();

  $(".pagination a, .page a, .next a, .prev a").live("click", function() {
    $.get(this.href, null, null, "script")
    return false;
  });
  
});

// document.observe("dom:loaded", function() {
//   var container = $(document.body)
// 
//   if (container) {
//     var img = new Image
//     img.src = '/assets/ajax-loader.gif'
// 
//     function createSpinner() {
//       return new Element('img', { src: img.src, 'class': 'spinner', 'height': '11', 'width': '11' })
//     }
//   }
// })

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

function goBackOneYear(){
  year_selector = $('year');
  if(year_selector.selectedIndex != 0){
    year_selector.selectedIndex = year_selector.selectedIndex - 1;
  }
}

function goForwardOneYear(){
  year_selector = $('year');
  if(year_selector.selectedIndex != year_selector.length - 1){
    year_selector.selectedIndex = year_selector.selectedIndex + 1;
  }
}

function goBackOneMonth(){
  month_selector = $('month');
  year_selector = $('year');
  
  if(month_selector.selectedIndex == 0)
  {
    if(year_selector.selectedIndex != 0){
      month_selector.selectedIndex = 11;
      year_selector.selectedIndex = year_selector.selectedIndex - 1;
    }
  }else{
    month_selector.selectedIndex = month_selector.selectedIndex - 1;
  }
}

function goForwardOneMonth(){
  month_selector = $('month');
  year_selector = $('year');
  
  if(month_selector.selectedIndex == 11)
  {
    if(year_selector.selectedIndex != year_selector.length - 1){
      month_selector.selectedIndex = 0;
      year_selector.selectedIndex = year_selector.selectedIndex + 1;
    }
  }else{
    month_selector.selectedIndex = month_selector.selectedIndex + 1;
  }
}

function goToCurrentMonth(){
  month_selector = $('month');
  year_selector = $('year');
  today = new Date();
  
  month_selector.selectedIndex = today.getMonth();
  var available_years = new Array();
  for (i=0; i <= year_selector.options.length - 1; i++){
    available_years.push(year_selector.options[i].value);
  };
  year_selector.selectedIndex = available_years.indexOf(today.getFullYear().toString(10))
}

function calculateEndOfMonthSpending(){
  per_day_spending = 0;
  days_left_until_end_of_month = $('days_left_until_end_of_month').value;
  amount_left = $('amount_left').value; // Amount left currently in checking
  estimated_spending = $('estimated_spending').value; // Amount you estimate to spend through end of month
  amount_left_over = $('amount_left_over').value;  // Amount that you want to have left over at end of month
  
  per_day_spending = ((amount_left - estimated_spending - amount_left_over) / days_left_until_end_of_month);
  
  $('left_to_spend_per_day_this_month').update('$ ' + per_day_spending.toFixed(2));
}

// HIGHCHART CHARTS
function drawHighChartHistogramChart(element_id, values, params, categories){
  var my_series = new Array();
  
  $H(values).each(function(pair){
     my_series.push({name: pair.key, data: pair.value.map(function(val){return parseInt(val,10)/100.0})})
   })
  
  min = params['min']/100.0;
  max = params['max']/100.0;
      
  new Highcharts.Chart({
    chart: {
      renderTo: element_id,
      defaultSeriesType: 'column'
    },
    credits: {
      enabled: false
    },
    title: {
      text: params['title']
    },
    
    tooltip: {
      formatter: function() {
        return '<b>$ ' + this.y.toFixed(2) + '</b> ' + this.series.name + ' in <b>' + this.x + '</b>';
      }
    },
    
    xAxis: {
      categories: categories
    },
    
    yAxis: {
      title: {
        text: null
      },
      labels: {
        formatter: function(){
          return ('$ ' + this.value);
        }
      },
      min: min,
      max: max
    },
    
    series: my_series,
  });
}