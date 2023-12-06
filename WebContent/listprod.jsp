<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
          font-family: Arial, Helvetica, sans-serif;
        }
        
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
        
        .dropdown {
          float: left;
          overflow: hidden;
        }
        
        .dropdown .dropbtn {
          font-size: 16px;  
          border: none;
          outline: none;
          color: white;
          padding: 14px 16px;
          background-color: inherit;
          font-family: inherit;
          margin: 0;
        }

        .navbar .search-container {
  float: right;
}

.navbar input[type=text] {
  padding: 6px;
  margin-top: 8px;
  font-size: 17px;
  border: none;
}
.navbar .search-container button {
        float: right;
        padding: 6px 10px;
        margin-top: 8px;
        margin-right: 16px;
        background: #ddd;
        font-size: 17px;
        border: none;
        cursor: pointer;
}
        
        .navbar a:hover, .dropdown:hover, .search-container button:hover .dropbtn {
            background-color: rgb(255, 153, 51);
        }

@media screen and (max-width: 600px){
  .navbar .search-container {
    float: none;
  }
  .navbar a, .navbar input[type=text], .navbar .search-container button {
    float: none;
    display: block;
    text-align: left;
    width: 100%;
    margin: 0;
    padding: 14px;
  }
  .topnav input[type=text] {
    border: 1px solid #ccc;  
  }

.navbar .search-container button:hover {
  background: rgb(255, 153, 51);
}
}
        
        .dropdown-content {
          display: none;
          position: absolute;
          background-color: #f9f9f9;
          min-width: 160px;
          box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
          z-index: 1;
        }
        
        .dropdown-content a {
          float: none;
          color: black;
          padding: 12px 16px;
          text-decoration: none;
          display: block;
          text-align: left;
        }
        
        .dropdown-content a:hover {
          background-color: rgb(255, 153, 51);
        }
        
        .dropdown:hover .dropdown-content {
          display: block;
        }
        </style>
        </head>
        <body style="background-color:rgb(41, 41, 41);">
        
        <div class="navbar">
          <a href=index.jsp>Home</a>
          <a href=account.jsp>Account</a>
          <a href=showcart.jsp>Cart</a>
          <div class="dropdown">
            <button class="dropbtn">Category 
              <i class="fa fa-caret-down"></i>
            </button>
            <div class="dropdown-content">
              <a href=listprod.jsp?categoryId=1>Shacks</a>
              <a href=listprod.jsp?categoryId=2>Beach Bungalows</a>
              <a href=listprod.jsp?categoryId=3>Condos</a>
              <a href=listprod.jsp?categoryId=4>Suburban Homes</a>
              <a href=listprod.jsp?categoryId=5>Forest Lodges</a>
              <a href=listprod.jsp?categoryId=6>Mansions</a>
            </div>
          </div> 
          <div class="search-container">
            <form action="listprod.jsp">
              <input type="text" placeholder="Search.." name="productName">
              <button type="submit"><i class="fa fa-search"></i></button>
            </form>
          </div>
        </div>
    

<head>
<title>D and K Real Estate</title>
</head>
<body>
<style>.header {
    background-color: rgb(255, 153, 51);
    padding: 5px;
    border: 2px solid #000000;
    margin-bottom: 5px;
    margin-top: 5px;
  }</style>
<div class="header">
<h1>Search by name or by category for products:</h1>
</div>
<style>
.box {
    float: none;
    overflow: auto;
    border: 2px solid #000000;
    padding: 8px 12px;
    padding-bottom: 40px;
    background-color: rgb(158,158,158);
  }
  tr{
    border: 2px solid black;
  }
  table {
    margin-left: 20px;
  border-collapse:collapse;
  color: rgb(0, 0, 0);
  background-color: rgb(255, 153, 51);
}
td{
    padding-left: 140px;
    padding-right: 140px;
}
 </style> 
 <div class="box">
<% // Get product name to search for

String name = request.getParameter("productName");
String category = request.getParameter("categoryId");
        
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
            format.setGroupingUsed(true);
            format.setGroupingSize(3);
            String sql;
            if(name != null && category != null){
            sql = "SELECT productId, productName, productPrice, productImageURL FROM product WHERE productName LIKE '%'+?+'%' AND categoryId = ? ORDER BY productPrice";
            }
            if(name != null){
                sql = "SELECT productId, productName, productPrice, productImageURL FROM product WHERE productName LIKE '%'+?+'%' ORDER BY productPrice";
            }
            else if(category != null){
                sql = "SELECT productId, productName, productPrice, productImageURL FROM product WHERE categoryId = ? ORDER BY productPrice";
                }
            else sql = "SELECT productId, productName, productPrice, productImageURL FROM product ORDER BY productPrice";
            PreparedStatement pstmt = con.prepareStatement(sql);
            if(name != null && category != null){
            pstmt.setString(1, name); pstmt.setString(2, category);
            }
            else if(name != null){
                pstmt.setString(1, name);
            }
            else if(category != null){
            pstmt.setString(1, category);
            }

            ResultSet rst = pstmt.executeQuery();
            out.println("<h2>All Products</h2><table>");
           // out.println("<table><tr><th align=center>Product Name</th><th>Price</th></tr>");
// Print out the ResultSet
while (rst.next()){
    int productId = rst.getInt(1);
    String productName = rst.getString(2);
    String productName2 = productName.replaceAll(" ", "&nbsp;");
    double productPrice = rst.getDouble(3);
    String producturl = rst.getString(4);
    out.print("<tr><td><h2><a href = product.jsp?id="+productId+"&name="+productName2+"&price="+productPrice+"></h2>Add to Cart</a></td><td><h3>"+productName+"</h3></td><td><h3>"+format.format(productPrice)+"</h3></td>");
    out.println("<td><img src="+producturl+" width=200></td></tr>");
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
</div>

</body>
</html>