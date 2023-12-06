<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>D and K Real Estate</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color:rgb(41, 41, 41);">
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
            <a href=account.jsp>Account</a>
			<a href=showcart.jsp>Cart</a>
			<div class = "logout">
			<a href=listprod.jsp>Continue Shopping</a></div>
			</div>

            
		<style>.header {
			background-color: rgb(255, 153, 51);
			padding: 5px;
			border: 2px solid #000000;
			margin-bottom: 5px;
			margin-top: 5px;
		  }.box {
			float: none;
			border: 2px solid #000000;
			background-color: rgb(158,158,158);
			padding-left: 80px;
			padding-top: 50px;
			padding-bottom: 50px;
		  }</style>
		<div class="header">

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");

String sql = "SELECT productName, productPrice, productImageURL, productImage, productDesc FROM product WHERE productId = ?";
PreparedStatement p; ResultSet r = null;
String name = "", quantity = "1", imgUrl = "", imgBin = "", productDesc = "";
double price = 0;
try (Connection con = DriverManager.getConnection(url, uid, pw);) 
{
    p = con.prepareStatement(sql);
    p.setString(1, productId);
    r = p.executeQuery(); r.next();
    productDesc = r.getString("productDesc");
    name = r.getString("productName"); price = r.getDouble("productPrice");
    imgUrl = r.getString("productImageURL"); imgBin = r.getString("productImage");
    out.println("<h1 align=\"center\">"+name+"</h1></div>");
}
catch (SQLException sqle)
{ out.println(sqle.getLocalizedMessage()); }

// TODO: If there is a productImageURL, display using IMG tag   
boolean useImgUrl = true;
out.println("<div class=box>");
try { imgUrl += ""; } 
catch (Exception e) { useImgUrl = false; }
if (useImgUrl && !imgUrl.equals("null"))
{
    out.println("<img src =\"" + imgUrl + "\">");
}

// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
/*boolean useImgBin = true;
try { imgBin += ""; }
catch (Exception e) { useImgUrl = false; }
if (useImgUrl && !imgBin.equals("null"))
{
    out.println("<t><img src = \"displayImage.jsp?id="+productId+"\">");
}*/
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
out.print("<table><tr><th>Description:</th><td>"+productDesc+"</td></tr><tr><th>Price:</th><td>"+currFormat.format(price)+"</td></tr></table>");
// TODO: Add links to Add to Cart and Continue Shopping
name = name.replaceAll(" ", "&nbsp;");
out.println("<b><h3><a href = addcart.jsp?id="+productId+"&name="+name+"&price="+price+"&quantity="+quantity+">Add to Cart</a></h3>"); 
%>
</div>
</body>
</html>