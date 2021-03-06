package com.bjsxt.shopping.stat;

import com.bjsxt.shopping.util.DB;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class StatService
{
  public static List getProductsBySaleCount()
  {
    Connection conn = DB.getConn();
    Statement stmt = DB.getStatement(conn);
    ResultSet rs = null;
    List list = new ArrayList();
    try
    {
      String sql = "select productid, sum(pcount) totalsalescount, name from salesitem join  product on (salesitem.productid = product.id)  group by productid order by totalsalescount desc";

      rs = DB.getResultSet(stmt, sql);
      while (rs.next()) {
        ProductStatItem p = new ProductStatItem();
        p.setProductId(rs.getInt("productid"));
        p.setTotalSalesCount(rs.getInt("totalsalescount"));
        p.setProductName(rs.getString("name"));
        list.add(p);
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      DB.close(stmt);
      DB.close(rs);
      DB.close(conn);
    }

    return list;
  }
}