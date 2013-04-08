<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.inventory.*"%>
<%@ page import="com.bjsxt.shopping.util.*" %>

<% 

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic: Picture Replace</title>
<link rel="stylesheet" type="text/css" href="../../css/productAdd.css">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery-ui.js"></script>
<script type="text/javascript" src="../js/picReplace.js"></script>



</head><body>

<div id="header">

</div>  

<div class="itemdetail">
<ul id="list-nav">
<!-- <li><a href="#">PENDING</a></li>
<li><a href="#">PENDING</a></li> -->
</ul>
<br/>
<br/>
<form name="form" action="../../servlet/MainPicReplace" method="post" enctype="multipart/form-data"> 

<table  class="productInfo" cellspacing="0">
<tr>
	<td class="bodyTxtRight">Main Image at home page:</td>
	<td class="bodyTxtLeft"><INPUT TYPE="FILE" NAME="SHOPbanner"></td>
</tr>
</table>
<br/>
<table  class="productInfo" cellspacing="0">
<tr>
	<td class="HedTxtLeft"><input type="button" name="cancel" id="cancel" value="Cancel"  /></td>
	<td class="HedTxtRight"><input type="submit" name="NextStep" value="Start Update" /></td>
</tr>
</table>
</form>
</div>
<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
