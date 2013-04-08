<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.homepage.*" %>
<%
	String category = request.getParameter("category");
	//category = "shopping";
	String order = picsOrder.getCurrentOrderByCategoryName(category);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link class="jsbin" href="../../jquery-ui-1.9.0.custom/css/jquery-ui-1.9.0.custom.min.css" rel="stylesheet" type="text/css"></link>
<script src="../../jquery-ui-1.9.0.custom/js/jquery-1.8.2.js"></script>
<script class="jsbin" src="../../jquery-ui-1.9.0.custom/js/jquery-ui-1.9.0.custom.min.js"></script>

<meta charset="utf-8">
<title>John Patrick Organic:Re-order Pictures</title>
<!--[if IE]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<style>
  article, aside, figure, footer, header, hgroup, 
  menu, nav, section { display: block; }
  
  #reorder-gallery {width:1000px; padding:20px; border:1px solid #eee;}
  #order-buttons {background-color:#eee; padding:10px;}
  #sortable { list-style-type: none; margin: 0; padding: 0; }
  #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: 150px; height: 110px; font-size: 4em; text-align: center; }
  #sortable li img {padding:1px; border:1px solid #ccc; cursor: pointer; width:140px; height:100px;}
  
  .ui-state-default, .ui-widget-content .ui-state-default{border:none; background:none;}
  
  .clear {clear:both;}
</style>
</head>
<body>
  <div id="reorder-gallery">
    <ul id="sortable">
<%
	StringTokenizer st = new StringTokenizer(order, ","); 
	 while (st.hasMoreTokens()) {
	 	String item = st.nextToken();
%>
      <li class="ui-state-default" id="<%=item %>"><img src="../../sample_files/<%=category %>/<%=item %>.jpg" /></li>    
<%} %>
	</ul>
    <div class="clear"></div>
    <br /><br />
    <div id="order-buttons">
      <button id="btnsaveorder" name="btnsaveorder">Save Order</button>
    </div>
  </div>
<script>
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
    $.ajax({
		type: 		"post",
		url: 		"savePicsOrder.jsp",
		data: 		"currentorder=" + imgOrder + "&category=<%=category%>",
		success:	function(msg) {
						alert(msg);		
						window.location.href = "index.jsp";	
					}
		}); 
  });
});


</script>
</body>
</html>