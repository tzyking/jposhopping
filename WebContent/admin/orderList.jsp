<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%!
private static final int PAGE_SIZE = 20;
%>

<%

String strPageNo = request.getParameter("pageno");
int pageNo = 1;
if(strPageNo != null) {
	pageNo = Integer.parseInt(strPageNo);
}
if(pageNo < 1) pageNo = 1;

List orders = new ArrayList();
int totalRecords = OrderMgr.getInstance().getOrders(orders, pageNo, PAGE_SIZE);

int totalPages = (totalRecords + PAGE_SIZE - 1) / PAGE_SIZE;
if(pageNo > totalPages){ 
	pageNo = totalPages;
	OrderMgr.getInstance().getOrders(orders, pageNo, PAGE_SIZE);
}//if(orders.size()== 0) pageNo = totalPages;

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:Order Management</title>
<link rel="stylesheet" type="text/css" href="../css/orderList.css">

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
          
    	<table class="orderList" cellspacing="0">
<tr>
	<td class="Hed">Order Id</td>
	<td class="Hed">User Id</td>
	<td class="Hed">Card No.(last 4 Digit)</td>
	<td class="Hed">Name</td>
	<td class="Hed">Email</td>
	<td class="Hed">City</td>
	<td class="Hed">State</td>
	<td class="Hed">Province</td>
	<td class="Hed">Country</td>
	<td class="Hed">ZipCode</td>
	<td class="Hed">MerchandiseTotal</td>
	<td class="Hed">Order Date</td>
	<td class="Hed">Status</td>
	<td class="Hed">Operation</td>
</tr>
<%
	String status = null;
	for(Iterator it = orders.iterator(); it.hasNext(); ) {
		SalesOrder so = (SalesOrder)it.next();
		if(so.getStatus() == 0)
			status = "Pending";
		else if(so.getStatus()== 1)
			status = "Shipped";
		else if(so.getStatus()== 2)
			status = "Invalid";
		
		double subtotal = 0;
		List sitms = OrderMgr.getInstance().getSalesItems(so);
		for(Iterator its = sitms.iterator(); its.hasNext(); ) {
			SalesItem si = (SalesItem)its.next();
			subtotal = subtotal + (si.getUnitPrice()*si.getCount());
		}
		%>
<tr>
	<td class="bodyTxtCenter"><%=so.getId() %></td>  
	<td class="bodyTxtCenter"><%=so.getUser().getId()%></td>
	 <td class="bodyTxtCenter"><%=so.getPr().getCnum().substring(so.getPr().getCnum().length()-4, so.getPr().getCnum().length()) %></td>
	<td class="bodyTxtCenter"><%=so.getSfirstName()+" "+ so.getSlastName() %></td>
	<td class="bodyTxtCenter"><%=so.getUser().getEmail() %></td>  
	<td class="bodyTxtCenter"><%=so.getScity() %></td> 
	<td class="bodyTxtCenter"><%=so.getSstate() %></td> 
	<td class="bodyTxtCenter"><%=so.getSprovince() %></td> 
	<td class="bodyTxtCenter"><%=so.getScountry() %></td> 
	<td class="bodyTxtCenter"><%=so.getSzip() %></td> 
	<td class="bodyTxtCenter"><%=DecimalFormatDouble.customFormat("0.00", subtotal ) %></td>
	<td class="bodyTxtCenter"><%=so.getODate() %></td> 
	<td class="bodyTxtCenter"><%=status %></td> 
	<td class="bodyTxtCenter">
		<a href="orderDetail.jsp?id=<%=so.getId()%>&pageno=<%=pageNo%>">Detail</a>&nbsp;
		<a href="orderEdit.jsp?id=<%=so.getId()%>&pageno=<%=pageNo%>">Edit</a>
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
		<a href="orderList.jsp?pageno=<%=1 %>">First</a>
		&nbsp;
		<a href="orderList.jsp?pageno=<%=pageNo-1 %>">Pre</a>
		&nbsp;
		<a href="orderList.jsp?pageno=<%=pageNo+1 %>">Next</a>
		&nbsp;
		<a href="orderList.jsp?pageno=<%=totalPages %>">Last</a>
	</center>
<br />
<br />

</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
