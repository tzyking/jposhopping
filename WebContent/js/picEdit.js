

$(document).ready(function() {
	$("#refresh").click(function() {
		//alert("attain");
		window.location.href = "picEdit.jsp?id=" + $("#id").attr("value") + "&pageno=" + $("#pageno").attr("value");
	});

});



