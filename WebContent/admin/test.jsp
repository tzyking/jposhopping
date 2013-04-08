<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String[] colors;

String productid = request.getParameter("productid");
colors = request.getParameterValues("color");
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
<!--<script type="text/javascript" src="sample_files/buy1.js"></script>-->
</head><body>

<%=productid%><br/>
<ul>
<%
    if (colors != null) {
    for (int i = 0; i < colors.length; i++) {
%>

<%
        out.println (colors[i]);
    }
  } else out.println ("none selected");
%>
</ul>
<br/>



</body></html>