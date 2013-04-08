<%@ page language="java" import="java.util.*, java.text.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*, com.bjsxt.shopping.promotion.*"%>
<%
		String strValue = request.getParameter("value").trim();
		String strAmount = request.getParameter("amount").trim();
		String strStartdate = request.getParameter("startdate").trim();

		double amount = Double.parseDouble(strAmount);
		
		giftCard gc = new giftCard();
		
		if(couponcode.checkExist(strValue) || giftCard.checkExist(strValue))
		{
			out.println("code used");
			return;
		}
						
		SimpleDateFormat isoFormat = new SimpleDateFormat("MM/dd/yyyy");
	  	Date startdate = isoFormat.parse(strStartdate);	
	  	Calendar cal = Calendar.getInstance();
		cal.setTime(startdate);
		cal.add(Calendar.YEAR, 1);
		Date enddate = cal.getTime();
		
		gc.setValue(strValue); 
		gc.setAmount(amount);
		gc.setStartDate(startdate); 
		gc.setEndDate(enddate);
		gc.setIsDeleted(0);
		gc.add();
				
       	out.println(strValue.toUpperCase());
%>
