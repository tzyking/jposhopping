package com.bjsxt.shopping.order;

import com.bjsxt.shopping.util.DecimalFormatDouble;
import lp.order.LPOrderFactory;
import lp.order.LPOrderPart;

public class orderXML
{
  protected String configfile = "1001249062";

  public String getOrderXML(paymentRecord pr)
  {
    LPOrderPart order = LPOrderFactory.createOrderPart("order");

    LPOrderPart op = LPOrderFactory.createOrderPart();

    op.put("ordertype", "SALE");

    order.addPart("orderoptions", op);

    op.clear();
    op.put("configfile", this.configfile);

    order.addPart("merchantinfo", op);

    op.clear();
    op.put("zip", pr.getBzip());
    op.put("addrnum", getNumberBeforeFirstChar(pr.getBaddress1()));
    op.put("address1", pr.getBaddress1());
    op.put("city", pr.getBcity());
    op.put("state", pr.getBstate());
    op.put("country", pr.getBcountry());

    order.addPart("billing", op);

    op.clear();
    op.put("cardnumber", insertPeriodically(pr.getCnum(), "-", 4));
    op.put("cardexpmonth", pr.getCexpmonth());
    op.put("cardexpyear", pr.getCexpyear());

    order.addPart("creditcard", op);

    op.clear();
    op.put("chargetotal", Double.toString(pr.getAmount()));
    if (Double.toString(pr.getTax()).equals("0.0"))
      op.put("tax", "0");
    else {
      op.put("tax", DecimalFormatDouble.customFormat("0.00", pr.getTax()));
    }
    order.addPart("payment", op);

    return order.toXML();
  }

  public static String insertPeriodically(String text, String insert, int period)
  {
    StringBuilder builder = new StringBuilder(
      text.length() + insert.length() * (text.length() / period) + 1);

    int index = 0;
    String prefix = "";
    while (index < text.length())
    {
      builder.append(prefix);
      prefix = insert;
      builder.append(text.substring(index, 
        Math.min(index + period, text.length())));
      index += period;
    }
    return builder.toString();
  }

  public static String getNumberBeforeFirstChar(String input) {
    int len = input.length();
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < len; i++) {
      if ((input.charAt(i) < '0') || (input.charAt(i) > '9'))
        break;
      sb.append(input.charAt(i));
    }

    return sb.toString().trim();
  }
}