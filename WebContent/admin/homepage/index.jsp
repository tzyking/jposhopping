<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.inventory.*" %>
<%!
private static final int PAGE_SIZE = 90;
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic:Product Management</title>
<link rel="stylesheet" type="text/css" href="../../css/productList_admin.css">

<script src="../../js/jquery.js" type="text/javascript"></script>


</head><body>

<div id="header">
</div>  

<div class="itemdetail">
<ul id="list-nav">
<li><a href="homepagePicList.jsp?category=look">Collection Images Edit</a></li>
<li><a href="homepagePicList.jsp?category=shopping">Shopping Images Edit</a></li>
<li><a href="homepagePicList.jsp?category=other">About Images Edit</a></li>

<!-- <li><a href="#">PENDING</a></li>
<li><a href="#">PENDING</a></li> -->
</ul>
    
   
		<br />    
        <br /> 
        <br />
		<br />
        <a href="MainPicReplace.jsp">Edit Following Picture at HOME PAGE:</a><br/><br/>
        <img class="pic" src="../../../pic/SHOPbanner.jpg">
		<br />
		<br />

</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
