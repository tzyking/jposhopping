	$(document).ready(function(){
		var curr_category = $("#category_hidden_input").val();
		$("#btnaddedit").click(function(){
									var picsamount = $("#picsamount").val();
									window.location.href = "homepagePicUpload.jsp?category="+curr_category+"&picsamount="+picsamount;
								});
								
		$("#btnedit").click(function(){
									window.location.href = "deletePics.jsp?category="+curr_category;
								});
		
	});