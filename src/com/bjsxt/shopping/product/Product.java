package com.bjsxt.shopping.product;

import com.bjsxt.shopping.category.Category;
import java.util.Date;

public class Product
{
  private int id;
  private String name;
  private String descr;
  private double normalPrice;
  private double memberPrice;
  private Date pdate;
  private int categoryId;
  private Category category;
  private int displayOrder;



public int getCategoryId()
  {
    return this.categoryId;
  }

  public void setCategoryId(int categoryId) {
    this.categoryId = categoryId;
  }

  public String getDescr() {
    return this.descr;
  }

  public void setDescr(String descr) {
    this.descr = descr;
  }

  public int getId() {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public double getMemberPrice() {
    return this.memberPrice;
  }

  public void setMemberPrice(double memberPrice) {
    this.memberPrice = memberPrice;
  }

  public String getName() {
    return this.name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public double getNormalPrice() {
    return this.normalPrice;
  }

  public void setNormalPrice(double normalPrice) {
    this.normalPrice = normalPrice;
  }

  public Date getPdate() {
    return this.pdate;
  }

  public void setPdate(Date pdate) {
    this.pdate = pdate;
  }

  public void update()
  {
  }

  public Category getCategory() {
    return this.category;
  }

  public void setCategory(Category category) {
    this.category = category;
  }
  
  public int getDisplayOrder() {
		return displayOrder;
	}

	public void setDisplayOrder(int displayOrder) {
		this.displayOrder = displayOrder;
	}
}