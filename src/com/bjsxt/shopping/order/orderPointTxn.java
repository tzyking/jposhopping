package com.bjsxt.shopping.order;

import java.io.PrintStream;
import lp.txn.JLinkPointTransaction;

public class orderPointTxn
{
  protected String clientCertPath = "";
  protected String password = "";
  protected String host = "";
  protected String configfile = "";
  protected int port = 0;

  protected String R_Time = "";
  protected String R_Ref = "";
  protected String R_Approved = "";
  protected String R_Code = "";
  protected String R_Authresr = "";
  protected String R_Error = "";
  protected String R_OrderNum = "";
  protected String R_Message = "";
  protected String R_Score = "";
  protected String R_TDate = "";
  protected String R_AVS = "";
  protected String R_FraudCode = "";
  protected String R_ESD = "";
  protected String R_Tax = "";
  protected String R_Shipping = "";

  public String response = "";

  public orderPointTxn(String _clientCertPath, String _configfile, String _host, String _password, int _port)
  {
    this.clientCertPath = _clientCertPath;
    this.password = _password;
    this.host = _host;
    this.configfile = _configfile;
    this.port = _port;
  }

  public orderPointTxn()
  {
  }

  public boolean process(String sOrderXML)
  {
    JLinkPointTransaction txn = new JLinkPointTransaction();

    txn.setClientCertificatePath(this.clientCertPath);
    txn.setPassword(this.password);
    txn.setHost(this.host);
    txn.setPort(this.port);

    System.out.println("OUTGOING XML:\n" + sOrderXML);

    String sResponse = "";
    boolean ret = false;
    try {
      sResponse = txn.send(sOrderXML);
    }
    catch (Exception e)
    {
      e.printStackTrace();
      sResponse = "<r_error>" + e.toString() + "</r_error>";
    }

    parseResponse(sResponse);
    printResp();
    this.response = sResponse;
    if (this.R_Approved.equals("APPROVED"))
      ret = true;
    return ret;
  }

  protected void parseResponse(String rsp)
  {
    this.R_Time = parseTag("r_time", rsp);
    this.R_Ref = parseTag("r_ref", rsp);
    this.R_Approved = parseTag("r_approved", rsp);
    this.R_Code = parseTag("r_code", rsp);
    this.R_Authresr = parseTag("r_authresronse", rsp);
    this.R_Error = parseTag("r_error", rsp);
    this.R_OrderNum = parseTag("r_ordernum", rsp);
    this.R_Message = parseTag("r_message", rsp);
    this.R_Score = parseTag("r_score", rsp);
    this.R_TDate = parseTag("r_tdate", rsp);
    this.R_AVS = parseTag("r_avs", rsp);
    this.R_Tax = parseTag("r_tax", rsp);
    this.R_Shipping = parseTag("r_shipping", rsp);
    this.R_FraudCode = parseTag("r_fraudCode", rsp);
    this.R_ESD = parseTag("esd", rsp);
  }

  protected String parseTag(String tag, String rsp)
  {
    StringBuffer sb = new StringBuffer(256);
    sb.append('<' + tag + '>');
    int len = sb.length();
    int idxSt = -1; int idxEnd = -1;
    if (-1 == (idxSt = rsp.indexOf(sb.toString())))
      return "";
    idxSt += len;
    sb.setLength(0);
    sb.append("</" + tag + '>');
    if (-1 == (idxEnd = rsp.indexOf(sb.toString(), idxSt)))
      return "";
    return rsp.substring(idxSt, idxEnd);
  }

  public void printResp()
  {
    System.out.println("\n******  XML RESPONSE  *******");
    if (this.R_Time.length() != 0)
      System.out.println("<r_time>" + this.R_Time + "</r_time>");
    if (this.R_Ref.length() != 0)
      System.out.println("<r_ref>" + this.R_Ref + "</r_ref>");
    if (this.R_Approved.length() != 0)
      System.out.println("<r_approved>" + this.R_Approved + "</r_approved>");
    if (this.R_Code.length() != 0)
      System.out.println("<r_code>" + this.R_Code + "</r_code>");
    if (this.R_OrderNum.length() != 0)
      System.out.println("<r_ordernum>" + this.R_OrderNum + "</r_ordernum>");
    if (this.R_Error.length() != 0)
      System.out.println("<r_error>" + this.R_Error + "</r_error>");
    if (this.R_FraudCode.length() != 0)
      System.out.println("<r_fraudCode>" + this.R_FraudCode + "</r_fraudCode>");
    if (this.R_Authresr.length() != 0)
      System.out.println("<r_authresponse>" + this.R_Authresr + "</r_authresponse>");
    if (this.R_Message.length() != 0)
      System.out.println("<r_message>" + this.R_Message + "</r_message>");
    if (this.R_TDate.length() != 0)
      System.out.println("<r_tdate>" + this.R_TDate + "</r_tdate>");
    if (this.R_Shipping.length() != 0)
      System.out.println("<r_shipping>" + this.R_Shipping + "</r_shipping>");
    if (this.R_Tax.length() != 0)
      System.out.println("<r_tax>" + this.R_Tax + "</r_tax>");
    if (this.R_AVS.length() != 0)
      System.out.println("<r_avs>" + this.R_AVS + "</r_avs>");
    if (this.R_ESD.length() != 0)
      System.out.println("<esd>" + this.R_ESD + "</esd>");
    if (this.R_Score.length() != 0) {
      System.out.println("<r_score>" + this.R_Score + "</r_score>");
    }
    System.out.println("\n****** End Of XML RESPONSE ********");
  }
}