<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.client.*, com.bjsxt.shopping.product.*, com.bjsxt.shopping.util.*" %>
    
<%
Cart c = (Cart)session.getAttribute("cart");
if(c == null) {
	c = new Cart();
	session.setAttribute("cart", c);
	//response.sendRedirect("productList.jsp");
}

CartItem ci = new CartItem();
ci.setCount(1);
ci.setColor("red");
ci.setSize("XS");
c.add(ci);


	//response.sendRedirect("productList.jsp");


;
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%=c.toString() %>
<a href="sessionTest2.jsp">2</a>
</body>
</html>