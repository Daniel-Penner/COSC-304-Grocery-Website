<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
    body {font-family: Arial, Helvetica, sans-serif;}
    form {border: 3px solid rgb(41, 41, 41);}
    
    input[type=text], input[type=password] {
      width: 100%;
      padding: 12px 20px;
      margin: 8px 0;
      display: inline-block;
      border: 1px solid rgb(41, 41, 41);
      box-sizing: border-box;
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
    
    button {
      background-color: rgb(255, 153, 51);
      color: white;
      padding: 14px 20px;
      margin: 8px 0;
      border: none;
      cursor: pointer;
      width: 100%;
    }
    
    button:hover {
      opacity: 0.8;
    }
    
    .cancelbtn {
      width: auto;
      padding: 10px 18px;
      background-color: rgb(255, 153, 51);
    }
    
    .imgcontainer {
      text-align: center;
      margin: 24px 0 12px 0;
    }
    
    img.avatar {
      width: 20%;
      border-radius: 50%;
    }
    
    .container {
      padding: 16px;
    }
    
    span.psw {
      float: right;
      padding-top: 16px;
    }
    .header {
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
                padding-left: 80px;
                padding-right: 80px;
                padding-top: 50px;
                padding-bottom: 50px;
              }
            </style>
            <div class="navbar">
                <a href=index.jsp>Home</a>
                <a href=listprod.jsp>Begin Shopping</a>
                <div class = "logout">
                    <a href=account.jsp>Account</a>
                </div>
            </div>
<title>Real Estate Order Processing</title>
</head>
<body style="background-color:rgb(41, 41, 41);">

<% 
// Get customer id
String custId = request.getParameter("customerId");
String password = request.getParameter("password");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";
boolean errId = true
	  , errCart = true
	  , errPass = false;
String errorMessage = "<h1>Invalid customer id. Go back to the previous page and try again.</h1>";
String custName = "";
try (Connection con = DriverManager.getConnection(url, uid, pw);) 
{
	String sql  = "SELECT customerId, firstName, lastName, password FROM customer";
	PreparedStatement p = con.prepareStatement(sql); // p.setString(1, custId);
	ResultSet r = p.executeQuery();
	errId = true;
	while (r.next())
	{
		if (custId.equals(r.getString(1)))
		{

			custName = r.getString(2) + " " + r.getString(3);
			errorMessage = "";
			if(!password.equals(r.getString(4))){
				errorMessage = "The password you entered was not correct. Please go back and try again.";
				errPass = true;
			}
			errId = false; break;
		}
	}
	if (productList == null || productList.size() < 1)
	{ errCart = true; errorMessage += "<div class = header><h1>Your shopping cart is empty!</h1></div"; }
	else
	{ errCart = false; }
}
catch (SQLException sqle)
{ out.println(sqle.getLocalizedMessage()); }

// If any are not true, display an error message
if (errId || errCart || errPass)
{
	out.println(errorMessage);
}
else
{
	// Make connection
	try (Connection con = DriverManager.getConnection(url, uid, pw);) 
	{
		// Save order information to database
		double totalPrice = 0;
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext())
		{ 
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ( (Integer)product.get(3)).intValue();
			totalPrice += qty*pr;
		}
		String sql = "SELECT address, city, state, postalCode, country FROM customer WHERE customerId = '" + custId + "'";
		PreparedStatement p = con.prepareStatement(sql); //p.setString(1, custId);
		ResultSet r = p.executeQuery();
		String[] location = new String[5];
		ResultSetMetaData meta = r.getMetaData();
		int rowCount = 0;
		while (r.next()) 
		{
			for (int j = 0; j < meta.getColumnCount(); j++) 
			{ 
				location[j] = (String)r.getObject(j + 1);                	 	                       	                                	                   
			}
		}            
		// Update total amount for order record
		sql = "INSERT INTO orderSummary (orderDate, totalAmount, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry, customerId) "+
			  "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		String dt = java.time.LocalDateTime.now().toString(); 
		dt = dt.substring(0,dt.indexOf('T')) + " " + dt.substring(dt.indexOf('T')+1, dt.indexOf('.'));
		
		// Use retrieval of auto-generated keys.
		p = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		p.setString(1, dt); p.setDouble(2, totalPrice); p.setString(3, location[0]); p.setString(4, location[1]);
		p.setString(5, location[2]); p.setString(6, location[3]); p.setString(7, location[4]); p.setString(8, custId);
		p.execute();
		ResultSet keys = p.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);
		
		// Insert each item into OrderProduct table using OrderId from previous INSERT
		out.println("<div class = header><h1>Your Order Summary</h1></div><div class = box>");
		iterator = productList.entrySet().iterator();
		out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
		out.println("<th>Price</th><th>Subtotal</th></tr>");
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		double total =0;
		while (iterator.hasNext())
		{
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String productId = (String) product.get(0);
			String name = (String) product.get(1);
			String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ((Integer)product.get(3)).intValue();	
			sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)"; p = con.prepareStatement(sql);
			p.setInt(1, orderId); p.setInt(2, Integer.parseInt(productId)); p.setInt(3, qty); p.setDouble(4, pr);
			p.executeUpdate(); 
			
			// Print out order summary
			out.print("<tr><td>"+productId+"</td>");
			out.print("<td>"+name+"</td>");
		
			out.print("<td align=\"center\">"+product.get(3)+"</td>");
			out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
			out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
			out.println("</tr>");
			total = total +pr*qty;
		}
		out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
		+"<td align=\"left\">"+currFormat.format(total)+"</td></tr>");
		out.println("</table>");
		out.println("<h1>Order completed. Will be shipped soon...</h1>");
		out.println("<h1>Your order reference number is: "+orderId+"</h1>");
		out.println("<h1>Shipping to customer: "+custId+" Name: "+custName+"</h1>");

		// Clear cart if order placed successfully
		productList.clear();
		con.close();
	}
	catch (SQLException sqle)
	{
		out.println(sqle.getLocalizedMessage());
	}
} %>
</div>
</BODY>
</HTML>
