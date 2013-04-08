package com.bjsxt.shopping.category;

import com.bjsxt.shopping.util.DB;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CategoryService
{
  private static CategoryService service;

  public static CategoryService getInstance()
  {
    if (service == null) {
      service = new CategoryService();
    }
    return service;
  }

  public List getTopCategories()
  {
    List categories = new ArrayList();
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = DB.getResultSet(stmt, "select * from category where grade = 1");
    try {
      while (rs.next()) {
        Category c = getCategoryFromRs(rs);
        categories.add(c);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(conn);
    }

    return categories;
  }

  public List getChilds(int id) {
    List categories = new ArrayList();
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = DB.getResultSet(stmt, "select * from category where pid = " + id);
    try {
      while (rs.next()) {
        Category c = getCategoryFromRs(rs);
        categories.add(c);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(conn);
    }

    return categories;
  }

  public List getCategories()
  {
    List categories = new ArrayList();
    Connection conn = DB.getConn();
    String sql = "select * from category order by cno";
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = DB.getResultSet(stmt, sql);
    try {
      while (rs.next()) {
        Category c = getCategoryFromRs(rs);
        categories.add(c);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }
    return categories;
  }

  private Category getCategoryFromRs(ResultSet rs) {
    Category c = new Category();
    try {
      c.setId(rs.getInt("id"));
      c.setPid(rs.getInt("pid"));
      c.setName(rs.getString("name"));
      c.setDescr(rs.getString("descr"));
      c.setCno(rs.getInt("cno"));
      c.setGrade(rs.getInt("grade"));
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return c;
  }

  public void delete(int id)
  {
  }

  public void delete(Category c) {
    delete(c.getId());
  }

  public void add(Category c) {
    Connection conn = DB.getConn();
    try {
      conn.setAutoCommit(false);
    } catch (SQLException e1) {
      e1.printStackTrace();
    }

    String sql = "insert into category values (null, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = DB.prepare(conn, sql);
    try {
      int cno = getNextCno(conn, c);

      pstmt.setInt(1, c.getPid());
      pstmt.setString(2, c.getName());
      pstmt.setString(3, c.getDescr());
      pstmt.setInt(4, cno);
      pstmt.setInt(5, c.getGrade());
      pstmt.executeUpdate();
      conn.commit();
    } catch (SQLException e) {
      try {
        conn.rollback();
      } catch (SQLException e1) {
        e1.printStackTrace();
      }
      e.printStackTrace();
    } finally {
      try {
        conn.setAutoCommit(true);
      } catch (SQLException e) {
        e.printStackTrace();
      }
      DB.close(pstmt);
      DB.close(conn);
    }
  }

  private int getNextCno(Connection conn, Category c)
  {
    int cno = -1;

    String sqlMax = "select max(cno) from category where pid = " + c.getPid();
    Statement stmtMax = DB.getStatement(conn);
    ResultSet rsMax = DB.getResultSet(stmtMax, sqlMax);
    try
    {
      rsMax.next();
      int cnoMax = rsMax.getInt(1);
      System.out.println(cnoMax);

      int baseNumber = (int)Math.pow(10.0D, 2.0D);

      int numberToAdd = (int)Math.pow(baseNumber, 3 - c.getGrade());

      if (cnoMax == 0) {
        if (c.getPid() == 0) {
          cno = numberToAdd;
        } else {
          int parentCno = getParentCno(conn, c);
          cno = parentCno + numberToAdd;
        }
      }
      else cno = cnoMax + numberToAdd;
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    } finally {
      DB.close(rsMax);
      DB.close(stmtMax);
    }

    return cno;
  }

  private int getParentCno(Connection conn, Category child) {
    String sql = "select cno from category where id = " + child.getPid();
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = DB.getResultSet(stmt, sql);

    int cno = -1;
    try
    {
      rs.next();
      cno = rs.getInt(1);
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
    }
    return cno;
  }

  public void update(Category c) {
    c.update();
  }

  public void updateCategory(int id, String name, String descr)
  {
  }

  public Category loadById(int id) {
    Category c = null;
    Connection conn = DB.getConn();
    String sql = "select * from category where id = " + id;
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = DB.getResultSet(stmt, sql);
    try {
      if (rs.next())
        c = getCategoryFromRs(rs);
    }
    catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(rs);
      DB.close(stmt);
      DB.close(conn);
    }
    return c;
  }
}