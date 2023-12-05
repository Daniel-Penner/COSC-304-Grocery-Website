<%@page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>


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
			out.println("<h2>Administrator Sales Report By Day</h2>");
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

</body>
</html>

