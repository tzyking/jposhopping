package com.bjsxt.shopping.inventory;

import com.bjsxt.shopping.product.Product;
import com.bjsxt.shopping.util.DB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class inventoryRecord
{
  private int id;
  private Product product;
  private String color;
  private String size;
  private int amount;

  public int getId()
  {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public Product getProduct() {
    return this.product;
  }

  public void setProduct(Product product) {
    this.product = product;
  }

  public String getColor() {
    return this.color;
  }

  public void setColor(String color) {
    this.color = color;
  }

  public String getSize() {
    return this.size;
  }

  public void setSize(String size) {
    this.size = size;
  }

  public int getAmount() {
    return this.amount;
  }

  public void setAmount(int amount) {
    this.amount = amount;
  }
  
  public void  add(){
	    int inventoryid = -1;
	  	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rsKey = null;
	    try {
	      conn = DB.getConn();
	      String sql = "insert into inventory values (null, ?, ?, ?, ?)";
	      pstmt = DB.prepare(conn, sql);
	      pstmt.setInt(1, this.product.getId());
	      pstmt.setString(2, this.getColor());
	      pstmt.setString(3, this.getSize());
	      pstmt.setInt(4, this.getAmount());
	      pstmt.executeUpdate();
	      rsKey = pstmt.getGeneratedKeys(); 
	      rsKey.next();
	      inventoryid = rsKey.getInt(1);
	    } catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(pstmt);
	      DB.close(conn);
	    } 
	    
	    try {
		      conn = DB.getConn();
		      String sql = "insert into inventorystatus values (?, ?, ?)";
		      pstmt = DB.prepare(conn, sql);
		      pstmt.setInt(1, inventoryid);
		      pstmt.setInt(2, this.product.getId());
		      pstmt.setInt(3, 0);
		      pstmt.executeUpdate();
		    } catch (SQLException e) {
		      e.printStackTrace();
		    } finally {
		      DB.close(pstmt);
		      DB.close(conn);
		    }  
	  
  }
  
  public String  addWithIdReturn(){
	    int inventoryid = -1;
	  	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rsKey = null;
	    try {
	      conn = DB.getConn();
	      String sql = "insert into inventory values (null, ?, ?, ?, ?)";
	      pstmt = DB.prepare(conn, sql);
	      pstmt.setInt(1, this.product.getId());
	      pstmt.setString(2, this.getColor());
	      pstmt.setString(3, this.getSize());
	      pstmt.setInt(4, this.getAmount());
	      pstmt.executeUpdate();
	      rsKey = pstmt.getGeneratedKeys(); 
	      rsKey.next();
	      inventoryid = rsKey.getInt(1);
	    } catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(pstmt);
	      DB.close(conn);
	    } 
	    
	    try {
		      conn = DB.getConn();
		      String sql = "insert into inventorystatus values (?, ?, ?)";
		      pstmt = DB.prepare(conn, sql);
		      pstmt.setInt(1, inventoryid);
		      pstmt.setInt(2, this.product.getId());
		      pstmt.setInt(3, 0);
		      pstmt.executeUpdate();
		    } catch (SQLException e) {
		      e.printStackTrace();
		    } finally {
		      DB.close(pstmt);
		      DB.close(conn);
		    } 
		    
		    return Integer.toString(inventoryid);
	  
}
  
  public static void addByColorsProductid(String[] colors, int Productid){
	  for (int i = 0; i < colors.length; i++) { 
		  String color = colors[i];
		  inventoryRecord ir = new inventoryRecord();
		  Product p = new Product();
		  p.setId(Productid);
		  ir.setColor(color);
		  ir.setProduct(p);
		 
		  ir.setSize("XS");
		  ir.setAmount(0);
		  ir.add();
		  ir.setSize("SM");
		  ir.add();

		  ir.setSize("MED");
		  ir.add();

		  ir.setSize("LG");
		  ir.add();
	  }  
	  
  }
  
  public static List addByColorsSizeProductid(String[] colors, String[] sizes, int Productid){
	  List ids = new ArrayList();
	  for (int i = 0; i < colors.length; i++) { 
		  String color = colors[i];
		  inventoryRecord ir = new inventoryRecord();
		  Product p = new Product();
		  p.setId(Productid);
		  ir.setColor(color);
		  ir.setProduct(p);
		  ir.setAmount(0);
		  for(int t = 0; t < sizes.length; t++){
			  String size = sizes[t];
			  ir.setSize(size); 
			 ids.add(ir.addWithIdReturn());
		  }
		  
	  }  
	  return ids;
  }
  
  public static void deletebyProductid(int id) { 
		Connection conn = null;
	    Statement stmt = null;
	    
	    try {
	      conn = DB.getConn();
	      String sql = "update inventorystatus set isdeleted = 1 where pid = " + id;
	      stmt = DB.getStatement(conn);
	      DB.executeUpdate(stmt, sql);
	    } finally {
	      DB.close(stmt);
	      DB.close(conn);
	    } 
  }

  public static List getInventoryRecords() {
    List irs = new ArrayList();
    Connection conn = DB.getConn();
    String sql = "select inventory.*, product.id pid, product.name pname from inventory left join product on inventory.productid = product.id";
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = DB.getResultSet(stmt, sql);
    try {
      while (rs.next()) {
        Product p = new Product();
        p.setId(rs.getInt("pid"));
        p.setName(rs.getString("pname"));

        inventoryRecord ir = new inventoryRecord();
        ir.setProduct(p);
        ir.setId(rs.getInt("id"));
        ir.setColor(rs.getString("color"));
        ir.setSize(rs.getString("size"));
        ir.setAmount(rs.getInt("amount"));
        irs.add(ir);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }
    return irs;
  }

  public static int getInventoryRecords(List irs, int pageNo, int pageSize) {
    Connection conn = DB.getConn();
    Statement stmtCount = DB.getStatement(conn);
    String sql = "select inventory.*, product.id pid, product.name pname from inventory  left join product on inventory.productid = product.id  limit " + 
      (pageNo - 1) * pageSize + "," + pageSize;
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = null;
    ResultSet rsCount = null;
    int totalRecords = 0;
    try {
      rsCount = DB.getResultSet(stmtCount, 
        "select count(*) from inventory");
      rsCount.next();
      totalRecords = rsCount.getInt(1);
      conn = DB.getConn();

      rs = DB.getResultSet(stmt, sql);
      while (rs.next()) {
        Product p = new Product();
        p.setId(rs.getInt("pid"));
        p.setName(rs.getString("pname"));

        inventoryRecord ir = new inventoryRecord();
        ir.setProduct(p);
        ir.setId(rs.getInt("id"));
        ir.setColor(rs.getString("color"));
        ir.setSize(rs.getString("size"));
        ir.setAmount(rs.getInt("amount"));
        irs.add(ir);
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
  
  
  public static int getAvailableInventoryRecords(List irs, int pageNo, int pageSize) {
	    Connection conn = DB.getConn();
	    Statement stmtCount = DB.getStatement(conn);
	    String sql = "select inventory.*, product.id pid, product.name pname from inventory  left join product on inventory.productid = product.id " +
	    		     " where exists( select 1 from inventorystatus ist where ist.id = inventory.id and ist.isdeleted = 0)  limit " + 
	                 (pageNo - 1) * pageSize + "," + pageSize;
	    Statement stmt = DB.getStatement(conn);
	    ResultSet rs = null;
	    ResultSet rsCount = null;
	    int totalRecords = 0;
	    try {
	      rsCount = DB.getResultSet(stmtCount, 
	        "select count(*) from inventory where exists ( select 1 from inventorystatus ist where ist.id = inventory.id and ist.isdeleted = 0)");
	      rsCount.next();
	      totalRecords = rsCount.getInt(1);
	      conn = DB.getConn();

	      rs = DB.getResultSet(stmt, sql);
	      while (rs.next()) {
	        Product p = new Product();
	        p.setId(rs.getInt("pid"));
	        p.setName(rs.getString("pname"));

	        inventoryRecord ir = new inventoryRecord();
	        ir.setProduct(p);
	        ir.setId(rs.getInt("id"));
	        ir.setColor(rs.getString("color"));
	        ir.setSize(rs.getString("size"));
	        ir.setAmount(rs.getInt("amount"));
	        irs.add(ir);
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
  
  public static int getInventoryRecordsByProductid(List irs, int pageNo, int pageSize, int productid) {
	    Connection conn = DB.getConn();
	    Statement stmtCount = DB.getStatement(conn);
	    String sql = "select inventory.*, product.id pid, product.name pname from inventory  left join product on inventory.productid = product.id where inventory.productid = "
	    	 		 + productid
	    			 +"  limit " 
	    			 +(pageNo - 1) * pageSize + "," + pageSize;
	    Statement stmt = DB.getStatement(conn);
	    ResultSet rs = null;
	    ResultSet rsCount = null;
	    int totalRecords = 0;
	    try {
	      rsCount = DB.getResultSet(stmtCount, 
	        "select count(*) from inventory where inventory.productid = "+ productid);
	      rsCount.next();
	      totalRecords = rsCount.getInt(1);
	      conn = DB.getConn();

	      rs = DB.getResultSet(stmt, sql);
	      while (rs.next()) {
	        Product p = new Product();
	        p.setId(rs.getInt("pid"));
	        p.setName(rs.getString("pname"));

	        inventoryRecord ir = new inventoryRecord();
	        ir.setProduct(p);
	        ir.setId(rs.getInt("id"));
	        ir.setColor(rs.getString("color"));
	        ir.setSize(rs.getString("size"));
	        ir.setAmount(rs.getInt("amount"));
	        irs.add(ir);
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

  public static inventoryRecord getInventoryRecordById(int id) {
    Connection conn = DB.getConn();
    String sql = "select inventory.*, product.id pid, product.name pname, product.descr pdescr from inventory left join product on inventory.productid = product.id where inventory.id = " + id;
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = null;
    inventoryRecord ir = null;
    try {
      rs = DB.getResultSet(stmt, sql);
      if (rs.next())
      {
        Product p = new Product();
        p.setId(rs.getInt("pid"));
        p.setName(rs.getString("pname"));
        p.setDescr(rs.getString("pdescr"));

        ir = new inventoryRecord();
        ir.setProduct(p);
        ir.setId(rs.getInt("id"));
        ir.setColor(rs.getString("color"));
        ir.setSize(rs.getString("size"));
        ir.setAmount(rs.getInt("amount"));
      }
    }
    catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }
    return ir;
  }

  public static inventoryRecord getInventoryRecordByPidSizeColor(int pid, String size, String color) {
	    Connection conn = DB.getConn();
	    String sql = " select inventory.*, product.id pid, product.name pname, product.descr pdescr from inventory left join product on inventory.productid = product.id " +
	    			 " where inventory.productid = " + pid + 
	    			 " AND inventory.color = '" + color + "' AND size = '" + size + "' ";
	    System.out.println(sql); 
	    Statement stmt = DB.getStatement(conn);
	    ResultSet rs = null;
	    inventoryRecord ir = null;
	    try {
	      rs = DB.getResultSet(stmt, sql);
	      if (rs.next())
	      {
	        Product p = new Product();
	        p.setId(rs.getInt("pid"));
	        p.setName(rs.getString("pname"));
	        p.setDescr(rs.getString("pdescr"));

	        ir = new inventoryRecord();
	        ir.setProduct(p);
	        ir.setId(rs.getInt("id"));
	        ir.setColor(rs.getString("color"));
	        ir.setSize(rs.getString("size"));
	        ir.setAmount(rs.getInt("amount"));
	      }
	    }
	    catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(rs);
	      DB.close(stmt);
	      DB.close(conn);
	    }
	    return ir;
	  }
  
  public static int getAmountByPidSizeColor(int pid, String size, String color) {
    Connection conn = DB.getConn();
    String sql = "select inventory.amount from inventory WHERE inventory.productid = " + pid + 
      " AND inventory.color = '" + color + "' AND size = '" + size + "' ";
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = null;
    int amount = -1;
    try {
      rs = DB.getResultSet(stmt, sql);
      if (rs.next())
        amount = rs.getInt(1);
    }
    catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }

    return amount;
  }

  public static boolean updateAmount(int irid, int amount) {
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    boolean result = false;
    try {
      String sql = "update inventory set amount = " + amount + " where id = " + irid;
      DB.executeUpdate(stmt, sql);
      result = true;
    } finally {
      DB.close(stmt);
      DB.close(conn);
    }
    return result;
  }

  public static boolean reduceAmount(int count, int pid, String size, String color) {
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    boolean result = false;
    try {
      String sql = "update inventory set amount = amount - " + count + " WHERE inventory.productid = " + pid + 
        " AND inventory.color = '" + color + "' AND size = '" + size + "' ";
      DB.executeUpdate(stmt, sql);
      result = true;
    } finally {
      DB.close(stmt);
      DB.close(conn);
    }
    return result;
  }
  
  public static List getAllColorOptions() {
	    List colors = new ArrayList();
	    try {
	      Connection conn = DB.getConn();
	      Statement stmt = DB.getStatement(conn);
	      ResultSet rs = null;
	      String sql = "select DISTINCT color from inventory ";
	      rs = DB.getResultSet(stmt, sql);

	      while (rs.next())
	        colors.add(rs.getString("color"));
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }

	    return colors;
	  }


  public static List getColorOptionByProductId(int pid) {
	    List colors = new ArrayList();
	    try {
	      Connection conn = DB.getConn();
	      Statement stmt = DB.getStatement(conn);
	      ResultSet rs = null;
	      String sql = "select DISTINCT color from inventory where productid = " + pid;
	      rs = DB.getResultSet(stmt, sql);

	      while (rs.next())
	        colors.add(rs.getString("color"));
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }

	    return colors;
	  }
  
  public static List getAvailableColorOptionByProductId(int pid) {
    List colors = new ArrayList();
    try {
      Connection conn = DB.getConn();
      Statement stmt = DB.getStatement(conn);
      ResultSet rs = null;
      String sql = "select DISTINCT color from inventory where productid = " + pid + " AND AMOUNT <> 0";
      rs = DB.getResultSet(stmt, sql);

      while (rs.next())
        colors.add(rs.getString("color"));
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }

    return colors;
  }
  
  public static List getAllSizeOption() {
	    List sizes = new ArrayList();
	    try {
	      Connection conn = DB.getConn();
	      Statement stmt = DB.getStatement(conn);
	      ResultSet rs = null;
	      String sql = "select DISTINCT size from inventory";
	      rs = DB.getResultSet(stmt, sql);

	      while (rs.next())
	        sizes.add(rs.getString("size"));
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }
	    return sizes;
  }
  
  public static List getAvailableSizeOptionByProductId(int pid) {
	    List sizes = new ArrayList();
	    try {
	      Connection conn = DB.getConn();
	      Statement stmt = DB.getStatement(conn);
	      ResultSet rs = null;
	      String sql = "select DISTINCT size from inventory where productid = " + pid + " AND AMOUNT > 0";
	      rs = DB.getResultSet(stmt, sql);

	      while (rs.next())
	        sizes.add(rs.getString("size"));
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }

	    return sizes;
	  }
}