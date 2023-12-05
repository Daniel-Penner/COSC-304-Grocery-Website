<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>Daniel's Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for

String name = request.getParameter("productName");
        
//Note: Forces loading of SQL Server driver
try
{    // Load driver class
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
    out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";        
    String uid = "sa";
    String pw = "304#sa#pw";
    try ( Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();) 
        {
            DecimalFormat format = new DecimalFormat("$#0.00");
            String sql;
            if(name != null){
            sql = "SELECT productId, productName, productPrice FROM Product WHERE productName LIKE '%'+?+'%'";
            }
            else sql =     "SELECT productId, productName, productPrice FROM Product";
            PreparedStatement pstmt = con.prepareStatement(sql);
            if(name != null){
            pstmt.setString(1, name);
            }
            ResultSet rst = pstmt.executeQuery();
            out.println("<h2>All Products</h2>");
            out.println("<table><tr><th align=center>Product Name</th><th>Price</th></tr>");
// Print out the ResultSet
while (rst.next()){
    int productId = rst.getInt(1);
    String productName = rst.getString(2);
    String productName2 = productName.replaceAll(" ", "&nbsp;");
    double productPrice = rst.getDouble(3);
    out.println("<tr><td><a href = product.jsp?id="+productId+"&name="+productName2+"&price="+productPrice+">Add to Cart</a></td><td>"+productName+"</td><td>"+format.format(productPrice)+"</td></tr>");
// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
}
// Close connection
con.close();
    }
catch (SQLException ex)
{
    out.println(ex);
}
// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);    // Prints $5.00
%>

</body>
</html>