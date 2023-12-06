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
			<a href=showcart.jsp>Cart</a>
			<a href=admin.jsp>Administrators</a>
			<div class = "logout">
			<a href=register.jsp>Login/Register</a>
			<a href=account.jsp>Account</a>
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
            <h1>Recovery:</h1>
		</div>
		<style>
		.box {
			float: none;
			border: 2px solid #000000;
			background-color: rgb(158,158,158);
			padding-left: 80px;
			padding-top: 50px;
			padding-bottom: 50px;
		  }
		.column {
			float: left;
			width: 33%;
		  }
		  .column-right{
			float: right;
			width: 30%;
		  }
		  
		  /* Clear floats after image containers */
		  .row::after {
			content: "";
			clear: both;
			display: table;
		  }
		  </style>
          <div class = box>
          <%
            String email = request.getParameter("email");
            out.print("<h2>Thank You! An email has been sent to "+email+" if it is in our system.");
%>


</div>
<!--
<h4 align="center"><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

<h4 align="center"><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>
//-->
</body>
</head>
</html>


