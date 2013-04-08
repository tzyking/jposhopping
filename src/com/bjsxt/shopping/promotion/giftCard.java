package com.bjsxt.shopping.promotion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

import com.bjsxt.shopping.util.DB;

public class giftCard {
	private int id; 
	private String value; 
	private double amount; 
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



	public double getAmount() {
		return amount;
	}



	public void setAmount(double amount) {
		this.amount = amount;
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
	    int id = -1;
	  	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rsKey = null;
	    try {
	      conn = DB.getConn();
	      String sql = "insert into giftcard values (null, ?, ?, ?, ?, ?)";
	      pstmt = DB.prepare(conn, sql);
	      pstmt.setString(1, this.getValue().toLowerCase());
	      pstmt.setDouble(2, this.getAmount());
	      pstmt.setTimestamp(3, new Timestamp(this.getStartDate().getTime()));
	      pstmt.setTimestamp(4, new Timestamp(this.getEndDate().getTime()));
	      pstmt.setInt(5, this.isDeleted);

	      pstmt.executeUpdate();
	      rsKey = pstmt.getGeneratedKeys(); 
	      rsKey.next();
	      id = rsKey.getInt(1);
	    } catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(pstmt);
	      DB.close(conn);
	    } 	    
	    return id;    	  
	}
	
	  public static boolean checkExist(String value){
		  int totalRecords = 0;
		  Connection conn = DB.getConn(); 
		  Statement stmtCount = DB.getStatement(conn);
		  ResultSet rsCount = DB.getResultSet(stmtCount, 
	      "select count(1) from giftcard where isDeleted = 0 and value='" + value.toLowerCase() + "'");
		  
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
	  
	  public static double getAmountbyValue(String value){
		  double amount = -1;
		  try {
		      Connection conn = DB.getConn();
		      Statement stmt = DB.getStatement(conn);
		      ResultSet rs = null;
		      String sql = "select amount from giftcard where isDeleted = 0 and value = '" + value.toLowerCase() + "'" ;
	
		      rs = DB.getResultSet(stmt, sql);

		      if(rs.next()){
		    	  amount = rs.getDouble("amount");
		    	  
		      }
		    }
		    catch (SQLException e)
		    {
		      e.printStackTrace();
		    }
		  return amount;
	  }
	  
	  public static boolean updateAmountbyValue(double amount, String value){
		  boolean result = false;
		  Connection conn = DB.getConn();
		  Statement stmt = DB.getStatement(conn);
		  String sql = "update giftcard set amount="+amount+" where isDeleted = 0 and value = '" + value.toLowerCase() + "'" ;
		  try{
			  DB.executeUpdate(stmt, sql);
			  result = true;
		  }catch(Exception e){
			  e.printStackTrace();
		  }
		  return result;
	  }

	public static void main(String[] args) {
		/*giftCard g = new giftCard();
		g.setValue("aaa122"); 
		g.setAmount(199.45);
		Calendar date = Calendar.getInstance(); 
		g.setStartDate(date.getTime());
		date.add(Calendar.YEAR, 1);
		g.setEndDate(date.getTime());
		g.setIsDeleted(0);
		
		System.out.println(g.add());*/
		System.out.println(giftCard.updateAmountbyValue(200, "aaa122"));
		// TODO Auto-generated method stub

	}

}