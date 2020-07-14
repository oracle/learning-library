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
ArrayList oRoles = (ArrayList) session.getAttribute( "logged-user-privileges" );

// Check rights
if ( !oRoles.contains( "SELECT" ) ) { response.sendRedirect( "index.jsp?err=no_privilege&needed_privilege=SELECT" ); return; }

// Retrieve user ID
String oFilterUserID 		= request.getParameter( "userid" ) 		!= null ? (String) request.getParameter( "userid" ) 	: "";

// Get layout configuration
String  oTemplate   = application.getInitParameter( "layout.template" )   != null ? application.getInitParameter( "layout.template" )                  : "default";
boolean oDisplayTab = application.getInitParameter( "layout.displaytab" ) != null ? application.getInitParameter( "layout.displaytab" ).equals("true") : true;

// Retrieve user profile
int    oUserID = 0;
String oFirstName = "";
String oLastName = "";
String oDOB = "";
String oSSN = "";
String oSIN = "";
String oNINO = "";
String oCORPORATE_CARD = "";
String oCC_PIN = "";
String oCC_EXPIRE = "";
String oMEMBER_ID = "";
String oLAST_INS_CLAIM = "";
String oBONUS_AMOUNT = "";
String oPAYMENT_ACCT_NO = "";
String oROUTING_NUMBER = "";

String oAddress_1 = "";
String oAddress_2 = "";
String oState = "";
String oCOUNTRY = "";
String oPOSTAL_CODE = "";
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
int oIsHeadOfDepartment = 0;
String oOrganization = "";
java.util.Date oStartDate = null;
java.util.Date oEndDate = null;
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
 
		Statement stmt = conn.createStatement();
		
		// Prepare query using filter parameters
		String oQuery = " select a.USERID, a.FIRSTNAME, a.LASTNAME, a.EMAIL, a.PHONEMOBILE, a.PHONEFIX, a.PHONEFAX, "
			+ "a.SSN, a.SIN, A.NINO, a.DOB, a.ADDRESS_1, a.ADDRESS_2, a.STATE, a.COUNTRY, a.POSTAL_CODE, "
			+ "a.EMPTYPE, a.POSITION, a.LOCATION, a.ISMANAGER, a.MANAGERID, a.DEPARTMENT, a.ORGANIZATION, a.STARTDATE, a.ENDDATE, a.ACTIVE, "
			+ "a.COSTCENTER, a.ISHEADOFDEPARTMENT, b.FIRSTNAME as MGR_FIRSTNAME, b.LASTNAME as MGR_LASTNAME, b.USERID as MGR_USERID, "
            + "a.CORPORATE_CARD, a.CC_PIN, a.CC_EXPIRE, "
			+ "c.MEMBER_ID, c.LAST_INS_CLAIM, c.BONUS_AMOUNT, c.PAYMENT_ACCT_NO, c.ROUTING_NUMBER "
			+ "from DEMO_HR_EMPLOYEES a left outer join DEMO_HR_EMPLOYEES b on a.MANAGERID = b.USERID "
			+ "left outer join DEMO_HR_SUPPLEMENTAL_DATA c on a.USERID = c.USERID "
			+ "where a.USERID = " + oFilterUserID +  " ";

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

			oSSN = rs.getString("SSN") != null ? rs.getString("SSN") : "";
			oSIN = rs.getString("SIN") != null ? rs.getString("SIN") : "";
			oNINO = rs.getString("NINO") != null ? rs.getString("NINO") : "";
			oDOB = rs.getString("DOB") != null ? rs.getString("DOB") : "";
			oAddress_1 = rs.getString("ADDRESS_1") != null ? rs.getString("ADDRESS_1") : "";
			oAddress_2 = rs.getString("ADDRESS_2") != null ? rs.getString("ADDRESS_2") : "";
			oState = rs.getString("STATE") != null ? rs.getString("STATE") : "";
			oCOUNTRY = rs.getString("COUNTRY") != null ? rs.getString("COUNTRY") : "";
			oPOSTAL_CODE = rs.getString("POSTAL_CODE") != null ? rs.getString("POSTAL_CODE") : "";

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

			oCORPORATE_CARD = rs.getString("CORPORATE_CARD") != null ? rs.getString("CORPORATE_CARD") : "";
			oCC_PIN = rs.getString("CC_PIN") != null ? rs.getString("CC_PIN") : "";
			oCC_EXPIRE = rs.getString("CC_EXPIRE") != null ? rs.getString("CC_EXPIRE") : "";

//			+ "c.MEMBER_ID, c.LAST_INS_CLAIM, c.BONUS_AMOUNT, c.PAYMENT_ACCT_NO "

			oMEMBER_ID = rs.getString("MEMBER_ID") != null ? rs.getString("MEMBER_ID") : "";
			oLAST_INS_CLAIM = rs.getString("LAST_INS_CLAIM") != null ? rs.getString("LAST_INS_CLAIM") : "";
			oBONUS_AMOUNT = rs.getString("BONUS_AMOUNT") != null ? rs.getString("BONUS_AMOUNT") : "";
			oPAYMENT_ACCT_NO = rs.getString("PAYMENT_ACCT_NO") != null ? rs.getString("PAYMENT_ACCT_NO") : "";
			oROUTING_NUMBER = rs.getString("ROUTING_NUMBER") != null ? rs.getString("ROUTING_NUMBER") : "";

		}
		
		if ( !oUserFound )
		{
			response.sendRedirect( "search.jsp?err=invalid_userid" );
			return;
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
	return;
}
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
		<title>HR Application</title> 
		<link rel="stylesheet" href="templates/<%= oTemplate %>/stylesheet1.css" media="screen">
		<style type="text/css" media="screen">@import url("templates/<%= oTemplate %>/stylesheet2.css");</style>
		<link rel="stylesheet" href="templates/<%= oTemplate %>/print.css" media="print">

		<script type="text/javascript" src="js/tabber.js"></script>
		<% if ( oDisplayTab ) { %>
			<link rel="stylesheet" href="css/example.css" TYPE="text/css" MEDIA="screen">
			<link rel="stylesheet" href="css/example-print.css" TYPE="text/css" MEDIA="print">
		<% } %>

		<!-- script type="text/javascript" src="js/sorttable.js"></script -->

		<link rel="shortcut icon" href="favicon.ico"/>

		<script type="text/javascript">
			document.write('<style type="text/css">.tabber{display:none;}<\/style>');
		</script>
	</head>
	<body>
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
				<div id="employee_view_details">
					<h2>Employee Profile</h2>
					<div class="tabber">
					     <div id="tabidentity" class="tabbertab" style="overflow: auto;">
						<h2>Identity</h2>
						<table cellpadding="3" cellspacing="2" border="0">
							<tr><th>HR ID</th><td><%= oUserID %></td></tr>
							<tr><th>Full Name</th><td><%= oLastName %>, <%= oFirstName %></td></tr>
                            <tr><th>SSN / SIN / NINO</th><td><%= oSSN %> <%= oSIN %> <%= oNINO %></td></tr>
							<tr><th>Date of Birth</th><td><%= oDOB %></td></tr>
							<tr><th>Address</th><td><%= oAddress_1 %> <%= oAddress_2 %> <%= oState %>, <%= oPOSTAL_CODE %></td></tr>
							<tr><th>Corporate Card / Expiration</th><td><%= oCORPORATE_CARD %> / <%= oCC_EXPIRE %></td></tr>
							<tr><th>Employee Type</th><td><%= oEmpType %></td></tr>
							<tr><th>Position</th><td><%= oPosition %></td></tr>
							<tr><th>Location</th><td><%= oLocation %></td></tr>
							<tr><th>Active</th><td><img src="images/icon_active_<%= oActive %>.gif" width="16" height="16" align="top" title="<% if ( oActive == 1 ) out.print( "Active" ); else out.print( "Inactive" ); %>"/> <% if ( oActive == 1 ) { out.print( "Yes, Active" ); } else { out.print( "No, Inactive" ); } %></td></tr>
						</table>
					     </div>

					     <div id="tabcommunication" class="tabbertab">
						<h2>Supplemental Data</h2>
						<table cellpadding="3" cellspacing="2" border="0">
							<tr><th>Member ID</th><td><%= oMEMBER_ID %></td></tr>
							<tr><th>Last Insurance Claim</th><td><%= oLAST_INS_CLAIM %></td></tr>
							<tr><th>&nbsp;</th><td>&nbsp;</td></tr>
							<tr><th>Routing Number</th><td><%= oROUTING_NUMBER %></td></tr>
							<tr><th>Payment Account No</th><td><%= oPAYMENT_ACCT_NO %></td></tr>
							<tr><th>Bonus Amount</th><td><%= oBONUS_AMOUNT %></td></tr>
						</table>
					     </div>

					     <div id="taborganization" class="tabbertab">
						  <h2>Organization</h2>
						<table cellpadding="3" cellspacing="2" border="0">
							<tr><th>Is Manager?</th><td><% if ( oIsManager == 1 ) { out.print( "Yes, Manager" ); } else { out.print( "No" ); } %></td></tr>
							<tr><th>Manager</th><td><% if ( oManagerID != 0 ) { %><a href="employee_view.jsp?userid=<%= oManagerID %>"><%= oManagerLastName + ", " + oManagerFirstName %></a><% } %></td></tr>
							<tr><th>Cost Center</th><td><%= oCostCenter %></td></tr>
							<tr><th>Department</th><td><%= oDepartment %></td></tr>
							<tr><th>Is Head of Department?</th><td><% if ( oIsHeadOfDepartment == 1 ) { out.print( "Yes, Head of Department" ); } else { out.print( "No" ); } %></td></tr>
							<tr><th>Organization</th><td><%= oOrganization %></td></tr>
							<tr><th>Start Date</th><td><% if ( oStartDate != null ) out.println( oStartDate ); %></td></tr>
							<tr><th>End Date</th><td><% if ( oEndDate != null ) out.println( oEndDate ); %></td></tr>
						</table>
					     </div>

					     <div id="tabcommunication" class="tabbertab">
						<h2>Communication</h2>
						<table cellpadding="3" cellspacing="2" border="0">
							<tr><th>Email Address</th><td><%= oEmail %></td></tr>
							<tr><th>Mobile Phone Number</th><td><%= oPhoneMobile %></td></tr>
							<tr><th>Fix Phone Number</th><td><%= oPhoneFix %></td></tr>
							<tr><th>Facsimile Telephone Number</th><td><%= oPhoneFax %></td></tr>
						</table>
					     </div>
					</div>
					<% if ( oRoles.contains("UPDATE") ) { %><div class="buttonbar"><button onclick="document.location = 'employee_modify.jsp?userid=<%= oFilterUserID %>';">Modify Employee</button></div><% } %>
				</div>
				<div id="direct_reports">
					<h2>Direct Reports</h2>
					<table cellpadding="3" cellspacing="2" border="0" class="sortable">
					<tr>
						<th>HR ID</th>
						<th>Full Name</th>
						<!-- th>Email</th -->
						<!-- th>Phone Mobile</th -->
						<!-- th>Phone Fix</th -->
						<!-- th>Phone Fax</th -->
						<th>Emp Type</th>
						<th>Position</th>
						<th>Location</th>
						<!-- th>Is Manager</th -->
						<th>Manager</th>
						<th>Cost Center</th>
						<th>Department</th>
						<th>Organization</th>
						<!-- th>Start Date</th -->
						<!-- th>End Date</th -->
						<th style="background-color: #fff;">&nbsp;</th>
					</tr>
					<%
					if (   !oFilterUserID.equals( "" ) )
					{
						try
						{
							Class.forName( oJDBCDriver );
							Connection conn = DriverManager.getConnection( oJDBCURL, oJDBCUser, oJDBCPassword ); 

							Statement stmt = conn.createStatement();
							
							String oQuery = "select a.USERID, a.FIRSTNAME, a.LASTNAME, a.EMAIL, a.PHONEMOBILE, a.PHONEFIX, a.PHONEFAX, "
								+ "a.COSTCENTER, a.EMPTYPE, a.POSITION, a.LOCATION, a.ISMANAGER, a.MANAGERID, a.DEPARTMENT, a.ORGANIZATION, a.STARTDATE, a.ENDDATE, a.ACTIVE, "
								+ "b.FIRSTNAME as MGR_FIRSTNAME, b.LASTNAME as MGR_LASTNAME, b.USERID as MGR_USERID "
								+ "from DEMO_HR_EMPLOYEES a left outer join DEMO_HR_EMPLOYEES b on a.MANAGERID = b.USERID where a.MANAGERID = " + oFilterUserID + " order by a.LASTNAME, a.FIRSTNAME";
							
							// Execute query and display results
							ResultSet rs = stmt.executeQuery( oQuery );
							while (rs.next())
							{
								int    oDUserID = rs.getInt("USERID");
								String oDFirstName = rs.getString("FIRSTNAME") != null ? rs.getString("FIRSTNAME") : "";
								String oDLastName = rs.getString("LASTNAME") != null ? rs.getString("LASTNAME") : "";
								String oDEmail = rs.getString("EMAIL") != null ? rs.getString("EMAIL") : "";
								String oDPhoneMobile = rs.getString("PHONEMOBILE") != null ? rs.getString("PHONEMOBILE") : "";
								String oDPhoneFix = rs.getString("PHONEFIX") != null ? rs.getString("PHONEFIX") : "";
								String oDPhoneFax = rs.getString("PHONEFAX") != null ? rs.getString("PHONEFAX") : "";
								String oDEmpType = rs.getString("EMPTYPE") != null ? rs.getString("EMPTYPE") : "";
								String oDPosition = rs.getString("POSITION") != null ? rs.getString("POSITION") : "";
								String oDLocation = rs.getString("LOCATION") != null ? rs.getString("LOCATION") : "";
								int    oDIsManager = rs.getInt("ISMANAGER");
								int    oDManagerID = rs.getInt("MANAGERID");
								String oDCostCenter = rs.getString("COSTCENTER") != null ? rs.getString("COSTCENTER") : "";
								String oDDepartment = rs.getString("DEPARTMENT") != null ? rs.getString("DEPARTMENT") : "";
								String oDOrganization = rs.getString("ORGANIZATION") != null ? rs.getString("ORGANIZATION") : "";
								java.util.Date oDStartDate = rs.getDate("STARTDATE");
								java.util.Date oDEndDate = rs.getDate("ENDDATE");
								int oDActive = rs.getInt("ACTIVE");
								String oDManagerFirstName = rs.getString("MGR_FIRSTNAME") != null ? rs.getString("MGR_FIRSTNAME") : "";
								String oDManagerLastName = rs.getString("MGR_LASTNAME") != null ? rs.getString("MGR_LASTNAME") : "";
								int oDManagerUserID = rs.getInt("MGR_USERID");
								%>
								
								<tr>
									<td><%= oDUserID %></td>
									<td><a href="employee_view.jsp?userid=<%= oDUserID %>"><%= oDLastName %>, <%= oDFirstName %></a></td>
									<!-- td><%= oDEmail %></td -->
									<!-- td><%= oDPhoneMobile %></td -->
									<!-- td><%= oDPhoneFix %></td -->
									<!-- td><%= oDPhoneFax %></td -->
									<td><%= oDEmpType %></td>
									<td><%= oDPosition %></td>
									<td><%= oDLocation %></td>
									<!-- td><%= oDIsManager %></td -->
									<td><%= oDManagerLastName + ", " + oDManagerFirstName %></td>
									<td><%= oDCostCenter %></td>
									<td><%= oDDepartment %></td>
									<td><%= oDOrganization %></td>
									<!-- td><%= oDStartDate %></td -->
									<!-- td><%= oDEndDate %></td -->
									<td><img src="images/icon_active_<%= oDActive %>.gif" width="16" height="16" title="<% if ( oDActive == 1 ) out.print( "Active" ); else out.print( "Inactive" ); %>"/></td>
								</tr>
								
								<%
							}
							 
							stmt.close();
						}
						catch(Exception e)
						{
							e.printStackTrace();
							out.println( e );
						}
					}
					%>
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
