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
String strProductid = request.getParameter("productid");

int pageNo = 1;
int productid = -1; 


if(strPageNo != null) {
	pageNo = Integer.parseInt(strPageNo);
}
if(pageNo < 1) pageNo = 1;

productid = Integer.parseInt(strProductid);

List irs = new ArrayList();
int totalRecords = inventoryRecord.getInventoryRecordsByProductid(irs, pageNo, PAGE_SIZE, productid);

int totalPages = (totalRecords + PAGE_SIZE - 1) / PAGE_SIZE;
if(pageNo > totalPages){ 
	pageNo = totalPages;
	inventoryRecord.getInventoryRecordsByProductid(irs, pageNo, PAGE_SIZE, productid);
}//if(orders.size()== 0) pageNo = totalPages;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:Inventory Setting</title>
<link rel="stylesheet" type="text/css" href="../css/inventorySetting.css">

<script src="../js/jquery.js" type="text/javascript"></script>


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
		<br />    
        <br />    
         <table  class="orderList" cellspacing="0">
<tr>
	<td class="bodyTxtLeft"><a href="productList.jsp"><b>Back To ProductList</b></a></td>
</tr>
</table>          
<table class="orderList" cellspacing="0">

<tr>
	<td class="Hed">inventoryRecord Id</td>
	<td class="Hed">Product Id</td>
	<td class="Hed">Product Name</td>
	<td class="Hed">Color</td>
	<td class="Hed">Size</td>
	<td class="Hed">Amount</td>
	<td class="Hed">Operation</td>
</tr>
<%
	//String status = null;
	for(Iterator it = irs.iterator(); it.hasNext(); ) {
		inventoryRecord ir = (inventoryRecord)it.next();
		
		%>
<tr>
	<td class="bodyTxtCenter"><%=ir.getId() %></td>  
	<td class="bodyTxtCenter"><%=ir.getProduct().getId()%></td> 
	<td class="bodyTxtCenter"><%=ir.getProduct().getName() %></td> 
	<td class="bodyTxtCenter"><%=ir.getColor() %></td> 
	<td class="bodyTxtCenter"><%=ir.getSize() %></td> 
	<td class="bodyTxtCenter"><%=ir.getAmount() %></td> 
	<td class="bodyTxtCenter">
		<a href="inventoryEdit.jsp?id=<%=ir.getId()%>&pageno=<%=pageNo%>&from=inventorySetting">Setting Amount</a>
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
		<a href="inventorySetting.jsp?pageno=<%=1 %>&productid=<%=productid%>">First</a>
		&nbsp;
		<a href="inventorySetting.jsp?pageno=<%=pageNo-1 %>&productid=<%=productid%>">Pre</a>
		&nbsp;
		<a href="inventorySetting.jsp?pageno=<%=pageNo+1 %>&productid=<%=productid%>">Next</a>
		&nbsp;
		<a href="inventorySetting.jsp?pageno=<%=totalPages %>&productid=<%=productid%>">Last</a>
	</center>
<br />
<br />

</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
