package com.bjsxt.shopping.product;

import java.util.List;

public class ProductOracleDAO
  implements ProductDAO
{
  public int add(Product p)
  {
	  return 1;
  }

  public void delete(int id)
  {
  }
  
  public List getAvailableProducts()
  {
    return null;
  }
  
  public List getProducts()
  {
    return null;
  }
  
  public List getProducts(String order)
  {
    return null;
  }

  public int getProducts(List products, int pageNo, int pageSize, boolean lazy)
  {
    return -1;
  }

  public Product loadById(int id)
  {
    return null;
  }

  public void update(Product p)
  {
  }

  public void delete(String conditionStr)
  {
  }

  public int find(List products, int pageNo, int pageSize, String queryStr)
  {
    return 0;
  }

public String getDisplayOrder() {
	// TODO Auto-generated method stub
	return null;
}

public String getIdsIndisplayorder() {
	// TODO Auto-generated method stub
	return null;
}

public void setDisplayOrderById(int displayOrder, int id) {
	// TODO Auto-generated method stub
	
}

public int updateDisplayOrders(String newIds) {
	// TODO Auto-generated method stub
	return 0;
}
}