package com.bjsxt.shopping.tag;

import java.io.IOException;
import javax.servlet.jsp.JspContext;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class HelloWorldTag extends SimpleTagSupport
{
  public void doTag()
    throws JspException, IOException
  {
    getJspContext().getOut().write("HelloWorld From Tag");
  }
}