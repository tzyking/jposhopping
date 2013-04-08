<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.email.*" %>
<%

User u = (User)session.getAttribute("user");
//String iGuest = (String)session.getAttribute("guest");
Cart c = (Cart)session.getAttribute("cart");

String from = request.getParameter("from");

if(!from.equals("pay_confirm.jsp"))
	response.sendRedirect("productList.jsp");
	
if(c == null) {
	response.sendRedirect("productList.jsp");
}	
	
if(u == null) {
	response.sendRedirect("login.jsp");
}
int flag = c.inventoryAmountCheck(); 
System.out.println("amount check =" + flag); 
if( flag < 0 ){
	response.sendRedirect("cart.jsp?action=amountadjustment");
	return; 
}
int guest = 0;
int ireturn = -1;

paymentRecord pr = (paymentRecord)session.getAttribute("paymentrecord");
shippingInfo shpi = (shippingInfo)session.getAttribute("shippinginfo");

String ctype = request.getParameter("ctype");
String cname = request.getParameter("cname");
String cnum = request.getParameter("cnum");
String cexpmonth = request.getParameter("cexpmonth");
String cexpyear = request.getParameter("cexpyear");

pr.setCtype(ctype);
pr.setCname(cname);
pr.setCnum(cnum);
pr.setCexpmonth(cexpmonth);
pr.setCexpyear(cexpyear);
orderXML ox = new orderXML();
String sox = ox.getOrderXML(pr);
orderPointTxn tx = new orderPointTxn("/usr/share/1001249062.p12", "1001249062", "secure.linkpt.net", "hats4287", 1129);
boolean approved = tx.process(sox);

approved = true;   //test mark, need to be removed 

int orderId = -1;
String receiverName = "";
if(approved){
	if(u.getUsername().equals("guest") && u.getPassword().equals("guest")){
		u.setId(u.saveAndReturnId());
		receiverName = "Guest";
	}else{
		receiverName = u.getUsername();
	}
	c.itemCheck();	
	orderId = u.buy(c, shpi);
	pr.setOrderId(orderId);
	pr.save();
	
	session.removeAttribute("cart");
	session.removeAttribute("couponcodes");
	session.removeAttribute("paymentrecord");
	session.removeAttribute("shippinginfo");
}else{
	response.sendRedirect("pay_confirm.jsp?checkoutfail=true");
}

pr = null;
double subtotal = 0;
SalesOrder so = OrderMgr.getInstance().loadById(orderId); 
List sitms = OrderMgr.getInstance().getSalesItems(so);
pr = paymentRecord.loadByorderId(orderId);

for(Iterator it = sitms.iterator(); it.hasNext(); ) {
	SalesItem si = (SalesItem)it.next();
	subtotal = subtotal + (si.getUnitPrice()*si.getCount());
}

Double originalAmount = (Double)session.getAttribute("originalamount");
pr.setTax(originalAmount.doubleValue()- subtotal);

orderConfirmationEmail oce = new orderConfirmationEmail();
oce.setTax(pr.getTax());
oce.setOrderId(orderId);
ireturn = oce.send(u.getEmail(), receiverName);
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:Thanks For Your Shopping</title>
<link rel="stylesheet" type="text/css" href="css/orderDone.css">
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
</head><body>

<div id="header">
<ul>
<li style="text-align:right; height: 15px">
<a href="look.jsp" id="collectionlink" style="text-align:right; margin-left: 20px">COLLECTION</a> 
<a href="productList.jsp" id="shoppinglink" style="text-align:right; margin-left: 20px">SHOPPING</a>
<a href="about.jsp" id="otherlink" style="text-align:right; margin-left: 20px">ABOUT</a>
<a href="contact.html" id="contactlink" style="text-align:right; margin-left: 20px">CONTACT</a>
</li>
<li style="text-align:left">
<a href="index.jsp"><img src="pic/logo.jpg" /></a>
</li>
<li>
	<a href="#" id="backhome"></a>
</li>
</ul>
</div>  

<div class="itemdetail">

    
   
		   
		<br />    
        <br />    
          
<table class="orderInfo" cellspacing="0">
<tr>
	<td class="Hed" colspan="3">ORDER FINISHED</td>
</tr>

<tr>
	<td class="bodyTxtLeft"><b>thanks for your shopping!</b><br/>
	your order is placed, order id is: <b><%=orderId %></b><br/>
	please keep it for reference<br/> 
	<%if(ireturn == 0){%>
    A order confirmation email has been send to the email address: <b><%=u.getEmail() %></b><br/>
    Please print this page for reference.
	<%}else if(ireturn == 1){%>
	We are unable to send a order confirmation email to the email address <b><%=u.getEmail() %></b><br/>
	If you need the Email, please contact our customer service at: <b>jessica.organic@gmail.com</b>
	<%} %>
	</td>  
	<td class="bodyTxtCenter"></td> 
	<td class="bodyTxtCenter"><a href="productList.jsp"><img src="pic/continue_shopping.png"/></a></td> 
</tr> 
</table><br/>
<table class="items" cellspacing="0">
<tr>
	<td colspan="6">ITEMS IN THIS ORDER</td>
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
<%if(originalAmount.doubleValue() > pr.getAmount()){ %>
<tr>
	<td></td><td></td><td></td><td></td><td class="total" colspan="2">PROMOTION: -$<%=DecimalFormatDouble.customFormat("0.00", originalAmount.doubleValue() - pr.getAmount())%></td>
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
	<td class="HedTxtLeft">BILLING INFORMATION</td>
</tr>
<tr>
	<td class="bodyTxtLeft"><%=pr.getBfirstName() + " " + pr.getBlastName() %></td> 
</tr>
<tr>
	<td class="bodyTxtLeft"><%=pr.getBaddress1() %></td> 
</tr>
<%if(pr.getBaddress2()!= null){ %>
<tr>
	<td class="bodyTxtLeft"><%=pr.getBaddress2() %></td> 
</tr>
<%} %>
<tr>
	<td  class="bodyTxtLeft"><%=pr.getBcity()+", "+pr.getBstate()+" "+pr.getBzip()+" "+pr.getBcountry()%> </td>
</tr>
<tr>
	<td  class="bodyTxtLeft">Phone: <%=pr.getBphone() %>  </td> 
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


<br/>

<br/>

</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
