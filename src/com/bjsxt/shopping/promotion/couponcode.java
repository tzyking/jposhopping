package com.bjsxt.shopping.promotion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import com.bjsxt.shopping.util.DB;

public class couponcode {

	private int id; 
	private String value; 
	private double amountoff; 
	private double percentageoff; 
	private Date startDate; 
	private Date endDate;
	private int isDeleted;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public double getAmountoff() {
		return amountoff;
	}
	public void setAmountoff(double amountoff) {
		this.amountoff = amountoff;
	}
	public double getPercentageoff() {
		return percentageoff;
	}
	public void setPercentageoff(double percentageoff) {
		this.percentageoff = percentageoff;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public int getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(int isDeleted) {
		this.isDeleted = isDeleted;
	}
		
	public int  add(){
	    int couponId = -1;
	  	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rsKey = null;
	    try {
	      conn = DB.getConn();
	      String sql = "insert into couponcode values (null, ?, ?, ?, ?, ?, ?)";
	      pstmt = DB.prepare(conn, sql);
	      pstmt.setString(1, this.value.toLowerCase());
	      pstmt.setDouble(2, this.amountoff);
	      pstmt.setDouble(3, this.percentageoff);
	      pstmt.setTimestamp(4, new Timestamp(this.getStartDate().getTime()));
	      pstmt.setTimestamp(5, new Timestamp(this.getEndDate().getTime()));
	      pstmt.setInt(6, this.isDeleted);

	      pstmt.executeUpdate();
	      rsKey = pstmt.getGeneratedKeys(); 
	      rsKey.next();
	      couponId = rsKey.getInt(1);
	    } catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(pstmt);
	      DB.close(conn);
	    } 	    
	    return couponId;    	  
  }
  
	public static String codeGenerator(){
		  String code = "-1";
		  Connection conn = DB.getConn(); 
		  Statement stmtCount = DB.getStatement(conn);
		  ResultSet rsCount = DB.getResultSet(stmtCount, 
	      "SELECT SUBSTRING(MD5(RAND()) FROM 1 FOR 9) AS password");
		  
		  try{
		      rsCount.next();
		      code = rsCount.getString(1);
		  }
		  catch (SQLException e) {
		          e.printStackTrace();
		  } finally {
		     DB.close(rsCount);
		     DB.close(stmtCount);
		     DB.close(conn);
		  }  
		  return code.toUpperCase();
	 }  	
	
  public static boolean checkExist(String value){
	  int totalRecords = 0;
	  Connection conn = DB.getConn(); 
	  Statement stmtCount = DB.getStatement(conn);
	  ResultSet rsCount = DB.getResultSet(stmtCount, 
      "select count(1) from couponcode where isDeleted = 0 and value='" + value.toLowerCase() + "'");
	  
	  try{
	      rsCount.next();
	      totalRecords = rsCount.getInt(1);
	  }
	  catch (SQLException e) {
	          e.printStackTrace();
	  } finally {
	     DB.close(rsCount);
	     DB.close(stmtCount);
	     DB.close(conn);
	  }  
	  if(totalRecords > 0)
		  return true;
	  else
		  return false;
  }  	
	
  public static double getCouponOffbyValue(String value){
	  double couponOff = -1;
	  try {
	      Connection conn = DB.getConn();
	      Statement stmt = DB.getStatement(conn);
	      ResultSet rs = null;
	      String sql = "select amountoff, percentageoff from couponcode where isDeleted = 0 and value = '" + value.toLowerCase() + "'" ;
	      //System.out.println(sql);
	      rs = DB.getResultSet(stmt, sql);

	      if(rs.next()){
	    	  if(rs.getDouble("amountoff") == 0)
	    		  couponOff = rs.getDouble("percentageoff");
	    	  else
	    		  couponOff = rs.getDouble("amountoff");
	      }
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }
	  return couponOff;
  }

  public static int getAvailableCouponCode(List couponCodes, int pageNo, int pageSize) {
	    Connection conn = DB.getConn();
	    Statement stmtCount = DB.getStatement(conn);
	    String sql = " select * from couponcode where isDeleted = 0  limit " + 
	                 (pageNo - 1) * pageSize + "," + pageSize;
	    Statement stmt = DB.getStatement(conn);
	    ResultSet rs = null;
	    ResultSet rsCount = null;
	    int totalRecords = 0;
	    try {
	      rsCount = DB.getResultSet(stmtCount, 
	        " select count(1) from couponcode where isDeleted = 0 ");
	      rsCount.next();
	      totalRecords = rsCount.getInt(1);
	      conn = DB.getConn();

	      rs = DB.getResultSet(stmt, sql);
	      while (rs.next()) {
	    	couponcode c = new couponcode();
	        c.setId(rs.getInt("id"));
	        c.setValue(rs.getString("value"));
	        c.setAmountoff(rs.getDouble("amountoff"));
	        c.setPercentageoff(rs.getDouble("percentageoff"));
	        c.setIsDeleted(rs.getInt("isDeleted"));
	        couponCodes.add(c);
	      }
	    } catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(rs);
	      DB.close(stmt);
	      DB.close(conn);
	    }
	    return totalRecords;
	  }
  
	public static boolean deleteById(int id) {
	    Connection conn = DB.getConn();
	    Statement stmt = DB.getStatement(conn);
	    boolean result = false;
	    try {
	      String sql = "update couponcode set isDeleted = 1 where id = " + id;
	     //System.out.println(sql);
	      DB.executeUpdate(stmt, sql);
	      result = true;
	    } finally {
	      DB.close(stmt);
	      DB.close(conn);
	    }
	    return result;
	  }
	
	public static List getproductIdsbyCouponCode(String value){
		List productIds = new ArrayList();
	    try {
	      Connection conn = DB.getConn();
	      Statement stmt = DB.getStatement(conn);
	      ResultSet rs = null;
	      String sql = "select productid from couponcode cc inner join couponcodeproduct ccp on cc.id = ccp.couponcodeid where cc.value = '" + value.toLowerCase() + "' and ccp.isDeleted = 0";
	      rs = DB.getResultSet(stmt, sql);

	      while (rs.next())
	    	  productIds.add(new Integer(rs.getInt("productid")));
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }	    
	    return productIds;
	}
  
  public static void main(String[] args) throws ParseException{
	  couponcode cp = new couponcode();
	  cp.setValue("ATTAT".toLowerCase()); 
	  cp.setPercentageoff(0.2);
	  cp.setIsDeleted(0);
	  
	  SimpleDateFormat isoFormat = new SimpleDateFormat("MM/dd/yyyy'T'HH:mm:ss");
	  //isoFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
	  Date date = isoFormat.parse("10/16/2012T22:01:02");
	  cp.setStartDate(date);
	  cp.setEndDate(date);
	  cp.add();
	  
	  //System.out.println(couponcode.getCouponOffbyValue("ttajeff"));
	  //System.out.println(couponcode.checkExist("ttajf"));
	  //System.out.println(couponcode.codeGenerator());
	  
	  //System.out.println(couponcode.getproductIdsbyCouponCode("t").size());
  }	
}
