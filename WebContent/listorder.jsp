<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Daniel's Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0));  // Prints $5.00

// Make connection
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
	String uid = "sa";
	String pw = "304#sa#pw";
	try ( Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();) 
		{
// Write query to retrieve all order summary records
			String sql = "SELECT orderId, orderDate, OS.customerId, firstName, lastname, totalAmount FROM ordersummary OS JOIN customer C ON OS.customerId = C.customerId";
			ResultSet rst = stmt.executeQuery(sql);
			
			out.println("<table border>"
			+" <tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Name</th><th>Total Amount</th></tr>");

			// Write a query to retrieve the products in the order
			String sql2 = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";
		
			//   - Use a PreparedStatement as will repeat this query many times
			PreparedStatement pstmt = con.prepareStatement(sql2);

			DecimalFormat format = new DecimalFormat("$#0.00");

// For each order in the ResultSet

while (rst.next()){
	int id = rst.getInt(1);

	// Print out the order summary information
	double amount = rst.getDouble(6); 
	out.println("<tr><td>"+id+"</td><td>"+rst.getString(2)+"</td><td>"+rst.getInt(3)+"</td><td>"+rst.getString(4) + " " + rst.getString(5)+"</td><td>"+format.format(amount)+"</td><tr><td colspan=4>");
	
	out.println("<table border = 1 align=right><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");

	pstmt.setInt(1, id);
	ResultSet rst2 = pstmt.executeQuery();

	// For each product in the order
	while (rst2.next()){
		// Write out product information 
		out.println("<tr><td>"+rst2.getInt(1)+"</td><td>"+rst2.getInt(2)+"</td><td>"+format.format(rst2.getDouble(3))+"</td></tr>");
	}
	out.println("</table> </td> </tr>");
		}
		out.println("</table>");
// Close connection
con.close();
	}
catch (SQLException ex)
{
	out.println(ex);
}
%>

</body>
</html>

