<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.inventory.*"%>
<%@ page import="com.bjsxt.shopping.util.*, com.bjsxt.shopping.homepage.*"  %>

<% 
String category = request.getParameter("category");
int picsamount = Integer.parseInt(request.getParameter("picsamount"));

int currentnumber = picsNumber.getCurrentNumberByCategoryName(category); 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:HomePage Pictures Upload</title>
<link rel="stylesheet" type="text/css" href="../../css/productAdd.css">
<script src="js/jquery.js"></script>



</head><body>

<div id="header">

</div>  

<div class="itemdetail">
<ul id="list-nav">
<!-- <li><a href="#">PENDING</a></li>
<li><a href="#">PENDING</a></li> -->
</ul>
<br/>
<br/>
<form name="form" action="../../servlet/homepagePicUpload" method="post" enctype="multipart/form-data"> 
<input type="hidden" name="category" value="<%=category %>">
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft" colspan="2">New Images Upload For Homepage</td>
</tr>
<%
	String bigfilename = "";
	for(int i = 0; i < picsamount; i++)
	{
		bigfilename = "b"+Integer.toString(currentnumber+i+1);
%>
<tr>
	<td class="bodyTxtRight">(<%=(i+1) %>)Small Size:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="<%=currentnumber+i+1 %>"></td>
</tr>
<tr>
	<td class="bodyTxtRight">Big Size:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="<%=bigfilename %>"></td>
</tr>
<%
} 
%>

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
