<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body style="background-color:rgb(41, 41, 41);">
    <style>
        body {font-family: Arial, Helvetica, sans-serif;}
        .navbar {
          overflow: hidden;
          background-color: rgb(41, 41, 41);
          margin-bottom: 5px;
          border: 2px solid #000000;
        }
        
        .navbar a {
          float: left;
          font-size: 16px;
          color: white;
          text-align: center;
          padding: 14px 16px;
          text-decoration: none;
        }
        
        .navbar .logout {
          float: right;
        }
		.navbar .logout button {
        float: right;
        padding: 6px 10px;
        margin-top: 8px;
        margin-right: 16px;
        background: #ddd;
        font-size: 17px;
        border: none;
        cursor: pointer;
}
.navbar a:hover{
    background-color: rgb(255, 153, 51);
}
</style>
<div class="navbar">
    <a href=index.jsp>Home</a>
    <a href=listprod.jsp>Begin Shopping</a>
    <a href=showcart.jsp>Cart</a>
    <a href=admin.jsp>Administrators</a>
    <div class = "logout">
    <a href=logout.jsp>Log out</a></div>

    <style>.header {
        background-color: rgb(255, 153, 51);
        padding: 5px;
        border: 2px solid #000000;
        margin-bottom: 5px;
        margin-top: 5px;
      }
      .box {
			float: none;
			border: 2px solid #000000;
			background-color: rgb(158,158,158);
			padding-left: 20px;
			padding-top: 20px;
			padding-bottom: 20px;
		  }
          tr{
    border: 2px solid black;
  }
  table {
    margin-left: 20px;
  background-color: white;
}
td{
    border: 2px solid black;
}
th{
    border: 2px solid black;
}</style>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
if(userName != null){
	try ( Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();){
// TODO: Print Customer information
String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer WHERE userid = '"+userName+"'";
ResultSet rst = stmt.executeQuery(sql);
rst.next();
out.println("<a href=listorder.jsp?id="+rst.getString(1)+">My Orders</a></div>");
out.println("<div class = header><h2>Your Profile</h2></div>");
out.print("<div class = box>");
out.println("<table>"
	+" <tr><th>Id</th><td>"+rst.getString(1)+"</td></tr>"
	+" <tr><th>First Name</th><td>"+rst.getString(2)+"</td></tr>"
	+" <tr><th>Last Name</th><td>"+rst.getString(3)+"</td></tr>"
	+" <tr><th>Email</th><td>"+rst.getString(4)+"</td></tr>"
	+" <tr><th>Phone</th><td>"+rst.getString(5)+"</td></tr>"
	+" <tr><th>Address</th><td>"+rst.getString(6)+"</td></tr>"
	+" <tr><th>City</th><td>"+rst.getString(7)+"</td></tr>"
	+" <tr><th>State</th><td>"+rst.getString(8)+"</td></tr>"
	+" <tr><th>Postal Code</th><td>"+rst.getString(9)+"</td></tr>"
	+" <tr><th>Country</th><td>"+rst.getString(10)+"</td></tr>"
	+" <tr><th>User id</th><td>"+rst.getString(11)+"</td></tr></table></div>");
// Make sure to close connection
con.close();
}
catch (SQLException ex)
{
out.println(ex);
}
}
%>
</body>
</html>

