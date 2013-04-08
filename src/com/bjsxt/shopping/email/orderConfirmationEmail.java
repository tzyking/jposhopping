package com.bjsxt.shopping.email;

import com.bjsxt.shopping.order.OrderMgr;
import com.bjsxt.shopping.order.SalesItem;
import com.bjsxt.shopping.order.SalesOrder;
import com.bjsxt.shopping.order.paymentRecord;
import com.bjsxt.shopping.product.Product;
import com.bjsxt.shopping.util.DecimalFormatDouble;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Iterator;
import java.util.List;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

public class orderConfirmationEmail
{
  private int orderId;
  
  private double tax;

  public int getOrderId()
  {
    return this.orderId;
  }

  public void setOrderId(int orderId) {
    this.orderId = orderId;
  }

  public double getTax() {
	return tax;
}

public void setTax(double tax) {
	this.tax = tax;
}

public int send(String reciverEmail, String reciverName) throws MalformedURLException {
    try {
      HtmlEmail email = new HtmlEmail();
      email.setHostName("smtp.gmail.com");
      email.setSmtpPort(587);
      email.setAuthenticator(new DefaultAuthenticator("johnpatrickorganic.shopping@gmail.com", "Aniu@1020"));
      email.addTo(reciverEmail, reciverName);
      email.setFrom("johnpatrickorganic.shopping@gmail.com", "John Patrick Organic");
      email.setSubject("your order(order Number:" + this.orderId + ") has been placed");
      email.setDebug(true);
      email.setTLS(true);

      URL url = new URL("http://organicbyjohnpatrick.com:8080/pic/logo.jpg");
      String cid = email.embed(url, "jpo logo");

      int id = this.orderId;
      double subtotal = 0.0D;
      SalesOrder so = OrderMgr.getInstance().loadById(id);
      List sitms = OrderMgr.getInstance().getSalesItems(so);
      paymentRecord pr = paymentRecord.loadByorderId(id);

      for (Iterator it = sitms.iterator(); it.hasNext(); ) {
        SalesItem si = (SalesItem)it.next();
        subtotal += si.getUnitPrice() * si.getCount();
      }
      pr.setTax(this.tax);
      double promotion = (subtotal + this.tax) - pr.getAmount();
      String displayPromotion = "";
      if(promotion > 0)
    	  displayPromotion = "<tr><td></td><td></td><td></td><td></td><td colspan=\"2\" style=\"border-top: 1px solid #000000; padding-right: 27px; text-align: right;\">PROMOTION: -$"+DecimalFormatDouble.customFormat("0.00", promotion) + "</td></tr>";

      String htmlBodyContent = "<html style=\"border: 0;\"><body style=\"margin: 0px; padding: 10px 50px 0px 50px; background-color: #ffffff; color: #333; font-family: Helvetica, Verdana, sans-serif; font-size: 14px; line-height: 20px;\"><img src=\"cid:" + 
        cid + "\"><br> " + 
        " <div class=\"itemdetail\" style=\"position: relative; margin-bottom: 5px; margin-top: 0; border: 10px solid #fff;\">" + 
        "<table cellspacing=\"0\" style=\"font-weight: normal; font-size: 11px; color: #404040; width: 900px; background-color: #fafafa; border: 1px #000000 solid; border-collapse: collapse; border-spacing: 0px;\">" + 
        "<tbody><tr><td colspan=\"6\">ITEMS IN THIS ORDER</td></tr>" + 
        "<tr>" + 
        "<td class=\"Hed\" style=\"border-bottom: 2px solid #333333; border-left: 1px solid #333333; background-color: #333333; text-align: center; text-indent: 5px; font-weight: bold; font-size: 11px; color: #FFFFFF;\">DESCRIPTION</td>" + 
        "<td class=\"Hed\" style=\"border-bottom: 2px solid #333333; border-left: 1px solid #333333; background-color: #333333; text-align: center; text-indent: 5px; font-weight: bold; font-size: 11px; color: #FFFFFF;\">COLOR</td>" + 
        "<td class=\"Hed\" style=\"border-bottom: 2px solid #333333; border-left: 1px solid #333333; background-color: #333333; text-align: center; text-indent: 5px; font-weight: bold; font-size: 11px; color: #FFFFFF;\">SIZE</td>" + 
        "<td class=\"Hed\" style=\"border-bottom: 2px solid #333333; border-left: 1px solid #333333; background-color: #333333; text-align: center; text-indent: 5px; font-weight: bold; font-size: 11px; color: #FFFFFF;\">UNIT PRICE</td>" + 
        "<td class=\"Hed\" style=\"border-bottom: 2px solid #333333; border-left: 1px solid #333333; background-color: #333333; text-align: center; text-indent: 5px; font-weight: bold; font-size: 11px; color: #FFFFFF;\">QUANTITY</td>" + 
        "<td class=\"Hed\" style=\"border-bottom: 2px solid #333333; border-left: 1px solid #333333; background-color: #333333; text-align: center; text-indent: 5px; font-weight: bold; font-size: 11px; color: #FFFFFF;\">SUBTOTAL</td>" + 
        "</tr>";

      for (Iterator it = sitms.iterator(); it.hasNext(); ) {
        SalesItem si = (SalesItem)it.next();
        htmlBodyContent = htmlBodyContent + 
          "<tr><td class=\"bodyTxtLeft\" style=\"border-bottom: 0px; border-top:1px solid #000000; width: 400px; border-left: 0px; border-right: 0px; text-align: left; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
          si.getProduct().getName() + "<br/>" + si.getProduct().getDescr() + "</td>" + 
          "<td class=\"bodyTxtCenter\" style=\"border-bottom: 0px; border-top: 1px solid #000000; border-left: 0px; border-right: 0px; text-align: center; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
          si.getColor() + "</td>" + 
          "<td class=\"bodyTxtCenter\" style=\"border-bottom: 0px; border-top: 1px solid #000000; border-left: 0px; border-right: 0px; text-align: center; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
          si.getSize() + "</td>" + 
          "<td class=\"bodyTxtCenter\" style=\"border-bottom: 0px; border-top: 1px solid #000000; border-left: 0px; border-right: 0px; text-align: center; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">$ " + 
          DecimalFormatDouble.customFormat("0.00", si.getProduct().getNormalPrice()) + "</td>" + 
          "<td class=\"bodyTxtCenter\" style=\"border-bottom: 0px; border-top: 1px solid #000000; border-left: 0px; border-right: 0px; text-align: center; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
          si.getCount() + "</td>" + 
          "<td class=\"bodyTxtCenter\" style=\"border-bottom: 0px; border-top: 1px solid #000000; border-left: 0px; border-right: 0px; text-align: center; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">$ " + 
          DecimalFormatDouble.customFormat("0.00", si.getProduct().getNormalPrice() * si.getCount()) + "</td></tr>";
      }
      htmlBodyContent = htmlBodyContent + 
        "<tr>" + 
        "<td colspan=\"6\" class=\"merchandiseTotal\" style=\"border-top: 1px solid #000000; padding-right: 27px; text-align: right;\">MERCHANDISE TOTAL: $ " + 
        DecimalFormatDouble.customFormat("0.00", subtotal) + "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td colspan=\"6\" class=\"tax\" style=\"border-bottom: 0px; border-top: 0px; border-left: 0px; border-right: 0px; padding-right: 27px; text-align: right;\">TAX: $ " + 
        DecimalFormatDouble.customFormat("0.00", pr.getTax()) + 
        "</tr>" + 
        "<tr>" + 
        "<td colspan=\"6\" class=\"tax\" style=\"border-bottom: 0px; border-top: 0px; border-left: 0px; border-right: 0px; padding-right: 27px; text-align: right;\">Shipping: $ 00.00</td>" + 
        "</tr>" +
        displayPromotion + 
        "<tr>" + 
        "<td></td><td></td><td></td><td></td><td class=\"total\" colspan=\"2\" style=\"border-top: 1px solid #000000; padding-right: 27px; text-align: right;\">TOTAL: $ " + 
        DecimalFormatDouble.customFormat("0.00", pr.getAmount()) + 
        "</tr>" + 
        "</tbody></table>" + 
        "<br>" + 
        "<table class=\"shippingInfo\" cellspacing=\"0\" style=\"font-weight: normal; font-size: 11px; color: #404040; width: 900px; background-color: #fafafa; border: 1px #000000 solid; border-collapse: collapse; border-spacing: 0px;\">" + 
        "<tbody>" + 
        "<tr>" + 
        "<td class=\"HedTxtLeft\" style=\"border-bottom: 2px solid #333333; border-left: 1px solid #333333; background-color: #333333; text-align: left; text-indent: 5px; font-weight: bold; font-size: 11px; color: #FFFFFF;\">SHIPPING INFORMATION</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td class=\"bodyTxtLeft\" style=\"border-bottom: 0px; border-top: opx; border-left: 0px; border-right: 0px; text-align: left; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
        so.getSfirstName() + " " + so.getSlastName() + "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td class=\"bodyTxtLeft\" style=\"border-bottom: 0px; border-top: opx; border-left: 0px; border-right: 0px; text-align: left; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
        so.getSaddress1() + "</td>" + 
        "</tr>";

      if (so.getSaddress2() != null) {
        htmlBodyContent = htmlBodyContent + "<tr>" + 
          "<td class=\"bodyTxtLeft\" style=\"border-bottom: 0px; border-top: opx; border-left: 0px; border-right: 0px; text-align: left; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
          so.getSaddress2() + "</td>" + 
          "</tr>";
      }

      htmlBodyContent = htmlBodyContent + "<tr>" + 
        "<td class=\"bodyTxtLeft\" style=\"border-bottom: 0px; border-top: opx; border-left: 0px; border-right: 0px; text-align: left; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
        so.getScity() + ", " + so.getSstate() + " " + so.getSzip() + " " + so.getScountry() + "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td class=\"bodyTxtLeft\" style=\"border-bottom: 0px; border-top: opx; border-left: 0px; border-right: 0px; text-align: left; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">Phone: " + 
        so.getSphone() + "</td>" + 
        "</tr>" + 
        "</tbody></table>" + 
        "<br>" + 
        "<table class=\"billingInfo\" cellspacing=\"0\" style=\"font-weight: normal; font-size: 11px; color: #404040; width: 900px; background-color: #fafafa; border: 1px #000000 solid; border-collapse: collapse; border-spacing: 0px;\">" + 
        "<tbody>" + 
        "<tr>" + 
        "<td colspan=\"2\" class=\"HedTxtLeft\" style=\"border-bottom: 2px solid #333333; border-left: 1px solid #333333; background-color: #333333; text-align: left; text-indent: 5px; font-weight: bold; font-size: 11px; color: #FFFFFF;\">BILLING INFORMATION</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td colspan=\"2\" class=\"bodyTxtLeft\" style=\"border-bottom: 0px; border-top: opx; border-left: 0px; border-right: 0px; text-align: left; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
        pr.getBfirstName() + " " + pr.getBlastName() + "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td colspan=\"2\" class=\"bodyTxtLeft\" style=\"border-bottom: 0px; border-top: opx; border-left: 0px; border-right: 0px; text-align: left; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
        pr.getBaddress1() + "</td>" + 
        "</tr>";

      if (pr.getBaddress2() != null) {
        htmlBodyContent = htmlBodyContent + "<tr>" + 
          "<td colspan=\"2\" class=\"bodyTxtLeft\" style=\"border-bottom: 0px; border-top: opx; border-left: 0px; border-right: 0px; text-align: left; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
          pr.getBaddress2() + "</td> " + 
          "</tr>";
      }

      htmlBodyContent = htmlBodyContent + "<tr>" + 
        "<td colspan=\"2\" class=\"bodyTxtLeft\" style=\"border-bottom: 0px; border-top: opx; border-left: 0px; border-right: 0px; text-align: left; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">" + 
        pr.getBcity() + ", " + pr.getBstate() + " " + pr.getBzip() + " " + pr.getBcountry() + "</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td colspan=\"2\" class=\"bodyTxtLeft\" style=\"border-bottom: 0px; border-top: opx; border-left: 0px; border-right: 0px; text-align: left; font-weight: normal; font-size: 11px; color: #404040; background-color: #fafafa;\">Phone: " + 
        pr.getBphone() + "</td>" + 
        "</tr>" + 
        "</tbody></table>" + 
        "<table class=\"contactInfo\" cellspacing=\"0\" style=\"text-align: right; font-weight: bold; font-size: 11px; color: #404040; width: 900px; background-color: #fafafa; border: 0px; border-collapse: collapse; border-spacing: 0px;\">" + 
        "<tbody><tr>" + 
        "<td>ORGANIC by John Patrick</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td>HRH Clothier Corporation</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td>5 Sherman Street</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td>Albany, New York 12210</td>" + 
        "</tr>" + 
        "<tr>" + 
        "<td>Customer Service: jessica.organic@gmail.com</td>" + 
        "</tr>" + 
        "</tbody></table></div></body></html>";

      email.setHtmlMsg(htmlBodyContent);
      email.setTextMsg("Your email client does not support HTML messages");

      email.send();
      return 0; } catch (EmailException e1) {
    }
    return 1;
  }

  public String getHtmlContent(int orderId)
  {
    double subtotal = 0.00;
    SalesOrder so = OrderMgr.getInstance().loadById(orderId);
    List sitms = OrderMgr.getInstance().getSalesItems(so);
    paymentRecord pr = paymentRecord.loadByorderId(orderId);

    for (Iterator it = sitms.iterator(); it.hasNext(); ) {
      SalesItem si = (SalesItem)it.next();
      subtotal += si.getUnitPrice() * si.getCount();
    }
    pr.setTax(pr.getAmount() - subtotal);

    return "";
  }
}