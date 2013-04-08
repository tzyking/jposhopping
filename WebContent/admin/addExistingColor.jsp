<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.inventory.*"%>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.color.*" %>

<% 
String action = request.getParameter("action");
String id = request.getParameter("id").trim();
String pageno = request.getParameter("pageno").trim();

//Product p = ProductMgr.getInstance().loadById(Integer.parseInt(id));
List colors = color.getAvailableColorNames();
List sizes = inventoryRecord.getAllSizeOption();


if(action != null && action.equals("add") ) {
	String[] scolors = request.getParameterValues("color");
	String[] ssizes = request.getParameterValues("size");
	List ids = inventoryRecord.addByColorsSizeProductid(scolors, ssizes, Integer.parseInt(id));
	String strids = "";
	for (Iterator ids_it = ids.iterator(); ids_it.hasNext(); ) { 
    			strids = strids + (String)ids_it.next() + ",";
	}
	response.sendRedirect("inventorySetting.jsp?productid=" + id + "&pageno="+pageno+"&ids=" + strids);
}


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic: Product Edit</title>
<link rel="stylesheet" type="text/css" href="../css/productAdd.css">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery-ui.js"></script>
<script type="text/javascript" src="../js/productEdit.js"></script>
<!-- <script src="js/jquery.js" type="../text/javascript"></script> 
<script type="text/javascript">
  function refresh()
  {
          
           window.location.href="productEdit.jsp?id=" + document.getElementsByName("id") + "&pageno=" + document.getElementsByName("pageno")
  }
  </script>

-->
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
<br/>
<br/>

<form name="form" action="addExistingColor.jsp" method="post"> 
<input type="hidden" name="action" value="add">
<input type="hidden" name="id" id="id" value="<%=id %>">
<input type="hidden" name="pageno" id="pageno" value="<%=pageno %>">

<br/>
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft" colspan="2">Select Colors and relevant size</td>
</tr>
<tr>
	<td class="bodyTxtRight">Colors:</td>
	<td class="bodyTxtLeft">
<%for (Iterator itc = colors.iterator(); itc.hasNext(); ) { 
    			String color = (String)itc.next();
    		%>
	<INPUT TYPE="checkbox" NAME="color" value="<%=color %>"><%=color %><BR>
	
 <%} %>
</td>
</tr>
<tr>
	<td class="bodyTxtRight">Size:</td>
	<td class="bodyTxtLeft">
<%for (Iterator itc1 = sizes.iterator(); itc1.hasNext(); ) { 
    			String size = (String)itc1.next();
    		%>
	<INPUT TYPE="checkbox" NAME="size" value="<%=size %>"><%=size %><BR>
	
 <%} %>
</td>
</tr>
</table>
<br/>
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft">
	<a href="productEdit.jsp?id=<%=id %>&pageno=<%=pageno %>" STYLE="TEXT-DECORATION: NONE">
	<input type="button" name="cancel" value="cancel">
	</a>
	</td>
	<td class="HedTxtRight"><input type="submit" name="NextStep" value="Add" /></td>
</tr>
</table>
</form>
</div>
<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
