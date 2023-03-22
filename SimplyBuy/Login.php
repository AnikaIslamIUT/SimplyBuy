<?php include('SimplyBuyServer.php'); ?>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Login Form</title>
	<link rel="stylesheet" type="text/css" href="Register.css">
</head>
<body style="background-image: url(paper-shopping.jpg);
	background-size: cover;">
	
	<div style="background: radial-gradient(#1C658C,#9AD0EC);color:#9AD0EC;" class="Header">
		<h2>Login</h2>
	</div>

	<form style="width: 30%;
	margin: 0px auto;
	background: radial-gradient(#11468F,#00B4D8);
	border: 1px solid #80c4de;
	border-radius: 0px 0px 10px 10px;
	padding: 20px;" 
	 method="post" action="Login.php">
		<?php include('errors.php'); ?>
		<div class="input-group">
			<label>Username</label>
			<input type="text" name="username">
		</div>
		<div class="input-group">
			<label>Password</label>
			<input type="password" name="password">
		</div>
		<div class="input-group">
			<button type="submit" name="login" class="Button">Login</button>
		</div>
		<p>
			Not a Member? <a href="Register.php">Register Now!</a>
		</p>
	</form>
	
</body>
</html>