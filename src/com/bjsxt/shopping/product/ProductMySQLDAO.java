package com.bjsxt.shopping.product;

import com.bjsxt.shopping.category.Category;
import com.bjsxt.shopping.util.DB;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

public class ProductMySQLDAO
  implements ProductDAO
{
	
  public int add(Product p)
  {
	int  productid = -1;
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rsKey = null;
    Statement stmt = null;
    try {
      conn = DB.getConn();
      String sql = "insert into product values (null, ?, ?, ?, ?, ?, ?, ?)";
      pstmt = DB.prepare(conn, sql, 1);
      pstmt.setString(1, p.getName());
      pstmt.setString(2, p.getDescr());
      pstmt.setDouble(3, p.getNormalPrice());
      pstmt.setDouble(4, p.getMemberPrice());
      pstmt.setTimestamp(5, new Timestamp(p.getPdate().getTime()));
      pstmt.setInt(6, p.getCategoryId());
      pstmt.setInt(7, p.getDisplayOrder());
      pstmt.executeUpdate();
      rsKey = pstmt.getGeneratedKeys(); 
      rsKey.next();
      productid = rsKey.getInt(1);
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(pstmt);
      DB.close(conn);
    }
    
    try {
	  conn = DB.getConn();
	  String sql = "update product set displayorder =" + productid + "  where id = " + productid;
	  stmt = DB.getStatement(conn);
	  DB.executeUpdate(stmt, sql);
	} finally {
	  DB.close(stmt);
	  DB.close(conn);
	} 
    
    try {
        conn = DB.getConn();
        String sql = "insert into prodstatus values (?, ?)";
        
        pstmt = DB.prepare(conn, sql, 1);
        pstmt.setInt(1, productid);
        pstmt.setInt(2, 0);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        DB.close(pstmt);
        DB.close(conn);
    }
        
    return productid;  
  }
  
  public void delete(int id) { 
		Connection conn = null;
	    Statement stmt = null;
	    
	    try {
	      conn = DB.getConn();
	      String sql = "update prodstatus set isdeleted = 1 where pid = " + id;
	      stmt = DB.getStatement(conn);
	      DB.executeUpdate(stmt, sql);
	    } finally {
	      DB.close(stmt);
	      DB.close(conn);
	    } 
    }
  public String getDisplayOrder(){
	  String displayOrder = "-1";
	  Connection conn = DB.getConn();
	  Statement stmt = DB.getStatement(conn);
	  String sql = " SELECT GROUP_CONCAT(p.displayorder order by p.displayorder  SEPARATOR ',') as displayorder FROM product p " +
	  			   " where exists ( select 1 from inventory i where i.productid = p.id and i.amount > 0 ) " +
	  			   "   and exists ( select 1 from prodstatus ps where ps.pid = p.id and ps.isdeleted = 0 ) " +
	  			   " GROUP BY p.categoryid ";
	  ResultSet rs = DB.getResultSet(stmt, sql);
	  
	 try {
		 if(rs.next()){
			 displayOrder = rs.getString("displayorder");
		 }
	 }
	 catch (SQLException e) {
	    e.printStackTrace();
	 } finally {
	    DB.close(stmt);
	    DB.close(rs);
	    DB.close(conn);
	 }
	 return displayOrder;
  }
  
  public String getIdsIndisplayorder(){
	  String ids = "-1";
	  Connection conn = DB.getConn();
	  Statement stmt = DB.getStatement(conn);
	  String sql = " SELECT GROUP_CONCAT(p.id order by p.displayorder  SEPARATOR ',') as ids FROM product p " +
	  			   " where exists ( select 1 from inventory i where i.productid = p.id and i.amount > 0 ) " +
	  			   "   and exists ( select 1 from prodstatus ps where ps.pid = p.id and ps.isdeleted = 0 ) " +
	  			   " GROUP BY p.categoryid ";
	  ResultSet rs = DB.getResultSet(stmt, sql);
	  
	 try {
		 if(rs.next()){
			 ids = rs.getString("ids");
		 }
	 }
	 catch (SQLException e) {
	    e.printStackTrace();
	 } finally {
	    DB.close(stmt);
	    DB.close(rs);
	    DB.close(conn);
	 }
	 return ids;
  }
  
  public void setDisplayOrderById(int displayOrder, int id) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    try {
	      conn = DB.getConn();
	      String sql = "update product set displayorder=? where id=?";
	      pstmt = DB.prepare(conn, sql);
	      pstmt.setInt(1, displayOrder);
	      pstmt.setInt(2, id);
	      pstmt.executeUpdate();
	    } catch (SQLException e) {
	      e.printStackTrace();
	    } finally {
	      DB.close(pstmt);
	      DB.close(conn);
	    }
  }
  
  public int updateDisplayOrders(String newIds){
	  int isUpdated = -1;
	  String currentIds  = this.getIdsIndisplayorder(); 
	  String currentDisplayOrder = this.getDisplayOrder();
	  String iNewIds = "-1";
	  String iCurrentIds = "-1";
	  String iCurrentDiplayOrder = "-1";
	  
	  StringTokenizer stNewIds = new StringTokenizer(newIds, ","); 
	  StringTokenizer stCurrentIds = new StringTokenizer(currentIds, ",");
	  StringTokenizer stcurrentDisplayOrder = new StringTokenizer(currentDisplayOrder, ","); 
	  
	  while (stNewIds.hasMoreTokens() && stCurrentIds.hasMoreTokens() && stcurrentDisplayOrder.hasMoreTokens()) {
		  iNewIds = stNewIds.nextToken();
		  iCurrentIds = stCurrentIds.nextToken();
		  iCurrentDiplayOrder = stcurrentDisplayOrder.nextToken();
		  
		  if(!iNewIds.equals(iCurrentIds)){
			 this.setDisplayOrderById(Integer.parseInt(iCurrentDiplayOrder), Integer.parseInt(iNewIds));
			 if (isUpdated < 1)  isUpdated = 1;  
		  }
	  }
	  
	  return isUpdated;
  }
  
  
  public List getAvailableProducts(){
	  
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    String sql = " select * from product p where exists ( select 1 from inventory i where i.productid = p.id and i.amount > 0 ) and exists ( select 1 from prodstatus ps where ps.pid = p.id and ps.isdeleted = 0 ) order by p.displayorder ";
    ResultSet rs = DB.getResultSet(stmt, sql);
    List products = new ArrayList();
    try {
      while (rs.next()) {
        Product p = getProductFromRs(rs);
        products.add(p);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(stmt);
      DB.close(rs);
      DB.close(conn);
    }
    return products;
    
  }
  
  public List getProducts()
  {
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    String sql = "select * from product order by pdate desc";
    ResultSet rs = DB.getResultSet(stmt, sql);
    List products = new ArrayList();
    try {
      while (rs.next()) {
        Product p = getProductFromRs(rs);
        products.add(p);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(stmt);
      DB.close(rs);
      DB.close(conn);
    }

    return products;
  }
  
  public List getProducts(String order)
  {
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    String sql = "select * from product " + order ;
    ResultSet rs = DB.getResultSet(stmt, sql);
    List products = new ArrayList();
    try {
      while (rs.next()) {
        Product p = getProductFromRs(rs);
        products.add(p);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(stmt);
      DB.close(rs);
      DB.close(conn);
    }

    return products;
  }

  public int getProducts(List products, int pageNo, int pageSize, boolean lazy)
  {
    int totalRecords = -1;
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);

    String sql = "";
    if (lazy)
      sql = "select * from product p where exists ( select 1 from prodstatus ps where ps.pid = p.id and ps.isdeleted = 0 ) order by pdate desc";
    else {
      sql = "select p.id productid, p.name pname, p.descr pdescr, p.normalprice,  p.memberprice, p.pdate, p.categoryid ,  c.id categoryid, c.name cname, c.descr cdescr, c.pid, c.cno, c.grade  from product p join category c on (p.categoryid = c.id) order by p.pdate desc";
    }

    sql = sql + " limit " + (pageNo - 1) * pageSize + "," + pageSize;

    ResultSet rs = DB.getResultSet(stmt, sql);

    Statement stmtCount = DB.getStatement(conn);
    ResultSet rsCount = DB.getResultSet(stmtCount, 
      "select count(*) from product p where exists ( select 1 from prodstatus ps where ps.pid = p.id and ps.isdeleted = 0 )");
    try
    {
      rsCount.next();
      totalRecords = rsCount.getInt(1);

      while (rs.next()) {
        Product p = null;
        if (lazy) {
          p = getProductFromRs(rs);
        } else {
          p = new Product();
          p.setId(rs.getInt("productid"));
          p.setName(rs.getString("pname"));
          p.setDescr(rs.getString("pdescr"));
          p.setNormalPrice(rs.getDouble("normalprice"));
          p.setMemberPrice(rs.getDouble("memberprice"));
          p.setPdate(rs.getTimestamp("pdate"));
          p.setCategoryId(rs.getInt("categoryid"));

          Category c = new Category();
          c.setId(rs.getInt("categoryid"));
          c.setName(rs.getString("cname"));
          c.setDescr(rs.getString("cdescr"));
          c.setPid(rs.getInt("pid"));
          c.setCno(rs.getInt("cno"));
          c.setGrade(rs.getInt("grade"));

          p.setCategory(c);
        }

        products.add(p);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rsCount);
      DB.close(stmtCount);
      DB.close(stmt);
      DB.close(rs);
      DB.close(conn);
    }

    return totalRecords;
  }
  

  public Product loadById(int id) {
    Connection conn = null;
    ResultSet rs = null;
    Statement stmt = null;
    Product p = null;
    try
    {
      String sql = "select * from product where id = " + id;
      conn = DB.getConn();
      stmt = DB.getStatement(conn);
      rs = DB.getResultSet(stmt, sql);
      if (rs.next())
        p = getProductFromRs(rs);
    }
    catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(stmt);
      DB.close(rs);
      DB.close(conn);
    }
    return p;
  }

  public void update(Product p) {
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
      conn = DB.getConn();
      String sql = "update product set name=? , descr=?, normalprice=?, memberprice=?, categoryid=? where id=?";
      pstmt = DB.prepare(conn, sql);
      pstmt.setString(1, p.getName());
      pstmt.setString(2, p.getDescr());
      pstmt.setDouble(3, p.getNormalPrice());
      pstmt.setDouble(4, p.getMemberPrice());
      pstmt.setInt(5, p.getCategoryId());
      pstmt.setInt(6, p.getId());
      pstmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(pstmt);
      DB.close(conn);
    }
  }

  private Product getProductFromRs(ResultSet rs) {
    Product p = null;
    try {
      p = new Product();
      p.setId(rs.getInt("id"));
      p.setName(rs.getString("name"));
      p.setDescr(rs.getString("descr"));
      p.setNormalPrice(rs.getDouble("normalprice"));
      p.setMemberPrice(rs.getDouble("memberprice"));
      p.setPdate(rs.getTimestamp("pdate"));
      p.setCategoryId(rs.getInt("categoryid"));
      p.setDisplayOrder(rs.getInt("displayorder"));
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return p;
  }
  public void delete(String conditionStr) { 
	Connection conn = null;
    Statement stmt = null;
    
    try { conn = DB.getConn();
      String sql = "delete from product " + conditionStr;
      stmt = DB.getStatement(conn);
      DB.executeUpdate(stmt, sql);
    } finally {
      DB.close(stmt);
      DB.close(conn);
    } }

  public int find(List products, int pageNo, int pageSize, String queryStr)
  {
    int totalRecords = -1;
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);

    String sql = "";
    sql = "select p.id productid, p.name pname, p.descr pdescr, p.normalprice,  p.memberprice, p.pdate, p.categoryid ,  c.id categoryid, c.name cname, c.descr cdescr, c.pid, c.cno, c.grade  from product p join category c on (p.categoryid = c.id)" + 
      queryStr + 
      " order by p.pdate desc";

    sql = sql + " limit " + (pageNo - 1) * pageSize + "," + pageSize;
    System.out.println(sql);

    ResultSet rs = DB.getResultSet(stmt, sql);

    Statement stmtCount = DB.getStatement(conn);
    ResultSet rsCount = DB.getResultSet(stmtCount, 
      "select count(*) from product " + queryStr.replaceAll("p\\.", ""));
    try
    {
      rsCount.next();
      totalRecords = rsCount.getInt(1);

      while (rs.next()) {
        Product p = null;
        p = new Product();
        p.setId(rs.getInt("productid"));
        p.setName(rs.getString("pname"));
        p.setDescr(rs.getString("pdescr"));
        p.setNormalPrice(rs.getDouble("normalprice"));
        p.setMemberPrice(rs.getDouble("memberprice"));
        p.setPdate(rs.getTimestamp("pdate"));
        p.setCategoryId(rs.getInt("categoryid"));

        Category c = new Category();
        c.setId(rs.getInt("categoryid"));
        c.setName(rs.getString("cname"));
        c.setDescr(rs.getString("cdescr"));
        c.setPid(rs.getInt("pid"));
        c.setCno(rs.getInt("cno"));
        c.setGrade(rs.getInt("grade"));

        p.setCategory(c);

        products.add(p);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rsCount);
      DB.close(stmtCount);
      DB.close(stmt);
      DB.close(rs);
      DB.close(conn);
    }

    return totalRecords;
  }
}