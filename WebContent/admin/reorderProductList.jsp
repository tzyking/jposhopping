<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%
	String ids = ProductMgr.getInstance().getProductIdsIndisplayorder();
	//int size = products.size(); 

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic: Reorder Images for Product List </title>
<link rel="stylesheet" type="text/css" href="../css/productList.css">

</head><body>

<div id="header">
<ul>



<li style="text-align:left">
<a href=""><img src="../pic/logo.jpg" /></a>
</li>

<li></li>
<li>
</li>
<li><a href="#" id="backhome"></a>
</li>
<li>
	
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
	<td class="bodyTxtCenter"></td>
	<td class="bodyTxtCenter"></td> <td class="bodyTxtCenter"></td>
	<td class="bodyTxtCenter" style="font-size:13pt; font-weight:bold">REORDER IMAGES FOR PRODUCT LIST:</td>   
</tr>
<tr><td class="bodyTxtCenter"></td>
	<td class="bodyTxtCenter"></td> <td class="bodyTxtCenter"></td>
	<td class="bodyTxtCenter"></td>   
</tr>
<tr>
<%
	int index = 0;
	String surfix = "";
	StringTokenizer st = new StringTokenizer(ids, ","); 
	int size = st.countTokens();
	
	 while (st.hasMoreTokens()) {
	 	String item = st.nextToken();
	 	surfix = "";
	 	if((index+1) % 4 == 0 && (index+1)!= size)
		   surfix = "</tr><tr>";
		else if((index+1)== size)
		   surfix = "</tr>";
%>

<td class="bodyTxtCenter">
<b><%=item %></b><br/>
<a href="product.jsp?id=<%=item %>"><img class="pic" src="../pic/listItem/<%=item %>.jpg"></a>
</td><%=surfix %>    

<%
     	index++;
}
%>



</table>
<br/>
<br/>

</div>

<form action="saveProductListOrder.jsp" method="post">
Enter new order:(for example:40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58 )	<br/>  
 <input name="currentorder" value="" size="100"/>
 <input type="submit" value="OK" id="okbtn" name="OK"/>                    
</form>


<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
