<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.inventory.*" %>
<%@ page import="com.bjsxt.shopping.email.*" %>
<%!
private static final int PAGE_SIZE = 30;
%>

<%

String strPageNo = request.getParameter("pageno");

int pageNo = 1;
int id = -1;

if(strPageNo != null) {
	pageNo = Integer.parseInt(strPageNo);
}
if(pageNo < 1) pageNo = 1;

List mls = new ArrayList();


int totalRecords = mailingList.getAvailableEmails(mls, pageNo, PAGE_SIZE);

int totalPages = (totalRecords + PAGE_SIZE - 1) / PAGE_SIZE;
if(pageNo > totalPages){ 
	pageNo = totalPages;
	mailingList.getAvailableEmails(mls, pageNo, PAGE_SIZE);
	
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:Mailing List</title>
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
        
          
    	<table class="orderList" cellspacing="0">
<tr>
	<td class="Hed">Email Address</td>
</tr>
<%
	//String status = null;
	for(Iterator it = mls.iterator(); it.hasNext(); ) {
		mailingList m = (mailingList)it.next();
		
		%>
<tr>
	<td class="bodyTxtCenter"><%=m.getEmail()%></td>  
  
</tr> 
<%
}
 %>
</table>
<center>
		page&nbsp;<%=pageNo %>/
		<%=totalPages %>
		&nbsp;
		<a href="mailingList.jsp?pageno=<%=1 %>">First</a>
		&nbsp;
		<a href="mailingList.jsp?pageno=<%=pageNo-1 %>">Pre</a>
		&nbsp;
		<a href="mailingList.jsp?pageno=<%=pageNo+1 %>">Next</a>
		&nbsp;
		<a href="mailingList.jsp?pageno=<%=totalPages %>">Last</a>
</center>
<br />
<br />

</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
