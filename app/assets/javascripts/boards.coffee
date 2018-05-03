ready = undefined
set_sort = undefined

set_sort = ->
  $('.item').each (i) ->
    $(this).attr 'data-pos', i + 1
    return
  return

ready = ->
  set_sort()
  $('.sortable').sortable()
  $('.sortable').sortable().bind 'sortupdate', (e, ui) ->
    updated_order = []
    set_sort()
    $('.item').each (i) ->
      updated_order.push
        id: $(this).data('id')
        position: i + 1
      return
    $.ajax
      type: 'PUT'
      url: ':board_id/lists/:list_id/cards/sort'
      data: order: updated_order
    return
  return

$(document).ready ready