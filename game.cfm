<html>
	<head>
	  <title>Add/Edit Games</title>
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
			
			<!--- Using Javascript for validation and to submit forms that have fillable fields (using a button onclick instead of form submit input) --->
			<noscript class="textarea">JavaScript is Required for Form Validation</noscript>

			<div class="row ps4header">
				<div class="col-sm-6">
					<h2><a href="game.cfm">Add/Edit Games</a></h2>
				</div>	
			</div><br>
			<div class="row">
				<div class="col-sm-12">
					<!--- Begin form, self posting --->
					<cfform class="ps4form" action="game.cfm" method="post" name="gameForm" id="gameForm">
						<cfif NOT isDefined("FORM.stage") OR FORM.stage is 3><!--- Display the starting form on page load or after full query --->
							<div class="row">
								<div class="col-sm-12">
									What would you like to do?
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									Select: 
								</div>
								<div class="col-sm-3">
									<cfselect name="method">
										<option value='add'>Add a Game</option>
										<option value='edit'>Edit a Game (Add Score)</option>
									</cfselect> 
								</div>
							</div>
							<cfinput type='hidden' name='stage' value='1'><!--- Set the next stage --->
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<cfinput type="Submit" name="SubmitForm" value="Submit" class="submitbtn">	
								</div>
							</div>
						<cfelseif isDefined("FORM.stage") AND FORM.stage is 1 AND FORM.method is 'add'><!--- Add a game --->
							
							<!--- Get teams and fields for form --->
							<cfquery name="getTeams"
								datasource = "#APPLICATION.datasource#"
								username = "#APPLICATION.username#"
								password = "#APPLICATION.password#">
								SELECT tbTeam.teamID, tbTeam.teamName, tbTeam.division 
								FROM tbTeam 
								WHERE tbTeam.status = 'active' 
							</cfquery>
							<cfquery name="getFields"
								datasource = "#APPLICATION.datasource#"
								username = "#APPLICATION.username#"
								password = "#APPLICATION.password#">
								SELECT tbLocation.locationID, tblocation.fieldName 
								FROM tblocation  
							</cfquery>
							<div class="row">
								<div class="col-sm-12">
									Add A Game
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="away">Away: </label>
								</div>
								<!--- Fill away select, we will check that it is not the same as home using JS on submission --->
								<div class="col-sm-3">
									<cfselect name="away" id="away" >
										<cfoutput query="getTeams">
											<option value="#getTeams.teamID#">#getTeams.teamName# - #getTeams.division#</option>
										</cfoutput>
									</cfselect>
								</div>
							</div>
							<div class="row">
								<!--- Fill home select, we will check that it is not the same as away using JS on submission --->
								<div class="col-sm-3">
									<label for="away">Home: </label>
								</div>
								<div class="col-sm-3">
									<cfselect name="home" id="home" >
										<cfoutput query="getTeams">
											<option value="#getTeams.teamID#">#getTeams.teamName# - #getTeams.division#</option>
										</cfoutput>
									</cfselect>
								</div>
							</div>
							<div class="row">
								<!--- Fill field select --->
								<div class="col-sm-3">
									<label for="away">Location: </label>
								</div>
								<div class="col-sm-3">
									<cfselect name="location" id="location" >
										<cfoutput query="getFields">
											<option value="#getFields.locationid#">#getFields.fieldname#</option>
										</cfoutput>
									</cfselect>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="date">Date: </label>
								</div>
								<!--- Will validate using JS and CF --->
								<div class="col-sm-3">
									<cfinput type="text" name="date" id="date" placeholder="yyyy-mm-dd">
									
									<cfinput type="hidden" name="date_required" value="Please enter a date.">
								</div>
								<div class="col-sm-6 hint" style="display:none" id="datehint">
									Date must be in form yyyy-mm-dd
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="time">Time: </label>
								</div>
								<div class="col-sm-3">
									<cfinput type="text" name="time" id="time" >
									<cfinput type="hidden" name="time_integer" value="Please enter a time as an integer">
									<cfinput type="hidden" name="time_required" value="Please enter a time as an integer.">		
									</cfinput>
								</div>
								<div class="col-sm-1">
									AM/PM
								</div>
								<div class="col-sm-3">
									<cfselect name="ampm" id="ampm">
										<option value="AM">AM</option>
										<option value="PM">PM</option>
									</cfselect>
								</div>
								<div class="col-sm-6 hint" style="display:none" id="timehint">
									Time is required as a number
								</div>
							</div>
							<cfinput type="hidden" name="stage" value=3>
							<cfinput type='hidden' name="method" value="add">
							<cfinput type='hidden' name='combined' id='combined' value=''>
							<div class="row" style="display:none" id="teamhint">
								<div class="col-sm-9 col-sm-offset-3 hint">
									Home Team Cannot Match Away Team
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<button type="button" name="SubmitForm" class="submitbtn" id="addsubmit">Add Game</button>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<a href="game.cfm">Go back to Add/Edit Game</a>
								</div>
							</div><br>
						<cfelseif isDefined("Form.stage") AND FORM.stage is 1 AND FORM.method is 'edit'><!--- Select a game to edit--->
							<div class="row">
								<div class="col-sm-12">
									Select Game
								</div>
							</div>
							<!--- Get all the games with home and away teams--->
							<cfquery name="selectgame"
								datasource = "#APPLICATION.datasource#"
								username = "#APPLICATION.username#"
								password = "#APPLICATION.password#">
								SELECT tbgame.gameID, tbgame.gamedate, tbgame.gametime, away.awayname, home.homename, tblocation.fieldname 
								FROM (SELECT tbgame.gameID, tbteam.teamname AS awayname, tbteam.teamid as awayid, tbgamerole.role  
								    from tbteam, tbgamerole, tbgame  
								    WHERE tbgamerole.gameid = tbgame.gameid 
								      AND tbgamerole.teamid = tbteam.teamid 
								      AND tbgamerole.role = 'away') away, 
								  (SELECT tbgame.gameID, tbteam.teamname AS homename, tbteam.teamid as homeid, tbgamerole.role  
								    from tbteam, tbgamerole, tbgame  
								    WHERE tbgamerole.gameid = tbgame.gameid 
								      AND tbgamerole.teamid = tbteam.teamid 
								      AND tbgamerole.role = 'home') home, 
								  tbgame, tblocation 
								WHERE tbgame.gameid = away.gameid AND tbgame.gameID = home.gameid and tblocation.locationid = tbgame.locationid 
								ORDER BY tbgame.gamedate
							</cfquery>
							<div class="row">
								<div class="col-sm-3">
									<label for="gameid">Select Game: </label>
								</div>
								<div class="col-sm-6">
									<cfselect name="gameid">
										<cfoutput query="selectgame">
											<!--- Populate query from getComponents query, select value is compNo, displays partDescr, after post the selected product will remain --->
											<option value="#selectgame.gameid#">#left(selectgame.gamedate,10)# #selectgame.gametime# #selectgame.awayname# at #selectgame.homename#</option>
										</cfoutput>
									</cfselect>
								</div>
							</div>
							<cfinput type="hidden" name="stage" value=2><!--- Set the stage and method --->
							<cfinput type='hidden' name="method" value="edit">
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<cfinput type="Submit" name="SubmitForm" value="Select Game" class="submitbtn">	
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<a href="game.cfm">Go back to Add/Edit Game</a>
								</div>
							</div><br>
						<cfelseif isDefined("FORM.stage") AND FORM.stage is 2 AND FORM.method is 'edit'><!--- Edit the game --->
							
							<!--- Get teams, fields, and games --->
							<cfquery name="getTeams"
								datasource = "#APPLICATION.datasource#"
								username = "#APPLICATION.username#"
								password = "#APPLICATION.password#">
								SELECT tbTeam.teamID, tbTeam.teamName, tbTeam.division 
								FROM tbTeam 
								WHERE tbTeam.status = 'active' 
							</cfquery>
							<cfquery name="getFields"
								datasource = "#APPLICATION.datasource#"
								username = "#APPLICATION.username#"
								password = "#APPLICATION.password#">
								SELECT tbLocation.locationID, tblocation.fieldName 
								FROM tblocation  
							</cfquery>
							<cfquery name="selectgame"
								datasource = "#APPLICATION.datasource#"
								username = "#APPLICATION.username#"
								password = "#APPLICATION.password#">
								SELECT tbgame.gameid, tbgame.gamedate, tbgame.gametime, away.awayid, away.awayruns, home.homeid, home.homeruns, tblocation.locationid, tblocation.fieldname, away.awayname, home.homename 
								FROM (SELECT tbgame.gameID, tbteam.teamname AS awayname, tbteam.teamid as awayid, tbgamerole.role, tbGameRole.runs as awayruns 
								    from tbteam, tbgamerole, tbgame  
								    WHERE tbgamerole.gameid = tbgame.gameid 
								      AND tbgamerole.teamid = tbteam.teamid 
								      AND tbgamerole.role = 'away') away, 
								  (SELECT tbgame.gameID, tbteam.teamname AS homename, tbteam.teamid as homeid, tbgamerole.role, tbGameRole.runs as homeruns 
								    from tbteam, tbgamerole, tbgame  
								    WHERE tbgamerole.gameid = tbgame.gameid 
								      AND tbgamerole.teamid = tbteam.teamid 
								      AND tbgamerole.role = 'home') home, 
								  tbgame, tblocation 
								WHERE tbgame.gameid = away.gameid 
									AND tbgame.gameID = home.gameid 
									AND tblocation.locationid = tbgame.locationid 
									AND tbgame.gameid = <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.gameid#">
							</cfquery>
							<div class="row">
								<div class="col-sm-12">
									Add A Game
								</div>
							</div>
							<!--- Away team select, will use the selectgame query to preselect original team --->
							<div class="row">
								<div class="col-sm-3">
									<label for="away">Away: </label>
								</div>
								<div class="col-sm-3">
									<cfselect name="away" id="away" >
										<cfoutput query="getTeams">
											<option value="#getTeams.teamID#" <cfif #getTeams.teamID# is #selectgame.awayid#>selected</cfif>>#getTeams.teamName# - #getTeams.division#</option>
										</cfoutput>
									</cfselect>
								</div>
								<div class="col-sm-2">
									<label for="awayruns">Away Runs: </label>
								</div>
								<div class="col-sm-2">
									<cfinput name="awayruns" id="awayruns" value="#selectgame.awayruns#">
									<cfinput type="hidden" name="awayruns_integer">	
								</div>
							</div>
							<!--- Home team select, will use the selectgame query to preselect original team --->
							<div class="row">
								<div class="col-sm-3">
									<label for="away">Home: </label>
								</div>
								<div class="col-sm-3">
									<cfselect name="home" id="home" >
										<cfoutput query="getTeams">
											<option value="#getTeams.teamID#" <cfif #getTeams.teamID# is #selectgame.homeid#>selected</cfif>>#getTeams.teamName# - #getTeams.division#</option>
										</cfoutput>
									</cfselect>
								</div>
								<div class="col-sm-2">
									<label for="homeruns">Home Runs: </label>
								</div>
								<div class="col-sm-2">
									<cfinput name="homeruns" id="homeruns" value="#selectgame.homeruns#">
									<cfinput type="hidden" name="homeruns_integer">
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="away">Location: </label>
								</div>
								<div class="col-sm-3">
									<cfselect name="location" id="location" >
										<cfoutput query="getFields">
											<option value="#getFields.locationid#" <cfif #getFields.locationid# is #selectgame.locationid#>selected</cfif>>#getFields.fieldname#</option>
										</cfoutput>
									</cfselect>
								</div>
							</div>
							<!--- Validate with both JS and CF, trim down to just date, no hours, min, etc --->
							<div class="row">
								<div class="col-sm-3">
									<label for="date">Date: </label>
								</div>
								<div class="col-sm-3">
									<cfinput type="text" name="date" id="date" value="#left(selectgame.gamedate, 10)#">
									<cfinput type="hidden" name="date_required" value="Please enter a date.">
								</div>
							</div>
							<!--- Time, I am trimming the AM and PM off, the if is becuase 7PM and 11AM are different lengths --->
							<div class="row">
								<div class="col-sm-3">
									<label for="time">Time: </label>
								</div>
								<div class="col-sm-3">
									<cfif len(selectgame.gametime) is 3>
										<cfinput type="text" name="time" id="time" value="#left(selectgame.gametime, 1)#">
										<cfinput type="hidden" name="time_integer" value="Time is required as an integer">
										<cfinput type="hidden" name="time_required" value="Time is required as an integer">
									<cfelse>
										<cfinput type="text" name="time" id="time" value="#left(selectgame.gametime, 2)#">
										<cfinput type="hidden" name="time_integer" value="Time is required as an integer">
										<cfinput type="hidden" name="time_required" value="Time is required as an integer">
									</cfif>
								</div>
								<div class="col-sm-1">
									AM/PM
								</div>
								<div class="col-sm-3">
									<cfselect name="ampm" id="ampm">
										<option value="AM" <cfif #right(selectgame.gametime,2)# is 'AM'>selected</cfif>>AM</option>
										<option value="PM" <cfif #right(selectgame.gametime,2)# is 'PM'>selected</cfif>>PM</option>
									</cfselect>
								</div>
							</div>
							<!--- Pass all our old values for the confirmation screen --->
							<cfinput type="hidden" name="stage" value=3>
							<cfinput type='hidden' name="method" value="edit">
							<cfinput type='hidden' name='oldgameid' id='oldgameid' value='#selectgame.gameid#'>
							<cfinput type='hidden' name='oldgamedate' id='oldgamedate' value='#selectgame.gamedate#'>
							<cfinput type='hidden' name='oldgametime' id='oldgametime' value='#selectgame.gametime#'>
							<cfinput type='hidden' name='oldawayruns' id='oladawayruns' value='#selectgame.awayruns#'>	
							<cfinput type='hidden' name='oldhomeid' id='oldhomeid' value='#selectgame.homeid#'>
							<cfinput type='hidden' name='oldhomeruns' id='oldhomeruns' value='#selectgame.homeruns#'>
							<cfinput type='hidden' name='oldfieldname' id='oldfieldname' value='#selectgame.fieldname#'>	
							<cfinput type='hidden' name='oldhomename' id='oldhomename' value='#selectgame.homename#'>
							<cfinput type='hidden' name='oldawayname' id='oldawayname' value='#selectgame.awayname#'>
							<cfinput type='hidden' name='combined' id='combined' value=''>
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<button type="button" name="SubmitForm" class="submitbtn" id="addsubmit">Edit Game</button>
								</div>
								<!--- JS errors --->
								<div class="col-sm-6 col-sm-offset-3 hint" style="display:none" id="teamhint">
									Home Team Cannot Match Away Team
								</div>
								<div class="col-sm-6 hint" style="display:none" id="awayrunshint">
									Runs must be an integer
								</div>
								<div class="col-sm-6 hint" style="display:none" id="homerunshint">
									Runs must be an integer
								</div>
								<div class="col-sm-6 hint" style="display:none" id="timehint">
									Time is required as a number
								</div>
								<div class="col-sm-6 hint" style="display:none" id="datehint">
									Date must be in form yyyy-mm-dd
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<a href="game.cfm">Go back to Add/Edit Game</a>
								</div>
							</div><br>
						</cfif>
					</cfform>
				</div>
			</div>
			<!--- Add a new game to the DB --->
			<cfif isDefined("Form.stage") AND FORM.stage is 3 AND FORM.method is 'add'>
				<cfparam name="querycheck" default="true">
				
				<!--- Update with a new game instance --->
				<cfquery name="addGame"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					INSERT INTO tbGame (locationID, gameDate, gameTime) 
  						VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#Form.location#">, 
  							to_date(<cfqueryparam cfsqltype="cf_sql_char" value="#Form.date#">,'yyyy-mm-dd'), 
  							<cfqueryparam cfsqltype="cf_sql_char" value="#Form.combined#">)
				</cfquery>
				<!--- Get the game we just added --->
				<cfquery name="getGame"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					SELECT * FROM (SELECT * FROM tbgame ORDER BY 1 DESC) WHERE ROWNUM=1
				</cfquery>
				<!--- Create the home team gamerole for the game we just created --->
				<cfquery name="addHome"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					INSERT INTO tbGameRole (gameID, role, teamID) 
  						VALUES (#getGame.gameID#, 
  							'home', 
  							<cfqueryparam cfsqltype="cf_sql_integer" value="#Form.home#"> )
				</cfquery>
				<!--- Create the away team gamerole for the game we just created --->
				<cfquery name="addAway"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					INSERT INTO tbGameRole (gameID, role, teamID) 
  						VALUES (#getGame.gameID#, 
  							'away', 
  							<cfqueryparam cfsqltype="cf_sql_integer" value="#Form.away#"> )
				</cfquery>
				<!--- Get all the info to display what we just added --->
				<cfquery name="confirmation"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					SELECT tbTeam.teamname, tbgame.gametime, tbgame.gamedate, tblocation.fieldname, tbgamerole.role 
						from tbteam, tbgame, tbgamerole, tblocation 
						WHERE tbteam.teamID = tbgamerole.teamID 
						  AND tbgame.gameID = tbgamerole.gameID 
						  AND tbgame.locationID = tblocation.locationID 
						  AND tbgame.gameID = #getGame.gameID#

				</cfquery>

				<div class="row ps4header">
					<div class="col-sm-12">
						<h2>Confirmation</h2>
					</div>	
				</div><br>

				<div class="row textarea ps4header">
					<div class="col-sm-12">
						You have successfully added:
					</div>
				</div>
				<div class="row ps4header">
					<div class="col-sm-12">
						Date: <cfoutput>#confirmation.gamedate#</cfoutput><br>
						Time: <cfoutput>#confirmation.gametime#</cfoutput><br>
						Location: <cfoutput>#confirmation.fieldname#</cfoutput><br>
						<cfoutput query="confirmation">
							Team: #confirmation.teamname# Role: #confirmation.role#<br>
						</cfoutput>
					</div>
				</div>
			</cfif>
			<cfif isDefined("Form.stage") AND FORM.stage is 3 AND FORM.method is 'edit'> <!--- Edit the DB --->
				<cfparam name="querycheck" default="true">
				
				<!--- Update DB --->
				<!--- Update tbGame --->
				<cfquery name="editGame"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					UPDATE tbGame  
					SET locationID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.location#">, 
						gameDate = to_date(<cfqueryparam cfsqltype="cf_sql_char" value="#Form.date#">,'yyyy-mm-dd'), 
						gameTime = <cfqueryparam cfsqltype="cf_sql_char" value="#Form.combined#"> 
					WHERE gameid = <cfqueryparam cfsqltype="cf_sql_num" value="#Form.oldgameid#">
				</cfquery>
				<cfquery name="getGame"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					SELECT * FROM tbgame where gameid = <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.oldgameid#">
				</cfquery>
				<!--- Update the away gameRole --->
				<cfquery name="editaway"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					UPDATE tbGameRole 
					SET teamID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.away#">
					<cfif #FORM.awayruns# IS NOT "">
						, runs = <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.awayruns#"> 
					<cfelseif #FORM.awayruns# IS "">
						, runs = null
					</cfif>
					WHERE gameID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.oldgameid#"> AND role = 'away'
				</cfquery>
				<!--- Update the home gameRole ---> 
				<cfquery name="edithome"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					UPDATE tbGameRole 
					SET teamID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.home#">
					<cfif #FORM.homeruns# IS NOT "">
						, runs = <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.homeruns#"> 
					<cfelseif #FORM.homeruns# IS "">
						, runs = null
					</cfif>
					WHERE gameID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.oldgameid#"> AND role = 'home'
				</cfquery>
				<!--- Get the information to display the confirmation --->
				<cfquery name="confirmation"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					SELECT tbTeam.teamname, tbgame.gametime, tbgame.gamedate, tblocation.fieldname, tbgamerole.role, tbGameRole.runs 
						from tbteam, tbgame, tbgamerole, tblocation 
						WHERE tbteam.teamID = tbgamerole.teamID 
						  AND tbgame.gameID = tbgamerole.gameID 
						  AND tbgame.locationID = tblocation.locationID 
						  AND tbgame.gameID = #getGame.gameID#
				</cfquery>

				<div class="row ps4header">
					<div class="col-sm-12">
						<h2>Confirmation</h2>
					</div>	
				</div><br>

				<div class="row textarea ps4header">
					<div class="col-sm-12">
						You have successfully edited:
					</div>
				</div>
				<div class="row ps4header">
					<div class="col-sm-12">
						Date: <cfoutput>#FORM.oldgamedate#</cfoutput><br>
						Time: <cfoutput>#FORM.oldgametime#</cfoutput><br>
						Location: <cfoutput>#FORM.oldfieldname#</cfoutput><br>
						Team: <cfoutput>#FORM.oldawayname#</cfoutput> Role: away Runs: <cfoutput>#FORM.oldawayruns#</cfoutput><br>
						Team: <cfoutput>#FORM.oldhomename#</cfoutput> Role: home Runs: <cfoutput>#FORM.oldhomeruns#</cfoutput><br>
					</div>
				</div>

				<div class="row textarea ps4header">
					<div class="col-sm-12">
						To:
					</div>
				</div>
				<div class="row ps4header">
					<div class="col-sm-12">
						Date: <cfoutput>#confirmation.gamedate#</cfoutput><br>
						Time: <cfoutput>#confirmation.gametime#</cfoutput><br>
						Location: <cfoutput>#confirmation.fieldname#</cfoutput><br>
						<cfoutput query="confirmation">
							Team: #confirmation.teamname# Role: #confirmation.role# Runs: #confirmation.runs#<br>
						</cfoutput>
					</div>
				</div>
			</cfif>

		</div><!--Container-->
		<footer>
			<div class="container">
				<cfinclude template="abps4footer.cfm">
			</div>
		</footer>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/game.js"></script>
	</body>
</html>