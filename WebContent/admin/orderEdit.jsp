<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%

int id = Integer.parseInt(request.getParameter("id"));
String pageno = request.getParameter("pageno").trim();

SalesOrder so = OrderMgr.getInstance().loadById(id);

String action = request.getParameter("action");
if(action != null && action.equals("modify") ) {
	int status = Integer.parseInt(request.getParameter("status"));
	so.setStatus(status);
	so.updateStatus(); 
	response.sendRedirect("orderList.jsp?pageno="+pageno);
}

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:Order Detail&Edit</title>
<link rel="stylesheet" type="text/css" href="../css/orderEdit.css">
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
<a href="orderList.jsp?pageno=<%=pageno%>">Back to OrderList</a>
<br/>
<form name="form" action="orderEdit.jsp" method="post"> 
		<input type="hidden" name="action" value="modify">
		<input type="hidden" name="id" value="<%=id %>">
		<input type="hidden" name="pageno" value="<%=pageno%>">         
    	<table class="statusUpdate" cellspacing="0">
<tr>
	<td  class="Hed" colspan="2">order status update</td>
</tr>
<tr>
	<td>
		<select name="status">
			<option value="0">Pending</option>
			<option value="1">Shipped</option>
			<option value="2">Invalid</option>
		</select>	
	</td>
	<td><input type="submit" value="Update"></td>	
</tr>
</table>
</form>
<br />
</div>

<script type="text/javascript">
	//alert(document.forms("form").status.options.length);
	for(i=0; i<document.forms("form").status.options.length; i++) {

		if(document.forms("form").status.options[i].value == <%=so.getStatus()%>) {
			document.forms("form").status.selectedIndex = i;
		}
		
	}
</script>


<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
