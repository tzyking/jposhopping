package com.bjsxt.shopping.order;

import com.bjsxt.shopping.user.User;
import java.util.Date;
import java.util.List;

public class SalesOrder
{
  private int id;
  private User user;
  private String sfirstName;
  private String slastName;
  private String saddress1;
  private String saddress2;
  private String scity;
  private String sstate;
  private String sprovince;
  private String szip;
  private String scountry;
  private String sphone;
  private Date oDate;
  private int status;
  private List items;
  private paymentRecord pr;

  public int getId()
  {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getSfirstName() {
    return this.sfirstName;
  }

  public void setSfirstName(String sfirstName) {
    this.sfirstName = sfirstName;
  }

  public String getSlastName() {
    return this.slastName;
  }

  public void setSlastName(String slastName) {
    this.slastName = slastName;
  }

  public String getSaddress1() {
    return this.saddress1;
  }

  public void setSaddress1(String saddress1) {
    this.saddress1 = saddress1;
  }

  public String getSaddress2() {
    return this.saddress2;
  }

  public void setSaddress2(String saddress2) {
    this.saddress2 = saddress2;
  }

  public String getScity() {
    return this.scity;
  }

  public void setScity(String scity) {
    this.scity = scity;
  }

  public String getSstate() {
    return this.sstate;
  }

  public void setSstate(String sstate) {
    this.sstate = sstate;
  }

  public String getSprovince() {
    return this.sprovince;
  }

  public void setSprovince(String sprovince) {
    this.sprovince = sprovince;
  }

  public String getSzip() {
    return this.szip;
  }

  public void setSzip(String szip) {
    this.szip = szip;
  }

  public String getScountry() {
    return this.scountry;
  }

  public void setScountry(String scountry) {
    this.scountry = scountry;
  }

  public String getSphone() {
    return this.sphone;
  }

  public void setSphone(String sphone) {
    this.sphone = sphone;
  }

  public Date getoDate() {
    return this.oDate;
  }

  public void setoDate(Date oDate) {
    this.oDate = oDate;
  }

  public List getItems() {
    return this.items;
  }

  public void setItems(List items) {
    this.items = items;
  }

  public Date getODate() {
    return this.oDate;
  }

  public void setODate(Date date) {
    this.oDate = date;
  }

  public int getStatus() {
    return this.status;
  }

  public void setStatus(int status) {
    this.status = status;
  }

  public User getUser() {
    return this.user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public paymentRecord getPr()
  {
    return this.pr;
  }

  public void setPr(paymentRecord pr) {
    this.pr = pr;
  }

  public void updateStatus() {
    OrderMgr.getInstance().updateStatus(this);
  }
}