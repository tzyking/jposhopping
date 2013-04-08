<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.inventory.*"%>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.color.*" %>


<% 
/*
String action = request.getParameter("action");
if(action != null && action.equals("create") ) {
	String colorName = request.getParameter("colorName").trim().toUpperCase();	
	color c = new color();
	c.setName(colorName);
	c.setIsDeleted(0);
	int cid = c.add();
	
	//inventoryRecord.addByColorsProductid(colors, productid); 
	
	response.sendRedirect("colorImageUpload.jsp?colorName="+colorName);

}
*/
//List products = ProductMgr.getInstance().getAvailableProducts();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic: Add New Store Credit Code</title>
<link rel="stylesheet" type="text/css" href="../css/productAdd.css">
<link rel="stylesheet" href="../jquery-ui-1.9.0.custom/css/ui-lightness/jquery-ui-1.9.0.custom.css" />
<link rel="stylesheet" href="../jquery-ui-1.9.0.custom/css/ui-lightness/jquery-ui-1.9.0.custom.min.css" />
<script src="../jquery-ui-1.9.0.custom/js/jquery-1.8.2.js"></script>
<script src="../jquery-ui-1.9.0.custom/js/jquery-ui-1.9.0.custom.js"></script>
<script src="../jquery-ui-1.9.0.custom/js/jquery-ui-1.9.0.custom.min.js"></script>
<!-- <script src="../js/jquery.js" type="text/javascript"></script> -->
<script>
 $(document).ready(function() {
 		$('#gobacklinkarea').hide();
 		$('#input_startdate').datepicker();
 		$('#btnGenerateCode').click(function () {
 			var value = $.trim($("#input_value").val());
 			var startdate = $.trim($("#input_startdate").val());
 			var stramount = $.trim($("#input_amount").val());
 			
 			if(value == '')
 			{
 				alert('Please enter Store Credit Code');
 				return;
 			}
 			if(stramount == ''){
 				alert('Please enter the Amount for this store credit code');
 				return;
 			}
 			
 			if(startdate == ''){
 				alert('Please enter the start date for this store credit code');
 				return;
 			}
 				
 			var intRegex = /^\d+$/;
			var floatRegex = /^((\d+(\.\d *)?)|((\d*\.)?\d+))$/;
			
			if(!intRegex.test(stramount) && !floatRegex.test(stramount)) {
			   alert('your amount input is invalid, please check and re-enter');
			   return;
			}
			
			$.ajax({
					type: 		"post",
					url: 		"createGiftCard.jsp",
					data: 		"startdate=" + startdate + "&value=" + value + "&amount=" + stramount,
					success:	function(msg) {
						if($.trim(msg) == "code used")
						{
							alert("code you input is currently being used, please try to enter other code");
							return;
						}
						var offDetail = stramount + ' Dollars ';  
						var display = '<br/><span style="font-size: 25px">' + offDetail + ' Store Credit Code: <span style="color:red">'+$.trim(msg)+ '</span> is ready, Please save it as reference.</span><br/>';
						$('#resultarea').append(display);
						$('#gobacklinkarea').show("slow");
						
					}
				});
 			
 		});
 	
 });
 </script>



</head><body>

<div id="header">

</div>  

<div class="itemdetail">
<ul id="list-nav">
<li><a href="productList.jsp">Product Management</a></li>
<li><a href="orderList.jsp">Order Management</a></li>
<li><a href="inventoryList.jsp">Inventory Management</a></li>
<li><a href="homepage/index.jsp">Homepage Management</a></li>
<li><a href="colorList.jsp">Color Management</a></li>
<!-- <li><a href="#">PENDING</a></li>
<li><a href="#">PENDING</a></li> -->
</ul>
<br/>
<br/>

<div style="padding-left:1.5%; font-weight:bold">
	<div style="float:left; padding-right: 30px"><span style=""> Store Credit Code:</span></div><br/>
	<div style="float:left; padding-right: 30px"><input id="input_value" value="" size="20"/></div><br/><br/>
	<div>Please specify the amount for the store credit code which will be generated:</div><br/>
	<div style="float:left; padding-right: 10px"><input id="input_amount" value="" size="20"/><span style="margin-left:5px">Dollars</span></div><br/>
	<br/>
	<div style="float:left; padding-right: 30px"><span style="">Start Date:</span></div><br/>
	<div style="float:left; padding-right: 30px"><input id="input_startdate" value="" size="20"/></div><br/>
	<br/>
	<div style="float:left;"><button type="button" id="btnGenerateCode" style="font-weight:bold; width:145px" >Generate Code</button></div><br/>
	<div id="resultarea"></div>
	<div id="gobacklinkarea"><a href="giftCardList.jsp"><h5></h5></a></div>
</div>           
<!--<form name="form" action="colorAdd.jsp" method="post"> 
<input type="hidden" name="action" value="create">
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft" colspan="2">Color INFORMATION</td>
</tr>
<tr>
	<td class="bodyTxtRight">Color Name:</td>
	<td class="bodyTxtLeft"><input id="colorName" name="colorName" value="" size="40" /></td>
</tr>
</table>
<br/>
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtRight"><input type="submit" name="NextStep" value="Next Step" /></td>
</tr>
</table>
</form>-->
</div>
<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
