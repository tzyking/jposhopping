<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.inventory.*" %>
<%@ page import="com.bjsxt.shopping.color.*, com.bjsxt.shopping.promotion.*" %>
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
	couponcode.deleteById(id);
	couponcodeProduct.deleteByCouponcodeId(id);
}
if(strPageNo != null) {
	pageNo = Integer.parseInt(strPageNo);
}
if(pageNo < 1) pageNo = 1;



List couponCodes = new ArrayList();


int totalRecords = couponcode.getAvailableCouponCode(couponCodes, pageNo, PAGE_SIZE);

int totalPages = (totalRecords + PAGE_SIZE - 1) / PAGE_SIZE;
if(pageNo > totalPages && totalRecords > 0){ 
	pageNo = totalPages;
	couponcode.getAvailableCouponCode(couponCodes, pageNo, PAGE_SIZE);
}

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
</ul>
    
   
		<br />    
        <br /> 
        <table  class="orderList" cellspacing="0">
<tr>
	<td class="bodyTxtLeft"><a href="couponCodeAdd.jsp"><b>Add Coupon Code</b></a></td>
</tr>
</table>   
          
    	<table class="orderList" cellspacing="0">
<tr>
	<td class="Hed">Coupon Code Id</td>
	<td class="Hed">Coupon Code</td>
	<td class="Hed">Discount Detail</td>
	<td class="Hed">Operation</td>
</tr>
<%
if(couponCodes.size() > 0){
	//String status = null;
	double discountDetail;
	String strDiscountDetail;
	for(Iterator it = couponCodes.iterator(); it.hasNext(); ) {
		couponcode c = (couponcode)it.next();
		discountDetail = c.getAmountoff() > 0? c.getAmountoff(): c.getPercentageoff();
		if (discountDetail < 1)
			strDiscountDetail = DecimalFormatDouble.customFormat("0.00", discountDetail*100) + "% OFF";
		else
			strDiscountDetail = DecimalFormatDouble.customFormat("0.00", discountDetail) + " Dollars OFF";		 
		%>
<tr>
	<td class="bodyTxtCenter"><%=c.getId() %></td>  
	<td class="bodyTxtCenter"><%=c.getValue().toUpperCase() %></td> 
	<td class="bodyTxtCenter"><%=strDiscountDetail %></td> 
	<td class="bodyTxtCenter">
		<a href="couponCodeList.jsp?id=<%=c.getId()%>" onclick="return confirm('delete the Coupon Code?')">DELETE</a>	
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
		<a href="couponCodeList.jsp?pageno=<%=1 %>">First</a>
		&nbsp;
		<a href="couponCodeList.jsp?pageno=<%=pageNo-1 %>">Pre</a>
		&nbsp;
		<a href="couponCodeList.jsp?pageno=<%=pageNo+1 %>">Next</a>
		&nbsp;
		<a href="couponCodeList.jsp?pageno=<%=totalPages %>">Last</a>
</center>

<%
}else{
 %>
 <tr>
 	<td><b>NO Coupon Code Available.</b></td>
 </tr>
 </table>
 
 <%
 } 
 %>
<br />
<br />

</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
