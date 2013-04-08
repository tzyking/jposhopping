package com.bjsxt.shopping.email;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import com.bjsxt.shopping.color.color;
import com.bjsxt.shopping.util.DB;

public class mailingList {
	private int id; 
	private String email; 
	private int isDeleted;
	private String note;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(int isDeleted) {
		this.isDeleted = isDeleted;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	} 
	
	public int  add(){
	    int Id = -1;
	  	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rsKey = null;
	    try {
	      conn = DB.getConn();
	      String sql = "insert into mailinglist(id, email, isdeleted) values (null, ?, ?)";
	      pstmt = DB.prepare(conn, sql);
	      pstmt.setString(1, this.email);
	      pstmt.setInt(2, this.isDeleted);

	      pstmt.executeUpdate();
	      rsKey = pstmt.getGeneratedKeys(); 
	      rsKey.next();
	      Id = rsKey.getInt(1);
	    } catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(pstmt);
	      DB.close(conn);
	    } 
	    
	    return Id;    	  
  }
	
	public static int getAvailableEmails(List mls, int pageNo, int pageSize) {
	    Connection conn = DB.getConn();
	    Statement stmtCount = DB.getStatement(conn);
	    String sql = " select * from mailinglist where isdeleted = 0  limit " + 
	                 (pageNo - 1) * pageSize + "," + pageSize;
	    Statement stmt = DB.getStatement(conn);
	    ResultSet rs = null;
	    ResultSet rsCount = null;
	    int totalRecords = 0;
	    try {
	      rsCount = DB.getResultSet(stmtCount, 
	        " select count(1) from mailinglist where isDeleted = 0 ");
	      rsCount.next();
	      totalRecords = rsCount.getInt(1);
	      conn = DB.getConn();
	      rs = DB.getResultSet(stmt, sql);
	      while (rs.next()) {

	        mailingList ml = new mailingList();
	        ml.setId(rs.getInt("id"));
	        ml.setEmail(rs.getString("email"));
	        ml.setIsDeleted(rs.getInt("isdeleted"));
	        mls.add(ml);
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
	
}
