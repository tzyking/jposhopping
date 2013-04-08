package com.bjsxt.shopping.category;

import com.bjsxt.shopping.util.DB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class Category
{
  public static final int MAX_GRADE = 3;
  public static final int LEVEL_LENGTH = 2;
  private int id;
  private String name;
  private String descr;
  private int pid;
  private int cno;
  private int grade;

  public String getDescr()
  {
    return this.descr;
  }

  public void setDescr(String descr) {
    this.descr = descr;
  }

  public int getGrade() {
    return this.grade;
  }

  public void setGrade(int grade) {
    this.grade = grade;
  }

  public int getId() {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getName() {
    return this.name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public int getPid() {
    return this.pid;
  }

  public void setPid(int pid) {
    this.pid = pid;
  }

  public void update() {
    Connection conn = DB.getConn();
    String sql = "update category set name = ? , descr = ? where id = ?";
    PreparedStatement pstmt = DB.prepare(conn, sql);
    try {
      pstmt.setString(1, this.name);
      pstmt.setString(2, this.descr);
      pstmt.setInt(3, this.id);
      pstmt.executeUpdate();
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(pstmt);
      DB.close(conn);
    }
  }

  public int getCno() {
    return this.cno;
  }

  public void setCno(int cno) {
    this.cno = cno;
  }

  public List getChilds() {
    return null;
  }
}