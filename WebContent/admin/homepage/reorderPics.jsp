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
<script src="js/reorder_pics.js"></script>
<link rel="stylesheet" href="css/reorder_pics.css">

<meta charset="utf-8">
<title>John Patrick Organic:Re-order Pictures</title>
<!--[if IE]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>
<body>
  <div id="reorder-gallery">
    <ul id="sortable">
<%
	StringTokenizer st = new StringTokenizer(order, ","); 
	 while (st.hasMoreTokens()) {
	 	String item = st.nextToken();
%>
      <li class="ui-state-default" id="<%=item %>"><img src="../../pic/<%=category %>/<%=item %>.jpg" /></li>    
<%} %>
	</ul>
    <div class="clear"></div>
    <br /><br />
    <div id="order-buttons">
      <button id="btnsaveorder" name="btnsaveorder">Save Order</button>
    </div>
    <input id="category_hidden_input" type="hidden" value="<%=category%>">
  </div>
</body>
</html>