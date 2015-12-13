<html>
	<head>
	  <title>Add/Edit Players</title>
	  <!-- from faviconshut.com -->
	  <link rel='icon' href='images/favicon.ico'>
	  <!-- Load bootstrap and custom css for formatting -->
	  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	  <link rel="stylesheet" href="css/final.css">
	</head>

	<body>
		<div class="container">
			<!--- load the header file --->
			<cfinclude template="abps4header.cfm">
			
			<noscript class="textarea">JavaScript is Required for Form Validation</noscript>

			<div class="row ps4header">
				<div class="col-sm-6">
					<h2>Please Log In</h2>
				</div>	
			</div><br>
			<div class="row">
				<div class="col-sm-12">
					<!--- Begin form, self posting --->
					<cfform class="ps4form" action="final.cfm" method="post" name="login">
						<div class="row">
							<div class="col-sm-3">
								<label for="userLogin">Username:</label>
							</div>
							<div class="col-sm-3">
								<input type="text" name="userLogin">
							</div>
						</div>
						<div class="row">
							<div class="col-sm-3">
								<label for="userPassword">Password:</label>
							</div>
							<div class="col-sm-3">
								<input type="password" name="userPassword">
							</div>
						</div>
						<div class="row">
							<div class="col-sm-offset-3 col-sm-3">
								<input type="submit" value="LogIn">
							</div>
						</div>
					</cfform>
				</div>
			</div>
		</div><!--Container-->
		<footer>
			<div class="container">
				<cfinclude template="abps4footer.cfm">
			</div>
		</footer>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	</body>
</html>