package com.bjsxt.shopping.client;

import com.bjsxt.shopping.inventory.*;
import com.bjsxt.shopping.product.Product;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart
{
  List items = new ArrayList();

  public List getItems() {
    return this.items;
  }

  public void setItems(List items) {
    this.items = items;
  }

  public void add(CartItem ci) {
    for (Iterator iter = this.items.iterator(); iter.hasNext(); ) {
      CartItem item = (CartItem)iter.next();
      if ((item.getProduct().getId() == ci.getProduct().getId()) && (item.getSize().equals(ci.getSize())) && (item.getColor().equals(ci.getColor()))) {
        item.setCount(item.getCount() + ci.getCount());
        return;
      }
    }
    this.items.add(ci);
  }

  public double getTotalMemberPrice() {
    double d = 0.0D;
    for (Iterator it = this.items.iterator(); it.hasNext(); ) {
      CartItem current = (CartItem)it.next();
      d += current.getProduct().getMemberPrice() * current.getCount();
    }
    return d;
  }
  public double getTotalNormalPrice() {
    double d = 0.0D;
    for (Iterator it = this.items.iterator(); it.hasNext(); ) {
      CartItem current = (CartItem)it.next();
      d += current.getProduct().getNormalPrice() * current.getCount();
    }
    return d;
  }

  public void deleteItemById(int productId) {
    for (Iterator iter = this.items.iterator(); iter.hasNext(); ) {
      CartItem item = (CartItem)iter.next();
      if (item.getProduct().getId() == productId)
        iter.remove();
    }
  }

  public void deleteItemByIdSizeColor(int productId, String size, String color)
  {
    for (Iterator iter = this.items.iterator(); iter.hasNext(); ) {
      CartItem item = (CartItem)iter.next();
      if ((item.getProduct().getId() == productId) && (item.getSize().equals(size)) && (item.getColor().equals(color)))
        iter.remove();
    }
  }

  public void itemCheck()
  {
    for (Iterator iter = this.items.iterator(); iter.hasNext(); ) {
      CartItem item = (CartItem)iter.next();
      if (item.getCount() == 0)
        iter.remove();
    }
  }
  
  public int inventoryAmountCheck()
  {
	  int flag = 0; 
		for(int i=0; i<this.getItems().size(); i++) {
			CartItem ci = (CartItem)this.getItems().get(i);
			if(ci.getCount()> inventoryRecord.getAmountByPidSizeColor(ci.getProduct().getId(),ci.getSize(),ci.getColor())){
				flag--; 
				return flag;				
			}				
		}
	  return flag;
  }
  
  public void getInsufficientInventoryRecords(List irs){
	  for(int i=0; i<this.getItems().size(); i++) {
			CartItem ci = (CartItem)this.getItems().get(i);
			if(ci.getCount()> inventoryRecord.getAmountByPidSizeColor(ci.getProduct().getId(),ci.getSize(),ci.getColor())){
				irs.add(inventoryRecord.getInventoryRecordByPidSizeColor(ci.getProduct().getId(), ci.getSize(), ci.getColor())); 
			}				
		}
	  
  }
  
  /*
   productids : type of List<Ingeter>
  */
  public double getDiscountAmountByCouponCodeoff(List productids, double off){
	  double discountAmount = 0;
	  for(int i = 0; i < this.getItems().size(); i++){
		  CartItem ci = (CartItem)this.getItems().get(i);
		  Product p = ci.getProduct();
		  int count = ci.getCount();
		  for (Iterator iter = productids.iterator(); iter.hasNext(); ) {
			  Integer pid = (Integer)iter.next();
			  if(p.getId() == pid.intValue()){
				  double unitDiscontAmount = (off < 1) ? p.getNormalPrice() * off * count : off * count;
				  discountAmount = discountAmount + unitDiscontAmount;
				  break;
			  }
		  }  
	  }
	  return discountAmount;
  }
  
  public static void main(String[] args) {
	  Cart c = new Cart();
	  CartItem ci = new CartItem();
	  Product p = new Product();
	  p.setId(130); 
	  p.setNormalPrice(105);
	  
	  
	  ci.setProduct(p);
	  ci.setCount(1); 
	  
	  CartItem ci1 = new CartItem();
	  Product p1 = new Product();
	  p1.setId(120); 
	  p1.setNormalPrice(99.95);
	  
	  
	  ci1.setProduct(p1);
	  ci1.setCount(1);
	  
	  
	  c.getItems().add(ci);
	  //c.getItems().add(ci1);
	  
	  List pids = new ArrayList();
	  pids.add(new Integer(130));
	  //pids.add(new Integer(121));
	  System.out.println(c.getDiscountAmountByCouponCodeoff(pids, 0.35));
	  
  }
 
}