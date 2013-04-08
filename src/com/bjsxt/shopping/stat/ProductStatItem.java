package com.bjsxt.shopping.stat;

public class ProductStatItem
{
  private int productId;
  private String productName;
  private int totalSalesCount;

  public int getProductId()
  {
    return this.productId;
  }

  public void setProductId(int productId) {
    this.productId = productId;
  }

  public String getProductName() {
    return this.productName;
  }

  public void setProductName(String productName) {
    this.productName = productName;
  }

  public int getTotalSalesCount() {
    return this.totalSalesCount;
  }

  public void setTotalSalesCount(int totalSalesCount) {
    this.totalSalesCount = totalSalesCount;
  }
}