$( function(){
  $(".sortable").sortable({
    connectWith: ".sortable",
    stop: updatePosition
  });

  function updatePosition(event, ui){
    var updateData = {
      task: {
        id: ui.item.data().id,
        list_id: ui.item.parent().data().id,
        sort: new_position(ui.item)
      }}
    console.log(updateData)
    $.ajax({
      url: ':board_id/lists/:list_id/cards/sort',
      type:'PUT',
      data: updateData
    })
  }

  function new_position($item){
    var pre = 0;
    var succ = 0;
    var current_pos = parseFloat($item.data().position);

    if($item.prev().length){
      pre=parseFloat($item.prev().data().position);
    }
    if($item.next().length){
      succ=parseFloat($item.next().data().position);
    }

    if(pre+succ === 0) return current_pos;
    if(pre === 0) return succ/2;
    if(succ === 0) return (pre + 1.0);
    return (parseFloat(pre) + parseFloat(succ))/2;
  }
});
