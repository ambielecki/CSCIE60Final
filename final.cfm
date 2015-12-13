<html>
	<head>
	  <title>Final Project</title>
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
			<div class="row ps4header">
				<div class="col-sm-12">
					<h2>Reports</h2>
				</div>	
			</div><br>
			<div class="row textarea">
				<div class="col-sm-12">
					<ul>
						<li><a href="cori.cfm">Check CORI Status</a></li>
						<li><a href="roster.cfm">Get Team Rosters</a></li>
						<li><a href="email.cfm">Get Email Addresses</a></li>
					</ul>
				</div>	
			</div><br>
			<div class="row ps4header">
				<div class="col-sm-12">
					<h2>Forms</h2>
				</div>	
			</div><br>
			<div class="row textarea">
				<div class="col-sm-12">
					<ul>
						<li><a href="player.cfm">Add/Edit Players</a></li>
						<li><a href="adult.cfm">Add Adults</a></li>
						<li><a href="game.cfm">Add/Edit Games</a></li>
					</ul>
				</div>	
			</div><br>
		</div>
		<footer>
			<div class="container">
				<cfinclude template="abps4footer.cfm">
			</div>
		</footer>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	</body>
</html>
