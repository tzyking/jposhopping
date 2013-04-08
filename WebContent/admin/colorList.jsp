<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.inventory.*" %>
<%@ page import="com.bjsxt.shopping.color.*" %>
<%!
private static final int PAGE_SIZE = 30;
%>

<%

String strPageNo = request.getParameter("pageno");
String strid = request.getParameter("id");
int pageNo = 1;
int id = -1;
if(strid != null) {
    
	id = Integer.parseInt(strid);
	color.deleteById(id);
	//inventoryRecord.deletebyProductid(id);
}
if(strPageNo != null) {
	pageNo = Integer.parseInt(strPageNo);
}
if(pageNo < 1) pageNo = 1;



List colors = new ArrayList();


int totalRecords = color.getAvailableColors(colors, pageNo, PAGE_SIZE);
//int totalRecords = inventoryRecord.getInventoryRecords(products, pageNo, PAGE_SIZE);

int totalPages = (totalRecords + PAGE_SIZE - 1) / PAGE_SIZE;
if(pageNo > totalPages){ 
	pageNo = totalPages;
	color.getAvailableColors(colors, pageNo, PAGE_SIZE);
	//inventoryRecord.getInventoryRecords(products, pageNo, PAGE_SIZE);
}//if(orders.size()== 0) pageNo = totalPages;

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:Color Management</title>
<link rel="stylesheet" type="text/css" href="../css/productList_admin.css">

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
<li><a href="colorList.jsp">Color Management</a></li>
<br/>
<br/>
<li><a href="mailingList.jsp">Mailing List</a></li>
<li><a href="couponCodeList.jsp">Promotion Code</a></li>
<!-- <li><a href="#">PENDING</a></li>
<li><a href="#">PENDING</a></li> -->
</ul>
    
   
		<br />    
        <br /> 
        <table  class="orderList" cellspacing="0">
<tr>
	<td class="bodyTxtLeft"><a href="colorAdd.jsp"><b>Add New Color</b></a></td>
</tr>
</table>   
          
    	<table class="orderList" cellspacing="0">
<tr>
	<td class="Hed">Color Id</td>
	<td class="Hed">Color name</td>
	<td class="Hed">Color Image</td>
	<td class="Hed">Operation</td>
</tr>
<%
	//String status = null;
	for(Iterator it = colors.iterator(); it.hasNext(); ) {
		color c = (color)it.next();
		
		%>
<tr>
	<td class="bodyTxtCenter"><%=c.getId() %></td>  
	<td class="bodyTxtCenter"><%=c.getName() %></td> 
	<td class="bodyTxtCenter"><img class="pic" src="../pic/picPattern/<%=c.getName() %>.jpg"></td> 
	<td class="bodyTxtCenter">
		<a href="colorList.jsp?id=<%=c.getId()%>" onclick="return confirm('delete the color?')">DELETE</a>	
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
		<a href="colorList.jsp?pageno=<%=1 %>">First</a>
		&nbsp;
		<a href="colorList.jsp?pageno=<%=pageNo-1 %>">Pre</a>
		&nbsp;
		<a href="colorList.jsp?pageno=<%=pageNo+1 %>">Next</a>
		&nbsp;
		<a href="colorList.jsp?pageno=<%=totalPages %>">Last</a>
</center>
<br />
<br />

</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
