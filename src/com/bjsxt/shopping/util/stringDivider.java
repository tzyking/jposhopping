package com.bjsxt.shopping.util;

import java.util.ArrayList;
import java.util.List;

public class stringDivider
{
  private String content;

  public String getContent()
  {
    return this.content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public List Divide(int numberPerLine) {
    List result = new ArrayList();
    StringBuffer sb = new StringBuffer();
    int count = 0;
    for (int i = 0; i < this.content.length(); i++) {
      if (count == numberPerLine) {
        result.add(sb.toString());
        sb.delete(0, sb.length());
        count = 0;
      }
      if (i == this.content.length() - 1) {
        sb.append(this.content.charAt(i));
        result.add(sb.toString());
        break;
      }

      char item = this.content.charAt(i);
      if (item == ' ')
        count++;
      sb.append(item);
    }

    return result;
  }
}