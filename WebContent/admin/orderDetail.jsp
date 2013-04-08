<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%

String sid = request.getParameter("id").trim();
int id = Integer.parseInt(sid);
double subtotal = 0, promotion = 0, originalPrice = 0;
SalesOrder so = OrderMgr.getInstance().loadById(id); 
List sitms = OrderMgr.getInstance().getSalesItems(so);
paymentRecord pr = paymentRecord.loadByorderId(id);

for(Iterator it = sitms.iterator(); it.hasNext(); ) {
	SalesItem si = (SalesItem)it.next();
	subtotal = subtotal + (si.getUnitPrice()*si.getCount());
}
if(pr.getBstate().equals("NY")) 
{
	originalPrice = subtotal*1.08;
	pr.setTax(subtotal*0.08);
}
else
{
	originalPrice = subtotal; 
	pr.setTax(0);
}

if(originalPrice > pr.getAmount())
{
	promotion = originalPrice - pr.getAmount();

}

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:Order Detail&Edit</title>
<link rel="stylesheet" type="text/css" href="../css/orderDetail.css">
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

           
    	<table class="items" cellspacing="0">
<tr>
	<td colspan="6">ITEMS IN THIS ORDER(<%=so.getODate() %>)</td>
</tr>
<tr>
	<td class="Hed">DESCRIPTION</td>
	<td class="Hed">COLOR</td>
	<td class="Hed">SIZE</td>
	<td class="Hed">UNIT PRICE</td>
	<td class="Hed">QUANTITY</td>
	<td class="Hed">SUBTOTAL</td>
</tr>
<%
	for(Iterator it = sitms.iterator(); it.hasNext(); ) {
		SalesItem si = (SalesItem)it.next();
		%>
<tr>
	<td class="bodyTxtLeft"><%=si.getProduct().getName() %><br /><%=si.getProduct().getDescr() %></td>  
	<td class="bodyTxtCenter"><%=si.getColor() %></td> 
	<td class="bodyTxtCenter"><%=si.getSize() %></td>
	<td class="bodyTxtCenter">$ <%=DecimalFormatDouble.customFormat("0.00", si.getProduct().getNormalPrice())%></td>  
	<td class="bodyTxtCenter"><%=si.getCount() %></td> 
	<td class="bodyTxtCenter">$ <%=DecimalFormatDouble.customFormat("0.00", si.getProduct().getNormalPrice()*si.getCount() )%></td> 
</tr> 
<%
}
 %>
<tr>
	<td colspan="6" class="merchandiseTotal">MERCHANDISE TOTAL: $ <%=DecimalFormatDouble.customFormat("0.00", subtotal )%></td>
</tr>
<tr>
	<td colspan="6" class="tax">TAX: $ <%=DecimalFormatDouble.customFormat("0.00",pr.getTax())%></td>
</tr> 
<tr>
	<td colspan="6" class="tax">Shipping: $ 00.00</td>
</tr>
<%if(promotion > 0){ %>
<tr>
	<td></td><td></td><td></td><td></td><td class="total" colspan="2">PROMOTION: -$<%=DecimalFormatDouble.customFormat("0.00", promotion)%></td>
</tr> 
<%} %>
<tr>
	<td></td><td></td><td></td><td></td><td class="total" colspan="2">TOTAL: $ <%=DecimalFormatDouble.customFormat("0.00", pr.getAmount())%></td>
</tr> 
</table>
<br />

<table  class="shippingInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft">SHIPPING INFORMATION</td>
</tr>
<tr>
	<td class="bodyTxtLeft"><%=so.getSfirstName() + " " + so.getSlastName() %></td> 
</tr>
<tr>
	<td class="bodyTxtLeft"><%=so.getSaddress1() %> </td> 
</tr>
<%if(so.getSaddress2()!= null){ %>
<tr>
	<td class="bodyTxtLeft"><%=so.getSaddress2() %> </td> 
</tr>
<%} %>
<tr>
	<td class="bodyTxtLeft"><%=so.getScity()+", "+so.getSstate()+" "+so.getSzip()+" "+so.getScountry()%></td> 
</tr>
<tr>
	<td class="bodyTxtLeft">Phone: <%=so.getSphone() %></td> 
</tr>
</table>
<br />
 
<table  class="billingInfo" cellspacing="0">
<tr>
	<td colspan="2" class="HedTxtLeft">BILLING INFORMATION</td>
</tr>
<tr>
	<td colspan="2" class="bodyTxtLeft"><%=pr.getBfirstName() + " " + pr.getBlastName() %></td> 
</tr>
<tr>
	<td colspan="2" class="bodyTxtLeft"><%=pr.getBaddress1() %></td> 
</tr>
<%if(pr.getBaddress2()!= null){ %>
<tr>
	<td colspan="2" class="bodyTxtLeft"><%=pr.getBaddress2() %></td> 
</tr>
<%} %>
<tr>
	<td colspan="2" class="bodyTxtLeft"><%=pr.getBcity()+", "+pr.getBstate()+" "+pr.getBzip()+" "+pr.getBcountry()%> </td>
</tr>
<tr>
	<td colspan="2" class="bodyTxtLeft">Phone: <%=pr.getBphone() %>  </td> 
</tr>


<!-- <tr>
	<td colspan="2" class="bodyTxtRight"><a href="#"><input type="image" src="pic/place_order.png"></a></td> 
</tr>
 -->
</table>


<table  class="contactInfo" cellspacing="0">
<tr>
	<td class="HedTxtRight">ORGANIC by John Patrick</td>
</tr>
<tr>
	<td class="HedTxtRight">HRH Clothier Corporation</td>
</tr>
<tr>
	<td class="HedTxtRight">5 Sherman Street</td>
</tr>
<tr>
	<td class="HedTxtRight">Albany, New York 12210</td>
</tr>
<tr>
	<td class="HedTxtRight">Customer Service: jessica.organic@gmail.com</td>
</tr>
</table>
</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
