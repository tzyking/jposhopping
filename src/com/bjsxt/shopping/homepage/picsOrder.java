package com.bjsxt.shopping.homepage;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.bjsxt.shopping.inventory.inventoryRecord;
import com.bjsxt.shopping.product.Product;
import com.bjsxt.shopping.util.DB;

public class picsOrder {
	private int id; 
	private String categoryName;
	private String currentOrder;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCurrentOrder() {
		return currentOrder;
	}
	public void setCurrentOrder(String currentOrder) {
		this.currentOrder = currentOrder;
	} 
	
	public static String getCurrentOrderByCategoryName(String categoryname){
		Connection conn = DB.getConn();
	    String sql = "select currentorder from picsorder WHERE categoryname = '" + categoryname + "' ";
	    Statement stmt = DB.getStatement(conn);
	    ResultSet rs = null;
	    String currentorder = "";
	    try {
	      rs = DB.getResultSet(stmt, sql);
	      if (rs.next())
	    	  currentorder = rs.getString(1); 
	    }
	    catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(rs);
	      DB.close(stmt);
	      DB.close(conn);
	    }
	    return currentorder;
	}
	
	
	public static boolean updateCurrentOrderbyCategoryName(String currentorder, String categoryname){
		Connection conn = DB.getConn();
	    Statement stmt = DB.getStatement(conn);
	    String sql = "update picsorder set currentorder = '" + currentorder + "' where categoryname = '" + categoryname + "' ";
	    boolean result = false;
	    try {
		      DB.executeUpdate(stmt, sql);
		      result = true;
		    } finally {
		      DB.close(stmt);
		      DB.close(conn);
		    }
		    
		 return result;   
	
	}
	
	public static List getPicsOrder(){
		 List pos = new ArrayList();
		 Connection conn = DB.getConn();
		 String sql = "select id, categoryname, currentorder from picsorder";
		 Statement stmt = DB.getStatement(conn);
		 ResultSet rs = DB.getResultSet(stmt, sql);
		 
		 try {
		      while (rs.next()) {
		        picsOrder p = new picsOrder();
		        p.setId(rs.getInt("id"));
		        p.setCategoryName(rs.getString("categoryname"));
		        p.setCurrentOrder(rs.getString("currentorder"));
		        
		        pos.add(p);
		      }
		    } catch (SQLException e) {
		      e.printStackTrace();
		    } finally {
		      DB.close(rs);
		      DB.close(stmt);
		      DB.close(conn);
		    }
		    return pos; 
	}
	
	public static List getPicsOrderByCategoryname(String categoryname){
		 List pos = new ArrayList();
		 Connection conn = DB.getConn();
		 String sql = "select id, categoryname, currentorder from picsorder where categoryname = '" + categoryname + "' ";
		 Statement stmt = DB.getStatement(conn);
		 ResultSet rs = DB.getResultSet(stmt, sql);
		 
		 try {
		      while (rs.next()) {
		        picsOrder p = new picsOrder();
		        p.setId(rs.getInt("id"));
		        p.setCategoryName(rs.getString("categoryname"));
		        p.setCurrentOrder(rs.getString("currentorder"));
		        
		        pos.add(p);
		      }
		    } catch (SQLException e) {
		      e.printStackTrace();
		    } finally {
		      DB.close(rs);
		      DB.close(stmt);
		      DB.close(conn);
		    }
		    return pos;
	}
}
