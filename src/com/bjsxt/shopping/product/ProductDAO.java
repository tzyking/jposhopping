package com.bjsxt.shopping.product;

import java.util.List;

public abstract interface ProductDAO
{
  public abstract List getAvailableProducts();
  
  public abstract List getProducts();
  
  public abstract List getProducts(String order);

  public abstract int getProducts(List paramList, int paramInt1, int paramInt2, boolean paramBoolean);

  public abstract int add(Product paramProduct);

  public abstract void delete(int paramInt);

  public abstract void update(Product paramProduct);

  public abstract Product loadById(int paramInt);

  public abstract void delete(String paramString);

  public abstract int find(List paramList, int paramInt1, int paramInt2, String paramString);
 
  public abstract String getDisplayOrder();
 
  public abstract String getIdsIndisplayorder();
  
  public abstract void setDisplayOrderById(int displayOrder, int id);
  
  public abstract int updateDisplayOrders(String newIds);
}