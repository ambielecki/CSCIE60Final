<html>
	<head>
	  <title>CORI Check</title>
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
					<h2>Check CORI Satus</h2>
				</div>	
			</div><br>
			<div class="col-sm-6">
				<!--- Begin form, self posting --->
				<cfform class="ps4form" action="cori.cfm" method="post">
					<div class="row">
						<div class="col-sm-12">
							Select Report Type
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							Report:
						</div>
						<div class="col-sm-6">
							<select name="type">
								<option value=2>Coaches With Current CORI</option>
								<option value=3>Coaches Needing CORI</option>
								<option value=4>All Active CORIs</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							Year:
						</div>
						<div class="col-sm-6">
							<select name="year">
								<option value=2016>2016</option>
								<option value=2015>2015</option>
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
			<cfif isDefined("Form.type") AND FORM.type is 2>
				<cfquery name="currentCori"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					select tbAdult.firstName, tbAdult.lastName, tbTeam.teamName  
					from tbAdult, tbCoachRole, tbCori, tbTeam 
					WHERE tbAdult.AdultID = tbCori.AdultID 
					  AND tbAdult.AdultID = tbCoachRole.AdultID 
					  AND tbTeam.teamID = tbCoachRole.teamID 
					  AND tbCori.year = <cfqueryparam cfsqltype="cf_sql_number" value="#FORM.year#">
					  AND tbCoachRole.year = <cfqueryparam cfsqltype="cf_sql_number" value="#FORM.year#">
				</cfquery>
				<div class="row">
					<div class="col-sm-12 ps4header">
						<h4>Coaches with Completed CORI for <cfoutput>#FORM.year#</cfoutput></h4>
					</div>
				</div><br>

				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered table-striped">
							<tr>
								<th>First Name</th>
								<th>Last Name</th>
								<th>Team</th>
							</tr>
							<cfoutput query="currentCori">
								<tr>
									<td>#currentCori.firstName#</td>
									<td>#currentCori.lastName#</td>
									<td>#currentCori.teamName#</td>
								</tr>
							</cfoutput>
						</table>
					</div>	
				</div>
				<div class="row">
					<div class="col-sm-12">
						<cfform action="coridownload.cfm" method="post">
							<cfinput type="hidden" name="year" value="#FORM.year#">
							<cfinput type="hidden" name="method" value = 2>
							<cfinput type="submit" name="submitexcel" value="Download Excel Report">
						</cfform>
					</div>
				</div>
			<cfelseif isDefined("Form.type") AND FORM.type is 3>
				<cfquery name="needCori"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">

					select tbAdult.firstName, tbAdult.lastName 
					from tbAdult, tbCoachRole 
					WHERE tbAdult.adultID = tbCoachRole.adultID 
						AND tbCoachRole.adultID NOT IN 
							(SELECT tbCORI.adultID FROM tbCORI where tbCORI.year = <cfqueryparam cfsqltype="cf_sql_number" value="#FORM.year#">)
				</cfquery>
				<div class="row">
					<div class="col-sm-12 ps4header">
						<h4>Coaches Needing a CORI for <cfoutput>#FORM.year#</cfoutput></h4>
					</div>
				</div><br>

				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered table-striped">
							<tr>
								<th>First Name</th>
								<th>Last Name</th>
							</tr>
							<cfoutput query="needCori">
								<tr>
									<td>#needCori.firstName#</td>
									<td>#needCori.lastName#</td>
								</tr>
							</cfoutput>
						</table>
					</div>	
				</div>
				<div class="row">
					<div class="col-sm-12">
						<cfform action="coridownload.cfm" method="post">
							<cfinput type="hidden" name="year" value="#FORM.year#">
							<cfinput type="hidden" name="method" value = 3>
							<cfinput type="submit" name="submitexcel" value="Download Excel Report">
						</cfform>
					</div>
				</div>
			<cfelseif isDefined("Form.type") AND FORM.type is 4>
				<cfquery name="allCori"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">

					SELECT tbAdult.firstName, tbAdult.lastName, tbCori.year 
					FROM tbAdult, tbCori 
					WHERE tbAdult.AdultID = tbCori.AdultID AND tbCori.year = <cfqueryparam cfsqltype="cf_sql_number" value="#FORM.year#">
					

				</cfquery>
				<div class="row">
					<div class="col-sm-12 ps4header">
						<h4>All Adults With Completed CORI for <cfoutput>#FORM.year#</cfoutput></h4>
					</div>
				</div><br>

				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered table-striped">
							<tr>
								<th>First Name</th>
								<th>Last Name</th>
							</tr>
							<cfoutput query="allCori">
								<tr>
									<td>#allCori.firstName#</td>
									<td>#allCori.lastName#</td>
								</tr>
							</cfoutput>
						</table>
					</div>	
				</div>
				<div class="row">
					<div class="col-sm-12">
						<cfform action="coridownload.cfm" method="post">
							<cfinput type="hidden" name="year" value="#FORM.year#">
							<cfinput type="hidden" name="method" value=4>
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
			