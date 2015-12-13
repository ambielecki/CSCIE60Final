<html>
	<head>
	  <title>Add/Edit Adults</title>
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
			<!--- Using both JS and CF validation --->
			<noscript class="textarea">JavaScript is Required for Form Validation</noscript>

			<div class="row ps4header">
				<div class="col-sm-12">
					<h2><a href="adult.cfm">Add Adult</a></h2>
				</div>	
			</div><br>

			<div class="row">
				<div class="col-sm-12">
					<!--- Begin form, self posting --->
					<cfform class="ps4form" action="adult.cfm" method="post">
						<div class="row">
								<div class="col-sm-12">
									Add Adult
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
									<label for="address">Address: </label>
								</div>
								<div class="col-sm-3">
									<cfinput type="text" name="address" id="address">
									<cfinput type="hidden" name="address_required" value="Address Required">
								</div>
								<div class="col-sm-6 hint" style="display:none" id="addresshint">
									Address Required
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="address">Phone: </label>
								</div>
								<div class="col-sm-3">
									<cfinput type="text" name="phone" id="phone" placeholder="xxx-xxx-xxxx">
									<cfinput type="hidden" name="phone_required" value="Phone Number Required in format xxx-xxx-xxxx">
									<cfinput type="hidden" name="phone_cfformtelephone" value="Phone Number Required in format xxx-xxx-xxxx">
								</div>
								<div class="col-sm-6 hint" style="display:none" id="phonehint">
									Phone Number Required in format xxx-xxx-xxxx
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3">
									<label for="address">Email: </label>
								</div>
								<div class="col-sm-3">
									<cfinput type="text" name="email" id="email">
									<cfinput type="hidden" name="email_required" value="Valid Email Address Required">
									<cfinput type="hidden" name="email_cfformemail" value="Valid Email Address Required">
								</div>
								<div class="col-sm-6 hint" style="display:none" id="emailhint">
									Valid Email Address Required
								</div>
							</div>
								<cfinput type="hidden" name="stage" value=3>
								<cfinput type='hidden' name="method" value="add">
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<cfinput type="Submit" name="SubmitForm" value="Add Adult" class="submitbtn" id="addsubmit">	
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<a href="adult.cfm">Go back to Add Adult</a>
								</div>
							</div><br>
					</cfform>
				</div>
			</div>
			<cfif isDefined("Form.stage") AND FORM.stage is 3 AND FORM.method is 'add'>
				<cfparam name="querycheck" default="true">
				
				<!--- Update DB --->
				<cfquery name="addPlayer"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					INSERT INTO tbAdult (lastName, firstName, address, phone, email) 
  						VALUES (<cfqueryparam cfsqltype="cf_sql_char" value="#Form.lastname#">, 
  							<cfqueryparam cfsqltype="cf_sql_char" value="#Form.firstname#">, 
  							<cfqueryparam cfsqltype="cf_sql_char" value="#Form.address#">, 
  							<cfqueryparam cfsqltype="cf_sql_char" value="#Form.phone#">,
  							<cfqueryparam cfsqltype="cf_sql_char" value="#Form.email#">)
				</cfquery>
				<cfquery name="confirmation"
					datasource = "#APPLICATION.datasource#"
					username = "#APPLICATION.username#"
					password = "#APPLICATION.password#">
					SELECT * FROM (SELECT * FROM tbAdult ORDER BY 1 DESC) WHERE ROWNUM=1
				</cfquery>

				<div class="row ps4header">
					<div class="col-sm-12">
						<h2>Confirmation</h2>
					</div>	
				</div><br>

				<div class="row textarea">
					<div class="col-sm-12">
						You have successfully added:
					</div>
				</div>
				<div class="row textarea">
					<div class="col-sm-12">
						Player: <cfoutput>#confirmation.firstname#</cfoutput> <cfoutput>#confirmation.lastname#</cfoutput><br>
						Address: <cfoutput>#confirmation.address#</cfoutput><br>
						Phone: <cfoutput>#confirmation.phone#</cfoutput><br>
						Email: <cfoutput>#confirmation.email#</cfoutput>
					</div>
				</div>
			</cfif>

		</div><!-- Container -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/adult.js"></script>
		<footer>
			<div class="container">
				<cfinclude template="abps4footer.cfm">
			</div>
		</footer>
	</body>
</html>