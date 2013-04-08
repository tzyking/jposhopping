package com.bjsxt.shopping.util;

import java.text.DecimalFormat;

public class DecimalFormatDouble
{
  public static String customFormat(String pattern, double value)
  {
    DecimalFormat myFormatter = new DecimalFormat(pattern);
    String output = myFormatter.format(value);
    return output;
  }
}