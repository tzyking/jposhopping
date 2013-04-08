<%@ page language="java" import="java.util.*, java.text.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*, com.bjsxt.shopping.color.*" %>
<%@ page import="com.bjsxt.shopping.util.*" %>
<%@ page import="com.bjsxt.shopping.inventory.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String errorInfo = null;
int amount = -1, quantity = -1;
int id = -1;
String color = null, size = null;

String action = request.getParameter("action");
String pid = request.getParameter("id");
if(pid != null) {
	id = Integer.parseInt(pid);
}
Product p = ProductMgr.getInstance().loadById(id);
stringDivider sd = new stringDivider();
sd.setContent(p.getDescr());
List descr = sd.Divide(5);
List colors = inventoryRecord.getAvailableColorOptionByProductId(id);
String initial_color = (String)colors.get(0);
List sizes = inventoryRecord.getAvailableSizeOptionByProductId(id);

if(action != null && action.trim().equals("add")) {
//	int id = Integer.parseInt(request.getParameter("id"));
	color = request.getParameter("color").trim();
	size = request.getParameter("size").trim();
	amount = inventoryRecord.getAmountByPidSizeColor(id,size,color);
	quantity = Integer.parseInt(request.getParameter("quantity").trim());
	
	Cart c = (Cart)session.getAttribute("cart");
	int amountInCart = 0;
	if(c != null){
		for(int i=0; i<c.getItems().size(); i++) {
			CartItem ci = (CartItem)c.getItems().get(i);
			if(ci.getProduct().getId()== id && ci.getColor().equals(color) && ci.getSize().equals(size))
				amountInCart = ci.getCount();
		}
		//System.out.println("amountInCart is" + amountInCart);
	}
	
	if(amount == 0){
		errorInfo = "Your selected item is temporarily our of stock. Please enter your email in the email box to be notified when desired color ("+ color +")" + " and size (" + size + ") is available.";
	}else if(amount != 0 && amount < quantity + amountInCart){
		errorInfo= "the quantity is out of the amount in our inventory, the amount we currently have is " + amount + ", please change the quantity";
	}else{
		response.sendRedirect("cart.jsp?size="+size+"&color="+color+"&quantity="+quantity+"&action="+action+"&id="+id);
	}
	
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>John Patrick Organic</title>
	<link rel="stylesheet" type="text/css" href="css/product.css">
	<link rel="stylesheet" type="text/css" href="css/header.css">
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/jquery-ui.js"></script>
	<script type="text/javascript" src="js/product.js"></script>
	<LINK rel="stylesheet" type="text/css" href="css/jqzoom.css">
	<SCRIPT type="text/javascript" src="js/jquery.jqzoom1.0.1.js"></SCRIPT>
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

<div class="buy">
<%if(action != null){ %>
	<div id="info_display">
	<span id="error_info"><font color="red"><%=errorInfo%></font></span><br/>
	<div id='outofstock_notify_email_container' style="display:inline; float:left;">
		<div style="font-weight:bold; display:inline; margin-right:15px;">Enter Your email address:</div>
		<div style="display:inline; margin-right:15px"><input size="40" maxlength="40" id="outofstock_notify_email" name="outofstock_notify_email" type="text" /></div>
		<div style="display:inline;"><button id="btn_outofstock_notify_email" type="button" onclick="" >NOTIFY WHEN IN STOCK</button></div>
		<div id="color_size" style="display:none;"><%=color + ":" + size %></div>
	</div>
	<br/>
	<br/>
	</div>
<%} 
initial_color = StringReplacer.emptySpaceFixer(initial_color);
%>
<%
DateFormat df = new SimpleDateFormat ("yyyy-MM-dd");
Date date_2012_12_01 = df.parse("2012-12-01");
Date date_2012_01_01 = df.parse("2012-01-01");

if(p.getPdate().before(date_2012_12_01)){
//System.out.println("old product");
%>
	<div class="gallery">
	  <a href="<%="pic/zoomItem/"+pid+"b.jpg" %>" class="showPic" title="ZoomIn">
	  	<img src="<%="pic/zoomItem/" + pid + ".jpg" %>">
	  </a>
	</div>
	<%
	if (p.getPdate().after(date_2012_01_01)){
	%>
	<div class="gallery">
	  <a href="<%="pic/zoomItem/"+pid+"_flatb.jpg" %>" class="showPic" title="ZoomIn">
	  	<img src="<%="pic/zoomItem/" + pid + "_flat.jpg" %>">
	  </a>
	</div>
	<%} %>
<%} else { %>
	<div id="gallery_regular" class="gallery">
	  <a id="item_pic" href="<%="pic/zoomItem/"+pid+"b_" + initial_color + ".jpg" %>" class="showPic" title="ZoomIn">
	  	<img src="<%="pic/zoomItem/" + pid + "_"+ initial_color +".jpg" %>">
	  </a>
	</div>
	<%
	 
	if (p.getPdate().after(date_2012_01_01)){
	%>
	<div id="gallery_flat" class="gallery">
	  <a id="item_pic_flat" href="<%="pic/zoomItem/"+pid+"_flatb_" + initial_color + ".jpg" %>" class="showPic" title="ZoomIn">
	  	<img src="<%="pic/zoomItem/" + pid + "_flat_" + initial_color + ".jpg" %>">
	  </a>
	</div>
	<%} %>
<%} %>
<div class="itemdetail">
<ul>
	<form method="post" action="product.jsp">	
	<input name="from" type="hidden" value="product.jsp"/>	
    <li><b><%=p.getName() %></b></li>
 	<%for(Iterator it = descr.iterator(); it.hasNext(); ) { 
 		String ci = (String)it.next();
 	%>
    <li><b><%=ci %></b></li> 	
 	<%} %>

    <li><b>Available in
    <%
    int i = 0;	
    for(Iterator itc = colors.iterator(); itc.hasNext(); ) { 
    	i++;
    	color = (String)itc.next();
    %>
    	<%if(colors.size() == 1) {%>
    	 	<%=" " + color %>
    	<%}else if(i==colors.size()){ %>
    		<%="and " + color %>
    	<%}else if(i == (colors.size()-1)){%>
    		<%=" " + color %>
    	<%}else{ %>
			<%=" " + color + ","%>
		<%} %>    
    <%} %>
    </b></li>
    <li>
    	<%if (id >= 9) {%>
    	<table  cellspacing="0">
    		<tr>
    		
    		<%for (Iterator itc1 = colors.iterator(); itc1.hasNext(); ) { 
    			color = (String)itc1.next();
    		%>
    			<td class="color_pattern_container"><a class="color_options" href="#" color="<%=color %>"><img class="pic" src="<%="pic/picPattern/" + color + ".jpg" %>"></a></td>
    			<td class="spacer"></td>
    		<%} %>
    		</tr>
    	</table>
    	<%} %>
    </li>
    <li></li>
    <li></li>
    <li>$ <%=DecimalFormatDouble.customFormat("0.00",p.getNormalPrice()) %></li>
    <li></li> 
    <li>size:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    	<select name="size" class="sizeSelector">
    	    <%for(Iterator its = sizes.iterator(); its.hasNext(); ) { 
    		size = (String)its.next(); %>
  			<option value="<%=size %>"><%=size %></option>
  			<%} %>
		</select>
     <a href="JavaScript:newPopup('sizeChart.htm');"><img src="pic/sizechart_button.jpg"></a></li>
     <li></li> 
     <li>color:&nbsp&nbsp&nbsp
    	<select name="color" class="colorsSelector">
  			<%for(Iterator itc1 = colors.iterator(); itc1.hasNext(); ) { 
    		color = (String)itc1.next(); %>
  			<option value="<%=color %>"><%=color %></option>
  			<%} %>
		</select>
    </li>
    <li></li>
    <li>Quantity:&nbsp <input name="quantity" class="quanityInput" value="1"/></li>
    <li></li>
    <li style="font-size:13pt; font-weight:bold"><input type="image" src="pic/add_to_bag.png">&nbsp&nbsp&nbsp&nbsp FREE SHIPPING!</li>
    <br/>
    <li>
    	<a href="http://pinterest.com/pin/create/button/?url=http%3A%2F%2Forganicbyjohnpatrick.com%2Fproduct.jsp%3Fid%3D<%=pid %>&media=http%3A%2F%2Forganicbyjohnpatrick.com%2Fpic%2FzoomItem%2F<%=pid %>b.jpg" class="pin-it-button" count-layout="horizontal"><img border="0" src="//assets.pinterest.com/images/PinExt.png" title="Pin It" /></a>
    </li>
    <input name="action" size="10" type="hidden" value="add"/>
    <input id="input_pid" name="id" size="10" type="hidden" value="<%=pid%>"/>
    </form>
</ul>
</div>
</div>


<div id="copyright">Copyright 2010 John Patrick Organic</div>

<script type="text/javascript" src="//assets.pinterest.com/js/pinit.js"></script>
</body>
</html>
