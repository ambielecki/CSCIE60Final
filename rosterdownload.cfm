<!--- Method and format from http://help.adobe.com/en_US/ColdFusion/9.0/Developing/WSc3ff6d0ea77859461172e0811cbec1553c-7feb.html --->

<!--- Use cfsetting to block output of HTML  
outside cfoutput tags. ---> 
<cfif isDefined("Form.year")>

    <cfsetting enablecfoutputonly="Yes"> 
     
    <!--- Get report info. ---> 

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
     
    <!--- Set content type. ---> 
    <cfcontent type="application/msexcel"> 
     
    <!--- Suggest default name for XLS file. ---> 
    <!--- "Content-Disposition" in cfheader also ensures  
    relatively correct Internet Explorer behavior. ---> 
    <cfheader name="Content-Disposition" value="filename=Roster.xls"> 
     
    <!--- Format data using cfoutput and a table.  
            Excel converts the table to a spreadsheet. 
            The cfoutput tags around the table tags force output of the HTML when 
            using cfsetting enablecfoutputonly="Yes" ---> 
    <cfoutput> 
        <table cols="5">
            <tr>
                <td>
                    #FORM.year# #getRoster.teamName# Roster
                </td>
                <td></td>
                <td></td>
            <tr>
            <tr> 
                <td>First Name</td> 
                <td>Last Name</td> 
            </tr>  
            <cfloop query="getRoster"> 
                <tr> 
                    <td>#firstname#</td> 
                    <td>#lastName#</td> 
                </tr> 
            </cfloop> 
        </table> 
    </cfoutput>
<cfelse>
     <html>
        <head>
          <title>Inaccessible</title>
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
                        <h2>The Page You Have Requested Is Unavailable</h2>
                    </div>  
                </div><br>
                <div class="row">
                    <div class="col-sm-12">
                        <a href="final.cfm">Click here to return to the homepage</a>
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
</cfif>
    