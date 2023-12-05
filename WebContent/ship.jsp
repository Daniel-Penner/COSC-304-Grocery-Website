<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Daniel's Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String id = request.getParameter("orderId");
	boolean errId = true;
	// TODO: Check if valid order id in database
	try (Connection con = DriverManager.getConnection(url, uid, pw);) 
{
	String sql  = "SELECT orderId FROM ordersummary";
	PreparedStatement p = con.prepareStatement(sql);
	ResultSet r = p.executeQuery();
	errId = true;
	while (r.next())
	{
		if (id.equals(r.getString(1)))
		{
			errId = false; break;
		}
	}
	if(errId){
		out.println("This is not a valid order Id");
	}
	else{
		// TODO: Start a transaction (turn-off auto-commit)
		con.setAutoCommit(false);
		// TODO: Retrieve all items in order with given id
		sql = "SELECT * FROM orderproduct WHERE orderId = "+id;
		p = con.prepareStatement(sql);
		r = p.executeQuery();
		// TODO: Create a new shipment record.
		Statement stmt = con.createStatement();
		stmt.execute("INSERT INTO shipment(warehouseId)VALUES(1);");
		boolean err = false;
		while(r.next()){
			int quantity = r.getInt("quantity");
			// TODO: For each item verify sufficient quantity available in warehouse 1.
			sql = "SELECT quantity FROM productInventory WHERE productId ="+r.getInt(2)+" AND warehouseId = 1";
			ResultSet r2 = stmt.executeQuery(sql);
			r2.next();	
			if(quantity > r2.getInt(1)){
				out.print("<h1>Shipment not done. Insufficient inventory for product id:"+r.getInt(2)+"</h1>");
				err = true;
				con.rollback();
				break;
			}
			else{
				out.println("<h2>Ordered Product: "+r.getInt(2)+" Qty: "+quantity+" Previous inventory: "+r2.getInt(1)+" New inventory: "+(r2.getInt(1)-quantity)+"</h2>");
				//stmt.executeUpdate("UPDATE productInventory SET quantity = "+(r2.getInt(1)-quantity)+" WHERE productId = "+ r.getInt(2));
			}
		}
		if(!err){
			con.commit();
		}
		con.setAutoCommit(true);
	}
}
catch (SQLException sqle)
{ out.println(sqle.getLocalizedMessage()); }
	
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
