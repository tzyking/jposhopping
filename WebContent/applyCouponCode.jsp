<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*, com.bjsxt.shopping.promotion.*"%>
<%
		String strCouponCode = request.getParameter("couponcode").trim();
		
		if(!couponcode.checkExist(strCouponCode)){
			out.println("invalid Code");
			return;
		}
				
		ArrayList couponCodes = (ArrayList)session.getAttribute("couponcodes");
		if(couponCodes != null){
			for (Iterator iter = couponCodes.iterator(); iter.hasNext(); ) {
				String cp = (String)iter.next(); 
				if(cp.toLowerCase().equals(strCouponCode.toLowerCase())){
					out.println("Code used before");
					return;
				}
			}
		}else
			couponCodes = new ArrayList();
			
		couponCodes.add(strCouponCode); 
		session.setAttribute("couponcodes", couponCodes);
		
		List productIds = couponcode.getproductIdsbyCouponCode(strCouponCode);			
					
		paymentRecord prcopy = (paymentRecord)session.getAttribute("paymentrecord");
       	double off = couponcode.getCouponOffbyValue(strCouponCode);
       	Cart c = (Cart)session.getAttribute("cart");
       	double DiscountAmount = c.getDiscountAmountByCouponCodeoff(productIds, off);
       	//System.out.println("DiscountAmount = " + DiscountAmount);
       	
       	if(DecimalFormatDouble.customFormat("0.00", DiscountAmount).equals("0.00")){
       		System.out.println("return value: " + DiscountAmount);
       		out.println("code not apply");
			return;
       	}
       	
       	prcopy.setAmount(prcopy.getAmount() - DiscountAmount);
       	session.setAttribute("paymentrecord", prcopy);
       	//System.out.println("after: prcopy amount = " + prcopy.getAmount());
       	out.println(DecimalFormatDouble.customFormat("0.00", prcopy.getAmount()));
%>
