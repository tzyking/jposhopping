

$(document).ready(function() {
	$("#refresh").click(function() {
		//alert("attain");
		window.location.href = "productEdit.jsp?id=" + $("#id").attr("value") + "&pageno=" + $("#pageno").attr("value");
	});

});



