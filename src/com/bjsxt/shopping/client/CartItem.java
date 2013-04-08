package com.bjsxt.shopping.client;

import com.bjsxt.shopping.product.Product;

public class CartItem
{
  private Product product;
  private int count;
  private String size;
  private String color;

  public int getCount()
  {
    return this.count;
  }

  public void setCount(int count) {
    this.count = count;
  }

  public Product getProduct() {
    return this.product;
  }

  public void setProduct(Product product) {
    this.product = product;
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
}