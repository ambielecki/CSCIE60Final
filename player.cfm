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
			<!--- Using both CF and JS validation --->
			<noscript class="textarea">JavaScript is Required for Form Validation</noscript>

			<div class="row ps4header">
				<div class="col-sm-12">
					<h2><a href="player.cfm">Add/Edit Players</a></h2>
				</div>	
			</div><br>
			<div class="row">
				<div class="col-sm-12">
					<!--- Begin form, self posting --->
					<cfform class="ps4form" action="player.cfm" method="post" id="playerForm">
						<cfif NOT isDefined("FORM.stage") OR FORM.stage is 3><!--- Display form both on page load and after a final submission --->
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
										<option value='add'>Add a Player</option>
										<option value='edit'>Edit a Player</option>
									</cfselect> 
								</div>
							</div>
							<cfinput type='hidden' name='stage' value='1'>
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<cfinput type="Submit" name="SubmitForm" value="Submit" class="submitbtn">	
								</div>
							</div>
						<cfelseif isDefined("FORM.stage") AND FORM.stage is 1 AND FORM.method is 'add'><!--- Add a new player --->
							<div class="row">
								<div class="col-sm-12">
									Add Player
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="firstname">First Name: </label>
								</div>
								<div class="col-sm-3">
									<cfinput type="text" name="firstname" id="firstname" >
									<cfinput type="hidden" name="firstname_required" value="First Name is Required">
								</div>
								<div class="col-sm-6 hint" style="display:none" id="firsthint">
									First Name is Required
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="lastname">Last Name: </label>
								</div>
								<div class="col-sm-3">
									<cfinput type="text" name="lastname" id="lastname" >
									<cfinput type="hidden" name="lastname_required" value="Last Name is Required">
								</div>
								<div class="col-sm-6 hint" style="display:none" id="lasthint">
									Last Name is Required
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="dob">Date of Birth: </label>
								</div>
								<div class="col-sm-3">
									<cfinput type="text" name="dob" id="dob" placeholder="yyyy-mm-dd">
									<cfinput type="hidden" name="dob_required" value="Please enter a date.">
									<!--- I would like to add the date validation, but it is reformatting it and I don't want to rewrite all my code at this point --->
								</div>
								<div class="col-sm-6 hint" style="display:none" id="datehint">
									Date must be in form yyyy-mm-dd
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="sex">Sex: </label>
								</div>
								<div class="col-sm-3">
									<cfselect name="sex">
										<option value="M">Male</optiom>
										<option value="F">Female</option>
									</cfselect>
								</div>
							</div>
								<cfinput type="hidden" name="stage" value=3>
								<cfinput type='hidden' name="method" value="add">
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<button type="button" name="SubmitForm" class="submitbtn" id="addsubmit">Add Player</button>	
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<a href="player.cfm">Go back to Add/Edit Player</a>
								</div>
							</div><br>
						<cfelseif isDefined("Form.stage") AND FORM.stage is 1 AND FORM.method is 'edit'><!--- Select a player to edit --->
							<div class="row">
								<div class="col-sm-12">
									Select Player
								</div>
							</div>
							<cfquery name="selectplayer"
								datasource = "#APPLICATION.datasource#"
								username = "#APPLICATION.username#"
								password = "#APPLICATION.password#">
								SELECT tbPlayer.playerID, tbPlayer.firstname, tbPlayer.lastname FROM tbPlayer
							</cfquery>
							<div class="row">
								<div class="col-sm-3">
									<label for="playerselect">Select Player: </label>
								</div>
								<div class="col-sm-6">
									<cfselect name="playerselect">
										<cfoutput query="selectplayer">
											<!--- Populate query from getComponents query, select value is compNo, displays partDescr, after post the selected product will remain --->
											<option value="#selectplayer.playerID#">#selectplayer.firstname# #selectplayer.lastname#</option>
										</cfoutput>
									</cfselect>
								</div>
							</div>
							<cfinput type="hidden" name="stage" value=2>
							<cfinput type='hidden' name="method" value="edit">
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<cfinput type="Submit" name="SubmitForm" value="Select Player" class="submitbtn">	
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<a href="player.cfm">Go back to Add/Edit Player</a>
								</div>
							</div><br>

						<cfelseif isDefined("FORM.stage") AND FORM.stage is 2 AND FORM.method is 'edit'><!--- Edit a player--->
							<div class="row">
								<div class="col-sm-12">
									Edit Player
								</div>
							</div>
							<cfquery name="editplayer"
								datasource = "#APPLICATION.datasource#"
								username = "#APPLICATION.username#"
								password = "#APPLICATION.password#">
								SELECT tbPlayer.playerID, tbPlayer.firstname, tbPlayer.lastname, tbPlayer.dob, tbplayer.sex 
								FROM tbPlayer 
								WHERE tbPlayer.playerID = <cfqueryparam cfsqltype="cf_sql_num" value="#Form.playerselect#">
							</cfquery>
							<div class="row">
								<div class="col-sm-3">
									<label for="firstname">First Name: </label>
								</div>
								<div class="col-sm-3">
									<cfinput type="text" name="firstname" id="firstname" value="#editplayer.firstName#">
									<cfinput type="hidden" name="firstname_required" value="First Name is Required">
								</div>
								<div class="col-sm-6 hint" style="display:none" id="firsthint">
									First Name is Required
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="lastname">Last Name: </label>
								</div>
								<div class="col-sm-3">
									<cfinput type="text" name="lastname" id="lastname" value="#editplayer.lastName#">
									<cfinput type="hidden" name="lastname_required" value="Last Name is Required">
								</div>
								<div class="col-sm-6 hint" style="display:none" id="lasthint">
									Last Name is Required
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="dob">Date of Birth: </label>
								</div>
								<div class="col-sm-3">
									<cfset fulldob = #editplayer.dob#>
									<cfinput type="text" name="dob" id="dob" value="#Left(fulldob, 10)#">
									<cfinput type="hidden" name="dob_required" value="Date must be in form yyyy-mm-dd">
								</div>
								<div class="col-sm-6 hint" style="display:none" id="datehint">
									Date must be in form yyyy-mm-dd
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="sex">Sex: </label>
								</div>
								<div class="col-sm-3">
									<cfselect name="sex">
										<option value="M"<cfif #editplayer.sex# is 'M'>selected</cfif>>Male</optiom>
										<option value="F"<cfif #editplayer.sex# is 'F'>selected</cfif>>Female</option>
									</cfselect>
								</div>
							</div>
								<!--- Pass all the old values for the confirmation screen --->
								<cfinput type="hidden" name="stage" value=3>
								<cfinput type='hidden' name="method" value="edit">
								<cfinput type='hidden' name="playerselect" value="#FORM.playerselect#">
								<cfinput type='hidden' name="oldfirstname" value="#editplayer.firstname#">
								<cfinput type='hidden' name="oldlastname" value="#editplayer.lastname#">
								<cfinput type='hidden' name="olddob" value="#editplayer.dob#">
								<cfinput type='hidden' name="oldsex" value="#editplayer.sex#">
								
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<button type="button" name="SubmitForm" class="submitbtn" id="addsubmit">Edit Player</button>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<a href="player.cfm">Go back to Add/Edit Player</a>
								</div>
							</div><br>
						</cfif>	
					</cfform>
				</div>
			</div><br>

			<cfif isDefined("Form.stage") AND FORM.stage is 3 AND FORM.method is 'add'><!--- Add a new player to the DB --->
				<cfparam name="querycheck" default="true">
				
				<!--- Update DB --->
				<cfquery name="addPlayer"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					INSERT INTO tbPlayer (lastName, firstName, dob, sex) 
  						VALUES (<cfqueryparam cfsqltype="cf_sql_char" value="#Form.lastname#">, 
  							<cfqueryparam cfsqltype="cf_sql_char" value="#Form.firstname#">, 
  							to_date(<cfqueryparam cfsqltype="cf_sql_char" value="#Form.dob#">,'yyyy-mm-dd'), 
  							<cfqueryparam cfsqltype="cf_sql_char" value="#Form.sex#">)
				</cfquery>
				<cfquery name="confirmation"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					SELECT * FROM (SELECT * FROM tbplayer ORDER BY 1 DESC) WHERE ROWNUM=1
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
						Player: <cfoutput>#confirmation.firstname#</cfoutput> <cfoutput>#confirmation.lastname#</cfoutput><br>
						DOB: <cfoutput>#confirmation.dob#</cfoutput><br>
						Sex: <cfoutput>#confirmation.sex#</cfoutput>
					</div>
				</div>
			</cfif>
			<cfif isDefined("Form.stage") AND FORM.stage is 3 AND FORM.method is 'edit'><!--- Edit a player --->
				<cfparam name="querycheck" default="true">
				<!--- Update DB --->
				<cfquery name="addPlayer"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#"> 
					update tbPlayer 
						set firstName = <cfqueryparam cfsqltype="cf_sql_char" value="#Form.firstname#">, lastName = <cfqueryparam cfsqltype="cf_sql_number" value="#Form.lastName#">, 
						sex = <cfqueryparam cfsqltype="cf_sql_char" value="#Form.sex#">, dob =to_date(<cfqueryparam cfsqltype="cf_sql_char" value="#Form.dob#">,'yyyy-mm-dd')
						WHERE playerID = <cfqueryparam cfsqltype="cf_sql_num" value="#Form.playerselect#"> 
				</cfquery>
				<cfquery name="confirmation"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					SELECT * FROM tbPlayer where playerID = <cfqueryparam cfsqltype="cf_sql_num" value="#Form.playerselect#"> 
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
						Player: <cfoutput>#FORM.oldfirstname#</cfoutput> <cfoutput>#FORM.oldlastname#</cfoutput><br>
						DOB: <cfoutput>#FORM.olddob#</cfoutput><br>
						Sex: <cfoutput>#FORM.oldsex#</cfoutput>
					</div>
				</div>

				<div class="row textarea ps4header">
					<div class="col-sm-12">
						To:
					</div>
				</div>
				<div class="row ps4header">
					<div class="col-sm-12">
						Player: <span id="newFname"><cfoutput>#confirmation.firstname#</cfoutput></span> <span id="newLname"><cfoutput>#confirmation.lastname#</cfoutput></span><br>
						DOB: <span id="newDob"><cfoutput>#confirmation.dob#</cfoutput></span><br>
						Sex: <span id="newSex"><cfoutput>#confirmation.sex#</cfoutput></span>
					</div>
				</div>
			</cfif>
		</div> <!--container-->
		<footer>
			<div class="container">
				<cfinclude template="abps4footer.cfm">
			</div>
		</footer>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/player.js"></script>
		<script type="text/javascript" src="js/afterupdate.js"></script>
	</body>
</html>