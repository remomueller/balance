Amount = 
  cleanAmount: (number) -> number.replace /[$ ]/g, ""
  
  validAmount: (number) -> false
  
jQuery ->
  $(".datepicker").datepicker
    showOtherMonths: true
    selectOtherMonths: true
    changeMonth: true
    changeYear: true
    
  $("#ui-datepicker-div").hide()

  $(".pagination a, .page a, .next a, .prev a").live("click", () ->
    $.get(this.href, null, null, "script")
    false
  )