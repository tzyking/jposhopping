package com.bjsxt.shopping.color;

import com.bjsxt.shopping.util.DB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class color {
	private int id; 
	private String name;
	private int isDeleted;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(int isDeleted) {
		this.isDeleted = isDeleted;
	}
	
	public int  add(){
	    int colorId = -1;
	  	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rsKey = null;
	    try {
	      conn = DB.getConn();
	      String sql = "insert into colors values (null, ?, ?)";
	      pstmt = DB.prepare(conn, sql);
	      pstmt.setString(1, this.name);
	      pstmt.setInt(2, this.isDeleted);

	      pstmt.executeUpdate();
	      rsKey = pstmt.getGeneratedKeys(); 
	      rsKey.next();
	      colorId = rsKey.getInt(1);
	    } catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(pstmt);
	      DB.close(conn);
	    } 
	    
	    return colorId;
	    	  
  }
	
	public static int getAvailableColors(List colors, int pageNo, int pageSize) {
	    Connection conn = DB.getConn();
	    Statement stmtCount = DB.getStatement(conn);
	    String sql = " select * from colors where isDeleted = 0  limit " + 
	                 (pageNo - 1) * pageSize + "," + pageSize;
	    Statement stmt = DB.getStatement(conn);
	    ResultSet rs = null;
	    ResultSet rsCount = null;
	    int totalRecords = 0;
	    try {
	      rsCount = DB.getResultSet(stmtCount, 
	        " select count(1) from colors where isDeleted = 0 ");
	      rsCount.next();
	      totalRecords = rsCount.getInt(1);
	      conn = DB.getConn();

	      rs = DB.getResultSet(stmt, sql);
	      while (rs.next()) {

	        color c = new color();
	        c.setId(rs.getInt("id"));
	        c.setName(rs.getString("name"));
	        c.setIsDeleted(rs.getInt("isDeleted"));
	        colors.add(c);
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
	
	public static List getAvailableColorNames(){
		List colors = new ArrayList();
	    try {
	      Connection conn = DB.getConn();
	      Statement stmt = DB.getStatement(conn);
	      ResultSet rs = null;
	      String sql = "select DISTINCT name from colors " ;
	      rs = DB.getResultSet(stmt, sql);

	      while (rs.next())
	        colors.add(rs.getString("name"));
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }

	    return colors;
	}
	
	public static boolean deleteById(int id) {
	    Connection conn = DB.getConn();
	    Statement stmt = DB.getStatement(conn);
	    boolean result = false;
	    try {
	      String sql = "update colors set isDeleted = 1 where id = " + id;
	     // System.out.println(sql);
	      DB.executeUpdate(stmt, sql);
	      result = true;
	    } finally {
	      DB.close(stmt);
	      DB.close(conn);
	    }
	    return result;
	  }

}
