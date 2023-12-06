<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
</head>
<body style="background-color:rgb(41, 41, 41);"></body>
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
		.navbar a:hover {
            background-color: rgb(255, 153, 51);
        }
		</style>
		<div class="navbar">
			<a href=index.jsp>Home</a>
			<a href=account.jsp>Account</a>
			<div class = "logout">
				<a href=listprod.jsp>Back To Shop</a>
				<%
				@SuppressWarnings({"unchecked"})
				HashMap<String, ArrayList<Object>> x = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

				if (x == null)
				{	out.println("<H1>Your shopping cart is empty!</H1>");
				out.println("</div>");
				}
				else if (x.size() == 0){
				out.println("</div>");
				}
				else out.print("<a href=checkout.jsp>Check Out</a></div>");
				%>
		</div>
		
<style>.box {
    float: none;
    overflow: auto;
    border: 2px solid #000000;
    padding: 8px 12px;
    padding-bottom: 40px;
    background-color: rgb(158,158,158);
  } 
  .button{
          font-size: 16px;
          color: white;
          text-align: center;
          padding: 14px 16px;
          text-decoration: none;
  } tr{
    border: 2px solid black;
  }
  table {
    margin-left: 20px;
  border-collapse:collapse;
  color: rgb(0, 0, 0);
  background-color: rgb(255, 153, 51);
}
td{
    padding-left: 75px;
    padding-right: 75px;
	padding-top: 20px;
	padding-bottom: 20px;
}</style>

<div class="box">
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
if (productList.size() == 0){
	out.println("<H1>Your shopping cart is empty!</H1>");
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		String productName = (String)product.get(1);
		String productId = (String)product.get(0);
		out.print("<tr><td>"+productId+"</td>");
		out.print("<td>"+productName+"</td>");

		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}
		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
		out.print("<td><h2><a href=addcart.jsp?id="+productId+"&name="+productName+"&price="+pr+"&quantity=-1> - </a></h2></td>");
		out.print("<td><h2><a href=addcart.jsp?id="+productId+"&name="+productName+"&price="+pr+"&quantity=1> + </a></h2></td>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	//out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
%>
<div>
</body>
</html> 

