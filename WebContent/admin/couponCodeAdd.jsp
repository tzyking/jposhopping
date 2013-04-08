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
List products = ProductMgr.getInstance().getAvailableProducts();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic: Add New COupon Code</title>
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
 		$('#input_enddate').datepicker();
 		$('#btnGenerateCode').click(function () {
 			
 			var checkedproducts = [];
    		$('#checkbox_products :checked').each(function() {
       			checkedproducts.push($(this).val());
     		});
     		//alert(checkedproducts);
 			//return;
 			
 			//alert("generate");
 			var couponcode = $.trim($("#input_couponcode").val());
 			//alert("couponcode is" + couponcode);
 			//return;
 			var startdate = $.trim($("#input_startdate").val());
 			//alert(startdate);
 			var enddate = $.trim($("#input_enddate").val());
 			//alert(enddate);
 			//return;
 			var stramountoff = $.trim($("#input_amountoff").val());
 			var strpercentageoff = $.trim($("#input_percentageoff").val());
 			var couponcode = $.trim($("#input_couponcode").val());
 			
 			if(couponcode == '')
 			{
 				alert('Please input promotion code');
 				return;
 			}
 			if(stramountoff == '' && strpercentageoff == ''){
 				alert('Please input valid value on percentage OFF or Amount OFF');
 				return;
 			}
 			if(stramountoff != '' && strpercentageoff != ''){
 				alert('Please delete a value, percentage OFF or Amount OFF');
 				return;
 			}
 				
 			var off;
 			if(stramountoff != ''){
 				off = stramountoff;
 			}else{
 				off = Number(strpercentageoff.replace(/[^0-9\.]+/g,""))/100;
 			}
 			
 			//alert(off); 
 			//return;
 			
 			var intRegex = /^\d+$/;
			var floatRegex = /^((\d+(\.\d *)?)|((\d*\.)?\d+))$/;
			
			//var str = $('#myTextBox').val();
			if(!intRegex.test(off) && !floatRegex.test(off)) {
			   alert('your amount/percentage input is invalid, please check and re-enter');
			   return;
			}
			
			//alert("coponcode before AJAX :" + couponcode);
			//return;
			$.ajax({
					type: 		"post",
					url: 		"createCouponCode.jsp",
					data: 		"off=" + off + "&startdate=" + startdate + "&enddate=" + enddate + "&couponcode=" + couponcode + "&products=" + checkedproducts,
					success:	function(msg) {
						if($.trim(msg) == "code used")
						{
							alert("coupon code you input is currently being used, please try to enter other code");
							return;
						}
						var offDetail = off < 1? (off*100).toFixed() + '% OFF ' : off + ' Dollars OFF';  
						var display = '<br/><span style="font-size: 25px">' + offDetail + ' Coupon Code: <span style="color:red">'+$.trim(msg)+ '</span> is ready, Please save it as reference.</span><br/>';
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
	<div style="float:left; padding-right: 30px"><span style="">Promotion Code:</span></div><br/>
	<div style="float:left; padding-right: 30px"><input id="input_couponcode" value="" size="20"/></div><br/><br/>
	<div>Please specify the amount or percentage for the promotion code which will be generated:</div><br/>
	<div style="float:left; padding-right: 10px"><input id="input_amountoff" value="" size="20"/><span style="margin-left:5px">Dollars OFF</span></div><span style="float:left;">----OR----</span><div style="float:left; padding-left: 10px"><input id="input_percentageoff" value="" size="20"/><span style="margin-left:5px">% OFF</span></div><br/>
	<br/>
	<div style="float:left; padding-right: 30px"><span style="">Start Date:</span></div><div style="float:left; padding-left: 215px"><span style="">Ending Date:</span></div><br/>
	<div style="float:left; padding-right: 30px"><input id="input_startdate" value="" size="20"/></div><div style="float:left; padding-left: 140px"><input id="input_enddate" value="" size="20"/></div><br/>
	<br/>
	<div>
	<span>Please select products associated with this promotion code:</span>
		<ul id="checkbox_products">
			<%for (Iterator itc = products.iterator(); itc.hasNext(); ) { 
    			Product p = (Product)itc.next();
    		%>
				<li><p><INPUT TYPE="checkbox" NAME="color" value="<%=p.getId() %>"><%=p.getName() %>.  Price: $<%=p.getNormalPrice() %></p></li>			
			 <%} %>
		</ul> 
	</div>
	<div style="float:left;"><button type="button" id="btnGenerateCode" style="font-weight:bold; width:145px" >Generate Code</button></div><br/>
	<div id="resultarea"></div>
	<div id="gobacklinkarea"><a href="couponCodeList.jsp"><h5>Go Back to Promotion List</h5></a></div>
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
</form>
</div>-->
<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
