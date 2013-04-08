<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.user.*" %>
<%
	User u = (User)session.getAttribute("user");
	if(u != null){
		//System.out.println("sgust is:"+ u.getUsername());
		//System.out.println("sgust is:"+ sgust);
		response.sendRedirect("ship_bill.jsp");	
	}

	String failInfo = request.getParameter("failInfo");
 %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
  <link rel="stylesheet" type="text/css" href="css/login.css">
  <link rel="stylesheet" href="css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" /> 
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine-en.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine.js" type="text/javascript"></script>
    
    <title>John Patrick Organic</title>
	<script>
		  
      $(document).ready(function() {
   
       $("#returnuserForm").validationEngine({
       		validationEventTriggers:"keyup blur"
       });
       $("#newuserForm").validationEngine({
       		validationEventTriggers:"keyup blur"
       });
       $("#guestForm").validationEngine({
       		validationEventTriggers:"keyup blur"
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

		<img src="pic/stepBannerLogin.gif">    
		<br />    
        <br /> 
        <%if (failInfo != null){ %>
        	<b style="color:red"><%=failInfo%></b>
        <%} %>   
 <table>
 <tr>
 <td>
<form id="returnuserForm" method="post" action="ship_bill.jsp">
<table class="returnCustomerLogin" cellspacing="0">

<tr>
	<td class="Hed">RETURNING CUSTOMER</td>
</tr>
<tr>
	<td class="bodyTxtRight">USERNAME 	<input class="validate[required,custom[noSpecialCaracters],length[0,20]]" name="username" id="username" value=""/></td>
</tr> 

<tr>
	<td class="bodyTxtRight">PASSWORD 	<input class="validate[required,length[6,15]] text-input" name="password" type="password" id="password" value=""></td>	
</tr> 

<tr>
<td class="loginbtn"><input class="submit" type="image" src="pic/login.png"></td>
</tr>
<input type="hidden" name="usertype" value="return"/> 
</table>

</form>
</td>
<td rowspan="2">
<form id="newuserForm" method="post" action="ship_bill.jsp">
<table class="newCustomerRegister" cellspacing="0">
<tr>
	<td class="Hed">NEW CUSTOMER</td>
</tr> 
<tr>
	<td class="bodyTxtRight">USERNAME <input class="validate[required,custom[noSpecialCaracters],length[0,20]]" id="nusername" name="username" value=""/>*</td>	
</tr> 
<tr>
	<td class="bodyTxtRight">E-MAIL <input  class="validate[required,custom[email]] text-input" id="nemail" name="email"  value=""/>*</td>	
</tr> 
<tr>
	<td class="bodyTxtRight">PASSWORD <input class="validate[required,length[6,15]] text-input" id="npassword" name="password" type="password"  value=""/>*</td>
</tr> 
<tr>
	<td class="bodyTxtRight">Note: Passwords MUST be at least 6 <br/> characters in length
and may contain <br />both numbers
and letters.</td>	
</tr>
<tr>
	<td class="bodyTxtRight">CONFIRM PASSWORD <input class="validate[required,confirm[npassword]] text-input" id="npassword2" name="confirmPassword" type="password"  value=""/>*</td>	
</tr> 
<tr>
<td class="registerbtn"><input class="submit" type="image" src="pic/create_an_account.png"></td>
</tr>
<input type="hidden" name="usertype" value="new"/> 
</table>

</form>
</td>

</tr>
<tr>
	<td>
		<form id="guestForm" method="post" action="ship_bill.jsp">
		
		<table class="expressCheckout" cellspacing="0">
		<tr>
		<td class="Hed">Express checkout</td>
		</tr>
		<tr>
			<td class="bodyTxtRight">E-MAIL <input  class="validate[required,custom[email]] text-input" id="guestemail" name="guestemail"  value=""/>*</td>	
		</tr>
		<tr>
		<td class="guestCheckout"><input class="submit" type="image" src="pic/checkout_as_guest.png"></td>
		</tr>
         <input type="hidden" name="usertype" value="guest"/>
		</table>
       
		</form>	
	</td>

</tr>
</table>

</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
