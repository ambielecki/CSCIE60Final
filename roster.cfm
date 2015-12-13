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
					<h2>Get Team Rosters</h2>
				</div>	
			</div><br>

			<cfquery name="getTeams"
				datasource = "#APPLICATION.datasource#"
				username = "#APPLICATION.username#"
				password = "#APPLICATION.password#">
				select tbTeam.teamID, tbTeam.teamname, tbTeam.division 
				FROM tbTeam 
				WHERE tbTeam.status ='active'
			</cfquery>

			<div class="col-sm-6">
				<!--- Begin form, self posting --->
				<cfform class="ps4form" action="roster.cfm" method="post">
					<div class="row">
						<div class="col-sm-12">
							Select Team
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							Team: 
						</div>
						<div class="col-sm-6">
							<cfselect name="team">
								<cfoutput query="getTeams">
									<!--- Populate query from getTeams query --->
									<option value="#getTeams.teamID#">#getTeams.teamName# - #getteams.division#</option>
								</cfoutput>
							</cfselect>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							Year:
						</div>
						<div class="col-sm-6">
							<select name="year">
								<option value=2016>2016</option>
								<option value=2015 selected>2015</option>
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
			<cfif isDefined("Form.team")>
				<cfquery name="getRoster"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					SELECT tbPlayer.firstname, tbplayer.lastname, tbTeam.teamName  
					FROM tbPlayer, tbplayerassignment, tbteam 
					WHERE tbteam.teamID = tbplayerassignment.teamid 
					AND tbplayer.playerid = tbplayerassignment.playerid 
					and tbplayerassignment.year = <cfqueryparam cfsqltype="cf_sql_number" value="#FORM.year#">
					and tbteam.teamid = <cfqueryparam cfsqltype="cf_sql_number" value="#FORM.team#">
				</cfquery>

				<div class="row">
					<div class="col-sm-12 ps4header">
						<h4><cfoutput>#FORM.year#</cfoutput> <cfoutput>#getRoster.teamName#</cfoutput> Roster</h4>
					</div>
				</div><br>

				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered table-striped">
							<tr>
								<th>First Name</th>
								<th>Last Name</th>
							</tr>
							<cfoutput query="getRoster">
								<tr>
									<td>#getRoster.firstName#</td>
									<td>#getRoster.lastName#</td>
								</tr>
							</cfoutput>
						</table>
					</div>	
				</div>
				<div class="row">
					<div class="col-sm-12">
						<cfform action="rosterdownload.cfm" method="post">
							<cfinput type="hidden" name="year" value="#FORM.year#">
							<cfinput type="hidden" name="team" value="#FORM.team#">
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
			