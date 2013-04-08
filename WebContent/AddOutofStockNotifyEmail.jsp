<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.email.*" %>
<%
String productid = request.getParameter("productid").trim();
String color = request.getParameter("color").trim();
String size = request.getParameter("size").trim();
String email = request.getParameter("email").trim();

OutofStockNotifyEmail m = new OutofStockNotifyEmail();
m.setProductid(Integer.parseInt(productid));
m.setColor(color);
m.setSize(size);
m.setEmail(email);
m.setCreateDate(new Date());
	
	if (m.save() > 0)
		out.println("saved");
	else
	    out.println("fail");	
%>
