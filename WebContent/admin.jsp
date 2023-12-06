<%@page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>
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
		<div class = "logout">
			<a href=account.jsp>Account</a>
		<a href=logout.jsp>Log out</a></div>
		</div>
	
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
				padding-left: 45%;
				padding-top: 20px;
				padding-bottom: 50px;
				padding-right: 45%;
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
		  <div class = header>
		  <h2>Administrator Reports</h2>
		  </div>
		  <div class = box>

<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%// TODO: Include files auth.jsp and jdbc.jsp
%>
<%

// TODO: Write SQL query that prints out total order amount by day
try ( Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();) 
		{
String sql = "SELECT CONCAT(datepart(year, orderDate),'-',datepart(month, orderDate),'-',datepart(day, orderDate)), SUM(totalAmount) FROM ordersummary GROUP BY CONCAT(datepart(year, orderDate),'-',datepart(month, orderDate),'-',datepart(day, orderDate))";
			ResultSet rst = stmt.executeQuery(sql);
			out.println("<h2>Sales By Day</h2>");
			out.println("<table border>"
			+" <tr><th>Order Date</th><th>Total Order Amount</th></tr>");
            
            DecimalFormat format = new DecimalFormat("$#0.00");

            while (rst.next()){
                out.print("<tr><td>"+rst.getString(1)+"</td><td>"+format.format(rst.getDouble(2))+"</td></tr>");
            }
            out.println("</table>");
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

