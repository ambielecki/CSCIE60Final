<html>
	<head>
	  <title>Get Email</title>
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
					<h2>Get Email Addresses</h2>
				</div>	
			</div><br>
			<div class="col-sm-6">
				<!--- Begin form, self posting --->
				<cfform class="ps4form" action="email.cfm" method="post">
					<div class="row">
						<div class="col-sm-12">
							Select Group
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							Group:
						</div>
						<div class="col-sm-6">
							<select name="group">
								<option value=1>Coaches</option>
								<option value=2>All Players' Contact</option>
								<option value=3>All Adults</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-sm-offset-6">
							<input type='submit' value="Submit Query">
						</div>
					</div>
				</cfform>
			</div>
			<cfif isDefined("Form.group") AND FORM.group is 1>
				<cfquery name="getEmail"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					select tbadult.firstname, tbadult.lastname, tbadult.email 
					from tbadult, tbcoachrole 
					where tbadult.adultid = tbcoachrole.adultid
				</cfquery>
				<div class="row">
					<div class="col-sm-12 ps4header">
						<h4>Coach Contact Information</h4>
					</div>
				</div><br>

				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered table-striped">
							<tr>
								<th>First Name</th>
								<th>Last Name</th>
								<th>Email</th>
							</tr>
							<cfoutput query="getEmail">
								<tr>
									<td>#getEmail.firstName#</td>
									<td>#getEmail.lastName#</td>
									<td>#getEmail.email#</td>
								</tr>
							</cfoutput>
						</table>
					</div>	
				</div>
				<div class="row">
					<div class="col-sm-12">
						<cfform action="emaildownload.cfm" method="post">
							<cfinput type="hidden" name="group" value = 1>
							<cfinput type="submit" name="submitexcel" value="Download Excel Report">
						</cfform>
					</div>
				</div>
			<cfelseif isDefined("Form.group") AND FORM.group is 2>
				<cfquery name="getEmail"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					select tbplayer.firstname, tbplayer.lastname, tbAdult.email 
					FROM tbplayer, tbadult, tbprimary 
					where tbplayer.playerid = tbprimary.playerid 
						AND tbadult.adultid = tbprimary.adultid
				</cfquery>
				<div class="row">
					<div class="col-sm-12 ps4header">
						<h4>Player Contact Information</h4>
					</div>
				</div><br>

				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered table-striped">
							<tr>
								<th>First Name</th>
								<th>Last Name</th>
								<th>Email</th>
							</tr>
							<cfoutput query="getEmail">
								<tr>
									<td>#getEmail.firstName#</td>
									<td>#getEmail.lastName#</td>
									<td>#getEmail.email#</td>
								</tr>
							</cfoutput>
						</table>
					</div>	
				</div>
				<div class="row">
					<div class="col-sm-12">
						<cfform action="emaildownload.cfm" method="post">
							<cfinput type="hidden" name="group" value = 2>
							<cfinput type="submit" name="submitexcel" value="Download Excel Report">
						</cfform>
					</div>
				</div>
			<cfelseif isDefined("Form.group") AND FORM.group is 3>
				<cfquery name="getEmail"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					select tbadult.firstname, tbadult.lastname, tbadult.email 
					from tbadult
				</cfquery>
				<div class="row">
					<div class="col-sm-12 ps4header">
						<h4>All Email Address</h4>
					</div>
				</div><br>

				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered table-striped">
							<tr>
								<th>First Name</th>
								<th>Last Name</th>
								<th>Email</th>
							</tr>
							<cfoutput query="getEmail">
								<tr>
									<td>#getEmail.firstName#</td>
									<td>#getEmail.lastName#</td>
									<td>#getEmail.email#</td>
								</tr>
							</cfoutput>
						</table>
					</div>	
				</div>
				<div class="row">
					<div class="col-sm-12">
						<cfform action="emaildownload.cfm" method="post">
							<cfinput type="hidden" name="group" value = 3>
							<cfinput type="submit" name="submitexcel" value="Download Excel Report">
						</cfform>
					</div>
				</div>
			</cfif>
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
			