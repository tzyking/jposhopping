var imgOrder = '';

$(function() {
  $("#sortable").sortable({
    update: function(event, ui) {
      imgOrder = $("#sortable").sortable('toArray').toString();
    }
  });
  $("#sortable").disableSelection();
  
  
});

$(document).ready(function(){
  imgOrder = $("#sortable").sortable('toArray').toString();
  $("#btnsaveorder").click(function(){	
    //alert(imgOrder);
	  
	var curr_category = $("#category_hidden_input").val();
    $.ajax({
		type: 		"post",
		url: 		"savePicsOrder.jsp",
		data: 		"currentorder=" + imgOrder + "&category=" + curr_category,
		success:	function(msg) {
						alert(msg);		
						window.location.href = "index.jsp";	
					}
		}); 
  });
});
