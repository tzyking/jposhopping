<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.inventory.*"%>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.color.*" %>

<% 
String action = request.getParameter("action");
List lcolors = color.getAvailableColorNames();

if(action != null && action.equals("create") ) {
	String productName = request.getParameter("productName").trim();
	String productDescr = request.getParameter("productDescr").trim();
	double productPrice = Double.parseDouble(request.getParameter("productPrice").trim());
	String[] colors = request.getParameterValues("color");
	String[] sizes = request.getParameterValues("size");
	
	Product p = new Product();
	p.setName(productName);
	p.setDescr(productDescr);
	p.setNormalPrice(productPrice);
	p.setMemberPrice(productPrice);
	p.setPdate(new Date());
	p.setCategoryId(2);
	p.setDisplayOrder(-1);
	
	int productid = ProductMgr.getInstance().add(p);
	
	//inventoryRecord.addByColorsProductid(colors, productid); 
	inventoryRecord.addByColorsSizeProductid(colors, sizes, productid);
	response.sendRedirect("inventoryInitial.jsp?productid="+Integer.toString(productid));

}


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
        <table  class="productInfo" cellspacing="0">
<tr>
	<td class="bodyTxtLeft"><a href="productList.jsp"><b>Back To ProductList</b></a></td>
</tr>
</table>   
<form name="form" action="productAdd.jsp" method="post"> 
<input type="hidden" name="action" value="create">
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft" colspan="2">PRODUCT INFORMATION</td>
</tr>
<tr>
	<td class="bodyTxtRight">Product Name:</td>
	<td class="bodyTxtLeft"><input id="productName" name="productName" value="" size="40" /></td>
</tr>
<tr>
	<td class="bodyTxtRight">Product Description:</td>
	<td class="bodyTxtLeft"><textarea id="productDescr" name="productDescr" rows="5" cols="40" value=""></textarea> </td>
</tr>
<tr>
	<td class="bodyTxtRight">Product Price:</td>
	<td class="bodyTxtLeft"><input id="productPrice" name="productPrice" value="" size="40" /></td>
</tr>
</table>
<br/>
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft" colspan="2">Select Colors</td>
</tr>
<tr>
	<td class="bodyTxtRight">Colors:</td>
	<td class="bodyTxtLeft">
<%for (Iterator itc = lcolors.iterator(); itc.hasNext(); ) { 
    			String color = (String)itc.next();
    		%>
	<INPUT TYPE="checkbox" NAME="color" value="<%=color %>"><%=color %><BR>
	
 <%} %>
</td>
</tr>
<tr>
	<td class="bodyTxtRight">Size:</td>
	<td class="bodyTxtLeft">
	<INPUT TYPE="checkbox" NAME="size" value="O/S">O/S<BR>
	<INPUT TYPE="checkbox" NAME="size" value="XS">XS<BR>
	<INPUT TYPE="checkbox" NAME="size" value="SM">SM<BR>
	<INPUT TYPE="checkbox" NAME="size" value="MED">MED<BR>
	<INPUT TYPE="checkbox" NAME="size" value="LG">LG<BR>
	<INPUT TYPE="checkbox" NAME="size" value="0">0<BR>
	<INPUT TYPE="checkbox" NAME="size" value="1">1<BR>
	<INPUT TYPE="checkbox" NAME="size" value="2">2<BR>
	<INPUT TYPE="checkbox" NAME="size" value="3">3<BR>
	<INPUT TYPE="checkbox" NAME="size" value="4">4<BR>
	<INPUT TYPE="checkbox" NAME="size" value="6">6<BR>
	<INPUT TYPE="checkbox" NAME="size" value="8">8<BR>
	<INPUT TYPE="checkbox" NAME="size" value="10">10<BR>
</td>
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
