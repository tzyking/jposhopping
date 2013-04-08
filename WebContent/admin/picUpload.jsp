<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.inventory.*"%>
<%@ page import="com.bjsxt.shopping.util.*" %>

<% 
String productid = request.getParameter("productid");
List colors = inventoryRecord.getAvailableColorOptionByProductId(Integer.parseInt(productid));
String color = "";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head> 
    <title>John Patrick Organic:</title>
<link rel="stylesheet" type="text/css" href="../css/productAdd.css">
<script src="js/jquery.js" type="../text/javascript"></script>
</head>
<body>

<div id="header">

</div>  

<div class="itemdetail">
<ul id="list-nav">
<li><a href="productList.jsp">Product Management</a></li>
<li><a href="orderList.jsp">Order Management</a></li>
<li><a href="inventoryList.jsp">Inventory Management</a></li>
<li><a href="homepage/index.jsp">Homepage Management</a></li>
</ul>
<br/>
<br/>
<form name="form" action="../servlet/fileUpload" method="post" enctype="multipart/form-data"> 
<input type="hidden" name="id" value="<%=productid %>">
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft" colspan="2">PRODUCT INFORMATION</td>
</tr>
<tr>
	<td class="bodyTxtRight">Pic for Product List page:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="listItem"></td>
</tr>

<%for(Iterator it_color = colors.iterator(); it_color.hasNext();) {
	color = (String)it_color.next();
	color = StringReplacer.emptySpaceFixer(color);
%>
<tr>
	<td class="bodyTxtRight" colspan="2"></td>
</tr>
<tr>
	<td class="HedTxtLeft" colspan="2">IMAGES FOR COLOR: <%=color %></td>
</tr>
<tr>
	<td class="bodyTxtRight">Zoom-out Pic for Product Page:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="<%=productid + "_" + color %>"></td>
</tr>
<tr>
	<td class="bodyTxtRight">Zoom-in Pic for Product Page:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="<%=productid + "b_" + color %>"></td>
</tr>
<tr>
	<td class="bodyTxtRight">Zoom-out flat Pic for Product Page:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="<%=productid + "_flat_" + color %>"></td>
</tr>
<tr>
	<td class="bodyTxtRight">Zoom-in flat Pic for Product Page:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="<%=productid + "_flatb_" + color %>"></td>
</tr>
<tr>
	<td class="bodyTxtRight">Thumb Pic for Shopping Cart:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="<%=productid + "_thumb_" + color %>"></td>
</tr>

<%} %>

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
