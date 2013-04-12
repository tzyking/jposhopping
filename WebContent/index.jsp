<%@ page language="java" import="java.util.*, java.io.*, java.util.regex.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.client.*, com.bjsxt.shopping.product.*, com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.homepage.*" %>
<%
	Enumeration e;
	e = request.getHeaderNames();
	String userAgent = request.getHeader("user-agent");
	
	if(userAgent.matches(".*BlackBerry.*") || userAgent.matches(".*Android.*") || userAgent.matches(".*iPhone.*") || userAgent.matches(".*iPad.*")) {
		response.sendRedirect("mobile.jsp");
	}
	
	List pos = picsOrder.getPicsOrderByCategoryname("shopping");
	int Min = 1, Max;
	
	Max = 6;
	int randomIndex = Min + (int)(Math.random() * ((Max - Min) + 1)); 
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head>
<title>John Patrick Organic</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="John Patrick Organic, Designer T-Shirts, Designer tee's, Slips, Camisoles, Made in New york, Organic Cotton, Organic Shirting, Ethical, Sustainable, recycled, Online Store, Sweater, Designer Fashion, Organic Designer, Luxury, Designer, Shirts" /> 
<meta name="description" content="The world's most famous luxury designer organic fashion brand. leader in the sustainability and transparency. made in USA." />
<link rel="stylesheet" type="text/css" href="css/jpoglobal_test.css">
<link rel="stylesheet" type="text/css" href="css/header.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/global_test.js"></script>
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
<a id="mailinglist" href="joinMailingList.jsp">JOIN OUR MAILING LIST</a>
</li>
</ul>
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

<div class="container_banner"  style="width: auto; display: block;">
	<a href="productList.jsp"><img src="pic/Banner/<%=randomIndex + ".jpg" %>"/></a>
	<!--<a href="productList.jsp"><img src="../pic/SHOPbanner.jpg"/></a>-->
	</div>
<%
	for(Iterator it = pos.iterator(); it.hasNext(); ) {
		picsOrder p = (picsOrder)it.next();
		String divid = p.getCategoryName() + "_container";
%>

<div class="container"  id="<%=divid %>">
<a  class="left" href="#">&lt;</a>
<%
		String divccc = "category_container";
		if(p.getCategoryName().equals("shopping"))
			divccc = "category_container_shopping";	
%>
<div class="<%=divccc %>">

  <a name="photo"></a>
	<div class="loader"></div>
<%
		int t = -1;
		if (p.getCategoryName().equals("look"))
			t = 2;
		else if (p.getCategoryName().equals("shopping"))
			t = 2;
		else if (p.getCategoryName().equals("other"))
			t = 2;	
		String divcls = "photo";
		String id = "shopping";
	 	if (p.getCategoryName().equals("shopping"))
	 		divcls = "shoppingphoto";
	 	else if (p.getCategoryName().equals("look"))
	 	    id = "look";
	 	else if (p.getCategoryName().equals("other"))
	 	    id = "about";  	
		for (int i = 0; i < t; i++){
			StringTokenizer st = new StringTokenizer(p.getCurrentOrder(), ","); 
	 		while (st.hasMoreTokens()) {
	 			String item = st.nextToken();	
%>
  	<div class="<%=divcls %>" id="<%=id %>">
		<img src="pic/<%=p.getCategoryName() %>/<%=item %>.jpg">
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
<%
	}
%>


<div id="copyright">Copyright 2013 John Patrick Organic</div>


</body></html>