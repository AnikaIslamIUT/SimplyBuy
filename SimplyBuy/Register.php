
<?php include('SimplyBuyServer.php'); ?>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Register Form</title>
	<link rel="stylesheet" type="text/css" href="Register.css">
</head>
<body style="background-image: url(paper-shopping.jpg);
	background-size: cover;">
	<div style="background: radial-gradient(#1C658C,#9AD0EC);color:#9AD0EC;" class="Header">
		<h2>Register</h2>
	</div>

	<form style="width: 30%;
	margin: 0px auto;
	background: radial-gradient(#11468F,#00B4D8);
	border: 1px solid #80c4de;
	border-radius: 0px 0px 10px 10px;
	padding: 20px;" method="post" action="register.php">

		<?php include('errors.php'); ?>

		<div class="input-group">
			<label>Username</label>
			<input type="text" name="username">
		</div>
		<div class="input-group">
			<label>Email</label>
			<input type="text" name="email">
		</div>
			<div class="input-group">
			<label>Phone Number</label>
			<input type="text" name="phone">
		</div>
			<div class="input-group">
			<label>Address</label>
			<input type="text" name="address">
		</div>
		<div class="input-group">
			<label>Password</label>
			<input type="password" name="pass1">
		</div>
		<div class="input-group">
			<label>Confirm Password</label>
			<input type="password" name="pass2">
		</div>
		<div class="input-group">
			<button type="submit" name="register" class="Button">Free Register</button>
		</div>
		<p>
			Already a Member? <a href="login.php">Log in</a>
		</p>
	</form>
</body>
</html>