<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.inventory.*"%>
<%@ page import="com.bjsxt.shopping.util.*" %>

<% 
//String action = request.getParameter("action");
String id = request.getParameter("id").trim();
String pageno = request.getParameter("pageno").trim();

/*
Product p = ProductMgr.getInstance().loadById(Integer.parseInt(id));


if(action != null && action.equals("update") ) {
	p.setName(request.getParameter("productName").trim());
	p.setDescr(request.getParameter("productDescr").trim());
	p.setNormalPrice(Double.parseDouble(request.getParameter("productPrice").trim()));
	p.setMemberPrice(Double.parseDouble(request.getParameter("productPrice").trim()));
	
	ProductMgr.getInstance().update(p);
	response.sendRedirect("productList.jsp?pageno="+pageno);
}
*/

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic: Product Image Edit</title>
<link rel="stylesheet" type="text/css" href="../css/productAdd.css">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery-ui.js"></script>
<script type="text/javascript" src="../js/picEdit.js"></script>
<!-- 
<script src="js/jquery.js" type="../text/javascript"></script> 
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
<!--
<li><a href="productList.jsp">Product Management</a></li>
<li><a href="orderList.jsp">Order Management</a></li>
<li><a href="inventoryList.jsp">Inventory Management</a></li>
<li><a href="homepage/index.jsp">Homepage Management</a></li>
 <li><a href="#">PENDING</a></li>
<li><a href="#">PENDING</a></li> -->
</ul>
<br/>
<br/>
<input type="hidden" name="id" id="id" value="<%=id %>">
<input type="hidden" name="pageno" id="pageno" value="<%=pageno %>">
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="bodyTxtLeft" colspan="3"><a href="productList.jsp?pageno=<%=pageno %>"><b>Back To ProductList</b></a></td>
</tr>
<tr>
	<td class="HedTxtLeft" >Pictures</td>
	<td class="HedTxtLeft" colspan="2"><!-- <input type="button" name="refresh" id="refresh" value="refresh" onclick="refresh()"> --></td>
</tr>
<tr>
	<td class="bodyTxtCenter">Pic For Homepage:</td>
	<td class="bodyTxtLeft">
		<img class="pic" src="../pic/listItem/<%=id %>.jpg">
	</td><td class="bodyTxtLeft">
		<a href="picReplace.jsp?id=<%=id %>&pageno=<%=pageno%>&type=listItem">CHANGE</a>
	</td>
</tr>
<tr>
	<td class="bodyTxtCenter">Pic For ShoppingCart:</td>
	<td class="bodyTxtLeft">
		<img class="pic" src="../pic/thumbItem/<%=id %>.jpg">
	</td><td class="bodyTxtLeft">
		<a href="picReplace.jsp?id=<%=id %>&pageno=<%=pageno%>&type=thumbItem">CHANGE</a>
	</td>
</tr>
<tr>
	<td class="bodyTxtCenter">Pic For Product Page:</td>
	<td class="bodyTxtLeft">
		<img class="pic" src="../pic/zoomItem/<%=id %>.jpg">
	</td><td class="bodyTxtLeft">
		<a href="picReplace.jsp?id=<%=id %>&pageno=<%=pageno%>&type=zoomItem">CHANGE</a>
	</td>
</tr>
<tr>
	<td class="bodyTxtCenter">Pic For Zoom-In:</td>
	<td class="bodyTxtLeft">
		<img class="pic" src="../pic/zoomItem/<%=id %>b.jpg" >
	</td><td class="bodyTxtLeft">
		<a href="picReplace.jsp?id=<%=id %>&pageno=<%=pageno%>&type=zoomItem_b">CHANGE</a>
	</td>
</tr>
<!-- 
<tr>
	<td class="bodyTxtRight" colspan="3">
		<a href="picReplace.jsp?id=<%=id %>&pageno=<%=pageno%>&type=all">CHANGE ALL</a>
	</td>
</tr>
 -->
</table>
<br/>
<!--
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtRight"><input type="submit" name="Update" value="Update" /></td>
</tr>
</table>
 </form> 
-->
</div>
<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
