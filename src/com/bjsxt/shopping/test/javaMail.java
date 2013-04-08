package com.bjsxt.shopping.test;

import com.bjsxt.shopping.email.orderConfirmationEmail;
import java.io.PrintStream;
import java.net.MalformedURLException;
import java.net.URL;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;

public class javaMail
{
  public static void main(String[] args)
    throws Exception
  {
    orderConfirmationEmail oce = new orderConfirmationEmail();
    oce.setOrderId(13);
    int i = oce.send("unicorntzyking@gmail.com", "Du huiyuan");
    if (i == 1)
      System.out.println("send email failure");
	  
	  
  }

  public static void sendText() throws EmailException
  {
    Email email = new SimpleEmail();
    email.setHostName("smtp.gmail.com");
    email.setSmtpPort(587);
    email.setAuthenticator(new DefaultAuthenticator("johnpatrickorganic.shopping@gmail.com", "Aniu@1020"));
    email.setDebug(true);
    email.setTLS(true);
    email.setFrom("johnpatrickorganic.shopping@gmail.com");
    email.setSubject("TestMail");
    email.setMsg("This is a test mail ... :-)");
    email.addTo("unicorntzyking@gmail.com");
    email.send();
  }

  public static void sendHTML()
    throws EmailException, MalformedURLException
  {
    HtmlEmail email = new HtmlEmail();
    email.setHostName("smtp.gmail.com");
    email.setSmtpPort(587);
    email.setAuthenticator(new DefaultAuthenticator("johnpatrickorganic.shopping@gmail.com", "Aniu@1020"));
    email.addTo("unicorntzyking@gmail.com", "jeffrey tong");
    email.setFrom("johnpatrickorganic.shopping@gmail.com", "John Patrick Organic");
    email.setSubject("you order has been placed");
    email.setDebug(true);
    email.setTLS(true);

    URL url = new URL("http://organicbyjohnpatrick.com:8080/pic/logo.jpg");
    String cid = email.embed(url, "jpo logo");

    email.setHtmlMsg("<html><img src=\"cid:" + cid + "\"><br><a href=\"http://organicbyjohnpatrick.com:8080/\"><a href=\"http://organicbyjohnpatrick.com:8080/\">jpo </a></html>");

    email.setTextMsg("Your email client does not support HTML messages");

    email.send();
  }
}