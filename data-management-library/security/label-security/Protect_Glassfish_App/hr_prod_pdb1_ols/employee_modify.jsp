<%@page import="java.io.InputStream"%>
<%@page contentType="text/html"%>
<%@page import ="java.sql.*"%>
<%@page import ="java.util.*"%>

<%
ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
InputStream propertiesFile = classLoader.getResourceAsStream("hr.properties");

if (propertiesFile == null) {
    throw new NullPointerException("Properties file 'hr.properties' is missing in classpath.");
}

Properties properties = new Properties();
properties.load(propertiesFile); // Handle IOException.

String oJDBCDriver = properties.getProperty("oJDBCDriver");
String oJDBCURL = properties.getProperty("oJDBCURL");
String oJDBCUser = properties.getProperty("oJDBCUser");
String oJDBCPassword = properties.getProperty("oJDBCPassword");

// Check if a user is logged
String oLoggedUser = (String) session.getAttribute( "logged-user" );
if ( oLoggedUser == null ) { response.sendRedirect( "login.jsp" ); return; }

// Retrieve logged user informations
String oLoggedUserFirstName  = (String) session.getAttribute( "logged-user-firstname" );
String oLoggedUserLastName   = (String) session.getAttribute( "logged-user-lastname" );

// String oUsername = (String) request.getParameter( "username" );
// String oPassword = (String) request.getParameter( "password" );

ArrayList oRoles = (ArrayList) session.getAttribute( "logged-user-privileges" );

// Check rights
if ( !oRoles.contains( "UPDATE" ) ) { response.sendRedirect( "index.jsp?err=no_privilege&needed_privilege=UPDATE" ); return; }

// Retrieve user ID
String oFilterUserID   = request.getParameter( "userid" )   != null ? (String) request.getParameter( "userid" )  : "";

// Get layout configuration
String  oTemplate   = application.getInitParameter( "layout.template" )   != null ? application.getInitParameter( "layout.template" )                  : "default";
boolean oDisplayTab = application.getInitParameter( "layout.displaytab" ) != null ? application.getInitParameter( "layout.displaytab" ).equals("true") : true;

// Retrieve user profile
int    oUserID = 0;
String oFirstName = "";
String oLastName = "";
String oEmail = "";
String oPhoneMobile = "";
String oPhoneFix = "";
String oPhoneFax = "";
String oEmpType = "";
String oPosition = "";
String oLocation = "";
int    oIsManager = 0;
int    oManagerID = 0;
String oCostCenter = "";
String oDepartment = "";
int    oIsHeadOfDepartment = 0;
String oOrganization = "";
java.util.Date oStartDate = null;
java.util.Date oEndDate = null;
String oStartDateStr = "";
String oEndDateStr = "";
int oActive = 0;
String oManagerFirstName = "";
String oManagerLastName = "";
int oManagerUserID = 0;
if (   !oFilterUserID.equals( "" ) )
{
 try
 {
  Class.forName( oJDBCDriver );
  Connection conn = DriverManager.getConnection( oJDBCURL, oJDBCUser, oJDBCPassword );
 
 System.out.println ("********* EMPLOYEE_MODIFY.JSP ************");
 CallableStatement stmt2 = null;
 String sql = "{call employeesearch_prod.set_app_user_label ( ? )}";
 stmt2 = conn.prepareCall(sql);
 stmt2.setString (1, oLoggedUser);
 stmt2.executeQuery();

 System.out.println (oLoggedUser);
 System.out.println( sql );

  Statement stmt = conn.createStatement();
  
  // Prepare query using filter parameters
  String oQuery = "select a.USERID, a.FIRSTNAME, a.LASTNAME, a.EMAIL, a.PHONEMOBILE, a.PHONEFIX, a.PHONEFAX, "
   + "a.EMPTYPE, a.POSITION, a.LOCATION, a.ISMANAGER, a.MANAGERID, a.DEPARTMENT, a.ORGANIZATION, a.STARTDATE, a.ENDDATE, a.ACTIVE, "
   + "a.COSTCENTER, a.ISHEADOFDEPARTMENT, b.FIRSTNAME as MGR_FIRSTNAME, b.LASTNAME as MGR_LASTNAME, b.USERID as MGR_USERID "
   + "from DEMO_HR_EMPLOYEES a left outer join DEMO_HR_EMPLOYEES b on a.MANAGERID = b.USERID where a.USERID = " + oFilterUserID + " ";

  // Execute query and display results
  ResultSet rs = stmt.executeQuery( oQuery );
  boolean oUserFound = false;
  if (rs.next())
  {
   oUserFound = true;
   oUserID = rs.getInt("USERID");
   oFirstName = rs.getString("FIRSTNAME") != null ? rs.getString("FIRSTNAME") : "";
   oLastName = rs.getString("LASTNAME") != null ? rs.getString("LASTNAME") : "";
   oEmail = rs.getString("EMAIL") != null ? rs.getString("EMAIL") : "";
   oPhoneMobile = rs.getString("PHONEMOBILE") != null ? rs.getString("PHONEMOBILE") : "";
   oPhoneFix = rs.getString("PHONEFIX") != null ? rs.getString("PHONEFIX") : "";
   oPhoneFax = rs.getString("PHONEFAX") != null ? rs.getString("PHONEFAX") : "";
   oEmpType = rs.getString("EMPTYPE") != null ? rs.getString("EMPTYPE") : "";
   oPosition = rs.getString("POSITION") != null ? rs.getString("POSITION") : "";
   oLocation = rs.getString("LOCATION") != null ? rs.getString("LOCATION") : "";
   oIsManager = rs.getInt("ISMANAGER");
   oManagerID = rs.getInt("MANAGERID");
   oCostCenter = rs.getString("COSTCENTER") != null ? rs.getString("COSTCENTER") : "";
   oDepartment = rs.getString("DEPARTMENT") != null ? rs.getString("DEPARTMENT") : "";
   oIsHeadOfDepartment = rs.getInt("ISHEADOFDEPARTMENT");
   oOrganization = rs.getString("ORGANIZATION") != null ? rs.getString("ORGANIZATION") : ""; 
   oStartDate = rs.getDate("STARTDATE");
   oEndDate = rs.getDate("ENDDATE");
   oActive = rs.getInt("ACTIVE");
   oManagerFirstName = rs.getString("MGR_FIRSTNAME") != null ? rs.getString("MGR_FIRSTNAME") : "";
   oManagerLastName = rs.getString("MGR_LASTNAME") != null ? rs.getString("MGR_LASTNAME") : "";
   oManagerUserID = rs.getInt("MGR_USERID");

   oStartDateStr = oStartDate != null ? oStartDate.toString() : "";
   oEndDateStr = oEndDate != null ? oEndDate.toString() : "";
  }
  
  if ( !oUserFound )
  {
   response.sendRedirect( "search.jsp?err=invalid_userid" );
  }
   
  stmt.close();
 }
 catch(Exception e)
 {
  e.printStackTrace();
  out.println( e );
 }
}
else
{
 response.sendRedirect( "search.jsp?err=invalid_userid" );
}
%>
<html>
 <head>
  <meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
  <title>HR Application</title> 
  <link rel="stylesheet" href="templates/<%= oTemplate %>/stylesheet1.css" media="screen">
  <style type="text/css" media="screen">@import url("templates/<%= oTemplate %>/stylesheet2.css");</style>
  <link rel="stylesheet" href="templates/<%= oTemplate %>/print.css" media="print">

  <script type="text/javascript" src="js/hr.js"></script>

  <script type="text/javascript" src="js/tabber.js"></script>
  <% if ( oDisplayTab ) { %>
   <link rel="stylesheet" href="css/example.css" TYPE="text/css" MEDIA="screen">
   <link rel="stylesheet" href="css/example-print.css" TYPE="text/css" MEDIA="print">
  <% } %>

  <link rel="shortcut icon" href="favicon.ico"/>

  <script type="text/javascript">
   document.write('<style type="text/css">.tabber{display:none;}<\/style>');
  </script>

  <script language="javascript" src="js/CalendarPopup.js"></script>
  <script language="javascript">document.write(getCalendarStyles());</script>
 </head>
 <body>
  <div id="pre-container">
  </div>
  <div id="container"> 
   <div id="header" title="HR Application">
    <div id="welcome">
      <a href="session_data.jsp">Welcome <%= oLoggedUserFirstName %> <%= oLoggedUserLastName %>!</a>
       <br/>Privileges: <%= oRoles %>
    </div>
    <h1>My HR Application</h1>
   </div>
  
   <div id="mainnav">
    <ul>
     <li><a href="index.jsp">Home</a></li>
     <li><a href="index.jsp">Help</a></li>
     <li><a href="index.jsp">About</a></li>
     <li><a href="controller.jsp?action=logout">Logout</a></li>
    </ul>
   </div>

   <div id="menu">
    <h3>Employees</h3>
    <ul>
     <% if ( oRoles.contains( "SELECT" ) ) { %><li><a href="search.jsp">Search Employees</a></li><% } %>
     <% if ( oRoles.contains( "INSERT" ) ) {%><li><a href="employee_create.jsp">New Employee</a></li><% } %>
    </ul>
    <h3>Absence And Attendance</h3>
    <ul>
     <li><a href="#">Timesheets</a></li>
     <li><a href="#">Vacation</a></li>
    </ul>
   </div>

   <div id="content">
    <div id="minheight"></div>
    <div id="employee_modify_details">
     <form name="employee_modify" method="post" action="controller.jsp" onsubmit="return checkEmployeeForm( this );">
      <h2>Modify Employee</h2>
      <input type="hidden" name="action" value="employee_modify"/>
      <div class="tabber" id="tabemployee">

        <div id="tabidentity" class="tabbertab" style="overflow: auto;">
        <h2>Identity</h2>
        <table cellpadding="3" cellspacing="2" border="0">
         <tr><th>HR ID</th><td><input type="hidden" name="userid" value="<%= oUserID %>"/><%= oUserID %></td></tr>
         <tr><th>First Name<span style="color:red;">*</span></th><td><input type="text" name="firstname" value="<%= oFirstName %>"/></td></tr>
         <tr><th>Last Name<span style="color:red;">*</span></td><td><input type="text" name="lastname" value="<%= oLastName %>"/></td></tr>
         <tr><th>Employee Type<span style="color:red;">*</span></th>
          <td>
           <select name="emptype">
            <option value="">-- Choose a value --</option>
            <option value="Part-Time" <% if ( oEmpType.equals( "Part-Time" ) ) out.print( "selected=\"selected\"" ); %>>Part-Time Employee</option>
            <option value="Full-Time" <% if ( oEmpType.equals( "Full-Time" ) ) out.print( "selected=\"selected\"" ); %>>Full-Time Employee</option>
           </select>
          </td>
         </tr>
         <tr>
          <th>Position<span style="color:red;">*</span></th>
          <td>
           <select name="position">
            <option value="Administrator I" <% if ( oPosition.equals( "Administrator I" ) ) out.print( "selected=\"selected\"" ); %>>Administrator I</option>
            <option value="DBA" <% if ( oPosition.equals( "DBA" ) ) out.print( "selected=\"selected\"" ); %>>DBA</option>
            <option value="Project Director" <% if ( oPosition.equals( "Project Director" ) ) out.print( "selected=\"selected\"" ); %>>Project Director</option>
            <option value="Project Manager" <% if ( oPosition.equals( "Project Manager" ) ) out.print( "selected=\"selected\"" ); %>>Project Manager</option>
            <option value="Documentation Clerk" <% if ( oPosition.equals( "Documentation Clerk" ) ) out.print( "selected=\"selected\"" ); %>>Documentation Clerk</option>
            <option value="Teller" <% if ( oPosition.equals( "Teller" ) ) out.print( "selected=\"selected\"" ); %>>Teller</option>
            <option value="Benefits Analyst" <% if ( oPosition.equals( "Benefits Analyst" ) ) out.print( "selected=\"selected\"" ); %>>Benefits Analyst</option>
            <option value="Development Manager" <% if ( oPosition.equals( "Development Manager" ) ) out.print( "selected=\"selected\"" ); %>>Development Manager</option>
            <option value="District Manager" <% if ( oPosition.equals( "District Manager" ) ) out.print( "selected=\"selected\"" ); %>>District Manager</option>
            <option value="HR Liason" <% if ( oPosition.equals( "HR Liason" ) ) out.print( "selected=\"selected\"" ); %>>HR Liason</option>
            <option value="Marketing Intern" <% if ( oPosition.equals( "Marketing Intern" ) ) out.print( "selected=\"selected\"" ); %>>Marketing Intern</option>
            <option value="QA Manager" <% if ( oPosition.equals( "QA Manager" ) ) out.print( "selected=\"selected\"" ); %>>QA Manager</option>
            <option value="Sales Consultant" <% if ( oPosition.equals( "Sales Consultant" ) ) out.print( "selected=\"selected\"" ); %>>Sales Consultant</option>
            <option value="Sales Coordinator" <% if ( oPosition.equals( "Sales Coordinator" ) ) out.print( "selected=\"selected\"" ); %>>Sales Coordinator</option>
            <option value="Sales Representative" <% if ( oPosition.equals( "Sales Representative" ) ) out.print( "selected=\"selected\"" ); %>>Sales Representative</option>
            <option value="Software Engineer" <% if ( oPosition.equals( "Software Engineer" ) ) out.print( "selected=\"selected\"" ); %>>Software Engineer</option>
           </select>
          </td>
         </tr>
          <th>Location<span style="color:red;">*</span></th>
          <td>
           <select name="location">

            <option value="Toronto" <% if ( oLocation.equals( "Toronto" ) ) out.print( "selected=\"selected\"" ); %>>Toronto</option>
            <option value="Santa Clara" <% if ( oLocation.equals( "Santa Clara" ) ) out.print( "selected=\"selected\"" ); %>>Santa Clara</option>
            <option value="Sunnyvale" <% if ( oLocation.equals( "Sunnyvale" ) ) out.print( "selected=\"selected\"" ); %>>Sunnyvale</option>
            <option value="San Mateo" <% if ( oLocation.equals( "San Mateo" ) ) out.print( "selected=\"selected\"" ); %>>San Mateo</option>
            <option value="El Segundo" <% if ( oLocation.equals( "El Segundo" ) ) out.print( "selected=\"selected\"" ); %>>El Segundo</option>
            <option value="Costa Mesa" <% if ( oLocation.equals( "Costa Mesa" ) ) out.print( "selected=\"selected\"" ); %>>Costa Mesa</option>
            <option value="Encino" <% if ( oLocation.equals( "Encino" ) ) out.print( "selected=\"selected\"" ); %>>Encino</option>
            <option value="Dallas" <% if ( oLocation.equals( "Dallas" ) ) out.print( "selected=\"selected\"" ); %>>Dallas</option>
            <option value="Chicago" <% if ( oLocation.equals( "Chicago" ) ) out.print( "selected=\"selected\"" ); %>>Chicago</option>
            <option value="New York" <% if ( oLocation.equals( "New York" ) ) out.print( "selected=\"selected\"" ); %>>New York</option>
            <option value="Cambridge" <% if ( oLocation.equals( "Cambridge" ) ) out.print( "selected=\"selected\"" ); %>>Cambridge</option>
           </select>
          </td>
          <tr><th>Active<span style="color:red;">*</span></th>
          <td>
           <select name="active">
            <option value="">-- Choose a value --</option>
            <option value="0" <% if ( oActive == 0 ) out.println( "selected=\"selected\"" ); %>>No, Inactive</option>
            <option value="1" <% if ( oActive == 1 ) out.println( "selected=\"selected\"" ); %>>Yes, Active</option>
           </select>
          </td>
         </tr>
        </table>
       </div>

        <div id="taborganization" class="tabbertab" style="overflow: auto;">
        <h2>Organization</h2>
        <table cellpadding="3" cellspacing="2" border="0">
         <tr><th>Is Manager?<span style="color:red;">*</span></th>
          <td>
           <select name="ismanager">
            <option value="">-- Choose a value --</option>
            <option value="0" <% if ( oIsManager == 0 ) out.println( "selected=\"selected\"" ); %>>No</option>
            <option value="1" <% if ( oIsManager == 1 ) out.println( "selected=\"selected\"" ); %>>Yes, Manager</option>
           </select>
          </td>
         </tr>
         <tr><th>Manager<span style="color:red;">*</span></th>
          <td>
           <select name="managerid">
            <option value="">-- Choose a value --</option>
            <%
             if ( oManagerID == 0 ) 
             { %>
              <option value="0" selected="selected">-- None --</option>
             <%
             }
            %>
            <%
            // Retrieve managers list
            try
            {
            
             Class.forName( oJDBCDriver );
             Connection conn = DriverManager.getConnection( oJDBCURL, oJDBCUser, oJDBCPassword );

             Statement stmt = conn.createStatement();
             
             String oQuery = "select a.USERID, a.FIRSTNAME, a.LASTNAME from DEMO_HR_EMPLOYEES a where a.ISMANAGER = 1 and a.ACTIVE = 1 order by a.LASTNAME, a.FIRSTNAME";
             
             // Execute query and display results
             ResultSet rs = stmt.executeQuery( oQuery );
             while (rs.next())
             {
              int    oMUserID = rs.getInt(1);
              String oMFirstName = rs.getString(2);
              String oMLastName = rs.getString(3);
              out.print( "<option value=\"" + oMUserID + "\"" );
              if ( oManagerID == oMUserID ) out.print( " selected=\"selected" );
              out.println( "\">" + oMLastName + ", " + oMFirstName + "</option>" );
             }
              
             stmt.close();
            }
            catch(Exception e)
            {
             e.printStackTrace();
             out.println( e );
            }
            %>
           </select>
           <!-- input type="text" name="managerid" value="<%= oManagerID %>" readonlyy="readonly"/ -->
           <!-- input type="text" name="managerfullname" value="<%= oManagerFirstName + " " + oManagerLastName %>" readonly="readonly"/> <a href="#">change</a -->
          </td>
         </tr>
         <tr><th>Cost Center<span style="color:red;">*</span></th>
          <td>
           <select name="costcenter">
            <option value="101" <% if ( oCostCenter.equals( "101" ) ) out.print( "selected=\"selected\"" ); %>>101 - Cost Center 101</option>
            <option value="102" <% if ( oCostCenter.equals( "102" ) ) out.print( "selected=\"selected\"" ); %>>101 - Cost Center 102</option>
           </select>
          </td>
         </tr>
         <tr>
          <th>Department<span style="color:red;">*</span></th>
          <td>
           <select name="department">
            <option value="Corporate" <% if ( oDepartment.equals( "Corporate" ) ) out.print( "selected=\"selected\"" ); %>>Corporate</option>
            <option value="Engineering" <% if ( oDepartment.equals( "Engineering" ) ) out.print( "selected=\"selected\"" ); %>>Engineering</option>
            <option value="Global IT" <% if ( oDepartment.equals( "Global IT" ) ) out.print( "selected=\"selected\"" ); %>>Global IT</option>
            <option value="Marketing" <% if ( oDepartment.equals( "Marketing" ) ) out.print( "selected=\"selected\"" ); %>>Marketing</option>
            <option value="QA" <% if ( oDepartment.equals( "QA" ) ) out.print( "selected=\"selected\"" ); %>>QA</option>
            <option value="Sales" <% if ( oDepartment.equals( "Sales" ) ) out.print( "selected=\"selected\"" ); %>>Sales</option>
           </select>
          </td>
         </tr>
         <tr><th>Is Head of Department?<span style="color:red;">*</span></th>
          <td>
           <select name="isheadofdepartment">
            <option value="">-- Choose a value --</option>
            <option value="0" <% if ( oIsHeadOfDepartment == 0 ) out.println( "selected=\"selected\"" ); %>>No</option>
            <option value="1" <% if ( oIsHeadOfDepartment == 1 ) out.println( "selected=\"selected\"" ); %>>Yes, Head of Department</option>
           </select>
          </td>
         </tr>
         <tr>
          <th>Organization<span style="color:red;">*</span></th>
          <td>
           <select name="organization">
            <option value="Xellerate Users" <% if ( oOrganization.equals( "Xellerate Users" ) ) out.print( "selected=\"selected\"" ); %>>Corporate</option>
           </select>
          </td>
         </tr>
         <tr><th>Start Date<span style="color:red;">*</span></th>
          <td>
           <script language="javascript">
            var cal1x = new CalendarPopup("testdiv1");
            cal1x.showNavigationDropdowns();
           </script>
           <input type="text" name="startdate" value="<%= oStartDateStr %>" readonly="readonly" style="color: #666;"/><a href="#" onclick="cal1x.select(document.forms[0].startdate,'anchor1x','yyyy-MM-dd'); return false;" TITLE="cal1x.select(document.forms[0].startdate,'anchor1x','yyyy-MM-dd'); return false;" NAME="anchor1x" ID="anchor1x"><img src="images/icon_calendar.gif" width="16" height="16" border="0" align="top"/></a><a href="#" onclick="document.forms[0].startdate.value = '';"><img src="images/icon_delete.gif" width="16" height="16" border="0" align="top"/></a>
          </td>
         </tr>
         <tr><th>End Date</th>
          <td>
           <script language="javascript">
            var cal2x = new CalendarPopup("testdiv1");
            cal2x.showNavigationDropdowns();
           </script>
           <input type="text" name="enddate" value="<%= oEndDateStr %>" readonly="readonly" style="color: #666;"/><a href="#" onclick="cal2x.select(document.forms[0].enddate,'anchor2x','yyyy-MM-dd'); return false;" TITLE="cal2x.select(document.forms[0].enddate,'anchor2x','yyyy-MM-dd'); return false;" NAME="anchor2x" ID="anchor2x"><img src="images/icon_calendar.gif" width="16" height="16" border="0" align="top"/></a><a href="#" onclick="document.forms[0].enddate.value = '';"><img src="images/icon_delete.gif" width="16" height="16" border="0" align="top"/></a>
          </td>
         </tr>
        </table>
       </div>

        <div id="tabcommunication" class="tabbertab" style="overflow: auto;">
        <h2>Communication</h2>
        <table cellpadding="3" cellspacing="2" border="0">
         <tr><th>Email Address</th><td><%= oEmail %></td></tr>
         <tr><th>Mobile Phone Number</th><td><%= oPhoneMobile %></td></tr>
         <tr><th>Fix Phone Number</th><td><%= oPhoneFix %></td></tr>
         <tr><th>Facsimile Telephone Number</th><td><%= oPhoneFax %></td></tr>
        </table>
       </div>
      </div>
      <div class="buttonbar" style="font-size: 80%;"><span style="color:red;">*</span> mandatory fields</div>
      <div class="buttonbar"><input type="submit" value="Save Employee"/>&nbsp;<button onclick="document.location = 'employee_view.jsp?userid=<%= oFilterUserID %>'; return false;">Cancel</button></div>
     </form>
    </div>
   </div>
   <div id="footer">
    <a href="index.jsp">My HR Application</a> | <a href="#">My Intranet</a> | <a href="#">My Self-Service</a><br/>
    Copyright &copy; My HR Application 2008
   </div>
  </div>
  <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></div>
 </body>
</html>
