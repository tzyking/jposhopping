<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.homepage.* " %>
<%
	String category = request.getParameter("category");
	//category = "shopping";
	String order = picsOrder.getCurrentOrderByCategoryName(category);
	//String rootpath = ;
	String rooturl =  request.getScheme() + "://" + request.getServerName() + request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<title>John Patrick Organic:Homepage Management:Delete Pictures</title>
	<link rel="stylesheet" href="../../jquery-ui-1.9.0.custom/css/ui-lightness/jquery-ui-1.9.0.custom.css">
	<script src="../../jquery-ui-1.9.0.custom/js/jquery-1.8.2.js"></script>
	<script src="../../jquery-ui-1.9.0.custom/js/jquery-ui-1.9.0.custom.js"></script>
	<script src="js/delete_pics.js"></script>
	<link rel="stylesheet" href="css/delete_pics.css">

</head>
<body>

<div class="demo ui-widget ui-helper-clearfix">
<ul id="gallery" class="gallery ui-helper-reset ui-helper-clearfix ui-droppable">
<%
	StringTokenizer st = new StringTokenizer(order, ","); 
	 while (st.hasMoreTokens()) {
	 	String item = st.nextToken();
%>
	<li class="ui-widget-content ui-corner-tr ui-draggable" id="<%=item %>">
		<h5 class="ui-widget-header"><%=item %></h5>
		<img src="../../pic/<%=category %>/<%=item %>.jpg" alt="The peaks of High Tatras" width="254" height="200">
		<a href="<%=rooturl%>/sample_files/<%=category %>/<%=item %>.jpg" title="View larger image" class="ui-icon ui-icon-zoomin">View larger</a>
		<a href="http://jqueryui.com/demos/droppable/link/to/trash/script/when/we/have/js/off" title="Delete this image" class="ui-icon ui-icon-trash">Delete image</a>
	</li>
<%} %>

</ul>

<div id="trash" class="ui-widget-content ui-state-default ui-droppable">
	<h4 class="ui-widget-header"><span class="ui-icon ui-icon-trash">Trash</span> Trash</h4>
</div>

</div>


<div class="demo-description">
<p><button id="btnNextStep" name="btnNextStep">Next Step</button></p>
<p>You can delete an image either by dragging it to the Trash or by clicking the trash icon.</p>
<p>You can "recycle" an image by dragging it back to the gallery or by clicking the recycle icon.</p>
<p>You can view larger image by clicking the zoom icon. jQuery UI dialog widget is used for the modal window.</p>
<input id="category_hidden_input" type="hidden" value="<%=category%>">
</div>
</body></html>