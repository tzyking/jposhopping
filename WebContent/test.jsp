<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
//String sameasbilling = request.getParameter("sameasbilling");
//String password = request.getParameter("password");
//String ProductId = request.getParameter("id");
//String color = request.getParameter("color");
//String action = request.getParameter("action");

 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html><head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>John Patrick Organic</title>
<link rel="stylesheet" type="text/css" href="sample_files/jpoglobal.css">
<script type="text/javascript" src="sample_files/jquery.js"></script>
<script type="text/javascript" src="sample_files/jquery-ui.js"></script>
<script>
		  
      $(document).ready(function() {
      		var originalPrice ="$1,666.331";
			var newPrice = Number(originalPrice.replace(/[^0-9\.]+/g,""));
			alert(newPrice.toFixed(2)); 
      });
</script>

<!--<script type="text/javascript" src="sample_files/buy1.js"></script>-->
</head><body>

<%out.println(request.getRealPath("/"));
%><br/>
<br/>



</body></html>