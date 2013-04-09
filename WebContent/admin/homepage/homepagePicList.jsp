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
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"></link>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js"></script>



<script>
	$(document).ready(function(){
		$("#btnaddedit").click(function(){
									//alert("yes");
									//alert($("#picsamount").val());
									var picsamount = $("#picsamount").val();
									//alert(value);
									window.location.href = "homepagePicUpload.jsp?category=<%=category%>"+"&picsamount="+picsamount;
								});
								
		$("#btnedit").click(function(){
									//alert("yes");
									//alert($("#picsamount").val());
									//var picsamount = $("#picsamount").val();
									//alert(value);
									window.location.href = "deletePics.jsp?category=<%=category%>";
								});
		
	});
</script>
</head><body>

<div id="header">
<ul>
<li style="text-align:left">
<a href="index.html"><img src="../../pic/logo.jpg" /></a>
</li>

<li><a href="#" id="backhome">BACK HOME</a>
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

</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
