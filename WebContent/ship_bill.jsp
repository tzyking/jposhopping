<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*, com.bjsxt.shopping.order.*, com.bjsxt.shopping.util.* " %>
<%
String name = null;
paymentRecord pr = null;
List States = null, Countries = null;
User user = (User)session.getAttribute("user");
Cart cart = (Cart)session.getAttribute("cart");
String usertype = request.getParameter("usertype");

States = State.getStates();
Countries = Country.getCountries();

if(user != null){
	name = user.getUsername();
}else if(usertype != null){
	if(usertype.trim().equals("return")) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		try {
			User u = User.check(username, password);
			session.setAttribute("user", u);
		} catch (UserNotFoundException e) {
			out.println(e.getMessage());
			response.sendRedirect("login.jsp?failInfo=Invalid Username");
		} catch (PasswordNotCorrectException e) {
			out.println(e.getMessage());
			response.sendRedirect("login.jsp?failInfo=invalid password");
		}
		pr = paymentRecord.loadByUsernamePassword(username, password);
		name = username;	
	}

	if(usertype.trim().equals("new")) {		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		
		if(User.usernameExist(username)){
			response.sendRedirect("login.jsp?failInfo=username already exists");
		}		
		User u = new User();
		u.setUsername(username);
		u.setPassword(password);
		u.setEmail(email);
		u.setRdate(new Date());
		int userid = -1;
		try{
		userid = u.saveAndReturnId();
		}catch(Exception e){
			response.sendRedirect("login.jsp?failInfo=create account fail");
		}
		u.setId(userid);
		session.setAttribute("user", u);
		name  = u.getUsername();
	}
	
	if(usertype.trim().equals("guest")){
		String guestemail = request.getParameter("guestemail");
		User u = new User();
		u.setUsername("guest");
		u.setPassword("guest");
		u.setEmail(guestemail);
		u.setRdate(new Date());
		session.setAttribute("user", u);
		name = "Guest";
	}
}else if(cart != null){
	response.sendRedirect("login.jsp");
}else{
	response.sendRedirect("productList.jsp");
}

 %>
 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>John Patrick Organic</title>
<link rel="stylesheet" type="text/css" href="css/ship_bill.css">
<link rel="stylesheet" href="css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" /> 
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine-en.js" type="text/javascript"></script>
<script src="js/jquery.validationEngine.js" type="text/javascript"></script>
<script>
		  
      $(document).ready(function() {
      
       $("#shipingbillingInfoForm").validationEngine({
       				validationEventTriggers:"keyup blur"
       	});
      
   		$(':checkbox').click(function () {
    		$("#sfirstname").toggleClass('validate[required,custom[onlyLetter],length[0,100]] text-input', !$(':checkbox:checked').length);
    		$("#slastname").toggleClass('validate[required,custom[onlyLetter],length[0,100]] text-input', !$(':checkbox:checked').length);
    		$("#saddress1").toggleClass('validate[required,length[0,200]] text-input', !$(':checkbox:checked').length);
    		$("#saddress2").toggleClass('validate[optional,length[0,200]] text-input', !$(':checkbox:checked').length);
    		$("#scity").toggleClass('validate[required,custom[onlyLetter],length[0,100]] text-input', !$(':checkbox:checked').length);
    		$("#sstate").toggleClass('validate[optional]', !$(':checkbox:checked').length);
    		$("#sprovince").toggleClass('validate[optional,custom[onlyLetter],length[0,100]]', !$(':checkbox:checked').length);
    		$("#szip").toggleClass('validate[required,custom[onlyNumber],length[0,30]]', !$(':checkbox:checked').length);
    		$("#scountry").toggleClass('validate[required]', !$(':checkbox:checked').length);
    		$("#sphone").toggleClass('validate[required,custom[telephone]] text-input', !$(':checkbox:checked').length);
    		
    		 $("#shipingbillingInfoForm").validationEngine({
       				validationEventTriggers:"keyup blur"
       			});
		});
		
		$('#reset_billingInfo').click(function () {
			$('#bfirstname').val('');
			$('#blastname').val('');
			$('#baddress1').val('');
			$('#baddress2').val('');
			$('#bcity').val('');		
			$('#bstate').val('');
			$('#bprovince').val('');
			$('#bzip').val('');
			$('#bcountry').val('US');
			$('#bphone').val('');	
			return false;	
		});

   		$("#sameasbilling").click( function(){
   			if( $(this).is(':checked') )
   			{
   				$('#sfirstname').val($('#bfirstname').val());	
   				$('#slastname').val($('#blastname').val());
   				$('#saddress1').val($('#baddress1').val());
   				$('#saddress2').val($('#baddress2').val());
   				$('#scity').val($('#bcity').val());
   				$('#sstate').val($('#bstate').val());
   				$('#sprovince').val($('#bprovince').val());
   				$('#szip').val($('#bzip').val());
   				$('#scountry').val($('#bcountry').val());
   				$('#sphone').val($('#bphone').val());
   				//$('#').val($('#').val());
   			} 

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

		<img src="pic/stepBannerShip_bill.gif">    
		<br /> 
		<b >Hi,<%=name%></b>    
  <form id="shipingbillingInfoForm"  method="post" action="pay_confirm.jsp"> 
  <input name="from" type="hidden" value="ship_bill.jsp"/>    
 <table>
 <tr>
 <td>
  
<table class="billingInformation" cellspacing="0">
<tr>
	<td class="Hed" colspan="2">BILLING INFORMATION</td>
</tr>
<tr><td>FIRST NAME: </td>
	<td class="bodyTxtLeft"><input class="validate[required,custom[onlyLetter],length[0,100]] text-input" id="bfirstname" name="bfirstname" value="<%=(pr!=null)? pr.getBfirstName() : "" %>"/></td>	
</tr> 
<tr>
	<td>LAST NAME: </td>
	<td class="bodyTxtLeft"><input class="validate[required,custom[onlyLetter],length[0,100]] text-input" id="blastname" name="blastname" value="<%=(pr!=null)? pr.getBlastName() : "" %>"/></td>	
</tr> 
<tr>
	<td>ADDRESS: </td>
	<td class="bodyTxtLeft"><input class="validate[required,length[0,200]] text-input" id="baddress1" name="baddress1" value="<%=(pr!=null)? pr.getBaddress1() : "" %>"/></td>	
</tr>
<tr>
	<td>APT/UNIT NO.: </td>
	<td class="bodyTxtLeft"><input class="validate[optional,length[0,200]] text-input" id="baddress2"  name="baddress2" value="<%=(pr!=null)? pr.getBaddress2() : "" %>"/></td>	
</tr>
<tr>
	<td>CITY: </td>
	<td class="bodyTxtLeft"><input class="validate[required,custom[onlyLetter],length[0,100]] text-input" id="bcity" name="bcity" value="<%=(pr!=null)? pr.getBcity() : "" %>"/></td>	
</tr>
<tr>
	<td>STATE: </td>
	<td class="bodyTxtLeft">
		<select class="validate[optional]" id="bstate" name="bstate">
  	<option value="" <%=(pr!=null && "".equals(pr.getBstate()))? "selected=\"selected\"" : "" %> >Select a state</option>
  	<%
  	for(Iterator it = States.iterator(); it.hasNext(); ) {
		State s = (State)it.next();
	 %>
	 	<option value="<%=s.getAbbreviation() %>" <%=(pr!=null&&s.getAbbreviation().equals(pr.getBstate()))? "selected=\"selected\"" : "" %> ><%=s.getName() %></option>
  	<%} %>
 	</select>&nbsp&nbsp&nbsp&nbsp&nbsp
    </td> 
</tr>
<tr>
 	<td></td>
	<td class="bodyTxtLeft">
    	&nbsp&nbsp&nbsp&nbsp&nbsp NOTE: For US orders, select your state from the dropdown above.
    </td>
   
</tr>
<tr>
	<td>PROVINCE: </td>
	<td class="bodyTxtLeft">
    	<input class="validate[optional,custom[onlyLetter],length[0,100]]" id="bprovince" name="bprovince" value="<%=(pr!=null)? pr.getBprovince() : "" %>"/>
    </td>
</tr>
<tr>
	 <td></td>
	<td class="bodyTxtLeft">
    	&nbsp&nbsp&nbsp&nbsp&nbsp NOTE: For international orders enter your province above.
    </td>
</tr>
<tr>
	 <td>ZIP: </td>
	<td class="bodyTxtLeft">
    	<input class="validate[required,length[0,30]]" id="bzip" name="bzip" value="<%=(pr!=null)? pr.getBzip() : "" %>"/>
    </td>
</tr>
<tr>
	<td>COUNTRY: </td>
	<td class="bodyTxtLeft">
        <select class="validate[required]" id="bcountry" name="bcountry">
     	<%
  		for(Iterator it = Countries.iterator(); it.hasNext(); ) {
			Country c = (Country)it.next();
	 	%>   
	 		<option value="<%=c.getIso2() %>" <%=(pr!=null&&c.getIso2().equals(pr.getBcountry()))? "selected=\"selected\"" : "" %> ><%=c.getCountry() %></option>
	 	<%} %>
        </select>
    </td>
</tr>
<tr>
	<td>PHONE: </td>
	<td class="bodyTxtLeft">
    	<input class="validate[required,custom[telephone]] text-input" id="bphone" name="bphone" value="<%=(pr!=null)? pr.getBphone() : "" %>"/>
    </td>
</tr>
<tr>
<td colspan="2" class="bodyTxtLeft"><a id="reset_billingInfo" href=""><b>Change Billing Information</b></a></td>
</tr>
</table>

</td>
</tr>
<tr>
<td>
<table class="shippingInformation" cellspacing="0">
<tr>
	<td class="Hed" colspan="2">SHIPPING INFORMATION</td>
</tr>
<tr>
	<td colspan="2" class="bodyTxtLeft"><input id="sameasbilling" name="sameasbilling" type="checkbox" value="1" /> <b>same as billing address</b> </td>	
</tr> 
<tr>
	<td>FIRST NAME: </td>
	<td class="bodyTxtLeft"><input class="validate[required,custom[onlyLetter],length[0,100]] text-input" id="sfirstname" name="sfirstname" value=""/></td>	
</tr> 
<tr>
	<td>LAST NAME: </td>
	<td class="bodyTxtLeft"><input  class="validate[required,custom[onlyLetter],length[0,100]] text-input" id="slastname" name="slastname" value=""/></td>	
</tr> 
<tr>
	<td>ADDRESS: </td>
	<td class="bodyTxtLeft"><input class="validate[required,length[0,200]] text-input" id="saddress1" name="saddress1" value=""/></td>	
</tr>
<tr>
	<td>APT/UNIT NO.:</td>
	<td class="bodyTxtLeft"><input class="validate[optional,length[0,200]] text-input" id="saddress2" name="saddress2" value=""/></td>	
</tr>
<tr>
	<td>CITY: </td>
	<td class="bodyTxtLeft"><input class="validate[required,custom[onlyLetter],length[0,100]] text-input" id="scity" name="scity" value=""/></td>	
</tr>
<tr>
	<td>STATE: </td>
	<td class="bodyTxtLeft">
		<select name="sstate" class="validate[optional]" id="sstate">
  	<option value="">Select a state</option>
  		<%
  	for(Iterator it = States.iterator(); it.hasNext(); ) {
		State s = (State)it.next();
	 %>
	 	<option value="<%=s.getAbbreviation() %>" ><%=s.getName() %></option>
  	<%} %>
  	<!-- 
	<option value="AL">Alabama</option>

	<option value="AK">Alaska</option>
	<option value="AZ">Arizona</option>
	<option value="AR">Arkansas</option>
	<option value="CA">California</option>
	<option value="CO">Colorado</option>
	<option value="CT">Connecticut</option>

	<option value="DC">Washington D.C.</option>
	<option value="DE">Delaware</option>
	<option value="FL">Florida</option>
	<option value="GA">Georgia</option>
	<option value="HI">Hawaii</option>
	<option value="ID">Idaho</option>

	<option value="IL">Illinois</option>
	<option value="IN">Indiana</option>
	<option value="IA">Iowa</option>
	<option value="KS">Kansas</option>
	<option value="KY">Kentucky</option>
	<option value="LA">Louisiana</option>

	<option value="ME">Maine</option>
	<option value="MD">Maryland</option>
	<option value="MA">Massachusetts</option>
	<option value="MI">Michigan</option>
	<option value="MN">Minnesota</option>
	<option value="MS">Mississippi</option>

	<option value="MO">Missouri</option>
	<option value="MT">Montana</option>
	<option value="NE">Nebraska</option>
	<option value="NV">Nevada</option>
	<option value="NH">New Hampshire</option>
	<option value="NJ">New Jersey</option>

	<option value="NM">New Mexico</option>
	<option value="NY">New York</option>
	<option value="NC">North Carolina</option>
	<option value="ND">North Dakota</option>
	<option value="OH">Ohio</option>
	<option value="OK">Oklahoma</option>

	<option value="OR">Oregon</option>
	<option value="PA">Pennsylvania</option>
	<option value="RI">Rhode Island</option>
	<option value="SC">South Carolina</option>
	<option value="SD">South Dakota</option>
	<option value="TN">Tennessee</option>

	<option value="TX">Texas</option>
	<option value="UT">Utah</option>
	<option value="VT">Vermont</option>
	<option value="VA">Virginia</option>
	<option value="WA">Washington</option>
	<option value="WV">West Virginia</option>

	<option value="WI">Wisconsin</option>
	<option value="WY">Wyoming</option>
	 -->
		</select>&nbsp&nbsp&nbsp&nbsp&nbsp
    </td> 
</tr>
<tr>
	<td></td>
	<td class="bodyTxtLeft">
    	&nbsp&nbsp&nbsp&nbsp&nbsp NOTE: For US orders, select your state from the dropdown above.
    </td>
</tr>
<tr>
	<td>PROVINCE: </td>
	<td class="bodyTxtLeft">
    	<input class="validate[optional,custom[onlyLetter],length[0,100]]" id="sprovince" name="sprovince" value=""/>
    </td>
</tr>
<tr>
	<td></td>
	<td class="bodyTxtLeft">
    	&nbsp&nbsp&nbsp&nbsp&nbsp NOTE: For international orders enter your province above.
    </td>
</tr>
<tr>
	<td>ZIP: </td>
	<td class="bodyTxtLeft">
    	<input class="validate[required,length[0,30]]" id="szip" name="szip" value=""/>
    </td>
</tr>
<tr>
	<td>COUNTRY: </td>
	<td class="bodyTxtLeft">
        <select class="validate[required]" id="scountry" name="scountry">
        <%
  		for(Iterator it = Countries.iterator(); it.hasNext(); ) {
			Country c = (Country)it.next();
	 	%>   
	 		<option value="<%=c.getIso2() %>" ><%=c.getCountry() %></option>
	 	<%} %>
	 	<!-- 
        	<option value="US">United States</option>
	<option value="AR">Argentina</option>
	<option value="AW">Aruba</option>
	<option value="AU">Australia</option>
	<option value="AT">Austria</option>

	<option value="BS">Bahamas</option>
	<option value="BB">Barbados</option>
	<option value="BE">Belgium</option>
	<option value="BM">Bermuda</option>
	<option value="BR">Brazil</option>
	<option value="CA">Canada</option>

	<option value="KY">Cayman Islands</option>
	<option value="CL">Chile</option>
	<option value="CN">China</option>
	<option value="CO">Colombia</option>
	<option value="CY">Cyprus</option>
	<option value="CZ">Czech Republic</option>

	<option value="DK">Denmark</option>
	<option value="DO">Dominican Republic</option>
	<option value="FI">Finland</option>
	<option value="FR">France</option>
	<option value="FX">France, Metropolitan</option>
	<option value="DE">Germany</option>

	<option value="GR">Greece</option>
	<option value="HK">Hong Kong</option>
	<option value="HU">Hungary</option>
	<option value="IN">India</option>
	<option value="IE">Ireland</option>
	<option value="IL">Israel</option>

	<option value="IT">Italy</option>
	<option value="JM">Jamaica</option>
	<option value="JP">Japan</option>
	<option value="KO">Korea</option>
	<option value="KW">Kuwait</option>
	<option value="LI">Liechtenstein</option>

	<option value="LU">Luxembourg</option>
	<option value="MO">Macau</option>
	<option value="MX">Mexico</option>
	<option value="MC">Monaco</option>
	<option value="NL">Netherlands</option>
	<option value="AN">Netherlands Antilles</option>

	<option value="NZ">New Zealand</option>
	<option value="NO">Norway</option>
	<option value="PH">Philippines</option>
	<option value="PL">Poland</option>
	<option value="PT">Portugal</option>
	<option value="PR">Puerto Rico</option>

	<option value="QA">Qatar</option>
	<option value="LC">Saint Lucia</option>
	<option value="SA">South Africa</option>
	<option value="SG">Singapore</option>
	<option value="SK">Slovak Republic</option>
	<option value="SI">Slovenia</option>

	<option value="ES">Spain</option>
	<option value="GP">St. Bartholomew (Guadaloupe)</option>
	<option value="SE">Sweden</option>
	<option value="CH">Switzerland</option>
	<option value="TW">Taiwan</option>
	<option value="TH">Thailand</option>

	<option value="AE">United Arab Emirates</option>
	<option value="GB">United Kingdom</option>
	<option value="UY">Uruguay</option>
	<option value="VI">Virgin Islands (U.S.)</option>
	 -->
        </select>
    </td>
</tr>
<tr>
	<td>PHONE: </td>
	<td class="bodyTxtLeft">
    	<input class="validate[required,custom[telephone]] text-input" id="sphone" name="sphone" value=""/>
    </td>
</tr>
</table>

</td>
</tr>
<tr>
<td class="iconProceed"><input class="submit" type="image" src="pic/proceed.png"></td>
</tr>
</table>

</form>   
</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
