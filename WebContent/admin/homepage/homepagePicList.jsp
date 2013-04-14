<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.homepage.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%

	String category = request.getParameter("category");
	String order = picsOrder.getCurrentOrderByCategoryName(category);
	//List products = ProductMgr.getInstance().getProducts();
	//int size = products.size(); 

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
<title>John Patrick Organic: Home Page Pictures List</title>
<link rel="stylesheet" type="text/css" href="../../css/productList.css">
<link rel="stylesheet" href="../../jquery-ui-1.9.0.custom/css/ui-lightness/jquery-ui-1.9.0.custom.css">
<script src="../../jquery-ui-1.9.0.custom/js/jquery-1.8.2.js"></script>
<script src="../../jquery-ui-1.9.0.custom/js/jquery-ui-1.9.0.custom.js"></script>
<script src="js/homepage_pic_list.js"></script>

</head><body>

<div id="header">
<ul>
<li style="text-align:left">
<a href="../../index.jsp"><img src="../../pic/logo.jpg" /></a>
</li>

<li><a href="index.jsp" id="backhome">BACK HOME</a>
</li>
</ul>
<ul>
</ul>
</div>  

<div class="itemdetail">

    
   
		
		<br />    
        <br />    
          
<table class="list" cellspacing="0">
    	
<tr>
<%
	int index = 0;
	String surfix = "";
	StringTokenizer st = new StringTokenizer(order, ","); 
	 while (st.hasMoreTokens()) {
	 	String item = st.nextToken();
		surfix = "";
		if((index+1) % 4 == 0 && st.countTokens() > 0)
		   surfix = "</tr><tr>";
		else if(st.countTokens() == 0)
		   surfix = "</tr>";
%>

<td class="bodyTxtCenter"><img class="pic" src="../../pic/<%=category %>/<%=item %>.jpg"></td><%=surfix %>    

<%
     	index++;
}
%>
<tr>
<td class="bodyTxtCenter"></td>
<td class="bodyTxtRight"></td>
<td class="bodyTxtRight">Amount of Pictures For Upload:<INPUT type="text" id="picsamount" name="picsamount" /></td>
<td class="bodyTxtCenter"><button id="btnaddedit" name="btnaddedit">Add&Delete&Rearrange Pictures</button></td>
</tr>
<tr>
<td class="bodyTxtCenter"></td>
<td class="bodyTxtRight"></td>
<td class="bodyTxtLeft"></td>
<td class="bodyTxtCenter"><button id="btnedit" name="btnedit">Delete&Rearrange Pictures</button></td>
</tr>


</table>
<br/>

<br/>
 <input id="category_hidden_input" type="hidden" value="<%=category%>">
</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
