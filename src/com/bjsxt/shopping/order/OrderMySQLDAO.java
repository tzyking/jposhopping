package com.bjsxt.shopping.order;

import com.bjsxt.shopping.product.Product;
import com.bjsxt.shopping.user.User;
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
import java.util.Iterator;
import java.util.List;

public class OrderMySQLDAO
  implements OrderDAO
{
  public int add(SalesOrder so)
  {
    int orderId = -1;

    Connection conn = DB.getConn();
    boolean autoCommit = true;
    try {
      autoCommit = conn.getAutoCommit();
      conn.setAutoCommit(false);
    } catch (SQLException e1) {
      e1.printStackTrace();
    }
    String sql = "insert into salesorder values (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = DB.prepare(conn, sql, 1);
    String sqlDetail = "insert into salesitem values (null, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmtDetail = DB.prepare(conn, sqlDetail);
    ResultSet rsKey = null;
    try {
      int userid = 0;
      userid = so.getUser().getId();
      pstmt.setInt(1, userid);
      pstmt.setString(2, so.getSfirstName());
      pstmt.setString(3, so.getSlastName());
      pstmt.setString(4, so.getSaddress1());
      pstmt.setString(5, so.getSaddress2());
      pstmt.setString(6, so.getScity());
      pstmt.setString(7, so.getSstate());
      pstmt.setString(8, so.getSprovince());
      pstmt.setString(9, so.getSzip());
      pstmt.setString(10, so.getScountry());
      pstmt.setString(11, so.getSphone());
      pstmt.setTimestamp(12, new Timestamp(so.getODate().getTime()));
      pstmt.setInt(13, so.getStatus());
      pstmt.executeUpdate();
      rsKey = pstmt.getGeneratedKeys();
      rsKey.next();
      orderId = rsKey.getInt(1);

      List items = so.getItems();
      Iterator it = items.iterator();
      while (it.hasNext()) {
        SalesItem si = (SalesItem)it.next();
        pstmtDetail.setInt(1, si.getProduct().getId());
        pstmtDetail.setDouble(2, si.getUnitPrice());
        pstmtDetail.setString(3, si.getColor());
        pstmtDetail.setString(4, si.getSize());
        pstmtDetail.setInt(5, si.getCount());
        pstmtDetail.setInt(6, orderId);
        pstmtDetail.addBatch();
      }
      pstmtDetail.executeBatch();
      conn.commit();
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      try {
        conn.setAutoCommit(autoCommit);
      } catch (SQLException e) {
        e.printStackTrace();
      }
      DB.close(rsKey);
      DB.close(pstmtDetail);
      DB.close(pstmt);
      DB.close(conn);
    }

    return orderId;
  }

  public void delete(int id)
  {
  }

  public void delete(String conditionStr)
  {
  }

  public int find(List products, int pageNo, int pageSize, String queryStr)
  {
    return 0;
  }

  public List getOrders()
  {
    return null;
  }

  public int getOrders(List orders, int pageNo, int pageSize) {
    Connection conn = DB.getConn();
    Statement stmtCount = DB.getStatement(conn);
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = null;
    ResultSet rsCount = null;
    int totalRecords = 0;
    try {
      rsCount = DB.getResultSet(stmtCount, 
        "select count(*) from salesorder");
      rsCount.next();
      totalRecords = rsCount.getInt(1);
      conn = DB.getConn();
      String sql = " select salesorder.*, paymentrecord.cnum, user.email from salesorder " +
      			   " left join paymentrecord on salesorder.id = paymentrecord.orderid  " +
      			   " left join user on user.id = salesorder.userid order by odate desc  limit " + 
      			   (pageNo - 1) * pageSize + "," + pageSize;
      System.out.println(sql);
      rs = DB.getResultSet(stmt, sql);
      while (rs.next()) {
        User u = new User();
        u.setId(rs.getInt("userid"));
        u.setEmail(rs.getString("email"));

        paymentRecord pr = new paymentRecord();
        pr.setCnum(rs.getString("cnum"));

        SalesOrder so = new SalesOrder();
        so.setUser(u);
        so.setPr(pr);
        so.setId(rs.getInt("id"));
        so.setSfirstName(rs.getString("sfirstname"));
        so.setSlastName(rs.getString("slastname"));
        so.setSaddress1(rs.getString("saddress1"));
        so.setSaddress2(rs.getString("saddress2"));
        so.setScity(rs.getString("scity"));
        so.setSstate(rs.getString("sstate"));
        so.setSprovince(rs.getString("sprovince"));
        so.setSzip(rs.getString("szip"));
        so.setScountry(rs.getString("scountry"));
        so.setSphone(rs.getString("sphone"));
        so.setODate(rs.getTimestamp("odate"));
        so.setStatus(rs.getInt("status"));
        orders.add(so);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(stmt);
      DB.close(stmtCount);
      DB.close(rs);
      DB.close(rsCount);
      DB.close(conn);
    }

    return totalRecords;
  }

  public SalesOrder loadById(int id) {
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = null;
    SalesOrder so = null;
    try {
      String sql = "select * from salesorder where salesorder.id = " + id;
      rs = DB.getResultSet(stmt, sql);
      if (rs.next()) {
        User u = new User();
        u.setId(rs.getInt("userid"));

        so = new SalesOrder();
        so.setId(rs.getInt("id"));
        so.setSfirstName(rs.getString("sfirstname"));
        so.setSlastName(rs.getString("slastname"));
        so.setSaddress1(rs.getString("saddress1"));
        so.setSaddress2(rs.getString("saddress2"));
        so.setScity(rs.getString("scity"));
        so.setSstate(rs.getString("sstate"));
        so.setSprovince(rs.getString("sprovince"));
        so.setSzip(rs.getString("szip"));
        so.setScountry(rs.getString("scountry"));
        so.setSphone(rs.getString("sphone"));
        so.setODate(rs.getTimestamp("odate"));
        so.setStatus(rs.getInt("status"));
        so.setUser(u);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }

    return so;
  }

  public void update(SalesOrder so)
  {
  }

  public List getSalesItems(int orderId)
  {
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = null;
    List items = new ArrayList();
    try {
      conn = DB.getConn();
      String sql = "select salesorder.id, salesorder.userid, salesorder.odate, salesorder.status,  salesitem.id itemid, salesitem.productid, salesitem.unitprice, salesitem.color, salesitem.size, salesitem.pcount, salesitem.orderid,  product.id pid, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid  from salesorder join salesitem on (salesorder.id = salesitem.orderid) join product on (salesitem.productid = product.id) where salesorder.id = " + 
        orderId;
      System.out.println(sql);
      rs = DB.getResultSet(stmt, sql);
      while (rs.next()) {
        Product p = new Product();
        p.setId(rs.getInt("pid"));
        p.setCategoryId(rs.getInt("categoryid"));
        p.setName(rs.getString("name"));
        p.setDescr(rs.getString("descr"));
        p.setPdate(rs.getTimestamp("pdate"));
        p.setNormalPrice(rs.getDouble("normalprice"));
        p.setMemberPrice(rs.getDouble("memberprice"));

        SalesItem si = new SalesItem();
        si.setOrderId(orderId);
        si.setId(rs.getInt("itemid"));
        si.setUnitPrice(rs.getDouble("unitprice"));
        si.setColor(rs.getString("color"));
        si.setSize(rs.getString("size"));
        si.setCount(rs.getInt("pcount"));
        si.setProduct(p);

        items.add(si);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }

    return items;
  }

  public void updateStatus(SalesOrder order)
  {
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    try {
      String sql = "update salesorder set status = " + order.getStatus() + " where id = " + order.getId();
      DB.executeUpdate(stmt, sql);
    } finally {
      DB.close(stmt);
      DB.close(conn);
    }
  }
}