package com.bjsxt.shopping.product;

public class ProductSearchFormBean
{
  private int categoryId;
  private String name;
  private double lowNormalPrice;
  private double highNormalPrice;
  private double lowMemberPrice;
  private double highMemberPrice;
  private String startDate;
  private String endDate;

  public int getCategoryId()
  {
    return this.categoryId;
  }

  public void setCategoryId(int categoryId) {
    this.categoryId = categoryId;
  }

  public double getHighMemberPrice() {
    return this.highMemberPrice;
  }

  public void setHighMemberPrice(double highMemberPrice) {
    this.highMemberPrice = highMemberPrice;
  }

  public double getHighNormalPrice() {
    return this.highNormalPrice;
  }

  public void setHighNormalPrice(double highNormalPrice) {
    this.highNormalPrice = highNormalPrice;
  }

  public double getLowMemberPrice() {
    return this.lowMemberPrice;
  }

  public void setLowMemberPrice(double lowMemberPrice) {
    this.lowMemberPrice = lowMemberPrice;
  }

  public double getLowNormalPrice() {
    return this.lowNormalPrice;
  }

  public void setLowNormalPrice(double lowNormalPrice) {
    this.lowNormalPrice = lowNormalPrice;
  }

  public String getName() {
    if (this.name == null) return "";
    return this.name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getEndDate() {
    if (this.endDate == null) return "";
    return this.endDate;
  }

  public void setEndDate(String endDate) {
    this.endDate = endDate;
  }

  public String getStartDate() {
    if (this.startDate == null) return "";
    return this.startDate;
  }

  public void setStartDate(String startDate) {
    this.startDate = startDate;
  }

  public boolean validate() {
    return true;
  }
}