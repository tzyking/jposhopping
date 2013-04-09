<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.client.*, com.bjsxt.shopping.product.*, com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.homepage.*" %>
<%
	String order = picsOrder.getCurrentOrderByCategoryName("look");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html><head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>John Patrick Organic:Collection </title>
<link rel="stylesheet" type="text/css" href="css/look.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="sample_files/look.js"></script>
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
</head>
<body>

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

<div class="container"  id="look_container" style="width: auto; display: block;">
<a  class="left" href="#">&lt;</a>
<div class="category_container">
  <a name="photo"></a>
	<div class="loader"></div>
<%
		int t = 2;
		for (int i = 0; i < t; i++){
			StringTokenizer st = new StringTokenizer(order, ","); 
	 		while (st.hasMoreTokens()) {
	 			String item = st.nextToken();	
%>
  	
  	<div class="photo">
		<img src="sample_files/look/b<%=item %>.jpg">
		<div style="background-color: transparent;" class="photo_overlay">
		</div>
	</div>
<%
			}
		} 
%>
	
 </div> 
<a class="right" href="#">&gt;</a>
</div>

<div id="copyright">Copyright 2010 John Patrick Organic</div>

</body></html>