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
            </style>
            <div class="navbar">
                <a href=index.jsp>Home</a>
                <a href=listprod.jsp>Begin Shopping</a>
                <a href=showcart.jsp>Cart</a>
                <div class = "logout">
                    <a href=account.jsp>Account</a>
                </div>
            </div>
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
    <title>Checkout Login</title>
    </head>
<body style="background-color:rgb(41, 41, 41);">

    <div class = header>
<h1>Enter your customer ID to complete the transaction:</h1>
</div>
<div class = box>

<form method="get" action="order.jsp">
<input type="text" placeholder="Enter ID" name="customerId" required><br><br>
<input type="password" placeholder="Enter Password" name="password" required><br><br>
<div button>
<div class = cancelbtn><button type="submit" value="Submit">Submit</button></div>
<div class = button> <button type="reset" value="Reset">Reset</button></class>
</div>
</form>
</div>

</body>
</html>

