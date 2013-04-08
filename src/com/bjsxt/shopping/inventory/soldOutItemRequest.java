package com.bjsxt.shopping.inventory;

import com.bjsxt.shopping.util.DB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class soldOutItemRequest
{
  private int id;
  private inventoryRecord ir;
  private String size;
  private String color;
  private String contactEmail;
  private Date rdate;

  public int getId()
  {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public inventoryRecord getIr()
  {
    return this.ir;
  }

  public void setIr(inventoryRecord ir) {
    this.ir = ir;
  }

  public String getSize() {
    return this.size;
  }

  public void setSize(String size) {
    this.size = size;
  }

  public String getColor() {
    return this.color;
  }

  public void setColor(String color) {
    this.color = color;
  }

  public String getContactEmail() {
    return this.contactEmail;
  }

  public void setContactEmail(String contactEmail) {
    this.contactEmail = contactEmail;
  }

  public Date getRdate() {
    return this.rdate;
  }

  public void setRdate(Date rdate) {
    this.rdate = rdate;
  }

  public void save()
  {
    Connection conn = DB.getConn();
    String sql = "insert into soldoutitemrequest values (null, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = DB.prepare(conn, sql);
    try {
      pstmt.setInt(1, this.ir.getId());
      pstmt.setString(2, this.color);
      pstmt.setString(3, this.size);
      pstmt.setString(4, this.contactEmail);
      pstmt.setTimestamp(5, new Timestamp(this.rdate.getTime()));
      pstmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(pstmt);
      DB.close(conn);
    }
  }

  public List getSoldOutItemRequests() {
    List irs = new ArrayList();
    Connection conn = DB.getConn();

    return null;
  }
}