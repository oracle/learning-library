<%@page contentType="text/html"%>
<%@page import ="java.sql.*"%>
<%@page import ="java.util.*"%>

<%
// Check if a user is logged
String oLoggedUser = (String) session.getAttribute( "logged-user" );

// Retrieve logged user informations
String oLoggedUserFirstName  = (String)  session.getAttribute( "logged-user-firstname" );
String oLoggedUserLastName   = (String)  session.getAttribute( "logged-user-lastname" );
ArrayList oRoles = (ArrayList) session.getAttribute( "logged-user-privileges" );

// Retrieve filter parameters
String oFilterUserID   = request.getParameter( "userid" )   != null ? (String) request.getParameter( "userid" )  : "";
String oFilterEmpType   = request.getParameter( "emptype" )  != null ? (String) request.getParameter( "emptype" )  : "";
String oFilterUsername   = request.getParameter( "username" )  != null ? (String) request.getParameter( "username" )  : "";
String oFilterFirstName  = request.getParameter( "firstname" )  != null ? (String) request.getParameter( "firstname" )  : "";
String oFilterLastName   = request.getParameter( "lastname" )  != null ? (String) request.getParameter( "lastname" )  : "";
String oFilterDepartment  = request.getParameter( "department" ) != null ? (String) request.getParameter( "department" ) : "";
String oFilterPosition   = request.getParameter( "position" )  != null ? (String) request.getParameter( "position" )  : "";

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
 <body>
  <div id="container">
   <div id="headerhome" title="HR Application">
    <div id="welcome"><a href="session_data.jsp">Welcome<% if ( oLoggedUser != null ) { out.print( " " + oLoggedUserFirstName + " " + oLoggedUserLastName ); } %></a>!
   <% if ( oRoles != null ) { %><br/>Privileges: <%= oRoles %><% } %>
    </div>
   <h1>My HR Application</h1>
  </div>

   <div id="mainnav">
    <ul>
     <li><a href="index.jsp">Home</a></li>
     <li><a href="index.jsp">Help</a></li>
     <li><a href="index.jsp">About</a></li>
     <li>
      <% if ( oLoggedUser != null ) { %><a href="controller.jsp?action=logout">Logout</a><% }
         else { %><a href="login.jsp">Login</a><% } %>
     </li> 
    </ul>
   </div>

   <% 
   if ( oLoggedUser != null ) 
   {
   %>
   <div id="menu">
    <h3>Employees</h3>
    <ul>
     <% if ( oRoles.contains( "SELECT" ) ) { %><li><a href="search.jsp">Search Employees</a></li><% } %>
     <% if ( oRoles.contains( "INSERT" ) ) { %><li><a href="employee_create.jsp">New Employee</a></li><% } %>
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
    <p>Stay in the know about upcoming changes to the DPS Human Resources and Payroll systems. <a href=#">Click here </a>to learn how these changes will impact you, get answers to your questions, and find tools and resources to prepare you for the changes.<a href="#">READ MORE</a></p>
   </div>
   <%
   }
   %>
   
   <div id="content">
    <div id="minheight"></div>
    <div class="entry">
     <h2><a href="#" title="Permanent link to this item">Latest Employee News</a></h2>
     <h3><%=new java.util.Date() %></h3>
     <p>
      <img class="imagefloat" src="images/image.png" alt="" width="100" height="100" border="0">
      During the summer months, hourly employees may continue benefit coverage by paying their premium portion either by working enough hours through the summer to cover premium costs or by paying through the summer coupon program. They also have the option to waive (drop) their insurance coverage through the summer.<a href="#">READ MORE</a>
     </p>
     <p>
      We want to let you know that beginning August 1, 2011, MyHRApp is changing the number of days allowed for doctors in the MyHRApp network to submit medical and behavioral claims for payment.  MyHRApp is advising them that they must submit claims within 90 days of the date of service.  Any claims received by MyHRApp on or after August 1 will be subject to the 90 day limit. <a href="#">READ MORE</a>
     </p>

     <ul>
      <li><a href="#">Comments (4)</a></li>
     </ul>
    </div>
   </div>
   
   <div id="footer">
    <a href="index.jsp">My HR Application</a> | <a href="#">My Intranet</a> | <a href="#">My Self-Service</a><br/>
    Copyright &copy; My HR Application 2008
   </div>
   
  </div>
 </body>
</html>
