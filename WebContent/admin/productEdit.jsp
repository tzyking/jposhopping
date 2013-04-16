<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.inventory.*"%>
<%@ page import="com.bjsxt.shopping.util.*" %>

<% 
String action = request.getParameter("action");
String id = request.getParameter("id").trim();
String pageno = request.getParameter("pageno").trim();

Product p = ProductMgr.getInstance().loadById(Integer.parseInt(id));
List colors = inventoryRecord.getColorOptionByProductId(Integer.parseInt(id));


if(action != null && action.equals("update") ) {
	p.setName(request.getParameter("productName").trim());
	p.setDescr(request.getParameter("productDescr").trim());
	p.setNormalPrice(Double.parseDouble(request.getParameter("productPrice").trim()));
	p.setMemberPrice(Double.parseDouble(request.getParameter("productPrice").trim()));
	
	ProductMgr.getInstance().update(p);
	response.sendRedirect("productList.jsp?pageno="+pageno);
}


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic: Product Edit</title>
<link rel="stylesheet" type="text/css" href="../css/productAdd.css">
<script src="../jquery-ui-1.9.0.custom/js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="../jquery-ui-1.9.0.custom/js/jquery-ui-1.9.0.custom.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/productEdit.js"></script>

</head><body>

<div id="header">

</div>  

<div class="itemdetail">
<ul id="list-nav">
<li><a href="productList.jsp">Product Management</a></li>
<li><a href="orderList.jsp">Order Management</a></li>
<li><a href="inventoryList.jsp">Inventory Management</a></li>
<li><a href="homepage/index.jsp">Homepage Management</a></li>
<br/>
<br/>
        <table  class="productInfo" cellspacing="0">
<tr>
	<td class="bodyTxtLeft"><a href="productList.jsp"><b>Back To ProductList</b></a></td>
</tr>
</table>
<form name="form" action="productEdit.jsp" method="post"> 
<input type="hidden" name="action" value="update">
<input type="hidden" name="id" id="id" value="<%=id %>">
<input type="hidden" name="pageno" id="pageno" value="<%=pageno %>">
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft" colspan="2">PRODUCT INFORMATION</td>
</tr>
<tr>
	<td class="bodyTxtRight">Product Name:</td>
	<td class="bodyTxtLeft"><input id="productName" name="productName" value="<%=p.getName() %>" size="40" /></td>
</tr>
<tr>
	<td class="bodyTxtRight">Product Description:</td>
	<td class="bodyTxtLeft"><textarea id="productDescr" name="productDescr" rows="5" cols="40" value="<%=p.getDescr() %>"><%=p.getDescr() %></textarea> </td>
</tr>
<tr>
	<td class="bodyTxtRight">Product Price:</td>
	<td class="bodyTxtLeft"><input id="productPrice" name="productPrice" value="<%=DecimalFormatDouble.customFormat("0.00", p.getNormalPrice()) %>" size="40" /></td>
</tr>
</table>
<br/>
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft">Colors</td>
</tr>
<%for (Iterator itc = colors.iterator(); itc.hasNext(); ) { 
    			String color = (String)itc.next();
    		%>
 <tr>
	<td class="bodyTxtleft"><%=color %></td>
</tr>
 <%} %>
<tr>
	<td class="bodyTxtLeft"><a href="addExistingColor.jsp?id=<%=id %>&pageno=<%=pageno %>"><b>Add color</b></a></td>
</tr>
</table>
<br/>
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtRight"><input type="submit" name="NextStep" value="Update" /></td>
</tr>
</table>
</form>
</div>
<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
