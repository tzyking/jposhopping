<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.inventory.*" %>
<%

int id = Integer.parseInt(request.getParameter("id"));
String pageno = request.getParameter("pageno").trim();
String from = request.getParameter("from").trim();
inventoryRecord ir = inventoryRecord.getInventoryRecordById(id);

String action = request.getParameter("action");
if(action != null && action.equals("modify") ) {
	int amount = Integer.parseInt(request.getParameter("amount"));
	inventoryRecord.updateAmount(ir.getId(), amount);
	//so.updateStatus(); 
	response.sendRedirect(from+".jsp?pageno="+pageno+"&productid="+ir.getProduct().getId());
}
	


%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:inventory record amount update</title>
<link rel="stylesheet" type="text/css" href="../css/inventoryEdit.css">
<script src="js/jquery.js" type="../text/javascript"></script>



</head><body>

<div id="header">
<ul>
<li>
<!--	<a href="#photo">PHOTO</a>
	<a href="#video">VIDEO</a>
	<a href="#weddings">WEDDINGS</a>-->
	<a href="#clients" id="otherlink"></a>
	<a href="#about" id="collectionlink"></a> 
	<a href="#contact" id="shoppinglink"></a>
	<a href="#" id="contactlink"></a>
</li>
<li>
	<a href="#" id="backhome"></a>
</li>
</ul>
</div>  

<div class="itemdetail">
<%if(from.equals("inventoryList")) {%>
<a href="inventoryList.jsp?pageno=<%=pageno%>">Back to inventoryList</a>
<%} %>
<br/>
<form name="form" action="inventoryEdit.jsp" method="post"> 
		<input type="hidden" name="action" value="modify">
		<input type="hidden" name="from" value="<%=from %>">
		<input type="hidden" name="id" value="<%=id %>">
		<input type="hidden" name="pageno" value="<%=pageno%>">         
    	<table class="amountUpdate" cellspacing="0">
<tr>
	<td colspan="6">Inventory Record Amount Update</td>
</tr>
<tr>
	<td  class="Hed">Inventory Record Id</td>
	<td  class="Hed">Product Name</td>
	<td  class="Hed">Product Description</td>
	<td  class="Hed">Color</td>
	<td  class="Hed">Size</td>
	<td  class="Hed">Amount</td>
	<td  class="Hed"></td>		
</tr>
<tr>
	<td class="bodyTxtCenter"><%=ir.getId() %></td>
	<td class="bodyTxtCenter"><%=ir.getProduct().getName() %></td>
	<td class="bodyTxtLeft"><%=ir.getProduct().getDescr() %></td>
	<td class="bodyTxtCenter"><%=ir.getColor() %></td>
	<td class="bodyTxtCenter"><%=ir.getSize() %></td>
	<td class="bodyTxtCenter"><input name="amount" style="width:40px" value="<%=ir.getAmount() %>" ></td>
	<td class="bodyTxtCenter"><input type="submit" value="Update"></td>	
</tr>
</table>
</form>
<br />
</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
