<!--- ### File adapted from Forta & Camdem --->
<!--- Code borrowed liberally from class--->

<!--- Force the user to log in --->
<!--- ### Code only executes if the user has not logged in ### --->
<!--- Code is skipped once the user is logged in via cfloginuser> --->
<cflogin>

  <!--- If the user hasn't gotten the login form yet, display it --->
  <cfif not (isDefined("FORM.userLogin") and isDefined("FORM.userPassword"))>
    <cfinclude template="login.cfm">
    <cfabort>

    <!--- Otherwise, the user is submitting the login form --->
    <!--- Code evaluates whether the username and password are valid --->
  <cfelse>

    <!--- Find record with this Username/Password --->
    <!--- If no rows returned, password not valid --->
    <cfquery name="getUser"
      datasource="#APPLICATION.dataSource#"
      password="#APPLICATION.password#"
      username="#APPLICATION.username#">
      select *
      from tblogin
      where uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.UserLogin#">
      and pwd = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.UserPassword#">
    </cfquery>

    <!--- If the username and password are correct... --->
    <cfif getUser.recordCount EQ 1>
      <!--- Tell ColdFusion to consider the user "logged in" --->
      <!--- NAME may be retrieved via GetAuthUser() --->
      <cfloginuser
      name="#getUser.fname#"
      password="#FORM.userPassword#"
      roles="#getUser.userview#">

      <cfcookie name="userview" value="#getUser.userview#">

      <!--- Otherwise, re-prompt for a valid username and password --->
    <cfelse>
      <cfinclude template="login.cfm">
      <div class="container">
        <div class="row ps4header">
          <div class="col-sm-12">
            <h4>The username/password combination is not recognized. Please try again.</h4>
          </div>  
        </div><br>
      </div>

      <cfabort>
    </cfif>
  </cfif>
</cflogin>

