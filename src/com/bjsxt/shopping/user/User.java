package com.bjsxt.shopping.user;

import com.bjsxt.shopping.client.Cart;
import com.bjsxt.shopping.client.CartItem;
import com.bjsxt.shopping.inventory.inventoryRecord;
import com.bjsxt.shopping.order.OrderMgr;
import com.bjsxt.shopping.order.SalesItem;
import com.bjsxt.shopping.order.SalesOrder;
import com.bjsxt.shopping.order.shippingInfo;
import com.bjsxt.shopping.product.Product;
import com.bjsxt.shopping.util.DB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class User
{
  private int id;
  private String username;
  private String password;
  private String email;
  private String phone;
  private String addr;
  private Date rdate;

  public String getAddr()
  {
    return this.addr;
  }

  public void setAddr(String addr) {
    this.addr = addr;
  }

  public int getId() {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getPassword() {
    return this.password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getPhone() {
    return this.phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public Date getRdate() {
    return this.rdate;
  }

  public void setRdate(Date rdate) {
    this.rdate = rdate;
  }

  public String getUsername() {
    return this.username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getEmail() {
    return this.email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public void save() {
    Connection conn = DB.getConn();
    String sql = "insert into user values (null, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = DB.prepare(conn, sql);
    try {
      pstmt.setString(1, this.username);
      pstmt.setString(2, this.password);
      pstmt.setString(3, this.email);
      pstmt.setString(4, this.phone);
      pstmt.setString(5, this.addr);
      pstmt.setTimestamp(6, new Timestamp(this.rdate.getTime()));
      pstmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(pstmt);
      DB.close(conn);
    }
  }

  public int saveAndReturnId()
  {
    int userid = -1;
    Connection conn = DB.getConn();
    String sql = "insert into user values (null, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = DB.prepare(conn, sql, 1);
    ResultSet rsKey = null;
    try {
      pstmt.setString(1, this.username);
      pstmt.setString(2, this.password);
      pstmt.setString(3, this.email);
      pstmt.setString(4, this.phone);
      pstmt.setString(5, this.addr);
      pstmt.setTimestamp(6, new Timestamp(this.rdate.getTime()));
      pstmt.executeUpdate();
      rsKey = pstmt.getGeneratedKeys();
      rsKey.next();
      userid = rsKey.getInt(1);
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(pstmt);
      DB.close(conn);
    }

    return userid;
  }

  public static List getUsers()
  {
    List users = new ArrayList();
    Connection conn = DB.getConn();
    String sql = "select * from user";
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = DB.getResultSet(stmt, sql);
    try {
      while (rs.next()) {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setPhone(rs.getString("phone"));
        u.setAddr(rs.getString("addr"));
        u.setRdate(rs.getTimestamp("rdate"));
        users.add(u);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }
    return users;
  }

  public static int getUsers(List users, int pageNo, int pageSize)
  {
    int totalRecords = -1;

    Connection conn = DB.getConn();
    String sql = "select * from user limit " + (pageNo - 1) * pageSize + 
      "," + pageSize;
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = DB.getResultSet(stmt, sql);

    Statement stmtCount = DB.getStatement(conn);
    ResultSet rsCount = DB.getResultSet(stmtCount, 
      "select count(*) from user");
    try
    {
      rsCount.next();
      totalRecords = rsCount.getInt(1);

      while (rs.next()) {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setPhone(rs.getString("phone"));
        u.setAddr(rs.getString("addr"));
        u.setRdate(rs.getTimestamp("rdate"));
        users.add(u);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rsCount);
      DB.close(stmtCount);
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }

    return totalRecords;
  }

  public static boolean delete(int id) {
    boolean b = false;
    Connection conn = DB.getConn();
    String sql = "delete from user where id = " + id;
    Statement stmt = DB.getStatement(conn);
    try
    {
      DB.executeUpdate(stmt, sql);
      b = true;
    } finally {
      DB.close(stmt);
      DB.close(conn);
    }
    return b;
  }
  public static boolean usernameExist(String username) {
    boolean i = false;
    Connection conn = DB.getConn();
    String sql = "select * from user where username = '" + username + "'";
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = DB.getResultSet(stmt, sql);
    try {
      if (rs.next())
        i = true;
    }
    catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }

    return i;
  }

  public static User check(String username, String password) throws UserNotFoundException, PasswordNotCorrectException
  {
    User u = null;
    Connection conn = DB.getConn();
    String sql = "select * from user where username = '" + username + "'";
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = DB.getResultSet(stmt, sql);
    try {
      if (!rs.next()) {
        throw new UserNotFoundException("user not found:" + username);
      }
      if (!password.equals(rs.getString("password"))) {
        throw new PasswordNotCorrectException("invalid password!");
      }
      u = new User();
      u.setId(rs.getInt("id"));
      u.setUsername(rs.getString("username"));
      u.setPassword(rs.getString("password"));
      u.setEmail(rs.getString("email"));
      u.setPhone(rs.getString("phone"));
      u.setAddr(rs.getString("addr"));
      u.setRdate(rs.getTimestamp("rdate"));
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }
    return u;
  }

  public static void update(User u) {
    u.update();
  }

  public void updatePassword()
  {
  }

  public static void updatePassword(User u) {
    u.updatePassword();
  }

  public static void updatePassword(int userId, String newPassword)
  {
  }

  public void update() {
    Connection conn = DB.getConn();
    String sql = "update user set phone = ?, addr = ? where id = ?";
    PreparedStatement pstmt = DB.prepare(conn, sql);
    try {
      pstmt.setString(1, this.phone);
      pstmt.setString(2, this.addr);
      pstmt.setInt(3, this.id);
      pstmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(pstmt);
      DB.close(conn);
    }
  }

  public static void main(String[] args) {
    List users = new ArrayList();
    int totalRecords = getUsers(users, 1, 10);
    for (int i = 0; i < users.size(); i++);
  }

  public int buy(Cart c, shippingInfo shpi)
  {
    SalesOrder so = new SalesOrder();
    so.setUser(this);
    so.setSfirstName(shpi.getSfirstName());
    so.setSlastName(shpi.getSlastName());
    so.setSaddress1(shpi.getSaddress1());
    so.setSaddress2(shpi.getSaddress2());
    so.setScity(shpi.getScity());
    so.setSstate(shpi.getSstate());
    so.setSprovince(shpi.getSprovince());
    so.setSzip(shpi.getSzip());
    so.setScountry(shpi.getScountry());
    so.setSphone(shpi.getSphone());
    so.setStatus(0);
    so.setODate(new Date());
    List salesItems = new ArrayList();
    List cartItems = c.getItems();
    for (int i = 0; i < cartItems.size(); i++) {
      SalesItem si = new SalesItem();
      CartItem ci = (CartItem)cartItems.get(i);

      inventoryRecord.reduceAmount(ci.getCount(), ci.getProduct().getId(), ci.getSize(), ci.getColor());

      si.setProduct(ci.getProduct());
      si.setCount(ci.getCount());
      si.setUnitPrice(ci.getProduct().getMemberPrice());
      si.setColor(ci.getColor());
      si.setSize(ci.getSize());
      salesItems.add(si);
    }
    so.setItems(salesItems);
    return OrderMgr.getInstance().add(so);
  }
}