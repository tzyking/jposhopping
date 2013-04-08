package com.bjsxt.shopping.promotion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.bjsxt.shopping.util.DB;

public class couponcodeProduct {

	private int id; 
	private int couponcodeId; 
	private int productId; 
	private int isDeleted; 
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCouponcodeId() {
		return couponcodeId;
	}
	public void setCouponcodeId(int couponcodeId) {
		this.couponcodeId = couponcodeId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
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
	      String sql = "insert into couponcodeproduct values (null, ?, ?, ?)";
	      pstmt = DB.prepare(conn, sql);
	      pstmt.setInt(1, this.couponcodeId);
	      pstmt.setInt(2, this.productId);
	      pstmt.setInt(3, this.isDeleted);

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
	
	public static void addByProductIdsAndCouponCodeId(int[] productIds, int couponcodeId){
		couponcodeProduct cp = new couponcodeProduct();
		cp.setCouponcodeId(couponcodeId);
		cp.setIsDeleted(0);
		for(int i=0; i < productIds.length; i++){
			cp.setProductId(productIds[i]);
			cp.add();		
		}
		
	}
	
	public static boolean getStatusbyCouponcodeIdAndProductId(int couponcodeId, int productId ){
		boolean result;
		int isDeleted = -1;
	    try {
	      Connection conn = DB.getConn();
	      Statement stmt = DB.getStatement(conn);
	      ResultSet rs = null;
	      String sql = "select isDeleted from couponcodeproduct where couponcodeid = " + couponcodeId + " and productid = " + productId;
	      rs = DB.getResultSet(stmt, sql);

	      if (rs.next())
	    	  isDeleted = rs.getInt("isDeleted");
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }	    
	    result = (isDeleted == 0)? true: false;
	    return result;
	}
	
	public static boolean deleteByCouponcodeId(int couponcodeid) {
	    Connection conn = DB.getConn();
	    Statement stmt = DB.getStatement(conn);
	    boolean result = false;
	    try {
	      String sql = "update couponcodeproduct set isDeleted = 1 where couponcodeid = " + couponcodeid;
	     //System.out.println(sql);
	      DB.executeUpdate(stmt, sql);
	      result = true;
	    } finally {
	      DB.close(stmt);
	      DB.close(conn);
	    }
	    return result;
	  }
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
/*		couponcodeProduct cp = new couponcodeProduct(); 
		cp.setCouponcodeId(1); 
		cp.setProductId(1);
		cp.setIsDeleted(0);
		System.out.println(cp.add());*/
		
		/*int[] pids = new int[] {1, 2, 3, 4};
		int cid = 4; 
		couponcodeProduct.addByProductIdsAndCouponCodeId(pids, cid);*/
		
		//System.out.println(couponcodeProduct.getStatusbyCouponcodeIdAndProductId(14, 1));
		System.out.println(couponcodeProduct.deleteByCouponcodeId(1));
	}

}
