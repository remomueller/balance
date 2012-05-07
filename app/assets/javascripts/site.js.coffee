jQuery ->
  $(".datepicker").datepicker
    showOtherMonths: true
    selectOtherMonths: true
    changeMonth: true
    changeYear: true

  $("#ui-datepicker-div").hide()

  $(document).on('click', ".pagination a, .page a, .next a, .prev a", () ->
    return false if $(this).parent().is('.active, .disabled, .per_page')
    $.get(this.href, null, null, "script")
    false
  )

  $(document).on("click", ".per_page a", () ->
    object_class = $(this).data('object')
    $.get($("#"+object_class+"_search").attr("action"), $("#"+object_class+"_search").serialize() + "&"+object_class+"_per_page="+ $(this).data('count'), null, "script")
    false
  )

  $('#user_email').focus()
  $('#entry_name').focus()
  $('#account_name').focus()
  $('#charge_type_name').focus()

  $("#search").watermark('&lt;Enter&gt; to Search')

  $.get($("#search-form").attr("action"), $("#search-form").serialize(), null, "script")

  $(document)
    .keydown( (e) ->
      if $("input, textarea").is(":focus") then return
      if e.which == 37
        goBackOneMonth()
      if e.which == 39
        goForwardOneMonth()
    )
