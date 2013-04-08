package com.bjsxt.shopping.order;

import java.util.List;

public abstract interface OrderDAO
{
  public abstract void update(SalesOrder paramSalesOrder);

  public abstract int add(SalesOrder paramSalesOrder);

  public abstract List getOrders();

  public abstract int getOrders(List paramList, int paramInt1, int paramInt2);

  public abstract void delete(int paramInt);

  public abstract SalesOrder loadById(int paramInt);

  public abstract void delete(String paramString);

  public abstract int find(List paramList, int paramInt1, int paramInt2, String paramString);

  public abstract List getSalesItems(int paramInt);

  public abstract void updateStatus(SalesOrder paramSalesOrder);
}