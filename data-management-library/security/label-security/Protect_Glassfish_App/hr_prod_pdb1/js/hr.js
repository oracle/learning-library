function isNumeric(x) 
{
	var RegExp = /^(\d*)$/;
	var result = x.match(RegExp);
	return result;
}

function checkSearchForm( form )
{
	if ( !isNumeric( form.userid.value ) )
	{
		alert( "HR ID is not valid! Check the format (integer)" );
		form.userid.focus();
		return false;
	}
	return true;
}

function checkEmployeeForm( form )
{
	// var form = document.forms.employee_create;
	
	if ( form.firstname.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(0);
		alert( "Please provide a First Name!" );
		form.firstname.focus();
		return false;
	}
	
	if ( form.lastname.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(0);
		alert( "Please provide a Last Name!" );
		form.lastname.focus();
		return false;
	}
	
	if ( form.emptype.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(0);
		alert( "Please provide an Employee Type!" );
		form.emptype.focus();
		return false;
	}
	
	if ( form.position.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(0);
		alert( "Please provide a Position!" );
		form.position.focus();
		return false;
	}
	
	if ( form.location.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(0);
		alert( "Please provide a Location!" );
		form.location.focus();
		return false;
	}

	if ( form.active.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(0);
		alert( "Please specify if Employee is Active!" );
		form.active.focus();
		return false;
	}
								
	if ( form.ismanager.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(1);
		alert( "Please specify if Employee is Manager!" );
		form.ismanager.focus();
		return false;
	}
	
	if ( form.managerid.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(1);
		alert( "Please provide a Manager!" );
		form.managerid.focus();
		return false;
	}
								
	if ( form.costcenter.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(1);
		alert( "Please provide a Cost Center!" );
		form.costcenter.focus();
		return false;
	}

	if ( form.department.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(1);
		alert( "Please provide a Department!" );
		form.department.focus();
		return false;
	}
	
	if ( form.isheadofdepartment.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(1);
		alert( "Please specify if Employee is Head of Department!" );
		form.isheadofdepartment.focus();
		return false;
	}
	
	if ( form.organization.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(1);
		alert( "Please provide a Organization!" );
		form.organization.focus();
		return false;
	}
	
	if ( form.startdate.value == "" )
	{
		document.getElementById('tabemployee').tabber.tabShow(1);
		alert( "Please provide a Start Date!" );
		form.startdate.focus();
		return false;
	}

	return true;
}
