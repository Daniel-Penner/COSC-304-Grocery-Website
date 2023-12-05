<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

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
out.println("<h2>Customer Profile</h2>");
out.println("<table border>"
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
	+" <tr><th>User id</th><td>"+rst.getString(11)+"</td></tr></table>");

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

