<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%
	//String ids = ProductMgr.getInstance().getProductIdsIndisplayorder();
	
	List products = ProductMgr.getInstance().getAvailableProducts();
	//int size = products.size(); 

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>John Patrick Organic</title>
<link rel="stylesheet" type="text/css" href="css/productList.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
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
<div class="header-main-logo">
<a href="index.jsp"><img src="sample_files/logo.jpg" /></a>
</div>
<div class="header-nav-bar-container">
<ul class="nav">
<li>
<a href="look.jsp" id="collectionlink">COLLECTION</a>  
</li>
<li>
<a href="productList.jsp" id="shoppinglink">SHOPPING</a> 
</li>
<li>
<a href="about.jsp" id="otherlink">ABOUT</a> 
</li>
<li>
<a href="contact.html" id="contactlink">CONTACT</a>
</li>
</ul>
</div>
<div class="header-nav-bar-container">
<ul>
<li>
<a href="http://www.facebook.com/pages/Organic-by-John-Patrick/142591215765336"><img src="pic/fb_icon_new.png" /></a> 
</li>
<li>
<a href="https://mobile.twitter.com/JPORGANIC"><img src="pic/twitter_icon_new.png" /></a>
</li>
<li>
<a href="http://pinterest.com/jporganic/"><img src="pic/pinterest_icon_new.png" /></a>
</li>
<li>
<a href="http://weibo.com/3166392887/profile?topnav=1&wvr=5"><img src="pic/weibo_icon_new.png" /></a>
</li>
</ul>
</div>
</div>   

<div class="itemdetail">		

  
          
<table class="list" cellspacing="0" style="margin-left:auto; margin-right:auto; ">
    	

<tr>  
	<td class="bodyTxtCenter"></td>
	<td class="bodyTxtCenter"></td> <td class="bodyTxtCenter"></td>
	<td class="bodyTxtCenter" style="font-size:13pt; font-weight:bold">FREE SHIPPING!<br/>WORLDWIDE</td>   
</tr>
<tr><td class="bodyTxtCenter"></td>
	<td class="bodyTxtCenter"></td> <td class="bodyTxtCenter"></td>
	<td class="bodyTxtCenter"></td>   
</tr>
<tr>
<%
	int index = 0;
	String surfix = "";
	//StringTokenizer st = new StringTokenizer(ids, ","); 
	int size = products.size(); //int size = st.countTokens();
	
	
		
	// while (st.hasMoreTokens()) {
	// 	String item = st.nextToken();
	for(Iterator it = products.iterator(); it.hasNext(); ) {
		Product p = (Product)it.next();
	 	surfix = "";
	 	if((index+1) % 4 == 0 && (index+1)!= size)
		   surfix = "</tr><tr>";
		else if((index+1)== size)
		   surfix = "</tr>";
%>

<td class="bodyTxtCenter"><a style="text-decoration: none; color:black; " href="product.jsp?id=<%=p.getId() %>"><img class="pic" src="pic/listItem/<%=p.getId() %>.jpg"><br/><b><%=p.getName() %></b></a><br/>$ <%=DecimalFormatDouble.customFormat("0.00",p.getNormalPrice()) %></td><%=surfix %>    

<%
     	index++;
}
%>
</table>


</div>



<div id="copyright">Copyright 2010 John Patrick Organic</div>


</body>
</html>
