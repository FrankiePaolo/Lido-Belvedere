<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Lido Belvedere - Register</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="././css/employeeregister.css">
    </head>
    <body>

        <!-- Intro text -->
        <div class="text">
            <p id="intro">
                Welcome to lido Belvedere!
            </p>
        </div>

        <form action="<%= request.getContextPath() %>/register" method="post">

            <!-- Registration form -->
            <div class="registrationform">
                <h1>Register</h1>
                <p>Please fill in this form to create an account and use our services.</p>
                <hr>

                <label for="name"><b>First Name</b></label>
                <input type="text" placeholder="Enter Name" name="firstName" id="firstName" required>

                <label for="surname"><b>Last Name</b></label>
                <input type="text" placeholder="Enter Surname" name="lastName" id="lastName" required>

             	<label for="surname"><b>Username</b></label>
                <input type="text" placeholder="Enter Surname" name="username" id="username" required>              

                <label for="psw"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="password" id="password" required>
                
                <label for="psw-repeat"><b>Repeat Password</b></label>
                <input type="password" placeholder="Repeat Password" name="password-repeat" id="password-repeat" required>
                
                <label for="email"><b>Address</b></label>
                <input type="text" placeholder="Enter Email" name="address" id="address" required>

   				<label for="Contact No"><b>Contact No</b></label>
                <input type="text" placeholder="Enter Contact No" name="contact" id="contact" required>
  
                <hr>

                <p>By creating an account you agree to our <a href="#">Terms  Privacy</a>.</p>
                <button type="submit" value="Submit" class="registerbtn">Register</button>
            </div>

            <!-- Login form -->
            <div class="loginform">
                <p>Already have an account? <a href="login.jsp">Sign in</a>.</p>
            </div>
        </form>

    </body>
</html>