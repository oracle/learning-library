<%@page import="java.io.InputStream"%>
<%@page contentType="text/html"%>
<%@page import ="java.sql.*"%>
<%@page import ="java.util.*"%>
<%
// Check if a user is logged
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

String oLoggedUser = (String) session.getAttribute( "logged-user" );
if ( oLoggedUser == null ) { response.sendRedirect( "login.jsp" ); return; }

// Retrieve logged user informations
String oLoggedUserFirstName  = (String) session.getAttribute( "logged-user-firstname" );
String oLoggedUserLastName   = (String) session.getAttribute( "logged-user-lastname" );
ArrayList oRoles = (ArrayList) session.getAttribute( "logged-user-privileges" );

// Check rights
if ( !oRoles.contains( "INSERT" ) ) { response.sendRedirect( "index.jsp?err=no_privilege&needed_privilege=INSERT" ); return; }

// Get layout configuration
String  oTemplate   = application.getInitParameter( "layout.template" )   != null ? application.getInitParameter( "layout.template" )                  : "default";
boolean oDisplayTab = application.getInitParameter( "layout.displaytab" ) != null ? application.getInitParameter( "layout.displaytab" ).equals("true") : true;
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
		<title>My HR Application</title> 
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
					<li><a href="search.jsp">Search Employees</a></li>
					<li><a href="employee_create.jsp">New Employee</a></li>
				</ul>
				<h3>Absence And Attendance</h3>
				<ul>
					<li><a href="#">Timesheets</a></li>
					<li><a href="#">Vacation</a></li>
				</ul>
			</div>

			<div id="content">
				<div id="minheight"></div>
				<div id="employee_create_details">
					<form name="employee_create" method="post" action="controller.jsp" onsubmit="return checkEmployeeForm( this );">
						<h2>Create New Employee</h2>
						<input type="hidden" name="action" value="employee_create"/>

						<div class="tabber" id="tabemployee">
							<div id="tabidentity" class="tabbertab" style="overflow: auto;">
								<h2>Identity</h2>
								<table cellpadding="3" cellspacing="2" border="0">
									<tr><th>HR ID</th><td>Will be generated automatically</td></tr>
									<tr><th>First Name<span style="color:red;">*</span></th><td><input type="text" name="firstname" value=""/></td></tr>
									<tr><th>Last Name<span style="color:red;">*</span></th><td><input type="text" name="lastname" value=""/></td></tr>
									<tr><th>Employee Type<span style="color:red;">*</span></th>
										<td>
											<select name="emptype">
												<option value="">-- Choose a value --</option>
												<option value="Full-Time">Full-Time Employee</option>
												<option value="Part-Time">Part-Time Employee</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>Position<span style="color:red;">*</span></th>
										<td>
											<select name="position">
												<option value="">-- Choose a value --</option>
												<option value="Administrator I">Administrator I</option>
												<option value="DBA">DBA</option>
												<option value="Project Director">Project Director</option>
												<option value="Project Manager">Project Manager</option>
												<option value="Documentation Clerk">Documentation Clerk</option>
												<option value="Teller">Teller</option>
												<option value="Benefits Analyst">Benefits Analyst</option>
												<option value="Development Manager">Development Manager</option>
												<option value="District Manager">District Manager</option>
												<option value="HR Liason">HR Liason</option>
												<option value="Marketing Intern">Marketing Intern</option>
												<option value="QA Manager">QA Manager</option>
												<option value="Sales Consultant">Sales Consultant</option>
												<option value="Sales Coordinator">Sales Coordinator</option>
												<option value="Sales Representative">Sales Representative</option>
												<option value="Software Engineer">Software Engineer</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>Location<span style="color:red;">*</span></th>
										<td>
											<select name="location">
												<option value="">-- Choose a value --</option>
												<option value="Santa Clara">Santa Clara</option>
												<option value="Sunnyvale">Sunnyvale</option>
												<option value="San Mateo">San Mateo</option>
												<option value="El Segundo">El Segundo</option>
												<option value="Costa Mesa">Costa Mesa</option>
												<option value="Encino">Encino</option>
												<option value="Dallas">Dallas</option>
												<option value="Chicago">Chicago</option>
												<option value="New York">New York</option>
												<option value="Cambridge">Cambridge</option>
											</select>
										</td>
									</tr>
									<tr><th>Active<span style="color:red;">*</span></th>
										<td>
											<select name="active">
												<option value="">-- Choose a value --</option>
												<option value="1">Yes, Active</option>
												<option value="0">No, Inactive</option>
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
												<option value="0">No</option>
												<option value="1">Yes, Manager</option>
											</select>
										</td>
									</tr>
									<tr><th>Manager<span style="color:red;">*</span></th>
										<td>
											<select name="managerid">
												<option value="">-- Choose a value --</option>
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
														int    oDUserID = rs.getInt("USERID");
														String oDFirstName = rs.getString("FIRSTNAME");
														String oDLastName = rs.getString("LASTNAME");
														%>
														<option value="<%= oDUserID %>"><%= oDLastName %>, <%= oDFirstName %></option>
														<%
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
											<!-- input type="text" name="managerid" value="" readonlyy="readonly"/ -->
											<!-- input type="text" name="managerfullname" value="" readonly="readonly"/> <a href="#">change</a -->
										</td>
									</tr>
									<tr><th>Cost Center<span style="color:red;">*</span></th>
										<td>
											<select name="costcenter">
												<option value="">-- Choose a value --</option>
												<option value="101">101 - Cost Center 101</option>
												<option value="102">101 - Cost Center 102</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>Department<span style="color:red;">*</span></th>
										<td>
											<select name="department">
												<option value="">-- Choose a value --</option>
												<option value="Corporate">Corporate</option>
												<option value="Engineering">Engineering</option>
												<option value="Global IT">Global IT</option>
												<option value="Marketing">Marketing</option>
												<option value="QA">QA</option>
												<option value="Sales">Sales</option>
											</select>
										</td>
									</tr>
									<tr><th>Is Head of Department?<span style="color:red;">*</span></th>
										<td>
											<select name="isheadofdepartment">
												<option value="">-- Choose a value --</option>
												<option value="0">No</option>
												<option value="1">Yes, Head of Department</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>Organization<span style="color:red;">*</span></th>
										<td>
											<select name="organization">
												<option value="">-- Choose a value --</option>
												<option value="Xellerate Users">Corporate</option>
											</select>
										</td>
									</tr>
									<tr><th>Start Date<span style="color:red;">*</span></th>
										<td>
											<script language="javascript">
												var cal1x = new CalendarPopup("testdiv1");
												cal1x.showNavigationDropdowns();
											</script>
											<input type="text" name="startdate" value="" readonly="readonly" style="color: #666;"/><a href="#" onclick="cal1x.select(document.forms[0].startdate,'anchor1x','yyyy-MM-dd'); return false;" TITLE="cal1x.select(document.forms[0].startdate,'anchor1x','yyyy-MM-dd'); return false;" NAME="anchor1x" ID="anchor1x"><img src="images/icon_calendar.gif" width="16" height="16" border="0" align="top"/></a><a href="#" onclick="document.forms[0].startdate.value = '';"><img src="images/icon_delete.gif" width="16" height="16" border="0" align="top"/></a>
										</td>
									</tr>
									<tr><th>End Date</th>
										<td>
											<script language="javascript">
												var cal2x = new CalendarPopup("testdiv1");
												cal2x.showNavigationDropdowns();
											</script>
											<input type="text" name="enddate" value="" readonly="readonly" style="color: #666;"/><a href="#" onclick="cal2x.select(document.forms[0].enddate,'anchor2x','yyyy-MM-dd'); return false;" TITLE="cal2x.select(document.forms[0].enddate,'anchor2x','yyyy-MM-dd'); return false;" NAME="anchor2x" ID="anchor2x"><img src="images/icon_calendar.gif" width="16" height="16" border="0" align="top"/></a><a href="#" onclick="document.forms[0].enddate.value = '';"><img src="images/icon_delete.gif" width="16" height="16" border="0" align="top"/></a>
										</td>
									</tr>
								</table>
							</div>
							<!-- div id="tabcommunication" class="tabbertab" style="overflow: auto;">
								<h2>Communication</h2>
								<table cellpadding="3" cellspacing="2" border="0">
									<tr><th>Mobile Phone Number</th><td><input type="text" name="phonemobile" value=""/></td></tr>
									<tr><th>Fix Phone Number</th><td><input type="text" name="phonefix" value=""/></td></tr>
									<tr><th>Facsimile Telephone Number</th><td><input type="text" name="phonefax" value=""/></td></tr>
								</table>
							</div -->
						</div>
						<div class="buttonbar" style="font-size: 80%;"><span style="color:red;">*</span> mandatory fields</div>
						<div class="buttonbar"><input type="submit" value="Create New Employee"/>&nbsp;<button onclick="document.location = 'search.jsp'; return false;">Cancel</button></div>
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
