package com.bjsxt.shopping.email;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Date;

import com.bjsxt.shopping.util.DB;

public class OutofStockNotifyEmail {
	private int id; 
	private int productid; 
	private String color; 
	private String size; 
	private String email; 
	private Date createDate;
	
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getProductid() {
		return productid;
	}


	public void setProductid(int productid) {
		this.productid = productid;
	}


	public String getColor() {
		return color;
	}


	public void setColor(String color) {
		this.color = color;
	}


	public String getSize() {
		return size;
	}


	public void setSize(String size) {
		this.size = size;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public Date getCreateDate() {
		return createDate;
	}


	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public int save()
	  {
		int  id = -1;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rsKey = null;
	    Statement stmt = null;
	    try {
	      conn = DB.getConn();
	      String sql = "insert into mailinglist_outofstocknotify values (null, ?, ?, ?, ?, ?)";
	      pstmt = DB.prepare(conn, sql, 1);
	      pstmt.setInt(1, this.getProductid());
	      pstmt.setString(2, this.getColor());
	      pstmt.setString(3, this.getSize());
	      pstmt.setString(4, this.getEmail());
	      pstmt.setTimestamp(5, new Timestamp(this.getCreateDate().getTime()));
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
	
	
	public static void main(String[] args) {
		OutofStockNotifyEmail o = new OutofStockNotifyEmail(); 
		o.setProductid(1); 
		o.setColor("DARK NODE"); 
		o.setSize("24");
		o.setEmail("unicorntzyking@gmail.com");
		o.setCreateDate(new Date());
		o.save();

	}

}
