<%@ page language="java" import="java.util.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.client.*, com.bjsxt.shopping.product.*, com.bjsxt.shopping.util.*" %>
    
<%

	Cart c = (Cart)session.getAttribute("cart");
	CartItem ci = new CartItem();
ci.setCount(1);
ci.setColor("white");
ci.setSize("LG");
c.add(ci);

	List items = c.getItems();

 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	for(Iterator it = items.iterator(); it.hasNext(); ) {
		CartItem cii = (CartItem)it.next();
		%>
		<%=cii.getCount() %>/<%=cii.getColor() %>/<%=cii.getSize() %><br/>
		
	<%} %>

</body>
</html>