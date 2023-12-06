<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Kaycee's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");

String sql = "SELECT productName, productPrice, productImageURL, productImage FROM product WHERE productId = ?";
PreparedStatement p; ResultSet r = null;
String name = "", quantity = "1", imgUrl = "", imgBin = "";
double price = 0;
try (Connection con = DriverManager.getConnection(url, uid, pw);) 
{
    p = con.prepareStatement(sql);
    p.setString(1, productId);
    r = p.executeQuery(); r.next();
    name = r.getString("productName"); price = r.getDouble("productPrice");
    imgUrl = r.getString("productImageURL"); imgBin = r.getString("productImage");
    
}
catch (SQLException sqle)
{ out.println(sqle.getLocalizedMessage()); }

// TODO: If there is a productImageURL, display using IMG tag   
boolean useImgUrl = true;

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
out.print("<table><tr><th>Id</th><td>"+name+"</td></tr><tr><th>Price</th><td>"+currFormat.format(price)+"</td></tr></table>");
// TODO: Add links to Add to Cart and Continue Shopping
name = name.replaceAll(" ", "&nbsp");
out.println("<b><h3><a href = addCart.jsp?id="+productId+"&name="+name+"&price="+price+"&quantity="+quantity+">Add to Cart</a></h3>"); 
out.println("<b><h3><a href = listprod.jsp>Continue Shopping</a></h3>");
%>
</body>
</html>