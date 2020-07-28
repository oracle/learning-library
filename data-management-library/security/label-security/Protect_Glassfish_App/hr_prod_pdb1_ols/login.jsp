<%@page contentType="text/html"%>
<%
// Check if a user is logged
String oLoggedUser = (String) session.getAttribute( "logged-user" );
if ( oLoggedUser != null ) 
{
 response.sendRedirect( "index.jsp" );
 return;
}

String oError = (String) request.getParameter( "err" );
String oErrorLabel = "";
if ( oError != null )
{
 if ( oError.equals( "no_login" ) ) oErrorLabel = "Could not log user! Please verify username and password";
 if ( oError.equals( "server_error" ) ) oErrorLabel = "Error while connecting to server! Contact your administrator";
 if ( oError.equals( "no_access" ) ) oErrorLabel = "You have no access to this application! Contact your administrator";
}

// Get layout configuration
String oTemplate = application.getInitParameter( "layout.template" ) != null ? application.getInitParameter( "layout.template" ) : "default";
%>
<html>
 <head>
  <meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
  <title>HR Application</title> 
  <link rel="stylesheet" href="templates/<%= oTemplate %>/stylesheet1.css" media="screen">
  <style type="text/css" media="screen">@import url("templates/<%= oTemplate %>/stylesheet2.css");</style>
  <link rel="stylesheet" href="templates/<%= oTemplate %>/print.css" media="print">
  <link rel="shortcut icon" href="favicon.ico"/>
 </head>
 <body onload="document.forms.login.username.focus();">
  <div id="container">
   <div id="headerhome" title="HR Application">
    <div id="welcome">Welcome!</div>
    <h1>My HR Application</h1>
   </div>

   <div id="mainnav">
    <ul>
     <li><a href="index.jsp">Home</a></li>
     <li><a href="index.jsp">Help</a></li>
     <li><a href="index.jsp">About</a></li>
     <li><a href="login.jsp">Login</a></li>
     <!-- li><a href="controller.jsp?action=logout">Logout</a></li -->
    </ul>
   </div>

   <% 
   if ( oLoggedUser != null ) 
   {
   %>
   <div id="menu">
    <h3>Employees</h3>
    <ul>
     <li><a href="search.jsp">Search Employees</a></li>
     <li><a href="employee_create.jsp">New Employee</a></li>
    </ul>
    <h3>Absence And Attendance</h3>
    <ul>
     <li><a href="#">Timesheets</a></li>
     <li><a href="#">Vacation</a></li>
    </ul>
   </div>
   <%
   }
   else
   {
   %>
   <div id="menu">
    <h3>Welcome!</h3>
    <p>Stay in the know about upcoming changes to the DPS Human Resources and Payroll systems. <a href="#">Click here</a> to learn how these changes will impact you, get answers to your questions, and find tools and resources to prepare you for the changes.<a href="#">READ MORE</a></p>
   </div>
   <%
   }
   %>

   <div id="content">
    <div id="minheight"></div>
    <h2>My HR Application</h2>
    <p>Welcome to My HR Application! Please provide your username and password to login.</p>

    <div id="error_box" style="color: red; font-weight: bold;">
     <%= oErrorLabel %>
    </div>

    <div id="login">
     <script>
      function checkForm()
      {
       var form = document.forms.login;
       if ( form.username.value == "" )
       {
        alert( "Please provide a username!" );
        form.username.focus();
        return false;
       }
       if ( form.password.value == "" )
       {
        alert( "Please provide a password!" );
        form.password.focus();
        return false;
       }
       return true;
       
      }
     </script>
     <form name="login" method="post" action="controller.jsp" onsubmit="return checkForm();">
      <input type="hidden" name="action" value="login"/>
      <table cellpadding="3" cellspacing="2">
       <tr><th>Username</th><td><input style="width: 200px;" type="text" name="username"/></td></tr>
       <tr><th>Password</th><td><input style="width: 200px;" type="password" name="password"/></td></tr>
      </table>
      <div class="buttonbar"><input type="submit" value="Login"/></div>
     </form>
    </div>
   </div>
   
   <div id="footer">
    <a href="index.jsp">My HR Application</a> | <a href="#">My Intranet</a> | <a href="#">My Self-Service</a><br/>
    Copyright &copy; My HR Application 2008
   </div>
  </div>
 </body>
</html>
