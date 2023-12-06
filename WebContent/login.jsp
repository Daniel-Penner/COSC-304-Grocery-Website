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
		</style>
		<div class="navbar">
			<a href=index.jsp>Home</a>
			<a href=listprod.jsp>Begin Shopping</a>
			<a href=showcart.jsp>Cart</a></div>
            <style>

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
     display: block;
     float: none;
  }
  .cancelbtn {
     width: 100%;
  }
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
<title>Login Screen</title>
</head>
<body style="background-color:rgb(41, 41, 41);">
<div class =header>
	<h1>Login Form</h1>
</div>

<div class = box>
	<form name="MyForm" action="validateLogin.jsp">
		<div class="imgcontainer">
		  <img src="img/img_avatar2.png" alt="Avatar" class="avatar">
		</div>
		<div class="container">
			<label for="uname"><b>Username</b></label>
			<input type="text" placeholder="Enter Username" name="username" id ="username" required>
		
			<label for="psw"><b>Password</b></label>
			<input type="password" placeholder="Enter Password" name="password" id="password" required>
				
			<button type="submit">Login</button>
		  </div>
		
		  <div class="container" style="background-color:rgb(41, 41, 41)">
			<a href="index.jsp"><button type="button" class="cancelbtn">Cancel</button></a>
			<span class="psw" style = "color: white">Forgot <a href="recover.jsp" style = "color: white">password?</a></span>
		  </div>
		</form>

</div>
</div>

</body>
</html>

