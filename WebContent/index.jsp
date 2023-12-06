<!DOCTYPE html>
<html>
	<head>
        <title>D and K Real Estate</title>
		
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
			<a href=listprod.jsp>Begin Shopping</a>
			<a href=admin.jsp>Administrators</a>
			<div class = "logout">
			<a href=login.jsp>Login</a>
			<a href=login.jsp>Account</a>
			<a href=logout.jsp>Log out</a></div>
			</div>

		<style>.header {
			background-color: rgb(255, 153, 51);
			padding: 5px;
			border: 2px solid #000000;
			margin-bottom: 5px;
			margin-top: 5px;
		  }</style>
		<div class="header">
			<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h1 align=\"center\">Welcome to D and K Real Estate, "+userName.substring(0,1).toUpperCase()+userName.substring(1,userName.length())+"!</h3>");
	else out.println("<h1 align=\"center\">Welcome to D and K Real Estate!</h1>");
%>
		</div>
		<style>
		.box {
			float: none;
			border: 2px solid #000000;
			padding: 8px 12px;
			background-color: rgb(158,158,158);
		  }
		</style>
		<div class = "box">
<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>
<!--
<h4 align="center"><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

<h4 align="center"><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>
//-->
</body>
</head>
</html>


