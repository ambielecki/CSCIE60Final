<!--- ########## Heading ########## --->
<div class="row bg-blue-gradient">
	<div class="col-sm-12 centered">
		<h1><a href="http://cscie60.dce.harvard.edu/~abieleck/final.cfm">Malden Little League</a></h1>
	</div>
</div>
<cfif NOT GetAuthUser() is "">
	<div class="row blueheader">
		<div class="pull-right">
			<h4>
				<a href="logout.cfm">Hello <cfoutput>#GetAuthUser()#</cfoutput> / Logout</a>
			</h4>
		</div>
	</div><br>
</cfif>
