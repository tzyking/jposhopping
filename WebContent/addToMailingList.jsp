<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.email.*" %>
<%
String email = request.getParameter("email").trim();
mailingList m = new mailingList();
m.setEmail(email); 
m.setIsDeleted(0);	
	if (m.add() > 0)
		out.println("result saved");
	else
	    out.println("fail");	
%>
