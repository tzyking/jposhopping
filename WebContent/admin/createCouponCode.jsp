<%@ page language="java" import="java.util.*, java.text.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.product.*, com.bjsxt.shopping.user.*, com.bjsxt.shopping.client.*" %>
<%@ page import="com.bjsxt.shopping.order.*" %>
<%@ page import="com.bjsxt.shopping.util.*, com.bjsxt.shopping.promotion.*"%>
<%
		String strOff = request.getParameter("off").trim();
		String strStartdate = request.getParameter("startdate").trim();
		String strEnddate = request.getParameter("enddate").trim();
		String strproductids = request.getParameter("products").trim();
		String strcouponcode = request.getParameter("couponcode").trim();
		
		double off = Double.parseDouble(strOff);
		
		couponcode cp = new couponcode();
		
		if(couponcode.checkExist(strcouponcode))
		{
			out.println("code used");
			return;
		}
						
		SimpleDateFormat isoFormat = new SimpleDateFormat("MM/dd/yyyy'T'HH:mm:ss");
	  //isoFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
	  	Date startdate = isoFormat.parse(strStartdate + "T00:00:00");
	  	Date enddate = isoFormat.parse(strEnddate + "T23:59:59"); 	
		cp.setStartDate(startdate);
		cp.setEndDate(enddate);
		cp.setIsDeleted(0); 
		cp.setValue(strcouponcode.toLowerCase());
		if(off < 1)
			cp.setPercentageoff(off);
		else
		    cp.setAmountoff(off);	
		int couponcodeId = cp.add();
		
		List pids = new ArrayList();
		StringTokenizer st = new StringTokenizer(strproductids, ","); 
	 	while (st.hasMoreTokens()) {
	 		pids.add(st.nextToken()); 
	 	}
	 	int[] intPids = new int[pids.size()];
	 	int i = 0;
	 	for(Iterator it = pids.iterator(); it.hasNext(); ) {
	 		String strPid = (String)it.next();
	 		intPids[i] = Integer.parseInt(strPid);
	 		i++;
	 	}
	 	
	 	couponcodeProduct.addByProductIdsAndCouponCodeId(intPids, couponcodeId);		
       	out.println(strcouponcode.toUpperCase());
      
%>
