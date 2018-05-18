$( function(){
  $(".sortable").sortable({
    connectWith: ".sortable",
    stop: updatePosition
  });
  var updatedOrder = []
  function updatePosition(event, ui){
    var updateData = {
      task: {
        id: ui.item.data().id,
        list_id: ui.item.parent().data().id,
        sort: new_position(ui.item),
        sort_id: find_id(ui.item)
      }}
    console.log(updateData)
    $.ajax({
      url: ':board_id/lists/:list_id/cards/sort',
      type:'PUT',
      data: updateData
    })
  }

  function new_position($item){
    
    updatedOrder =[];
    var current_pos = $item.index();

    $item.prevAll().each(function (i){
    	updatedOrder.push(i); 
    });
    updatedOrder.push(current_pos);
    $item.nextAll().each(function (i){
      i = updatedOrder.length;
      updatedOrder.push(i); 
    });
    return updatedOrder;
  }

  function find_id($item){

    updatedOrder = [];
    var current_id = $item.data().id;
    var list = $item.parent();
    list.children().each(function(i,v){
      updatedOrder.push($(this).data().id);
    });
    return updatedOrder;
  }
});