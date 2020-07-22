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
if ( oLoggedUser == null ) 
{
 response.sendRedirect( "login.jsp" );
 return;
}

// Retrieve logged user informations
String oLoggedUserFirstName  = (String) session.getAttribute( "logged-user-firstname" );
String oLoggedUserLastName   = (String) session.getAttribute( "logged-user-lastname" );
ArrayList oRoles = (ArrayList) session.getAttribute( "logged-user-privileges" );

String oACTION = "";
String oAUDITED_CURSORID = "";
String oAUTHENTICATED_IDENTITY = "";
String oAUTHENTICATION_DATA = "";
String oAUTHENTICATION_METHOD  = "";
String oBG_JOB_ID  = "";
String oCLIENT_IDENTIFIER  = "";
String oCLIENT_INFO = "";
String oCURRENT_BIND = "";
String oCURRENT_EDITION_ID = "";
String oCURRENT_EDITION_NAME = "";
String oCURRENT_SCHEMA = "";
String oCURRENT_SCHEMAID = "";
String oCURRENT_SQL = "";
String oCURRENT_SQLn = "";
String oCURRENT_SQL_LENGTH = "";
String oCURRENT_USER = "";
String oCURRENT_USERID = "";
String oDATABASE_ROLE = "";
String oDB_DOMAIN = "";
String oDB_NAME = "";
String oDB_UNIQUE_NAME = "";
String oDBLINK_INFO = "";
String oENTRYID = "";
String oENTERPRISE_IDENTITY = "";
String oFG_JOB_ID = "";
String oGLOBAL_CONTEXT_MEMORY = "";
String oGLOBAL_UID = "";
String oHOST = "";
String oIDENTIFICATION_TYPE = "";
String oINSTANCE = "";
String oINSTANCE_NAME = "";
String oIP_ADDRESS = "";
String oISDBA = "";
String oLANG = "";
String oLANGUAGE = "";
String oMODULE = "";
String oNETWORK_PROTOCOL = "";
String oNLS_CALENDAR = "";
String oNLS_CURRENCY = "";
String oNLS_DATE_FORMAT = "";
String oNLS_DATE_LANGUAGE = "";
String oNLS_SORT = "";
String oNLS_TERRITORY = "";
String oOS_USER = "";
String oPOLICY_INVOKER = "";
String oPROXY_ENTERPRISE_IDENTITY = "";
String oPROXY_USER = "";
String oPROXY_USERID = "";
String oSERVER_HOST = "";
String oSERVICE_NAME = "";
String oSESSION_EDITION_ID = "";
String oSESSION_EDITION_NAME = "";
String oSESSION_USER = "";
String oSESSION_USERID = "";
String oSESSIONID = "";
String oSID = "";
String oSTATEMENTID = "";
String oSYS_SESSION_ROLES = "";
String oTERMINAL = "";
 

// Check rights
if ( !oRoles.contains( "SELECT" ) )
{
 response.sendRedirect( "index.jsp?err=no_privilege&needed_privilege=SELECT" );
 return;
}

// Get layout configuration
String oTemplate = application.getInitParameter( "layout.template" ) != null ? application.getInitParameter( "layout.template" ) : "default";

// Retrieve filter parameters
int    oUserID = 0;
%>
<html>
 <head>
  <meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
  <title>HR Application</title> 
  <link rel="stylesheet" href="templates/<%= oTemplate %>/stylesheet1.css" media="screen">
  <style type="text/css" media="screen">@import url("templates/<%= oTemplate %>/stylesheet2.css");</style>
  <link rel="stylesheet" href="templates/<%= oTemplate %>/print.css" media="print">

  <script type="text/javascript" src="js/hr.js"></script>
  <script type="text/javascript" src="js/sorttable.js"></script>

  <link rel="shortcut icon" href="favicon.ico"/>
 </head>
 <body>
  <div id="container">
                    <div id="header" title="HR Application">
                      <div id="welcome">
                       <a href="session_data.jsp">Welcome <%= oLoggedUserFirstName %> <%= oLoggedUserLastName %>!</a>
                         <br/>Privileges: <%= oRoles %>
                      </div>
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
    <div id="filter">
     <form name="search_employees" method="post" action="search.jsp" onsubmit="return checkSearchForm(this);">
      <input type="hidden" name="action" value="search"/>
      <h2>Session Details</h2>
      <table cellpadding="3" cellspacing="2" border="0">
      </table>
     </form>
    </div>
    <div id="employees_list">
     <table cellpadding="3" cellspacing="2" border="0" class="sortable">
     <%
      try
      {
       Class.forName( oJDBCDriver );
       Connection conn = DriverManager.getConnection( oJDBCURL, oJDBCUser, oJDBCPassword );
          Statement stmt = conn.createStatement();


 System.out.println ("********** SESSION_DATA.JSP  *****************");
        
 // Prepare query using filter parameters
        String oQuery = "select sys_context ('userenv','ACTION') ACTION, "
         + "sys_context ('userenv','AUDITED_CURSORID') AUDITED_CURSORID, "
         + "sys_context ('userenv','AUTHENTICATED_IDENTITY') AUTHENTICATED_IDENTITY, "
         + "sys_context ('userenv','AUTHENTICATION_DATA') AUTHENTICATION_DATA, " 
         + "sys_context ('userenv','AUTHENTICATION_METHOD') AUTHENTICATION_METHOD, " 
         + "sys_context ('userenv','BG_JOB_ID') BG_JOB_ID, " 
         + "sys_context ('userenv','CLIENT_IDENTIFIER') CLIENT_IDENTIFIER, " 
         + "sys_context ('userenv','CLIENT_INFO') CLIENT_INFO, " 
         + "sys_context ('userenv','CURRENT_BIND') CURRENT_BIND, " 
         + "sys_context ('userenv','CURRENT_EDITION_ID') CURRENT_EDITION_ID, " 
         + "sys_context ('userenv','CURRENT_EDITION_NAME') CURRENT_EDITION_NAME, " 
         + "sys_context ('userenv','CURRENT_SCHEMA') CURRENT_SCHEMA, " 
         + "sys_context ('userenv','CURRENT_SCHEMAID') CURRENT_SCHEMAID, " 
         + "sys_context ('userenv','CURRENT_SQL') CURRENT_SQL, " 
         + "sys_context ('userenv','CURRENT_SQLn') CURRENT_SQLn, " 
         + "sys_context ('userenv','CURRENT_SQL_LENGTH') CURRENT_SQL_LENGTH, " 
         + "sys_context ('userenv','CURRENT_USER') CURRENT_USER, " 
         + "sys_context ('userenv','CURRENT_USERID') CURRENT_USERID, " 
         + "sys_context ('userenv','DATABASE_ROLE') DATABASE_ROLE, " 
         + "sys_context ('userenv','DB_DOMAIN') DB_DOMAIN, " 
         + "sys_context ('userenv','DB_NAME') DB_NAME, " 
         + "sys_context ('userenv','DB_UNIQUE_NAME') DB_UNIQUE_NAME, " 
         + "sys_context ('userenv','DBLINK_INFO') DBLINK_INFO, " 
         + "sys_context ('userenv','ENTRYID') ENTRYID, " 
         + "sys_context ('userenv','ENTERPRISE_IDENTITY') ENTERPRISE_IDENTITY, " 
  + "sys_context ('userenv','FG_JOB_ID') FG_JOB_ID, " 
  + "sys_context ('userenv','GLOBAL_CONTEXT_MEMORY') GLOBAL_CONTEXT_MEMORY, " 
  + "sys_context ('userenv','GLOBAL_UID') GLOBAL_UID, " 
  + "sys_context ('userenv','HOST') HOST, " 
  + "sys_context ('userenv','IDENTIFICATION_TYPE') IDENTIFICATION_TYPE, " 
  + "sys_context ('userenv','INSTANCE') INSTANCE, " 
  + "sys_context ('userenv','INSTANCE_NAME') INSTANCE_NAME, " 
  + "sys_context ('userenv','IP_ADDRESS') IP_ADDRESS, " 
  + "sys_context ('userenv','ISDBA') ISDBA, " 
  + "sys_context ('userenv','LANG') LANG, " 
  + "sys_context ('userenv','LANGUAGE') LANGUAGE, " 
  + "sys_context ('userenv','MODULE') MODULE, " 
  + "sys_context ('userenv','NETWORK_PROTOCOL') NETWORK_PROTOCOL, " 
  + "sys_context ('userenv','NLS_CALENDAR') NLS_CALENDAR, " 
  + "sys_context ('userenv','NLS_CURRENCY') NLS_CURRENCY, " 
  + "sys_context ('userenv','NLS_DATE_FORMAT') NLS_DATE_FORMAT, " 
  + "sys_context ('userenv','NLS_DATE_LANGUAGE') NLS_DATE_LANGUAGE, " 
  + "sys_context ('userenv','NLS_SORT') NLS_SORT, " 
  + "sys_context ('userenv','NLS_TERRITORY') NLS_TERRITORY, " 
  + "sys_context ('userenv','OS_USER') OS_USER, " 
  + "sys_context ('userenv','POLICY_INVOKER') POLICY_INVOKER, " 
  + "sys_context ('userenv','PROXY_ENTERPRISE_IDENTITY') PROXY_ENTERPRISE_IDENTITY, " 
  + "sys_context ('userenv','PROXY_USER') PROXY_USER, " 
  + "sys_context ('userenv','PROXY_USERID') PROXY_USERID, " 
  + "sys_context ('userenv','SERVER_HOST') SERVER_HOST, " 
  + "sys_context ('userenv','SERVICE_NAME') SERVICE_NAME, " 
  + "sys_context ('userenv','SESSION_EDITION_ID') SESSION_EDITION_ID, " 
  + "sys_context ('userenv','SESSION_EDITION_NAME') SESSION_EDITION_NAME, " 
  + "sys_context ('userenv','SESSION_USER') SESSION_USER, " 
  + "sys_context ('userenv','SESSION_USERID') SESSION_USERID, " 
  + "sys_context ('userenv','SESSIONID') SESSIONID, " 
  + "sys_context ('userenv','SID') SID, " 
  + "sys_context ('userenv','STATEMENTID') STATEMENTID, " 
  + "sys_context ('SYS_SESSION_ROLES','APP_DBA') HAS_APP_DBA_ROLE, " 
  + "sys_context ('userenv','TERMINAL') TERMINAL " 
  + " from dual ";

      ResultSet rs = stmt.executeQuery( oQuery );
     rs.next();
     // Execute query and display results
     oACTION = rs.getString( "ACTION" ) != null ? rs.getString( "ACTION" ) : "";
     oAUDITED_CURSORID = rs.getString( "AUDITED_CURSORID" ) != null ? rs.getString( "AUDITED_CURSORID" ) : "";
     oAUTHENTICATED_IDENTITY = rs.getString( "AUTHENTICATED_IDENTITY" ) != null ? rs.getString( "AUTHENTICATED_IDENTITY" ) : "";
     oAUTHENTICATION_DATA = rs.getString( "AUTHENTICATION_DATA" ) != null ? rs.getString( "AUTHENTICATION_DATA" ) : "";
     oAUTHENTICATION_METHOD  = rs.getString( "AUTHENTICATION_METHOD" ) != null ? rs.getString( "AUTHENTICATION_METHOD" ) : "";
     oBG_JOB_ID  = rs.getString( "BG_JOB_ID" ) != null ? rs.getString( "BG_JOB_ID" ) : "";
     oCLIENT_IDENTIFIER  = rs.getString( "CLIENT_IDENTIFIER" ) != null ? rs.getString( "CLIENT_IDENTIFIER" ) : "";
     oCLIENT_INFO = rs.getString( "CLIENT_INFO" ) != null ? rs.getString( "CLIENT_INFO" ) : "";
     oCURRENT_BIND = rs.getString( "CURRENT_BIND" ) != null ? rs.getString( "CURRENT_BIND" ) : "";
     oCURRENT_EDITION_ID = rs.getString( "CURRENT_EDITION_ID" ) != null ? rs.getString( "CURRENT_EDITION_ID" ) : "";
     oCURRENT_EDITION_NAME = rs.getString( "CURRENT_EDITION_NAME" ) != null ? rs.getString( "CURRENT_EDITION_NAME" ) : "";
     oCURRENT_SCHEMA = rs.getString( "CURRENT_SCHEMA" ) != null ? rs.getString( "CURRENT_SCHEMA" ) : "";
     oCURRENT_SCHEMAID = rs.getString( "CURRENT_SCHEMAID" ) != null ? rs.getString( "CURRENT_SCHEMAID" ) : "";
     oCURRENT_SQL = rs.getString( "CURRENT_SQL" ) != null ? rs.getString( "CURRENT_SQL" ) : "";
     oCURRENT_SQLn = rs.getString( "CURRENT_SQLn" ) != null ? rs.getString( "CURRENT_SQLn" ) : "";
     oCURRENT_SQL_LENGTH = rs.getString( "CURRENT_SQL_LENGTH" ) != null ? rs.getString( "CURRENT_SQL_LENGTH" ) : "";
     oCURRENT_USER = rs.getString( "CURRENT_USER" ) != null ? rs.getString( "CURRENT_USER" ) : "";
     oCURRENT_USERID = rs.getString( "CURRENT_USERID" ) != null ? rs.getString( "CURRENT_USERID" ) : "";
     oDATABASE_ROLE = rs.getString( "DATABASE_ROLE" ) != null ? rs.getString( "DATABASE_ROLE" ) : "";
     oDB_DOMAIN = rs.getString( "DB_DOMAIN" ) != null ? rs.getString( "DB_DOMAIN" ) : "";
     oDB_NAME = rs.getString( "DB_NAME" ) != null ? rs.getString( "DB_NAME" ) : "";
     oDB_UNIQUE_NAME = rs.getString( "DB_UNIQUE_NAME" ) != null ? rs.getString( "DB_UNIQUE_NAME" ) : "";
     oDBLINK_INFO = rs.getString( "DBLINK_INFO" ) != null ? rs.getString( "DBLINK_INFO" ) : "";
     oENTRYID = rs.getString( "ENTRYID" ) != null ? rs.getString( "ENTRYID" ) : "";
     oENTERPRISE_IDENTITY = rs.getString( "ENTERPRISE_IDENTITY" ) != null ? rs.getString( "ENTERPRISE_IDENTITY" ) : "";
     oFG_JOB_ID = rs.getString( "FG_JOB_ID" ) != null ? rs.getString( "FG_JOB_ID" ) : "";
     oGLOBAL_CONTEXT_MEMORY = rs.getString( "GLOBAL_CONTEXT_MEMORY" ) != null ? rs.getString( "GLOBAL_CONTEXT_MEMORY" ) : "";
     oGLOBAL_UID = rs.getString( "GLOBAL_UID" ) != null ? rs.getString( "GLOBAL_UID" ) : "";
     oHOST = rs.getString( "HOST" ) != null ? rs.getString( "HOST" ) : "";
     oIDENTIFICATION_TYPE = rs.getString( "IDENTIFICATION_TYPE" ) != null ? rs.getString( "IDENTIFICATION_TYPE" ) : "";
     oINSTANCE = rs.getString( "INSTANCE" ) != null ? rs.getString( "INSTANCE" ) : "";
     oINSTANCE_NAME = rs.getString( "INSTANCE_NAME" ) != null ? rs.getString( "INSTANCE_NAME" ) : "";
     oIP_ADDRESS = rs.getString( "IP_ADDRESS" ) != null ? rs.getString( "IP_ADDRESS" ) : "";
     oISDBA = rs.getString( "ISDBA" ) != null ? rs.getString( "ISDBA" ) : "";
     oLANG = rs.getString( "LANG" ) != null ? rs.getString( "LANG" ) : "";
     oLANGUAGE = rs.getString( "LANGUAGE" ) != null ? rs.getString( "LANGUAGE" ) : "";
     oMODULE = rs.getString( "MODULE" ) != null ? rs.getString( "MODULE" ) : "";
     oNETWORK_PROTOCOL = rs.getString( "NETWORK_PROTOCOL" ) != null ? rs.getString( "NETWORK_PROTOCOL" ) : "";
     oNLS_CALENDAR = rs.getString( "NLS_CALENDAR" ) != null ? rs.getString( "NLS_CALENDAR" ) : "";
     oNLS_CURRENCY = rs.getString( "NLS_CURRENCY" ) != null ? rs.getString( "NLS_CURRENCY" ) : "";
     oNLS_DATE_FORMAT = rs.getString( "NLS_DATE_FORMAT" ) != null ? rs.getString( "NLS_DATE_FORMAT" ) : "";
     oNLS_DATE_LANGUAGE = rs.getString( "NLS_DATE_LANGUAGE" ) != null ? rs.getString( "NLS_DATE_LANGUAGE" ) : "";
     oNLS_SORT = rs.getString( "NLS_SORT" ) != null ? rs.getString( "NLS_SORT" ) : "";
     oNLS_TERRITORY = rs.getString( "NLS_TERRITORY" ) != null ? rs.getString( "NLS_TERRITORY" ) : "";
     oOS_USER = rs.getString( "OS_USER" ) != null ? rs.getString( "OS_USER" ) : ""; 
     oPOLICY_INVOKER = rs.getString( "POLICY_INVOKER" ) != null ? rs.getString( "POLICY_INVOKER" ) : "";
     oPROXY_ENTERPRISE_IDENTITY = rs.getString( "PROXY_ENTERPRISE_IDENTITY" ) != null ? rs.getString( "PROXY_ENTERPRISE_IDENTITY" ) : "";
     oPROXY_USER = rs.getString( "PROXY_USER" ) != null ? rs.getString( "PROXY_USER" ) : "";
     oPROXY_USERID = rs.getString( "PROXY_USERID" ) != null ? rs.getString( "PROXY_USERID" ) : "";
     oSERVER_HOST = rs.getString( "SERVER_HOST" ) != null ? rs.getString( "SERVER_HOST" ) : "";
     oSERVICE_NAME = rs.getString( "SERVICE_NAME" ) != null ? rs.getString( "SERVICE_NAME" ) : "";
     oSESSION_EDITION_ID = rs.getString( "SESSION_EDITION_ID" ) != null ? rs.getString( "SESSION_EDITION_ID" ) : "";
 oSESSION_EDITION_NAME = rs.getString( "SESSION_EDITION_NAME" ) != null ? rs.getString( "SESSION_EDITION_NAME" ) : "";
oSESSION_USER = rs.getString( "SESSION_USER" ) != null ? rs.getString( "SESSION_USER" ) : "";
oSESSION_USERID = rs.getString( "SESSION_USERID" ) != null ? rs.getString( "SESSION_USERID" ) : "";
oSESSIONID = rs.getString( "SESSIONID" ) != null ? rs.getString( "SESSIONID" ) : "";
oSID = rs.getString( "SID" ) != null ? rs.getString( "SID" ) : "";
oSTATEMENTID = rs.getString( "STATEMENTID" ) != null ? rs.getString( "STATEMENTID" ) : "";
oSYS_SESSION_ROLES = rs.getString( "HAS_APP_DBA_ROLE" ) != null ? rs.getString( "HAS_APP_DBA_ROLE" ) : "";
oTERMINAL = rs.getString( "TERMINAL" ) != null ? rs.getString( "TERMINAL" ) : "";   
     %> 
     <%
     /*
     String select[] = request.getParameterValues("id");
     if (select != null && select.length != 0) {
     out.println(oQuery);
     }
     */
     stmt.close();
     }
     catch(Exception e)
     {
      e.printStackTrace();
      out.println( e );
     }
    %>
      <tr><td>ACTION</td><td><%= oACTION %></td></tr>
      <tr><td>AUDITED_CURSORID</td><td><%= oAUDITED_CURSORID %></td></tr>
      <tr><td>AUTHENTICATED_IDENTITY</td><td><%= oAUTHENTICATED_IDENTITY %></td></tr>
      <tr><td>AUTHENTICATION_DATA</td><td><%= oAUTHENTICATION_DATA %></td></tr>
      <tr><td>AUTHENTICATION_METHOD</td><td><%= oAUTHENTICATION_METHOD %></td></tr>
      <tr><td>BG_JOB_ID</td><td><%= oBG_JOB_ID %></td></tr>
      <tr><td>CLIENT_IDENTIFIER</td><td><%= oCLIENT_IDENTIFIER %></td></tr>
      <tr><td>CLIENT_INFO</td><td><%= oCLIENT_INFO %></td></tr>
      <tr><td>CURRENT_BIND</td><td><%= oCURRENT_BIND %></td></tr>
      <tr><td>CURRENT_EDITION_ID</td><td><%= oCURRENT_EDITION_ID %></td></tr>
      <tr><td>CURRENT_EDITION_NAME</td><td><%= oCURRENT_EDITION_NAME %></td></tr>
      <tr><td>CURRENT_SCHEMA</td><td><%= oCURRENT_SCHEMA %></td></tr>
      <tr><td>CURRENT_SCHEMAID</td><td><%= oCURRENT_SCHEMAID %></td></tr>
      <tr><td>CURRENT_SQL</td><td><%= oCURRENT_SQL %></td></tr>
      <tr><td>CURRENT_SQLn</td><td><%= oCURRENT_SQLn %></td></tr>
      <tr><td>CURRENT_SQL_LENGTH</td><td><%= oCURRENT_SQL_LENGTH %></td></tr>
      <tr><td>CURRENT_USER</td><td><%= oCURRENT_USER %></td></tr>
      <tr><td>CURRENT_USERID</td><td><%= oCURRENT_USERID %></td></tr>
      <tr><td>DATABASE_ROLE</td><td><%= oDATABASE_ROLE %></td></tr>
      <tr><td>DB_DOMAIN</td><td><%= oDB_DOMAIN %></td></tr>
      <tr><td>DB_NAME</td><td><%= oDB_NAME %></td></tr>
      <tr><td>DB_UNIQUE_NAME</td><td><%= oDB_UNIQUE_NAME %></td></tr>
      <tr><td>DBLINK_INFO</td><td><%= oDBLINK_INFO %></td></tr>
      <tr><td>ENTRYID</td><td><%= oENTRYID %></td></tr>
      <tr><td>ENTERPRISE_IDENTITY</td><td><%= oENTERPRISE_IDENTITY %></td></tr>
      <tr><td>FG_JOB_ID</td><td><%= oFG_JOB_ID %></td></tr>
      <tr><td>GLOBAL_CONTEXT_MEMORY</td><td><%= oGLOBAL_CONTEXT_MEMORY %></td></tr>
      <tr><td>GLOBAL_UID</td><td><%= oGLOBAL_UID %></td></tr>
      <tr><td>HOST</td><td><%= oHOST %></td></tr>
      <tr><td>IDENTIFICATION_TYPE</td><td><%= oIDENTIFICATION_TYPE %></td></tr>
      <tr><td>INSTANCE</td><td><%= oINSTANCE %></td></tr>
      <tr><td>INSTANCE_NAME</td><td><%= oINSTANCE_NAME %></td></tr>
      <tr><td>IP_ADDRESS</td><td><%= oIP_ADDRESS %></td></tr>
      <tr><td>ISDBA</td><td><%= oISDBA %></td></tr>
      <tr><td>LANG</td><td><%= oLANG %></td></tr>
      <tr><td>LANGUAGE</td><td><%= oLANGUAGE %></td></tr>
      <tr><td>MODULE</td><td><%= oMODULE %></td></tr>
      <tr><td>NETWORK_PROTOCOL</td><td><%= oNETWORK_PROTOCOL %></td></tr>
      <tr><td>NLS_CALENDAR</td><td><%= oNLS_CALENDAR %></td></tr>
      <tr><td>NLS_CURRENCY</td><td><%= oNLS_CURRENCY %></td></tr>
      <tr><td>NLS_DATE_FORMAT</td><td><%= oNLS_DATE_FORMAT %></td></tr>
      <tr><td>NLS_DATE_LANGUAGE</td><td><%= oNLS_DATE_LANGUAGE %></td></tr>
      <tr><td>NLS_SORT</td><td><%= oNLS_SORT %></td></tr>
      <tr><td>NLS_TERRITORY</td><td><%= oNLS_TERRITORY %></td></tr>
      <tr><td>OS_USER</td><td><%= oOS_USER %></td></tr>
      <tr><td>POLICY_INVOKER</td><td><%= oPOLICY_INVOKER %></td></tr>
      <tr><td>PROXY_ENTERPRISE_IDENTITY</td><td><%= oPROXY_ENTERPRISE_IDENTITY %></td></tr>
      <tr><td>PROXY_USER</td><td><%= oPROXY_USER %></td></tr>
      <tr><td>PROXY_USERID</td><td><%= oPROXY_USERID %></td></tr>
      <tr><td>SERVER_HOST</td><td><%= oSERVER_HOST %></td></tr>
      <tr><td>SERVICE_NAME</td><td><%= oSERVICE_NAME %></td></tr>
      <tr><td>SESSION_EDITION_ID</td><td><%= oSESSION_EDITION_ID %></td></tr>
      <tr><td>SESSION_EDITION_NAME</td><td><%= oSESSION_EDITION_NAME %></td></tr>
      <tr><td>SESSION_USER</td><td><%= oSESSION_USER %></td></tr>
      <tr><td>SESSION_USERID</td><td><%= oSESSION_USERID %></td></tr>
      <tr><td>SESSIONID</td><td><%= oSESSIONID %></td></tr>
      <tr><td>SID</td><td><%= oSID %></td></tr>
      <tr><td>STATEMENTID</td><td><%= oSTATEMENTID %></td></tr>
                                                <tr><td colspan=2><b> Specialized Context Data </b></td></tr>
      <tr><td>Has APP_DBA Role</td><td><%= oSYS_SESSION_ROLES %></td></tr>
      <tr><td>TERMINAL</td><td><%= oTERMINAL %></td></tr>
     </table>
    </div>
   </div>
   <div id="footer">
    <a href="index.jsp">My HR Application</a> | <a href="#">My Intranet</a> | <a href="#">My Self-Service</a><br/>
    Copyright &copy; My HR Application 2008
   </div>
  </div>
 </body>
</html>
