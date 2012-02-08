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

  $("#entry_name")
    .bind("keydown", (event) ->
      if event.keyCode == $.ui.keyCode.TAB && $(this).data("autocomplete").menu.active
        event.preventDefault()
    )
    .autocomplete(
      source: root_url + "entries/autocomplete",
      html: true
    )

  $("#search-form")
    .bind("change", (event) ->
      $.get($("#search-form").attr("action"), $("#search-form").serialize(), null, "script")
    )

  $.get($("#search-form").attr("action"), $("#search-form").serialize(), null, "script")

  # $("#entry_name").bind( "keydown", ( event ) ->
  #   if event.keyCode === $.ui.keyCode.TAB && $(this).data("autocomplete").menu.active
  #     event.preventDefault();
  # )
#     .autocomplete(
# #     source: "<%= auto_complete_for_entry_name_path(autocomplete: true) %>",
#       selectFirst: true,
#       html: true,
#   });
