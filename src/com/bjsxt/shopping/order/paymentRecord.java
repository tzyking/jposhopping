package com.bjsxt.shopping.order;

import com.bjsxt.shopping.util.DB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class paymentRecord
{
  private int id;
  private int orderId;
  private double amount;
  private double tax;
  private String ctype;
  private String cname;
  private String cnum;
  private String cexpmonth;
  private String cexpyear;
  private String bfirstName;
  private String blastName;
  private String baddress1;
  private String baddress2;
  private String bcity;
  private String bstate;
  private String bprovince;
  private String bzip;
  private String bcountry;
  private String bphone;

  public int getId()
  {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getOrderId() {
    return this.orderId;
  }

  public void setOrderId(int orderId) {
    this.orderId = orderId;
  }

  public double getAmount() {
    return this.amount;
  }

  public void setAmount(double amount) {
    this.amount = amount;
  }

  public double getTax() {
    return this.tax;
  }

  public void setTax(double tax) {
    this.tax = tax;
  }

  public String getCtype() {
    return this.ctype;
  }

  public void setCtype(String ctype) {
    this.ctype = ctype;
  }

  public String getCname() {
    return this.cname;
  }

  public void setCname(String cname) {
    this.cname = cname;
  }

  public String getCnum() {
    return this.cnum;
  }

  public void setCnum(String cnum) {
    this.cnum = cnum;
  }

  public String getCexpmonth() {
    return this.cexpmonth;
  }

  public void setCexpmonth(String cexpmonth) {
    this.cexpmonth = cexpmonth;
  }

  public String getCexpyear() {
    return this.cexpyear;
  }

  public void setCexpyear(String cexpyear) {
    this.cexpyear = cexpyear;
  }

  public String getBfirstName() {
    return this.bfirstName;
  }

  public void setBfirstName(String bfirstName) {
    this.bfirstName = bfirstName;
  }

  public String getBlastName() {
    return this.blastName;
  }

  public void setBlastName(String blastName) {
    this.blastName = blastName;
  }

  public String getBaddress1() {
    return this.baddress1;
  }

  public void setBaddress1(String baddress1) {
    this.baddress1 = baddress1;
  }

  public String getBaddress2() {
    return this.baddress2;
  }

  public void setBaddress2(String baddress2) {
    this.baddress2 = baddress2;
  }

  public String getBcity() {
    return this.bcity;
  }

  public void setBcity(String bcity) {
    this.bcity = bcity;
  }

  public String getBstate() {
    return this.bstate;
  }

  public void setBstate(String bstate) {
    this.bstate = bstate;
  }

  public String getBprovince() {
    return this.bprovince;
  }

  public void setBprovince(String bprovince) {
    this.bprovince = bprovince;
  }

  public String getBzip() {
    return this.bzip;
  }

  public void setBzip(String bzip) {
    this.bzip = bzip;
  }

  public String getBcountry() {
    return this.bcountry;
  }

  public void setBcountry(String bcountry) {
    this.bcountry = bcountry;
  }

  public String getBphone() {
    return this.bphone;
  }

  public void setBphone(String bphone) {
    this.bphone = bphone;
  }

  public void save()
  {
    Connection conn = DB.getConn();
    String sql = "insert into paymentrecord values (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = DB.prepare(conn, sql);
    try {
      pstmt.setInt(1, this.orderId);
      pstmt.setDouble(2, this.amount);
      pstmt.setString(3, this.ctype);
      pstmt.setString(4, this.cname);
      pstmt.setString(5, this.cnum);
      pstmt.setString(6, this.cexpmonth);
      pstmt.setString(7, this.cexpyear);
      pstmt.setString(8, this.bfirstName);
      pstmt.setString(9, this.blastName);
      pstmt.setString(10, this.baddress1);
      pstmt.setString(11, this.baddress2);
      pstmt.setString(12, this.bcity);
      pstmt.setString(13, this.bstate);
      pstmt.setString(14, this.bprovince);
      pstmt.setString(15, this.bzip);
      pstmt.setString(16, this.bcountry);
      pstmt.setString(17, this.bphone);

      pstmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(pstmt);
      DB.close(conn);
    }
  }

  public static paymentRecord loadByorderId(int orderId)
  {
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = null;
    paymentRecord pr = null;
    try {
      String sql = "select * from paymentrecord where paymentrecord.orderid = " + orderId;
      rs = DB.getResultSet(stmt, sql);
      if (rs.next()) {
        pr = new paymentRecord();
        pr.setId(rs.getInt("id"));
        pr.setOrderId(rs.getInt("orderid"));
        pr.setAmount(rs.getDouble("amount"));
        pr.setCtype(rs.getString("ctype"));
        pr.setCname(rs.getString("cname"));
        pr.setCnum(rs.getString("cnum"));
        pr.setCexpmonth(rs.getString("cexpmonth"));
        pr.setCexpyear(rs.getString("cexpyear"));
        pr.setBfirstName(rs.getString("bfirstname"));
        pr.setBlastName(rs.getString("blastname"));
        pr.setBaddress1(rs.getString("baddress1"));
        pr.setBaddress2(rs.getString("baddress2"));
        pr.setBcity(rs.getString("bcity"));
        pr.setBstate(rs.getString("bstate"));
        pr.setBprovince(rs.getString("bprovince"));
        pr.setBzip(rs.getString("bzip"));
        pr.setBcountry(rs.getString("bcountry"));
        pr.setBphone(rs.getString("bphone"));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }

    return pr;
  }
  
  public static paymentRecord loadByUsernamePassword(String userName, String password)
  {
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = null;
    paymentRecord pr = null;
    try {
      String sql =	  "select " +
				      "p.bfirstname bfirstname, " +
				      "p.blastname blastname, " +
				      "p.baddress1 baddress1, " +
				      "p.baddress2 baddress2, " +
				      "p.bcity bcity, " +
				      "p.bstate bstate, " +
				      "p.bprovince bprovince, " + 
				      "p.bzip bzip, " +
				      "p.bcountry bcountry, " +
				      "p.bphone bphone " +
				      "from salesorder s, paymentrecord p, user u " +
				      "where s.id = p.orderid " +
				      "and u.id = s.userid " +
				      "and u.username = '" + userName + "' " + 
				      "and u.password = '" + password + "'";
      
      rs = DB.getResultSet(stmt, sql);
      if (rs.next()) {
        pr = new paymentRecord();
        pr.setBfirstName(rs.getString("bfirstname"));
        pr.setBlastName(rs.getString("blastname"));
        pr.setBaddress1(rs.getString("baddress1"));
        pr.setBaddress2(rs.getString("baddress2"));
        pr.setBcity(rs.getString("bcity"));
        pr.setBstate(rs.getString("bstate"));
        pr.setBprovince(rs.getString("bprovince"));
        pr.setBzip(rs.getString("bzip"));
        pr.setBcountry(rs.getString("bcountry"));
        pr.setBphone(rs.getString("bphone"));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }

    return pr;
  }
  
  public static void main(String[] args) {
	paymentRecord p = paymentRecord.loadByUsernamePassword("vanessa", "bracewell1");
	System.out.println(p.bfirstName);
	System.out.println(p.baddress2);
	System.out.println(p.baddress2.isEmpty());
  }
}