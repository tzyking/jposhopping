<%@ page language="java" import="java.util.*, java.io.*, java.util.regex.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.client.*, com.bjsxt.shopping.product.*, com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.homepage.*" %>
<%
	List pos = picsOrder.getPicsOrderByCategoryname("shopping");
	int Min = 1, Max;
	
	Max = 6;
	int randomIndex = Min + (int)(Math.random() * ((Max - Min) + 1)); 
		
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head>
<title>John Patrick Organic: Mobile</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="John Patrick Organic, Designer T-Shirts, Designer tee's, Slips, Camisoles, Made in New york, Organic Cotton, Organic Shirting, Ethical, Sustainable, recycled, Online Store, Sweater, Designer Fashion, Organic Designer, Luxury, Designer, Shirts" /> 
<meta name="description" content="The world's most famous luxury designer organic fashion brand. leader in the sustainability and transparency. made in USA." />
<link rel="stylesheet" type="text/css" href="sample_files/jpoglobal_test.css">
<script type="text/javascript" src="sample_files/jquery.js"></script>
<script type="text/javascript" src="sample_files/jquery-ui.js"></script>
<script type="text/javascript" src="sample_files/global_test.js"></script>
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
<li style="text-align: right; height: 15px;"> 
<a id="mailinglist" href="joinMailingList.jsp" style="text-align: right; margin-right: 40px;">JOIN OUR MAILING LIST</a>
</li>
<li id="navigatorbar" style="text-align: right; height: 15px;"> 
<a href="look.jsp" id="collectionlink" style="text-align: right; margin-left: 20px;">COLLECTION</a>  
<a href="productList.jsp" id="shoppinglink" style="text-align: right; margin-left: 20px;">SHOPPING</a> 
<a href="about.jsp" id="otherlink" style="text-align: right; margin-left: 20px;">ABOUT</a> 
<a href="contact.html" id="contactlink" style="text-align: right; margin-left: 20px;">CONTACT</a> 
</li>
<li>
<table style="width:100%">
<tr>
<td style="text-align:left"><a href="index.jsp"><img src="sample_files/logo.jpg" /></a></td>
<td  style="text-align:right"><a href="http://www.facebook.com/pages/Organic-by-John-Patrick/142591215765336"><img src="pic/fb_icon_new.png" /></a>&nbsp;&nbsp; <a href="https://mobile.twitter.com/JPORGANIC"><img src="pic/twitter_icon_new.png" /></a>&nbsp;&nbsp; <a href="http://pinterest.com/jporganic/"><img src="pic/pinterest_icon_new.png" /></a>&nbsp;&nbsp; <a href="http://weibo.com/3166392887/profile?topnav=1&wvr=5"><img src="pic/weibo_icon_new.png" /></a></td>
</tr>
</table>
</li>
</ul>
</div>  
<div class="container_banner"  style="width: auto; display: block;">
 	<a href="productList.jsp"><img src="pic/mobile/banner/<%=randomIndex + ".jpg" %>"/></a>
	
</div>

<div id="copyright">Copyright 2010 John Patrick Organic</div>

</body></html>