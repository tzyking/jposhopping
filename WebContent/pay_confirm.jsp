<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%

User u = (User)session.getAttribute("user");
//String iGuest = (String)session.getAttribute("guest");
Cart c = (Cart)session.getAttribute("cart");
paymentRecord pr = null;
shippingInfo shpi = null;

String from = request.getParameter("from");

if(from != null && !from.equals("ship_bill.jsp")){
	if(u == null) {
		response.sendRedirect("login.jsp");
	}
	if(c == null) {
		response.sendRedirect("productList.jsp");
	}

}

String checkoutfail = request.getParameter("checkoutfail");

if(checkoutfail == null){
c.itemCheck();
String bfirstname = request.getParameter("bfirstname");
String blastname = request.getParameter("blastname");
String baddress1 = request.getParameter("baddress1");
String baddress2 = request.getParameter("baddress2");
String bcity = request.getParameter("bcity");
String bstate = request.getParameter("bstate");
String bzip = request.getParameter("bzip");
String bprovince = request.getParameter("bprovince");
String bcountry = request.getParameter("bcountry");
String bphone = request.getParameter("bphone");

pr = new paymentRecord();
pr.setBfirstName(bfirstname);
pr.setBlastName(blastname);
pr.setBaddress1(baddress1);
pr.setBaddress2(baddress2);
pr.setBcity(bcity);
pr.setBstate(bstate);
pr.setBprovince(bprovince);
pr.setBzip(bzip);
pr.setBcountry(bcountry);
pr.setBphone(bphone);

shpi = new shippingInfo();
String[] sameasbilling = request.getParameterValues("sameasbilling");
if(sameasbilling != null && sameasbilling[0].equals("1")){
	shpi.setSfirstName(bfirstname);
	shpi.setSlastName(blastname);
	shpi.setSaddress1(baddress1);
	shpi.setSaddress2(baddress2);
	shpi.setScity(bcity);
	shpi.setSstate(bstate);
	shpi.setSprovince(bprovince);
	shpi.setSzip(bzip);
	shpi.setScountry(bcountry);
	shpi.setSphone(bphone);
}else{
	shpi.setSfirstName(request.getParameter("sfirstname"));
	shpi.setSlastName(request.getParameter("slastname"));
	shpi.setSaddress1(request.getParameter("saddress1"));
	shpi.setSaddress2(request.getParameter("saddress2"));
	shpi.setScity(request.getParameter("scity"));
	shpi.setSstate(request.getParameter("sstate"));
	shpi.setSprovince(request.getParameter("sprovince"));
	shpi.setSzip(request.getParameter("szip"));
	shpi.setScountry(request.getParameter("scountry"));
	shpi.setSphone(request.getParameter("sphone"));
}

double tax = 0;
if (shpi.getSstate().equals("NY")){
	tax = c.getTotalNormalPrice()*0.08;
}
pr.setTax(tax);

double amount = c.getTotalNormalPrice() + tax;

pr.setAmount(amount);

Double originalAmount = new Double(amount);
session.setAttribute("paymentrecord", pr);
session.setAttribute("shippinginfo", shpi);
session.setAttribute("originalamount", originalAmount);

}else if(checkoutfail != null && checkoutfail.equals("true") ){
	 pr = (paymentRecord)session.getAttribute("paymentrecord");
 	 shpi = (shippingInfo)session.getAttribute("shippinginfo");
	
}



List items = c.getItems();
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:payment</title>
<link rel="stylesheet" type="text/css" href="css/pay_confirm.css">
<link rel="stylesheet" href="css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" /> 
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine-en.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine.js" type="text/javascript"></script>
<script>
		  
      $(document).ready(function() {
      
       $("#paymentForm").validationEngine({
       			validationEventTriggers:"keyup blur"
       	});
       	
       	$("#applycouponcode").click(function() {
       			//alert("coupon code");
       			var couponcode = $.trim($("#couponcode").val());
       			//alert(couponcode);
       			//return false;
       			
				$.ajax({
					type: 		"post",
					url: 		"applyCouponCode.jsp",
					data: 		"couponcode=" + couponcode,
					success:	function(msg) {
						//alert(msg);
						if($.trim(msg) == "invalid Code"){
							alert("the coupon code is invalid, please check and re-enter");
							return;
						}else if($.trim(msg)== "code not apply"){
							alert("The promotional code does not apply to any item of this order");
							return;
						}else if ($.trim(msg) == "Code used before"){
							alert("the coupon code was already applied to this order, you cannot use it again");
							return;
						}else{
							var originalPrice = Number($("#totalamount").text().replace(/[^0-9\.]+/g,""));
							//alert("originalPrice = " + originalPrice);
							var newPrice = Number(msg.replace(/[^0-9\.]+/g,""));
							//alert("newPrice = " + newPrice);
							var offamount = originalPrice - newPrice; 
							
							$("#totaloff").append("- $" + offamount.toFixed(2) + "<br/>"); 
						
							$("#couponcode").val("");
							$("#totalamount").text("");
							$("#totalamount").text("$" + newPrice.toFixed(2));
						}
		
					}
				});
				
       	});
      
      });

		
	</script>

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

    
   
		<img src="pic/stepBannerPay_confirm.gif">    
		<br />    
        <br />    
          
    	<table class="cart" cellspacing="0">
<tr>
	<td class="Hed">DESCRIPTION</td>
	<td class="Hed">QUANTITY</td>
	<td class="Hed">SUBTOTAL</td>
</tr>
<%
	for(Iterator it = items.iterator(); it.hasNext(); ) {
		CartItem ci = (CartItem)it.next();
		%>
<tr>
	<td class="bodyTxtLeft"><b><%=ci.getProduct().getName() %></b><br/><%=ci.getProduct().getDescr() %><br /><%="SIZE:" + ci.getSize() + " COLOR:" + ci.getColor()+". " %>Price: $ <%=DecimalFormatDouble.customFormat("0.00", ci.getProduct().getNormalPrice()) %></td>  
	<td class="bodyTxtCenter"><%=ci.getCount() %></td> 
	<td class="bodyTxtCenter">$ <%=DecimalFormatDouble.customFormat("0.00", ci.getProduct().getNormalPrice()*ci.getCount() )%></td> 
</tr> 
<%
}
 %>
<tr>
	<td colspan="3" class="merchandiseTotal">MERCHANDISE TOTAL: $ <%=DecimalFormatDouble.customFormat("0.00", c.getTotalNormalPrice() )%></td>
</tr>
<tr>
	<td colspan="3" class="tax">TAX: $ <%=DecimalFormatDouble.customFormat("0.00",pr.getTax())%></td>
</tr> 
<tr>
	<td colspan="3" class="tax">Shipping: $ 00.00</td>
</tr>
<tr>
	<td class="total" style="font-size: 14px; font-weight: bold"><b>Promotion Code:</b> <input size="20" maxlength="20" id="couponcode" name="couponcode" type="text" /></td><td class="total"><a id="applycouponcode" href="#"><input type="image" src="images/couponcode_submit.jpg"></a></td><td class="total" colspan="2" style="font-weight:bold; width: 25%; ">TOTAL: <span id="totaloff" style="color:red"></span> <span id="totalamount"><%="$" + DecimalFormatDouble.customFormat("0.00", pr.getAmount())%></span></td>
</tr> 

</table>
<br />

<table  class="cart" cellspacing="0">
<tr>
	<td class="HedTxtLeft">SHIPPING INFORMATION</td>
</tr>
<tr>
	<td class="bodyTxtLeft"><%=shpi.getSfirstName() + " " + shpi.getSlastName() %></td> 
</tr>
<tr>
	<td class="bodyTxtLeft"><%=shpi.getSaddress1() %> </td> 
</tr>
<%if(shpi.getSaddress2()!= null){ %>
<tr>
	<td class="bodyTxtLeft"><%=shpi.getSaddress2() %> </td> 
</tr>
<%} %>
<tr>
	<td class="bodyTxtLeft"><%=shpi.getScity()+", "+shpi.getSstate()+" "+shpi.getSzip()+" "+shpi.getScountry()%></td> 
</tr>
<tr>
	<td class="bodyTxtLeft">Phone: <%=shpi.getSphone() %>  </td> 
</tr>
</table>
<br/>
<table  class="cart" cellspacing="0">
<tr>
	<td class="HedTxtLeft">RETURN POLICY-</td>
</tr>
<tr>
	<td class="HedTxtLeft">We accept returns for credit within 10 days of receipt of merchandise. Merchandise can not be worn and needs to be in the original packaging. <br/>The customer is responsible for the cost of shipping the returned merchandise.</td>
</tr>
</table>
<br />
<form id="paymentForm" method="post" action="orderDone.jsp"> 
<input name="from" type="hidden" value="pay_confirm.jsp"/>
<table  class="cart" cellspacing="0">
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
<%if(checkoutfail != null && checkoutfail.equals("true")) {%>
<tr>
	<td colspan="2" class="bodyTxtLeft"><h3><font color="red">checkout failure, please check the payment information and resubmit</font></h3></td> 
</tr>

<%} %>
<tr>
	<td colspan="2" class="bodyTxtCenter"><h3>PAYMENT INFORMATION</h3>  </td> 
</tr>
<tr>
	 <td class="bodyTxtRight" width="50%">CARD TYPE:</td><td class="bodyTxtLeft" width="50%"> <select name="ctype">

	<option value="AmericanExpress">American Express</option>
	<option value="Discover">Discover</option>
	<option value="MasterCard">Master Card</option>
	<option value="Visa">Visa</option>
	<option value="JCB">JCB</option>
</select>* 
</td>
</tr>
<tr>
	 <td class="bodyTxtRight" width="50%">NAME OF CARDHOLDER: </td> <td class="bodyTxtLeft" width="50%"><input class="validate[required,custom[onlyLetter],length[0,20]] text-input" size="20" maxlength="20" id="cname" name="cname" type="text" />*
</td>
</tr>
<tr>
	 <td class="bodyTxtRight" width="50%">CARD NUMBER: </td> <td class="bodyTxtLeft" width="50%"><input class="validate[required,custom[onlyNumber],length[0,20]] text-input" size="20" maxlength="20" id="cnum" name="cnum" type="text" />* 
</td>
</tr>
<tr>
	<td class="bodyTxtRight" width="50%">EXPIRATION DATE:</td>
	<td class="bodyTxtLeft" width="50%"><select name="cexpmonth">
	<option value="01">January</option>
	<option value="02">February</option>
	<option value="03">March</option>
	<option value="04">April</option>
	<option value="05">May</option>

	<option value="06">June</option>
	<option value="07">July</option>
	<option value="08">August</option>
	<option value="09">September</option>
	<option value="10">October</option>
	<option value="11">November</option>

	<option value="12">December</option>
</select> 
												/ <select name="cexpyear">
	<option value="10">2010</option>
	<option value="11">2011</option>
	<option value="12">2012</option>
	<option value="13">2013</option>

	<option value="14">2014</option>
	<option value="15">2015</option>
	<option value="16">2016</option>
	<option value="17">2017</option>
	<option value="18">2018</option>
</select>*
 
 </td>

</tr>
<tr>
	<td colspan="2" class="bodyTxtRight"><a href="#"><input type="image" src="pic/place_order.png"></a></td> 
</tr>
</table>
</form>
</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
