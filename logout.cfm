<html>
  <head>
    <title>Logout</title>
  </head>

  <body>
    <cflogout>

    <cfcookie name="userview" expires="now">
    <a href="login.cfm">Click here to return to the login page if you are not redirected.</a>
    <script>window.location = "login.cfm";</script>
  </body>
</html>