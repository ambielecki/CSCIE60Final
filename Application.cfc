<cfcomponent output="false">

   <!--- ########## Oracle Variables ########## --->

   <cfparam name="Request.DSN" default="cscie60">
   <cfparam name="Request.username" default="abieleck">
   <cfparam name="Request.password" default="4517">

   <!--- ########## Name this application ########## --->
   
   <cfset this.name="MaldenLittleLeague">
   
   <!--- ########## Turn on Session Management ########## --->

   <cfset this.sessionManagement=true>
  
   <!--- ########## Set Application Variables ########## --->

   <cffunction name="onApplicationStart" output="false" returnType="void">
       <cfset APPLICATION.dataSource="cscie60">
       <cfset APPLICATION.username="abieleck">
       <cfset APPLICATION.password="4517">
       <cfset APPLICATION.companyName = "Malden LL">
       <cfset APPLICATION.clientmanagement="no">
       <cfset APPLICATION.sessionmanagement="yes">
       <cfset APPLICATION.setclientcookies="yes">
       <cfset APPLICATION.setdomaincookies="no">
       <cfset APPLICATION.sessiontimeout="#CreateTimeSpan(0,0,10,0)#">
       <cfset APPLICATION.applicationtimeout="#CreateTimeSpan(0,0,20,0)#">
   </cffunction>
   
   <!--- ########## Protect the whole application --->

   <cffunction name="onRequestStart" output="false" returnType="void">
      <cfinclude template="forceUserLogin.cfm">
   </cffunction>

</cfcomponent>
