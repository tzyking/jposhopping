package com.bjsxt.shopping.order;

import com.bjsxt.shopping.product.Product;

public class SalesItem
{
  private int id;
  private Product product;
  private double unitPrice;
  private String color;
  private String size;
  private int count;
  private int orderId;

  public int getCount()
  {
    return this.count;
  }
  public void setCount(int count) {
    this.count = count;
  }
  public int getId() {
    return this.id;
  }
  public void setId(int id) {
    this.id = id;
  }
  public int getOrderId() {
    return this.orderId;
  }
  public void setOrderId(int orderId) {
    this.orderId = orderId;
  }
  public Product getProduct() {
    return this.product;
  }
  public void setProduct(Product product) {
    this.product = product;
  }
  public double getUnitPrice() {
    return this.unitPrice;
  }
  public void setUnitPrice(double unitPrice) {
    this.unitPrice = unitPrice;
  }

  public String getColor() {
    return this.color;
  }
  public void setColor(String color) {
    this.color = color;
  }
  public String getSize() {
    return this.size;
  }
  public void setSize(String size) {
    this.size = size;
  }
}