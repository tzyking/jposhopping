<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.inventory.*" %>
<%!
private static final int PAGE_SIZE = 90;
%>

<%

String strPageNo = request.getParameter("pageno");
String strid = request.getParameter("id");
int pageNo = 1;
int id = -1;
if(strid != null) {
	id = Integer.parseInt(strid);
	ProductMgr.getInstance().delete(id);
	inventoryRecord.deletebyProductid(id);
}
if(strPageNo != null) {
	pageNo = Integer.parseInt(strPageNo);
}
if(pageNo < 1) pageNo = 1;

List products = new ArrayList();
int totalRecords = ProductMgr.getInstance().getProducts(products, pageNo, PAGE_SIZE, true);

int totalPages = (totalRecords + PAGE_SIZE - 1) / PAGE_SIZE;
if(pageNo > totalPages){ 
	pageNo = totalPages;
	ProductMgr.getInstance().getProducts(products, pageNo, PAGE_SIZE, true);
}

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:Product Management</title>
<link rel="stylesheet" type="text/css" href="../css/productList_admin.css">

<script src="../jquery-ui-1.9.0.custom/js/jquery-1.8.2.js" type="text/javascript"></script>


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
<br/>
<br/>
<li><a href="mailingList.jsp">Mailing List</a></li>
<li><a href="couponCodeList.jsp">Promotion Code</a></li>
</ul>
    
   
		<br />    
        <br /> 
        <table  class="orderList" cellspacing="0">
<tr>
	<td class="bodyTxtLeft"><a href="productAdd.jsp"><b>Add New Product</b></a></td>
	<td class="bodyTxtRight"><a href="reorderProductList.jsp"><b>Re-order Images for Product List</b></a></td>
</tr>
</table>   
          
    	<table class="orderList" cellspacing="0">
<tr>
	<td class="Hed">Product Id</td>
	<td class="Hed">Product name</td>
	<td class="Hed">Product Price</td>
	<td class="Hed">Date of Create</td>
	<td class="Hed">Operation</td>
</tr>
<%
	//String status = null;
	for(Iterator it = products.iterator(); it.hasNext(); ) {
		Product p = (Product)it.next();
		
		%>
<tr>
	<td class="bodyTxtCenter"><%=p.getId() %></td>  
	<td class="bodyTxtCenter"><%=p.getName() %></td> 
	<td class="bodyTxtCenter"><%=DecimalFormatDouble.customFormat("0.00", p.getNormalPrice()) %></td> 
	<td class="bodyTxtCenter"><%=p.getPdate() %></td> 
	<td class="bodyTxtCenter">
		<a href="productEdit.jsp?id=<%=p.getId()%>&pageno=<%=pageNo%>">PRODUCT EDIT</a>&nbsp;
		<a href="inventorySetting.jsp?productid=<%=p.getId()%>&pageno=<%=pageNo%>">INVENTORY EDIT</a>&nbsp;
		<a href="picEdit.jsp?id=<%=p.getId()%>&pageno=<%=pageNo%>">IMAGE EDIT</a>&nbsp;
		<a href="productList.jsp?id=<%=p.getId()%>" onclick="return confirm('delete the product?')">DELETE</a>	
	</td>   
</tr> 
<%
}
 %>
</table>
<center>
		page&nbsp;<%=pageNo %>/
		<%=totalPages %>
		&nbsp;
		<a href="productList.jsp?pageno=<%=1 %>">First</a>
		&nbsp;
		<a href="productList.jsp?pageno=<%=pageNo-1 %>">Pre</a>
		&nbsp;
		<a href="productList.jsp?pageno=<%=pageNo+1 %>">Next</a>
		&nbsp;
		<a href="productList.jsp?pageno=<%=totalPages %>">Last</a>
</center>
<br />
<br />

</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
