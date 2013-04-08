<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
String action = request.getParameter("action");
String username = request.getParameter("username");
String password = request.getParameter("password");
String error = "";
if(action != null && action.equals("login") ) {
if(username.trim().equals("jpo")&&password.trim().equals("jposhopping"))
  response.sendRedirect("productList.jsp");
else
  error = "username or password invalid, please try again";
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="../js/shadedborder.js"></script>
<script language="javascript" type="text/javascript">
  var holderBorder = RUZEE.ShadedBorder.create({ corner:20, border:2 });
</script>
<link href="../css/adminIndex.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="content">

  <div id="innerholder">
  <b>CMS for OrganicByJohnPatrick</b>
  <br>
		<form action="index.jsp" method="post">
		<input type="hidden" name="action" value="login">
        	<div>
            	<div id="label"><b>User Name :</b></div>
                <div class="roundedfield" >  
                    <input name="username" value="" size="40"/>
                </div>
            </div>
            <div>
                <div id="label"><b>Password :</b></div>
                <div class="roundedfield" > 
                    <input type="password" name="password" value="" size="40" />
                </div>    
            </div>
            <input type="submit" value="Login" id="loginbutton" name="loginbutton"/>
		</form>
		<br/>
		<font size="3" color="red"><%=error %></font>
  </div>
</div>
<script language="javascript" type="text/javascript">  
    holderBorder.render('content');
</script>
</body>
</html>
