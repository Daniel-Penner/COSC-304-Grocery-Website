<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>D and K Real Estate</title>
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
.header {
        background-color: rgb(255, 153, 51);
        padding: 5px;
        border: 2px solid #000000;
        margin-bottom: 5px;
        margin-top: 5px;
      }      .box {
			float: none;
			border: 2px solid #000000;
			background-color: rgb(158,158,158);
			padding-top: 20px;
			padding-bottom: 20px;
            padding-right: 20px;
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
<div class="navbar">
    <a href=index.jsp>Home</a>
    <a href=listprod.jsp>Begin Shopping</a>
    <a href=showcart.jsp>Cart</a>
    <a href=admin.jsp>Administrators</a>
    <div class = "logout">
		<a href=account.jsp>Account</a>
    <a href=logout.jsp>Log out</a></div>
	</div>
	<div class = header>
<h1>Order List</h1>
	</div>
<div class = box>
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
			String userid = request.getParameter("id");
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
	String id = rst.getString(1);
	if(id.equals(userid)){
	// Print out the order summary information
	double amount = rst.getDouble(6); 
	out.println("<tr><td>"+id+"</td><td>"+rst.getString(2)+"</td><td>"+rst.getInt(3)+"</td><td>"+rst.getString(4) + " " + rst.getString(5)+"</td><td>"+format.format(amount)+"</td><tr><td colspan=4>");
	
	out.println("<table border = 1 align=right><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");

	pstmt.setString(1, id);
	ResultSet rst2 = pstmt.executeQuery();

	// For each product in the order
	while (rst2.next()){
		// Write out product information 
		out.println("<tr><td>"+rst2.getInt(1)+"</td><td>"+rst2.getInt(2)+"</td><td>"+format.format(rst2.getDouble(3))+"</td></tr>");
	}
	out.println("</table> </td> </tr>");
		}
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
</div>
</body>
</html>

