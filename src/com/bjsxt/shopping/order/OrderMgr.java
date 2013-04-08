package com.bjsxt.shopping.order;

import com.bjsxt.shopping.client.Cart;
import com.bjsxt.shopping.user.User;
import java.util.List;

public class OrderMgr
{
  private static OrderMgr mgr = null;

  private static OrderDAO dao = new OrderMySQLDAO();

  public static OrderMgr getInstance()
  {
    if (mgr == null) {
      mgr = new OrderMgr();
    }
    return mgr;
  }

  public int add(SalesOrder so) {
    return dao.add(so);
  }

  public int userBuy(Cart c, shippingInfo s, User u) {
    return u.buy(c, s);
  }

  public int getOrders(List list, int pageNo, int pageSize) {
    return dao.getOrders(list, pageNo, pageSize);
  }

  public SalesOrder loadById(int id) {
    return dao.loadById(id);
  }

  public List getSalesItems(SalesOrder order) {
    return dao.getSalesItems(order.getId());
  }

  public void updateStatus(SalesOrder order) {
    dao.updateStatus(order);
  }
}