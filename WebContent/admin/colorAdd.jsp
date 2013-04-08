<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.inventory.*"%>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.color.*" %>


<% 
String action = request.getParameter("action");
if(action != null && action.equals("create") ) {
	String colorName = request.getParameter("colorName").trim().toUpperCase();	
	color c = new color();
	c.setName(colorName);
	c.setIsDeleted(0);
	int cid = c.add();
	
	//inventoryRecord.addByColorsProductid(colors, productid); 
	
	response.sendRedirect("colorImageUpload.jsp?colorName="+colorName);

}


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic: colorAdd</title>
<link rel="stylesheet" type="text/css" href="../css/productAdd.css">
<script src="js/jquery.js" type="../text/javascript"></script>



</head><body>

<div id="header">

</div>  

<div class="itemdetail">
<ul id="list-nav">
<li><a href="productList.jsp">Product Management</a></li>
<li><a href="orderList.jsp">Order Management</a></li>
<li><a href="inventoryList.jsp">Inventory Management</a></li>
<li><a href="homepage/index.jsp">Homepage Management</a></li>
<li><a href="colorList.jsp">Color Management</a></li>
<!-- <li><a href="#">PENDING</a></li>
<li><a href="#">PENDING</a></li> -->
</ul>
<br/>
<br/>
        <table  class="productInfo" cellspacing="0">
<tr>
	<td class="bodyTxtLeft"><a href="colorList.jsp"><b>Back To Color List</b></a></td>
</tr>
</table>   
<form name="form" action="colorAdd.jsp" method="post"> 
<input type="hidden" name="action" value="create">
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft" colspan="2">Color INFORMATION</td>
</tr>
<tr>
	<td class="bodyTxtRight">Color Name:</td>
	<td class="bodyTxtLeft"><input id="colorName" name="colorName" value="" size="40" /></td>
</tr>
</table>
<br/>
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtRight"><input type="submit" name="NextStep" value="Next Step" /></td>
</tr>
</table>
</form>
</div>
<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
