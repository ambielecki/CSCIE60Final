<!--- Use cfsetting to block output of HTML  
outside cfoutput tags. ---> 
<cfsetting enablecfoutputonly="Yes"> 
 
<!--- Get employee info. ---> 
<cfquery name="GetEmps" 
    datasource = "#APPLICATION.datasource#"
    username = "#APPLICATION.username#"
    password = "#APPLICATION.password#"> 
    SELECT * FROM tbAdult 
</cfquery> 
 
<!--- Set content type. ---> 
<cfcontent type="application/msexcel"> 
 
<!--- Suggest default name for XLS file. ---> 
<!--- "Content-Disposition" in cfheader also ensures  
relatively correct Internet Explorer behavior. ---> 
<cfheader name="Content-Disposition" value="filename=Employees.xls"> 
 
<!--- Format data using cfoutput and a table.  
        Excel converts the table to a spreadsheet. 
        The cfoutput tags around the table tags force output of the HTML when 
        using cfsetting enablecfoutputonly="Yes" ---> 
<cfoutput> 
    <table cols="4">
    <tr>
        <td>Get Employees</dt>
        <td></dt>
        <td></dt>
    <tr>
    <tr> 
        <td>First Name</td> 
        <td>Last Name</td> 
        <td>Email Address</td> 
    </tr>   
        <cfloop query="GetEmps"> 
            <tr> 
                <td>#AdultID#</td> 
                <td>#Email#</td> 
                <td>#Phone#</td> 
            </tr> 
        </cfloop> 
    </table> 
</cfoutput>