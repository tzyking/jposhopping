<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.homepage.*" %>
<%
String currentorder = request.getParameter("currentorder");
String category = request.getParameter("category");
picsOrder.updateCurrentOrderbyCategoryName(currentorder, category);	
	if (picsOrder.updateCurrentOrderbyCategoryName(currentorder, category))
		out.println("result saved");
	else
	    out.println("fail");	
%>
