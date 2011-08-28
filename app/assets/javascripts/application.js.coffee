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

  $(".field_with_errors input, .field_with_errors_cleared input, .field_with_errors textarea, .field_with_errors_cleared textarea").change( () ->
    el = $(this)
    if  el.val() != '' && el.val() != null
      $(el).parent().removeClass('field_with_errors')
      $(el).parent().addClass('field_with_errors_cleared')
    else
      $(el).parent().removeClass('field_with_errors_cleared')
      $(el).parent().addClass('field_with_errors')
  )
  
  $(".per_page a").live("click", () ->
    object_class = $(this).data('object')
    $.get($("#"+object_class+"_search").attr("action"), $("#"+object_class+"_search").serialize() + "&"+object_class+"_per_page="+ $(this).data('count'), null, "script")
    false
  )
  
  $('#menu').waypoint( (event, direction) ->
    $(this).toggleClass('sticky', direction == "down")
    $(this).css( left: $("#header").offset().left )
    event.stopPropagation()
  )
  
  $('#entry_name').focus()
  
  $("#entry_decimal_amount").watermark('Format x.xx (No $ Sign)')
  
  $("#search").watermark('&lt;Enter&gt; to Search')
  
  $('#user_email').focus()