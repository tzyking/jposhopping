<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.inventory.*"%>
<%@ page import="com.bjsxt.shopping.util.*" %>

<% 
String productid = request.getParameter("productid");
productid = "7";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:</title>
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
<!-- <li><a href="#">PENDING</a></li>
<li><a href="#">PENDING</a></li> -->
</ul>
<br/>
<br/>
<form name="form" action="../servlet/fileReplace" method="post" enctype="multipart/form-data"> 
<input type="hidden" name="id" value="<%=productid %>">
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft" colspan="2">PRODUCT INFORMATION</td>
</tr>
<tr>
	<td class="bodyTxtRight">Pic for Product List page:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="listItem"></td>
</tr>
<tr>
	<td class="bodyTxtRight">Zoom-out Pic for Product Page:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="zoomItem"></td>
</tr>
<tr>
	<td class="bodyTxtRight">Zoom-in Pic for Product Page:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="zoomItem_b"></td>
</tr>
<tr>
	<td class="bodyTxtRight">Thumb Pic for Shopping Cart:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="thumbItem"></td>
</tr>

</table>
<br/>
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtRight"><input type="submit" name="NextStep" value="Start" /></td>
</tr>
</table>
</form>
</div>
<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
