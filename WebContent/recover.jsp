<body style="background-color:rgb(41, 41, 41);">
    <style>* {box-sizing: border-box}
    body {
              font-family: Arial, Helvetica, sans-serif;
            }
    
    /* Add padding to containers */
    .container {
      padding: 16px;
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
        </style>
            <div class="navbar">
                <a href=index.jsp>Home</a>
                <a href=listprod.jsp>Begin Shopping</a>
                <a href=showcart.jsp>Cart</a></div>
                <style>
    
    /* Full-width input fields */
    input[type=text], input[type=password] {
      width: 100%;
      padding: 15px;
      margin: 5px 0 22px 0;
      display: inline-block;
      border: none;
      background: #f1f1f1;
    }
    
    input[type=text]:focus, input[type=password]:focus {
      background-color: #ddd;
      outline: none;
    }
    
    /* Overwrite default styles of hr */
    hr {
      border: 1px solid #f1f1f1;
      margin-bottom: 25px;
    }
    
    /* Set a style for the submit/register button */
    .registerbtn {
      background-color: rgb(255, 153, 51);
      color: black;
      padding: 16px 20px;
      margin: 8px 0;
      border: none;
      cursor: pointer;
      width: 100%;
      opacity: 0.9;
    }
    .cancelbtn {
  padding: 10px 18px;
  background-color: rgb(158,158,158);
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
    
    .registerbtn:hover {
      opacity:1;
    }
    
    /* Add a blue text color to links */
    a {
      color: dodgerblue;
    }
    
    /* Set a grey background color and center the text of the "sign in" section */
    .signin {
      background-color: #f1f1f1;
      text-align: center;
    }
    .header {
                background-color: rgb(255, 153, 51);
                padding: 5px;
                border: 2px solid #000000;
                margin-bottom: 5px;
                margin-top: 5px;
              }
    </style>
    
    
        <div class="container">
          <div class = header><h1>Recover Password</h1></div>
          <div class = box>
            <form action="mockrecover.jsp">
          <h2>Please fill in this form to recover your password.</h2>
          <hr>
      
          <label for="email"><b>Email</b></label>
          <input type="text" placeholder="Enter Email" name="email" id="email" required>
          <hr>
          <button type="submit" class="registerbtn">Submit</button>
        <div class="cancelbtn">
          <a href="login.jsp"><button type="button" class="cancelbtn">Cancel</button></a>
        </div>
        </form>
        </div>
        </div>
    </body>