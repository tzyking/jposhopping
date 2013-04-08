<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.client.*, com.bjsxt.shopping.product.*, com.bjsxt.shopping.inventory.*, com.bjsxt.shopping.util.*" %>
<%
//String from = request.getParameter("from");
//if(from == null || (!from.equals("product.jsp")) &&)
//	response.sendRedirect("productList.jsp");
session.removeAttribute("guest");
request.setCharacterEncoding("GBK");
String action = request.getParameter("action");
List insuficientIRS = new ArrayList();

if(action == null){
	response.sendRedirect("productList.jsp");
}

Cart c = (Cart)session.getAttribute("cart");
if(c == null) {
	c = new Cart();
	session.setAttribute("cart", c);
	//response.sendRedirect("productList.jsp");
}

%>

<%
if(action != null && action.trim().equals("add")) {
	int id = Integer.parseInt(request.getParameter("id"));
	Product p = ProductMgr.getInstance().loadById(id);
	CartItem ci = new CartItem();
	ci.setProduct(p);
	ci.setCount(Integer.parseInt(request.getParameter("quantity").trim()));
	ci.setColor(request.getParameter("color").trim());
	ci.setSize(request.getParameter("size").trim());
	c.add(ci);
}

if(action != null && action.trim().equals("delete")) {
	int id = Integer.parseInt(request.getParameter("id"));
	String color = request.getParameter("color");
	String size = request.getParameter("size");
	c.deleteItemByIdSizeColor(id, size, color);
}

if(action != null && action.trim().equals("update")) {
	for(int i=0; i<c.getItems().size(); i++) {
		CartItem ci = (CartItem)c.getItems().get(i);
		int count = Integer.parseInt(request.getParameter("p" + ci.getProduct().getId()+ci.getSize().trim() + ci.getColor().trim()));
		ci.setCount(count);
	}
}

c.itemCheck();
 %> 

<%
List items = c.getItems();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html><head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>John Patrick Organic</title>
<link rel="stylesheet" type="text/css" href="css/cart.css">
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36719702-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<style type="text/css">

</style>

</head><body>

<div id="header">
<ul>
<li style="text-align:right; height: 15px">
<a href="look.html" id="collectionlink" style="text-align:right; margin-left: 20px">COLLECTION</a> 
<a href="productList.jsp" id="shoppinglink" style="text-align:right; margin-left: 20px">SHOPPING</a>
<a href="about.html" id="otherlink" style="text-align:right; margin-left: 20px">ABOUT</a>
<a href="contact.html" id="contactlink" style="text-align:right; margin-left: 20px">CONTACT</a>
</li>
<li style="text-align:left">
<a href="index.html"><img src="pic/logo.jpg" /></a>
</li>
<li>
	<a href="#" id="backhome"></a>
</li>
</ul>
</div>  

<div class="itemdetail">

		<img src="pic/stepBannerCart.gif" />    
		<br />    
        <br />  
        <%if(items.size() == 0){
 %> 
 <h3>There is no item in your shopping bag</h3> <br/><br/>
 <a href="productList.jsp"><img src="pic/continue_shopping.png"/></a>

 <%	
return;
}
  %>
  
<%
if(action != null && action.trim().equals("amountadjustment")) {
	c.getInsufficientInventoryRecords(insuficientIRS);	
 %>
<h3><P style="color:#FF0000;">Amount of Following items in our Inventory is insufficient, please edit the amount in your cart:</P></h3>
<ul style="color:#FF0000;">
<%
	for(Iterator it = insuficientIRS.iterator(); it.hasNext(); ) {
		inventoryRecord ir = (inventoryRecord)it.next();	
%>
	<li>productName: <%=ir.getProduct().getName() %> - Color: <%=ir.getColor() %> - Size: <%=ir.getSize() %> - Inventory Amount: <%=ir.getAmount() %></li>	
<%
	}
%>
</ul>
<% 
}
%>   
        <form action="cart.jsp" method="get">
		<input type="hidden" name="action" value="update"/> 
		 
    	<table summary="Software or other data table" class="cart" cellspacing="0">
<!--<tr>
	<td colspan="4" class="helpHed">Data table template, e.g., software list</td>
</tr>-->
<!--<tr class="blankRow">
	<td colspan="4" class="blankCell">Data table template, e.g., software list</td>
</tr>-->
<tr>
	<td class="Hed">ITEM</td>
	<td class="Hed">DESCRIPTION</td>
	<td class="Hed">QUANTITY</td>
	<td class="Hed">SUBTOTAL</td>
</tr>
<%
	for(Iterator it = items.iterator(); it.hasNext(); ) {
		CartItem ci = (CartItem)it.next();
		String color = StringReplacer.emptySpaceFixer(ci.getColor());
		String thumbPicFileName = "pic/" + ci.getProduct().getId() + "_thumb_" + color + ".jpg"; 
		%>
<tr>
	<td class="thumb"><img src="<%=thumbPicFileName%>"/></td>
	<td class="bodyTxtLeft"><%=ci.getProduct().getName() %><br /><%=ci.getProduct().getDescr()+". SIZE:" + ci.getSize() + " COLOR:" + ci.getColor() %><br />Price: $ <%=DecimalFormatDouble.customFormat("0.00",ci.getProduct().getNormalPrice()) %></td>  
	<td class="bodyTxtCenter">
		<input type="text" size=3 name="<%="p" + ci.getProduct().getId() + ci.getSize() + ci.getColor() %>" value="<%=ci.getCount()%>"/>
	</td> 
	<td class="subtotal">$ <%=DecimalFormatDouble.customFormat("0.00", ci.getProduct().getNormalPrice()*ci.getCount()) %>  <br /><br /><br /><a href="cart.jsp?action=delete&id=<%=ci.getProduct().getId() %>&size=<%=ci.getSize()%>&color=<%=ci.getColor() %>">REMOVE</a></td> 
</tr> 
	<%
	}
	%>
<tr>
	<td colspan="4" class="total"><a href="javascript:document.forms[0].submit()">UPDATE</a> Total: $ <%=DecimalFormatDouble.customFormat("0.00", c.getTotalNormalPrice()) %> <br />Does not include applicable sales tax or shipping</td>
</tr> 
</table>
</form>
<br />
<table  class="buttons" cellspacing="0">
<tr>
	<td><a href="productList.jsp"><img src="pic/continue_shopping.png"/></a>&nbsp&nbsp <a href="login.jsp?from=cart.jsp"><img src="pic/proceed.png"/></a></td>
</tr>
</table>
</div>

<div>
<table class="return-policy" cellspacing="0">
<tr><td class="return-policy-header">RETURN POLICY</td></tr>
<tr>
<td>We accept returns for merchandise credit within 14 days of ship date. No refunds. Merchandise cannot be worn, altered, or washed. To make a return, please email <b>jessica.organic@gmail.com</b> with your order information. Customer is responsible for cost of return shipping. Any discounted purchases are final sale. </td>
</tr>

</table>
</div>


<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body></html>