package com.bjsxt.shopping.homepage;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.bjsxt.shopping.util.DB;

public class picsNumber {
	private int id; 
	private String categoryName; 
	private int currentNumber;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCategory() {
		return categoryName;
	}
	public void setCategory(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getCurrentNumber() {
		return currentNumber;
	}
	public void setCurrentNumber(int currentNumber) {
		this.currentNumber = currentNumber;
	} 
	
	public static int getCurrentNumberByCategoryName(String categoryname){
		Connection conn = DB.getConn();
		String sql = "select currentnumber from picsnumber WHERE categoryname = '" + categoryname + "' ";
	    Statement stmt = DB.getStatement(conn);
	    ResultSet rs = null;
	    int currentnumber = -1;
	    try {
	      rs = DB.getResultSet(stmt, sql);
	      if (rs.next())
	    	  currentnumber = rs.getInt(1); 
	    }
	    catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(rs);
	      DB.close(stmt);
	      DB.close(conn);
	    }
	    return currentnumber;
		
	}
	
	public static int updateCurrentNumberByCategoryName(String categoryname){
		
		Connection conn = DB.getConn();
	    String sql = "select currentnumber from picsnumber WHERE categoryname = '" + categoryname + "' ";
	    Statement stmt = DB.getStatement(conn);
	    ResultSet rs = null;
	    int currentnumber = -1;
	    try {
	      rs = DB.getResultSet(stmt, sql);
	      if (rs.next())
	    	  currentnumber = rs.getInt(1);
	      
	      currentnumber = currentnumber + 1; 
	      sql = "update picsnumber set currentnumber = " + currentnumber + " where categoryname = '" + categoryname + "' ";
	      DB.executeUpdate(stmt, sql);
	    }
	    catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(rs);
	      DB.close(stmt);
	      DB.close(conn);
	    }

	    return currentnumber;
		
	}
	
	
	
	

}
