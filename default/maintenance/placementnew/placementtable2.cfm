<cfset readonly = "readonly">
<html>
<head>
<title><cfoutput>Placement</cfoutput> Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<style>
th{
	text-align:left;
	font-size:13px;
}
    
.leaveinput {
    width: 67px;
}
</style>

</head>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<script type="text/javascript" src="/scripts/prototype.js"></script>
<script type="text/javascript" src="/scripts/effects.js"></script>
<script type="text/javascript" src="/scripts/controls.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/collapse_expand_single_item.js"></script>

<!---<link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">--->
<!---<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">--->
<link rel="stylesheet" href="/latest/css/select2/select2.css" />  
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>   
<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>  
<script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
          
<script language="JavaScript">

// begin: customer search
function getSupp(type,option){
		var inputtext = document.PlacementForm.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
}

function getSuppResult(suppArray){
	DWRUtil.removeAllOptions("custno");
	DWRUtil.addOptions("custno", suppArray,"KEY", "VALUE");
}

// end: customer search


function validate(){
  if(document.PlacementForm.placementno.value==''){
	alert("Your Placement's No. cannot be blank.");
	document.PlacementForm.placementno.focus();
	return false;
  }

  function getDateObject(dateString,dateSeperator)
	{
	//This function return a date object after accepting 
	//a date string ans dateseparator as arguments
	var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;
	
	//extract day portion
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	
	//extract month portion 
	endPos=dateString.indexOf(sepChar,curPos+1); cMonth=dateString.substring(curPos+1,endPos);
	
	//extract year portion 
	curPos=endPos;
	endPos=curPos+5; 
	cYear=curValue.substring(curPos+1,endPos);
	
	//Create Date Object
	dtObject=new Date(cYear,cMonth,cDate); 
	return dtObject;
	}
	var startDate = getDateObject(document.PlacementForm.startdate.value,"/");
	var endDate = getDateObject(document.PlacementForm.completedate.value,"/");
	<!---
	if(startDate >= endDate){
	alert("Start date cannot be earlier than completed date");
	document.PlacementForm.startdate.focus();
	return false;
	}--->


  return true;
}

function limitText(field,maxlimit){
	if (field.value.length > maxlimit) // if too long...trim it!
		field.value = field.value.substring(0, maxlimit);
		// otherwise, update 'characters left' counter
}

function selectlist(varval,varattb){		
		for (var idx=0;idx<document.getElementById(varattb).options.length;idx++) 
		{
			if (varval==document.getElementById(varattb).options[idx].value) 
			{
				document.getElementById(varattb).options[idx].selected=true;
				
			}
		}
		}
		
function selectlist2(varval,varattb){		
	document.getElementById(varattb).value = varval; 
}

function updatearea()
{
selectlist(document.getElementById('location1').value,'location');
}
<cfoutput>
function workhrpt()
{
	<cfloop list="Tues,Wednes,Thurs,Fri" index="i">
	selectlist(document.getElementById('Monhr').value,'#i#hr');
	selectlist(document.getElementById('Monmina').value,'#i#mina');
	selectlist(document.getElementById('Monhre').value,'#i#hre');
	selectlist(document.getElementById('Monminae').value,'#i#minae');
	document.getElementById('#i#timestart').value = document.getElementById('Monhr').value +':'+ document.getElementById('Monmina').value+':00';
	document.getElementById('#i#timeoff').value = document.getElementById('Monhre').value +':'+ document.getElementById('Monminae').value+':00';
	
	document.getElementById('#i#breakhour').value = document.getElementById('Monbreakhour').value;
	document.getElementById('#i#totalhour').value = document.getElementById('Montotalhour').value;
	document.getElementById('#i#remark').value = document.getElementById('Monremark').value;
	</cfloop>
}
</cfoutput>

function makehour(dayvar)
{
	
	var timefrom = parseFloat(document.getElementById(dayvar+'hr').value);
	var minfrom = (parseFloat(document.getElementById(dayvar+'mina').value)/60+0.000001).toFixed(3);
	
	document.getElementById(dayvar+'timestart').value = document.getElementById(dayvar+'hr').value +':'+ document.getElementById(dayvar+'mina').value+':00';
	
	timefrom = parseFloat(timefrom) + parseFloat(minfrom);
	
	var timeto = parseFloat(document.getElementById(dayvar+'hre').value);
	var minto = (parseFloat(document.getElementById(dayvar+'minae').value)/60+0.000001).toFixed(3);
	
	document.getElementById(dayvar+'timeoff').value = document.getElementById(dayvar+'hre').value +':'+ document.getElementById(dayvar+'minae').value+':00';
	
	timeto = parseFloat(timeto) + parseFloat(minto);
	
	if(timefrom <= timeto)
	{
		var totalindex =  parseFloat(timeto) - parseFloat(timefrom);
	}
	else
	{
		var totalindex = document.getElementById(dayvar+'hr').options.length-parseFloat(timefrom) + parseFloat(timeto);
	}
	
	
	var totalhour = parseFloat((parseFloat(totalindex)+0.000001).toFixed(2));
	
	if(document.getElementById(dayvar+'breakhour').value == '')
	{
		document.getElementById(dayvar+'totalhour').value = totalhour;
	}
	else
	{
	document.getElementById(dayvar+'totalhour').value = totalhour-parseFloat(document.getElementById(dayvar+'breakhour').value);
	}
}

<!---auto fill in hr manager email, [20170118, Yew Yang]--->
function getHRmgrEmail(id, approver){
	
	jQuery.post("/default/maintenance/placementnew/AutoFillHrMgr.cfc?method=FillHrMgr&ReturnFormat=json",{"id":id},function(response){
			
			document.getElementById(approver).value = response.EMAIL;
			},"JSON");
}
<!---auto fill--->

function totalupnew()
{
	var adminfeenew = 0;
	if(document.getElementById('admin_fee1').checked == true && document.getElementById('admin_fee_fix_amt').value != '')
	{
		for(var i = 1; i <= 5;i++)
		{
		if(document.getElementById('employer_rate_'+i).value != '')
		{
		document.getElementById('adminfee'+i).value = parseFloat(document.getElementById('admin_fee_fix_amt').value).toFixed(2);
		}
		
		}
	}
	else if(document.getElementById('admin_fee2').checked == true && document.getElementById('admin_fee_fix_amt').value != '')
	{
		for(var i = 1; i <= 5;i++)
		{
		if(document.getElementById('employee_rate_'+i).value != '')
		{
		document.getElementById('adminfee'+i).value = (parseFloat(document.getElementById('employee_rate_'+i).value)*parseFloat(document.getElementById('admin_fee_fix_amt').value)/100).toFixed(2);
		}
		else
		{
		document.getElementById('adminfee'+i).value = 0;
		}
		
		}
	}
	
	if(document.getElementById('rebate').value != '')
	{
	for(var i = 1; i <= 5;i++)
		{
		if(document.getElementById('employer_rate_'+i).value != '')
		{
		document.getElementById('rebateamt'+i).value = parseFloat(document.getElementById('rebate').value).toFixed(2);
		}
		}
	}
		
}

function totalallup()
{
	
	for(var i = 1; i <= 5;i++)
	{
		var totalamountall = 0;
		if(document.getElementById('employer_rate_'+i).value != '')
		{
				totalupnew();
				if(document.getElementById('cpfamt'+i).value != '')
				{
					totalamountall = parseFloat(totalamountall) + parseFloat(document.getElementById('cpfamt'+i).value);
				}
				
				if(document.getElementById('sdfamt'+i).value != '')
				{
					totalamountall = parseFloat(totalamountall) + parseFloat(document.getElementById('sdfamt'+i).value);
				}
				document.getElementById('subtotalamt'+i).value = (parseFloat(document.getElementById('employer_rate_'+i).value) + parseFloat(totalamountall)).toFixed(2);
				
				if(	document.getElementById('adminfee'+i).value != '')
				{
					
					totalamountall = parseFloat(totalamountall) + parseFloat(document.getElementById('adminfee'+i).value);
				
				}
				if(	document.getElementById('rebateamt'+i).value != '')
				{
					
					totalamountall = parseFloat(totalamountall) - parseFloat(document.getElementById('rebateamt'+i).value);
				
				}
			document.getElementById('allamt'+i).value = (parseFloat(document.getElementById('employer_rate_'+i).value) + parseFloat(totalamountall)).toFixed(2);
		
		}
		
	}
}


function validateall()
{
	<cfif url.type eq "delete">
	return confirm('Are You Sure You Want To Delete?');
	<cfelse>
	if(document.getElementById('placementtype').value == "Temporary")
	{
		var msg = "";
		if(document.getElementById('startdate').value == '')
		{
			msg = msg + "Contract Start Date is Required\n";
		}
		if(document.getElementById('completedate').value == '')
		{
			msg = msg + "Contract End Date is Required\n";
		}
<!--- 		if(document.getElementById('emp_pay_d').value == '')
		{
			msg = msg + "Employee Pay Day is Required\n";
		} --->
		if(document.getElementById('assignmenttype').value == '')
		{
			msg = msg + "Invoice Type is Required\n";
		}
		if(document.getElementById('empno').value == '')
		{
			msg = msg + "Employee Number is Required\n";
		}
		<!--- if(document.getElementById('sex').value == '')
		{
			msg = msg + "Sex is Required\n";
		}
		if(document.getElementById('nric').value == '')
		{
			msg = msg + "NRIC is Required\n";
		}
		if(document.getElementById('clienttype').value == '')
		{
			msg = msg + "Rate Type is Required\n";
		} --->
		if(document.getElementById('eff_d_1').value == '')
		{
			msg = msg + "Effective Date is Required\n";
		}
		if(document.getElementById('employee_rate_1').value == '')
		{
			msg = msg + "Employee Rate is Required\n";
		}
		if(document.getElementById('employer_rate_1').value == '')
		{
			msg = msg + "Employer Rate is Required\n";
		}
		<!--- if(document.getElementById('wd_p_week').value == '')
		{
			msg = msg + "Work Days Per Week is Required\n";
		} --->
		
		if(msg != '')
		{
			alert(msg);
			return false;
		}
		
	}
	
	if(document.getElementById('placementtype').value == "Temporary")
	{
	if(contractsigndatevalid())
	{
		return true;
	}
	else
	{
		return false;
	}
	
	
	if(contractdatevalid())
	{
		return true;
	}
	else
	{
		return false;
	}
	}
	else{
	return true;
	}
	</cfif>
	
}

function contractdatevalid()
{
				var datef = document.getElementById('startdate').value;
				var datet = document.getElementById('completedate').value;
				var datefday = datef.substring(0,2) * 1;
				var datetday = datet.substring(0,2) * 1;
				var datefmonth = datef.substring(3,5) * 1;
				var datetmonth = datet.substring(3,5) * 1;
				var datefyear = datef.substring(6,10) * 1;
				var datetyear = datet.substring(6,10) * 1;
				
				if(datefyear > datetyear)
				{
				 alert("Contract End Date should be later than Contract Start Date");
				 return false;
				}
				else if( datefmonth > datetmonth && datefyear == datetyear)
				{
				 alert("Contract End Date should be later than Contract Start Date");
				 return false;
				}
				else if(datefday > datetday &&  datefmonth == datetmonth && datefyear == datetyear)
				{
				 alert("Contract End Date should be later than Contract Start Date");
				 return false;
				}
				else{
					return true;
				}
}

function contractsigndatevalid()
{
	return true;
				<!--- var datef = document.getElementById('placementdate').value;
				var datet = document.getElementById('startdate').value;
				var datefday = datef.substring(0,2) * 1;
				var datetday = datet.substring(0,2) * 1;
				var datefmonth = datef.substring(3,5) * 1;
				var datetmonth = datet.substring(3,5) * 1;
				var datefyear = datef.substring(6,10) * 1;
				var datetyear = datet.substring(6,10) * 1;
				
				if(datefyear > datetyear)
				{
				 alert("Contract Start Date should be later than Contract Sign Date");
				 return false;
				}
				else if( datefmonth > datetmonth && datefyear == datetyear)
				{
				 alert("Contract Start Date should be later than Contract Sign Date");
				 return false;
				}
				else if(datefday > datetday &&  datefmonth == datetmonth && datefyear == datetyear)
				{
				 alert("Contract Start Date should be later than Contract Sign Date");
				 return false;
				}
				else{
					return true;
				} --->
}


function showast(showit)
{
	
		for(var i = 1; i <= parseFloat(document.getElementById('astcount').value);i++)
		{
			if(showit == "Y")
				{
					document.getElementById('requiredcheck'+i).style.display = "inline";
				}
			else
				{
					document.getElementById('requiredcheck'+i).style.display = "none";
				}
		}
}
    
function calculateleave(leavetype)
{
    // || 0 will convert value from any "falsey" to 0. (NaN, null, undefined, etc)
    
    var totalleave = document.getElementById(leavetype+'totaldays');
    var leavedays = document.getElementById(leavetype+'days').value || 0;
    
    if(leavetype == 'AL')
    {
        if(document.getElementById(leavetype+'bfable').checked == true)
        {
            var leavecarryforward = parseFloat(document.getElementById(leavetype+'bfdays').value) || 0;
            totalleave.value = parseFloat(leavedays) + parseFloat(leavecarryforward);
        }
        else
        {
            totalleave.value = parseFloat(leavedays);
        }
    }
    else
    {
        totalleave.value = parseFloat(leavedays);
    }
    
    totalleave.value = totalleave.value || 0;
}
</script>

<cfset dts1 = replace(dts,'_i','_p','All')>

<!--- <cfquery name="getemployee" datasource="#dts#">
	SELECT *
	FROM #dts1#.pmast
</cfquery> --->

<cfquery name="getarea" datasource="#dts#">
	SELECT *
	FROM icarea
</cfquery>

<!--- <cfquery name="getcustno" datasource="#dts#">
	SELECT *
	FROM #target_arcust#
</cfquery> --->

<cfquery name="getagent" datasource="#dts#">
	SELECT *
	FROM icagent
</cfquery>

<cfquery name="getenduser" datasource="#dts#">
	SELECT *
	FROM driver
</cfquery>


<cfquery name="getproject" datasource="#dts#">
	SELECT *
	FROM #dts1#.project
</cfquery>

<cfquery name="getclaimlist" datasource="#dts#">
	SELECT wos_group,desp FROM icgroup
</cfquery>

<cfquery name="leavelist" datasource="#dts#">
Select * from iccostcode order by costcode
</cfquery>

<body>
<cfset newkey = 0>
<cfoutput>
	<cfif url.type eq "Edit" or (isdefined('url.placementno') and url.type eq "Create")>
		<cfquery datasource='#dts#' name="getitem">
			Select * from Placement where placementno='#url.placementno#'
		</cfquery>
		<cfif url.type eq "Create" and isdefined('url.placementno')>
        <cfquery name="getplacementno" datasource="#dts#">
        select max(right(placementno,6)) as placementno from placement
        </cfquery>
        <cfif getplacementno.recordcount eq 0>
        <cfset placementno='000001'>
        <cfelse>
        <cfif isnumeric(left(getplacementno.placementno,1)) eq false>
        <cfset placementno = right(getplacementno.placementno,6)>
        <cfset placementno=placementno + 1>
        <cfelse>
        <cfset placementno=getplacementno.placementno + 1>
        </cfif>
        
        
        </cfif>
        <cfset placementdate=dateformat(now(),'DD/MM/YYYY')>.
        <cfset placementno=getitem.location&placementno>
        <cfelse>
        <cfset placementno=getitem.placementno>
        <cfset placementdate=dateformat(getitem.placementdate,'DD/MM/YYYY')>
        </cfif>
		<cfset placementtype=getitem.placementtype>
        <cfset pm = getitem.pm>
        <cfset jobstatus = getitem.jobstatus>
        <cfset jostatus = getitem.jostatus>
        <cfset jobtype = getitem.jobtype>
        <cfset invoicegroup = getitem.invoicegroup>
        <cfset ottable = getitem.ottable>
        <cfset jobpostype = getitem.jobpostype>
        <cfset location = getitem.location>
        <cfset xcustno = getitem.custno>
        <cfset custname = getitem.custname>
        <cfset contactperson = getitem.contactperson>
        <cfset xconsultant = getitem.consultant>
        <cfset billto = getitem.billto>
        <cfset xjobcode = getitem.jobcode>
        <cfset position = getitem.position>
        <cfset xempno = getitem.empno>
        <cfset nric = getitem.nric>
        <cfset iname = getitem.iname>
        <cfset empname = getitem.empname>
        <cfset sex = getitem.sex>
        <!---<cfset duration = getitem.duration>--->
        <cfset startdate = dateformat(getitem.startdate,'DD/MM/YYYY')>
        <cfset completedate = dateformat(getitem.completedate,'DD/MM/YYYY')>
        <cfif getitem.completedate1 neq "0000-00-00">
        <cfset completedate1 = dateformat(getitem.completedate1,'DD/MM/YYYY')>
        <cfelse>
        <cfset completedate1 = "">
		</cfif>
        <cfif getitem.completedate2 neq "0000-00-00">
        <cfset completedate2 = dateformat(getitem.completedate2,'DD/MM/YYYY')>
        <cfelse>
        <cfset completedate2 = "">
		</cfif>
        <cfset clienttype = getitem.clienttype>
        <cfset assignmenttype=getitem.assignmenttype>
        
        <cfset po_no = getitem.po_no>
        <cfset po_date = dateformat(getitem.po_date,'DD/MM/YYYY')>
        <cfset po_amount = getitem.po_amount>
        <cfset description1 = getitem.description1>
        <cfset description2 = getitem.description2>
        <cfset emp_pay_d = getitem.emp_pay_d>
        <cfset bill_d = getitem.bill_d>
        <cfset approvalType = getitem.approvalType>
        <cfset hrMgr = getitem.hrMgr>
        <cfset hrMgrEmail = getitem.hrmgremail>
        <cfset verifier = getitem.verifier>
        <cfset verifieremail = getitem.verifieremail>
        <cfset mpPIC = getitem.mppic>
		<cfset mpPICEmail = getitem.mppicemail>
		<cfset mpPIC2 = getitem.mppic2>
		<cfset mpPICEmail2 = getitem.mppicemail2>
		<cfset mpPicSp = getitem.mppicsp>
		<cfset mpPicSpEmail = getitem.mppicspemail>
        <!---Added by Nieo 20171219 1158--->
        <cfset workorderid=getitem.workorderid>
        <cfset costcenter=getitem.costcenter>
        <cfset cLocation=getitem.cLocation>
        <cfset businessunit=getitem.businessunit>
        <cfset jobid=getitem.jobid>
        <cfset jobposting=getitem.jobposting>
        <cfset securityID=getitem.securityID>
        <cfset site=getitem.site>
        <!---Added by Nieo 20171219 1158--->
        <cfset option_to_ext = getitem.option_to_ext>
        <cfset department = getitem.department>
        <cfset supervisor = getitem.supervisor>
        <cfset timesheet = getitem.timesheet>
        <cfset system42 = getitem.system42>
        <cfset flexw = getitem.flexw>
        <cfset    refer_by_client = getitem.refer_by_client>
        <cfset    inc_bill_cpf = getitem.inc_bill_cpf>
        <cfset    cpf_amount = getitem.cpf_amount>
        <cfset    inc_bill_sdf = getitem.inc_bill_sdf>
        <cfset    sdf_amount = getitem.sdf_amount>
        <cfset    admin_fee = getitem.admin_fee>
        <cfset    admin_fee_fix_amt = getitem.admin_fee_fix_amt>
        <cfset adminfeepamt = getitem.adminfeepamt>
        <cfset    admin_f_min_amt = getitem.admin_f_min_amt>
        <cfset    rebate = getitem.rebate>
        <cfset    rebate_pro_rate = getitem.rebate_pro_rate>
        <cfset    eff_d_1 = dateformat(getitem.eff_d_1,'DD/MM/YYYY')>
        <cfset    eff_d_2 = dateformat(getitem.eff_d_2,'DD/MM/YYYY')>
        <cfset    eff_d_3 = dateformat(getitem.eff_d_3,'DD/MM/YYYY')>
        <cfset    eff_d_4 = dateformat(getitem.eff_d_4,'DD/MM/YYYY')>
        <cfset    eff_d_5 = dateformat(getitem.eff_d_5,'DD/MM/YYYY')>
        <cfset    employee_rate_1 = getitem.employee_rate_1>
        <cfset    employee_rate_2 = getitem.employee_rate_2>
        <cfset    employee_rate_3 = getitem.employee_rate_3>
        <cfset    employee_rate_4 = getitem.employee_rate_4>
        <cfset    employee_rate_5 = getitem.employee_rate_5>
        <cfset    employer_rate_1 = getitem.employer_rate_1>
        <cfset    employer_rate_2 = getitem.employer_rate_2>
        <cfset    employer_rate_3 = getitem.employer_rate_3>
        <cfset    employer_rate_4 = getitem.employer_rate_4>
        <cfset    employer_rate_5 = getitem.employer_rate_5>
        <cfset    allamt1 = getitem.allamt1>
        <cfset    allamt2 = getitem.allamt2>
        <cfset    allamt3 = getitem.allamt3>
        <cfset    allamt4 = getitem.allamt4>
        <cfset    allamt5 = getitem.allamt5>
        <cfset    adminfee1 = getitem.adminfee1>
        <cfset    adminfee2 = getitem.adminfee2>
        <cfset    adminfee3 = getitem.adminfee3>
        <cfset    adminfee4 = getitem.adminfee4>
        <cfset    adminfee5 = getitem.adminfee5>
        <cfset    cpfamt1 = getitem.cpfamt1>
        <cfset    cpfamt2 = getitem.cpfamt2>
        <cfset    cpfamt3 = getitem.cpfamt3>
        <cfset    cpfamt4 = getitem.cpfamt4>
        <cfset    cpfamt5 = getitem.cpfamt5>
        <cfset    sdfamt1 = getitem.sdfamt1>
        <cfset    sdfamt2 = getitem.sdfamt2>
        <cfset    sdfamt3 = getitem.sdfamt3>
        <cfset    sdfamt4 = getitem.sdfamt4>
        <cfset    sdfamt5 = getitem.sdfamt5>
        <cfset    subtotalamt1 = getitem.subtotalamt1>
        <cfset 	  subtotalamt2 = getitem.subtotalamt2>
        <cfset    subtotalamt3 = getitem.subtotalamt3>
        <cfset    subtotalamt4 = getitem.subtotalamt4>
        <cfset    subtotalamt5 = getitem.subtotalamt5>
        <cfset    rebateamt1 = getitem.rebateamt1>
        <cfset 	  rebateamt2 = getitem.rebateamt2>
        <cfset    rebateamt3 = getitem.rebateamt3>
        <cfset    rebateamt4 = getitem.rebateamt4>
        <cfset    rebateamt5 = getitem.rebateamt5>
        <cfset    bonuspayable = getitem.bonuspayable>
        <cfset    bonusbillable = getitem.bonusbillable>
        <cfset    bonusamt = getitem.bonusamt>
        <cfset    bonusdate = dateformat(getitem.bonusdate,'DD/MM/YYYY')>
        <cfset    awspayable = getitem.awspayable>
        <cfset    awsbillable = getitem.awsbillable>
        <cfset    awsamt = getitem.awsamt>
        <cfset    awsdate = dateformat(getitem.awsdate,'DD/MM/YYYY')>
        <cfset    bonusadmable = getitem.bonusadmable>
        <cfset    bonussdfable = getitem.bonussdfable>
        <cfset    bonuscpfable = getitem.bonuscpfable>
        <cfset    bonuswiable = getitem.bonuswiable>
        <cfset    awsadmable = getitem.awsadmable>
        <cfset    awssdfable = getitem.awssdfable>
        <cfset    awscpfable = getitem.awscpfable>
        <cfset    awswiable = getitem.awswiable>
        <cfset    phpayable = getitem.phpayable>
        <cfset    phbillable = getitem.phbillable>
        <cfset    phdate = dateformat(getitem.phdate,'DD/MM/YYYY')>
        <cfloop query="getclaimlist">
        <cfset    "#getclaimlist.wos_group#payable" = evaluate("getitem.#getclaimlist.wos_group#payable")>
        <cfset    "#getclaimlist.wos_group#billable" = evaluate("getitem.#getclaimlist.wos_group#billable")>
        <cfset    "per#getclaimlist.wos_group#claimcap" = evaluate("getitem.per#getclaimlist.wos_group#claimcap")>
        <cfset    "#getclaimlist.wos_group#claimdate" = dateformat(evaluate("getitem.#getclaimlist.wos_group#claimdate"),'DD/MM/YYYY')>
        <cfset    "total#getclaimlist.wos_group#claimable" = evaluate("getitem.total#getclaimlist.wos_group#claimable")>
        <cfset    "#getclaimlist.wos_group#claimedamt" = evaluate("getitem.#getclaimlist.wos_group#claimedamt")>
        </cfloop>
 
        <cfset    ALbfdays = getitem.ALbfdays>
        <cfset    ALtype = getitem.ALtype>
        <cfset    ALbfable = getitem.ALbfable>
        <cfloop query="leavelist">
        <cfset    "#leavelist.costcode#entitle" = evaluate('getitem.#leavelist.costcode#entitle')>
        <cfset    "#leavelist.costcode#payable1" = evaluate('getitem.#leavelist.costcode#payable1')>
        <cfset    "#leavelist.costcode#billable1" = evaluate('getitem.#leavelist.costcode#billable1')>
        <cfset    "#leavelist.costcode#date" = dateformat(evaluate('getitem.#leavelist.costcode#date'),'DD/MM/YYYY')>
        <cfset    "#leavelist.costcode#days" = evaluate('getitem.#leavelist.costcode#days')>
        <cfset    "#leavelist.costcode#totaldays" = evaluate('getitem.#leavelist.costcode#totaldays')>
        <cfset    "#leavelist.costcode#earndays" = evaluate('getitem.#leavelist.costcode#earndays')>
        <cfset    "#leavelist.costcode#earntype" = evaluate('getitem.#leavelist.costcode#earntype')>
        <cfset    "#leavelist.costcode#remarks" = evaluate('getitem.#leavelist.costcode#remarks')>
        </cfloop>       
        <cfset    allowancedesp1 = getitem.allowancedesp1>
        <cfset    allowancedesp2 = getitem.allowancedesp2>
        <cfset    allowancedesp3 = getitem.allowancedesp3>
        <cfset    allowanceamt1 = getitem.allowanceamt1>
        <cfset    allowanceamt2 = getitem.allowanceamt2>
        <cfset    allowanceamt3 = getitem.allowanceamt3>
        <cfset    allowancebillable1 = getitem.allowancebillable1>
        <cfset    allowancebillable2 = getitem.allowancebillable2>
        <cfset    allowancebillable3 = getitem.allowancebillable3>
        <cfset    allowancepayable1 = getitem.allowancepayable1>
        <cfset    allowancepayable2 = getitem.allowancepayable2>
        <cfset    allowancepayable3 = getitem.allowancepayable3>
        <cfset    prorated1 = getitem.prorated1>
        <cfset    prorated2 = getitem.prorated2>
        <cfset    prorated3 = getitem.prorated3>
        <cfset    billableitem1 = getitem.billableitem1>
        <cfset    billableitem2 = getitem.billableitem2>
        <cfset    billableitem3 = getitem.billableitem3>
        <cfset    billableitemamt1 = getitem.billableitemamt1>
        <cfset    billableitemamt2 = getitem.billableitemamt2>
        <cfset    billableitemamt3 = getitem.billableitemamt3>
        <cfset    billableprorated1 = getitem.billableprorated1>
        <cfset    billableprorated2 = getitem.billableprorated2>
        <cfset    billableprorated3 = getitem.billableprorated3>
        <cfloop from="4" to="6" index="bb">
        <cfset "billableitem#bb#" = evaluate('getitem.billableitem#bb#')>
        <cfset "billableitemamt#bb#" = evaluate('getitem.billableitemamt#bb#')>
        <cfset "billableprorated#bb#" = "">
        </cfloop>
        <cfset    wd_p_week = getitem.wd_p_week>
        <cfset    Montimestart = getitem.Montimestart>
        <cfset    Montimeoff = getitem.Montimeoff>
        <cfset    Monbreakhour = getitem.Monbreakhour>
        <cfset    Montotalhour = getitem.Montotalhour>
        <cfset    Monremark = getitem.Monremark>
        <cfset    Tuestimestart = getitem.Tuestimestart>
        <cfset    Tuestimeoff = getitem.Tuestimeoff>
        <cfset    Tuesbreakhour = getitem.Tuesbreakhour>
        <cfset    Tuestotalhour = getitem.Tuestotalhour>
        <cfset    Tuesremark = getitem.Tuesremark>
        <cfset    Wednestimestart = getitem.Wednestimestart>
        <cfset    Wednestimeoff = getitem.Wednestimeoff>
        <cfset    Wednesbreakhour = getitem.Wednesbreakhour>
        <cfset    Wednestotalhour = getitem.Wednestotalhour>
        <cfset    Wednesremark = getitem.Wednesremark>
        <cfset    Thurstimestart = getitem.Thurstimestart>
        <cfset    Thurstimeoff = getitem.Thurstimeoff>
        <cfset    Thursbreakhour = getitem.Thursbreakhour>
        <cfset    Thurstotalhour = getitem.Thurstotalhour>
        <cfset    Thursremark = getitem.Thursremark>
        <cfset    Thurstimestart = getitem.Thurstimestart>
        <cfset Fritimestart = getitem.Fritimestart>
        <cfset    Fritimeoff = getitem.Fritimeoff>
        <cfset    Fribreakhour = getitem.Fribreakhour>
        <cfset    Fritotalhour = getitem.Fritotalhour>
        <cfset    Friremark = getitem.Friremark>
        <cfset    Saturtimestart = getitem.Saturtimestart>
        <cfset    Saturtimeoff = getitem.Saturtimeoff>
        <cfset    Saturbreakhour = getitem.Saturbreakhour>
        <cfset    Saturtotalhour = getitem.Saturtotalhour>
        <cfset    Saturremark = getitem.Saturremark>
        <cfset    Suntimestart = getitem.Suntimestart>
        <cfset    Suntimeoff = getitem.Suntimeoff>
        <cfset    Sunbreakhour = getitem.Sunbreakhour>
        <cfset    Suntotalhour = getitem.Suntotalhour>
        <cfset    Sunremark = getitem.Sunremark>
        <cfloop list="Mon,Tues,Wednes,Thurs,Fri,Satur,Sun" index="i">
        <cfset "#i#halfday" = evaluate('getitem.#i#halfday')>
        </cfloop>
        <cfset 	sps = getitem.sps>
        <cfset    pub_holiday_phpd = getitem.pub_holiday_phpd>
        <cfset    ann_leav_phpd = getitem.ann_leav_phpd>
        <cfset    medic_leav_phpd = getitem.medic_leav_phpd>
        <cfset    hosp_leav_phpd = getitem.hosp_leav_phpd>
        <cfset aw1 = getitem.aw1>
        <cfset aw2 = getitem.aw2>
		<cfset aw3 = getitem.aw3>
        <cfloop from="4" to="6" index="aa">
        <cfset "aw#aa#" = evaluate('getitem.aw#aa#')>
        <cfset "allowancedesp#aa#" = evaluate('getitem.allowancedesp#aa#')>
        <cfset "allowanceamt#aa#" = evaluate('getitem.allowanceamt#aa#')>
        <cfset "allowancebillable#aa#" = evaluate('getitem.allowancebillable#aa#')>
        <cfset "allowancepayable#aa#" = evaluate('getitem.allowancepayable#aa#')>
        <cfset "prorated#aa#" = ''>
        </cfloop>
        <cfif url.type eq "Create" and isdefined('url.placementno')>
        <cfset mode="Create">
		<!--- <cfset title="Create Item"> --->
		<cfset title="Create Placement">
		<cfset button="Save">
        <cfelse>
		<cfset mode="Edit">
		<!--- <cfset title="Edit Item"> --->
		<cfset title="Edit Placement">
		<cfset button="Save">
	</cfif>
	<cfelseif url.type eq "Delete">
		<cfquery datasource='#dts#' name="getitem">
			Select * from Placement where placementno='#url.placementno#'
		</cfquery>
		
		<cfset placementno=getitem.placementno>
		<cfset placementdate=dateformat(getitem.placementdate,'DD/MM/YYYY')>
		<cfset placementtype=getitem.placementtype>
        <cfset pm = getitem.pm>
        <cfset jobstatus = getitem.jobstatus>
        <cfset jostatus = getitem.jostatus>
        <cfset jobtype = getitem.jobtype>
        <cfset invoicegroup = getitem.invoicegroup>
        <cfset ottable = getitem.ottable>
        <cfset jobpostype = getitem.jobpostype>
        <cfset location = getitem.location>
        <cfset xcustno = getitem.custno>
        <cfset custname = getitem.custname>
        <cfset contactperson = getitem.contactperson>
        <cfset xconsultant = getitem.consultant>
        <cfset billto = getitem.billto>
        <cfset xjobcode = getitem.jobcode>
        <cfset position = getitem.position>
        <cfset xempno = getitem.empno>
        <cfset nric = getitem.nric>
        <cfset iname = getitem.iname>
        <cfset sex = getitem.sex>
        <cfset empname = getitem.empname>
        <!---<cfset duration = getitem.duration>--->
        <cfset startdate = dateformat(getitem.startdate,'DD/MM/YYYY')>
        <cfset completedate = dateformat(getitem.completedate,'DD/MM/YYYY')>
        <cfif getitem.completedate1 neq "0000-00-00">
        <cfset completedate1 = dateformat(getitem.completedate1,'DD/MM/YYYY')>
        <cfelse>
        <cfset completedate1 = "">
		</cfif>
        <cfif getitem.completedate2 neq "0000-00-00">
        <cfset completedate2 = dateformat(getitem.completedate2,'DD/MM/YYYY')>
        <cfelse>
        <cfset completedate2 = "">
		</cfif>
        <cfset clienttype = getitem.clienttype>
        <cfset assignmenttype=getitem.assignmenttype>
        
        <cfset po_no = getitem.po_no>
        <cfset po_date = dateformat(getitem.po_date,'DD/MM/YYYY')>
        <cfset po_amount = getitem.po_amount>
        <cfset description1 = getitem.description1>
        <cfset description2 = getitem.description2>
        <cfset emp_pay_d = getitem.emp_pay_d>
        <cfset bill_d = getitem.bill_d>
        <cfset option_to_ext = getitem.option_to_ext>
        <cfset    department = getitem.department>
         <cfset supervisor = getitem.supervisor>
        <cfset timesheet = getitem.timesheet>
        <cfset system42 = getitem.system42>
        <cfset flexw = getitem.flexw>
        <cfset    refer_by_client = getitem.refer_by_client>
        <cfset    inc_bill_cpf = getitem.inc_bill_cpf>
        <cfset    cpf_amount = getitem.cpf_amount>
        <cfset    inc_bill_sdf = getitem.inc_bill_sdf>
        <cfset    sdf_amount = getitem.sdf_amount>
        <cfset    admin_fee = getitem.admin_fee>
        <cfset    admin_fee_fix_amt = getitem.admin_fee_fix_amt>
        <cfset adminfeepamt = getitem.adminfeepamt>
        <cfset    admin_f_min_amt = getitem.admin_f_min_amt>
        <cfset    rebate = getitem.rebate>
        <cfset    rebate_pro_rate = getitem.rebate_pro_rate>
       	<cfset    eff_d_1 = dateformat(getitem.eff_d_1,'DD/MM/YYYY')>
        <cfset    eff_d_2 = dateformat(getitem.eff_d_2,'DD/MM/YYYY')>
        <cfset    eff_d_3 = dateformat(getitem.eff_d_3,'DD/MM/YYYY')>
        <cfset    eff_d_4 = dateformat(getitem.eff_d_4,'DD/MM/YYYY')>
        <cfset    eff_d_5 = dateformat(getitem.eff_d_5,'DD/MM/YYYY')>
        <cfset    employee_rate_1 = getitem.employee_rate_1>
        <cfset    employee_rate_2 = getitem.employee_rate_2>
        <cfset    employee_rate_3 = getitem.employee_rate_3>
        <cfset    employee_rate_4 = getitem.employee_rate_4>
        <cfset    employee_rate_5 = getitem.employee_rate_5>
        <cfset    employer_rate_1 = getitem.employer_rate_1>
        <cfset    employer_rate_2 = getitem.employer_rate_2>
        <cfset    employer_rate_3 = getitem.employer_rate_3>
        <cfset    employer_rate_4 = getitem.employer_rate_4>
        <cfset    employer_rate_5 = getitem.employer_rate_5>
        <cfset    allamt1 = getitem.allamt1>
        <cfset    allamt2 = getitem.allamt2>
        <cfset    allamt3 = getitem.allamt3>
        <cfset    allamt4 = getitem.allamt4>
        <cfset    allamt5 = getitem.allamt5>
        <cfset    adminfee1 = getitem.adminfee1>
        <cfset    adminfee2 = getitem.adminfee2>
        <cfset    adminfee3 = getitem.adminfee3>
        <cfset    adminfee4 = getitem.adminfee4>
        <cfset    adminfee5 = getitem.adminfee5>
        <cfset    cpfamt1 = getitem.cpfamt1>
        <cfset    cpfamt2 = getitem.cpfamt2>
        <cfset    cpfamt3 = getitem.cpfamt3>
        <cfset    cpfamt4 = getitem.cpfamt4>
        <cfset    cpfamt5 = getitem.cpfamt5>
        <cfset    sdfamt1 = getitem.sdfamt1>
        <cfset    sdfamt2 = getitem.sdfamt2>
        <cfset    sdfamt3 = getitem.sdfamt3>
        <cfset    sdfamt4 = getitem.sdfamt4>
        <cfset    sdfamt5 = getitem.sdfamt5>
        <cfset    subtotalamt1 = getitem.subtotalamt1>
        <cfset 	  subtotalamt2 = getitem.subtotalamt2>
        <cfset    subtotalamt3 = getitem.subtotalamt3>
        <cfset    subtotalamt4 = getitem.subtotalamt4>
        <cfset    subtotalamt5 = getitem.subtotalamt5>
        <cfset    rebateamt1 = getitem.rebateamt1>
        <cfset 	  rebateamt2 = getitem.rebateamt2>
        <cfset    rebateamt3 = getitem.rebateamt3>
        <cfset    rebateamt4 = getitem.rebateamt4>
        <cfset    rebateamt5 = getitem.rebateamt5>
        <cfset    bonuspayable = getitem.bonuspayable>
        <cfset    bonusbillable = getitem.bonusbillable>
        <cfset    bonusamt = getitem.bonusamt>
        <cfset    bonusdate = dateformat(getitem.bonusdate,'DD/MM/YYYY')>
        <cfset    awspayable = getitem.awspayable>
        <cfset    awsbillable = getitem.awsbillable>
        <cfset    awsamt = getitem.awsamt>
        <cfset    awsdate = dateformat(getitem.awsdate,'DD/MM/YYYY')>
        <cfset    bonusadmable = getitem.bonusadmable>
        <cfset    bonussdfable = getitem.bonussdfable>
        <cfset    bonuscpfable = getitem.bonuscpfable>
        <cfset    bonuswiable = getitem.bonuswiable>
        <cfset    awsadmable = getitem.awsadmable>
        <cfset    awssdfable = getitem.awssdfable>
        <cfset    awscpfable = getitem.awscpfable>
        <cfset    awswiable = getitem.awswiable>
        <cfset    phpayable = getitem.phpayable>
        <cfset    phbillable = getitem.phbillable>
        <cfset    phdate = dateformat(getitem.phdate,'DD/MM/YYYY')>
        <cfloop query="getclaimlist">
        <cfset    "#getclaimlist.wos_group#payable" = evaluate("getitem.#getclaimlist.wos_group#payable")>
        <cfset    "#getclaimlist.wos_group#billable" = evaluate("getitem.#getclaimlist.wos_group#billable")>
        <cfset    "per#getclaimlist.wos_group#claimcap" = evaluate("getitem.per#getclaimlist.wos_group#claimcap")>
        <cfset    "total#getclaimlist.wos_group#claimable" = evaluate("getitem.total#getclaimlist.wos_group#claimable")>
        <cfset    "#getclaimlist.wos_group#claimdate" = dateformat(evaluate("getitem.#getclaimlist.wos_group#claimdate"),'DD/MM/YYYY')>
         <cfset    "#getclaimlist.wos_group#claimedamt" = evaluate("getitem.#getclaimlist.wos_group#claimedamt")>
        </cfloop>
         <cfloop query="leavelist">
        <cfset    "#leavelist.costcode#entitle" = evaluate('getitem.#leavelist.costcode#entitle')>
        <cfset    "#leavelist.costcode#payable1" = evaluate('getitem.#leavelist.costcode#payable1')>
        <cfset    "#leavelist.costcode#billable1" = evaluate('getitem.#leavelist.costcode#billable1')>
        <cfset    "#leavelist.costcode#date" = dateformat(evaluate('getitem.#leavelist.costcode#date'),'DD/MM/YYYY')>
        <cfset    "#leavelist.costcode#days" = evaluate('getitem.#leavelist.costcode#days')>
        <cfset    "#leavelist.costcode#totaldays" = evaluate('getitem.#leavelist.costcode#totaldays')>
        <cfset    "#leavelist.costcode#earndays" = evaluate('getitem.#leavelist.costcode#earndays')>
        <cfset    "#leavelist.costcode#earntype" = evaluate('getitem.#leavelist.costcode#earntype')>
        <cfset    "#leavelist.costcode#remarks" = evaluate('getitem.#leavelist.costcode#remarks')>
        </cfloop>  
        <cfset    ALbfdays = getitem.ALbfdays>
        <cfset    ALtype = getitem.ALtype>
        <cfset    ALbfable = getitem.ALbfable>
        <cfset    allowancedesp1 = getitem.allowancedesp1>
        <cfset    allowancedesp2 = getitem.allowancedesp2>
        <cfset    allowancedesp3 = getitem.allowancedesp3>
        <cfset    allowanceamt1 = getitem.allowanceamt1>
        <cfset    allowanceamt2 = getitem.allowanceamt2>
        <cfset    allowanceamt3 = getitem.allowanceamt3>
        <cfset    allowancebillable1 = getitem.allowancebillable1>
        <cfset    allowancebillable2 = getitem.allowancebillable2>
        <cfset    allowancebillable3 = getitem.allowancebillable3>
        <cfset    allowancepayable1 = getitem.allowancepayable1>
        <cfset    allowancepayable2 = getitem.allowancepayable2>
        <cfset    allowancepayable3 = getitem.allowancepayable3>
        <cfset    prorated1 = getitem.prorated1>
        <cfset    prorated2 = getitem.prorated2>
        <cfset    prorated3 = getitem.prorated3>
        <cfset    billableitem1 = getitem.billableitem1>
        <cfset    billableitem2 = getitem.billableitem2>
        <cfset    billableitem3 = getitem.billableitem3>
        <cfset    billableitemamt1 = getitem.billableitemamt1>
        <cfset    billableitemamt2 = getitem.billableitemamt2>
        <cfset    billableitemamt3 = getitem.billableitemamt3>
        <cfset    billableprorated1 = getitem.billableprorated1>
        <cfset    billableprorated2 = getitem.billableprorated2>
        <cfset    billableprorated3 = getitem.billableprorated3>
        <cfloop from="4" to="6" index="bb">
        <cfset "billableitem#bb#" = evaluate('getitem.billableitem#bb#')>
        <cfset "billableitemamt#bb#" = evaluate('getitem.billableitemamt#bb#')>
        <cfset "billableprorated#bb#" = "">
        </cfloop>
        <cfset    wd_p_week = getitem.wd_p_week>
        <cfset    Montimestart = getitem.Montimestart>
        <cfset    Montimeoff = getitem.Montimeoff>
        <cfset    Monbreakhour = getitem.Monbreakhour>
        <cfset    Montotalhour = getitem.Montotalhour>
        <cfset    Monremark = getitem.Monremark>
        <cfset    Tuestimestart = getitem.Tuestimestart>
        <cfset    Tuestimeoff = getitem.Tuestimeoff>
        <cfset    Tuesbreakhour = getitem.Tuesbreakhour>
        <cfset    Tuestotalhour = getitem.Tuestotalhour>
        <cfset    Tuesremark = getitem.Tuesremark>
        <cfset    Wednestimestart = getitem.Wednestimestart>
        <cfset    Wednestimeoff = getitem.Wednestimeoff>
        <cfset    Wednesbreakhour = getitem.Wednesbreakhour>
        <cfset    Wednestotalhour = getitem.Wednestotalhour>
        <cfset    Wednesremark = getitem.Wednesremark>
        <cfset    Thurstimestart = getitem.Thurstimestart>
        <cfset    Thurstimeoff = getitem.Thurstimeoff>
        <cfset    Thursbreakhour = getitem.Thursbreakhour>
        <cfset    Thurstotalhour = getitem.Thurstotalhour>
        <cfset    Thursremark = getitem.Thursremark>
        <cfset    Fritimestart = getitem.Fritimestart>
        <cfset    Fritimeoff = getitem.Fritimeoff>
        <cfset    Fribreakhour = getitem.Fribreakhour>
        <cfset    Fritotalhour = getitem.Fritotalhour>
        <cfset    Friremark = getitem.Friremark>
        <cfset    Saturtimestart = getitem.Saturtimestart>
        <cfset    Saturtimeoff = getitem.Saturtimeoff>
        <cfset    Saturbreakhour = getitem.Saturbreakhour>
        <cfset    Saturtotalhour = getitem.Saturtotalhour>
        <cfset    Saturremark = getitem.Saturremark>
        <cfset    Suntimestart = getitem.Suntimestart>
        <cfset    Suntimeoff = getitem.Suntimeoff>
        <cfset    Sunbreakhour = getitem.Sunbreakhour>
        <cfset    Suntotalhour = getitem.Suntotalhour>
        <cfset    Sunremark = getitem.Sunremark>
        <cfloop list="Mon,Tues,Wednes,Thurs,Fri,Satur,Sun" index="i">
        <cfset "#i#halfday" = evaluate('getitem.#i#halfday')>
        </cfloop>
        <cfset    sps = getitem.sps>
        <cfset    pub_holiday_phpd = getitem.pub_holiday_phpd>
        <cfset    ann_leav_phpd = getitem.ann_leav_phpd>
        <cfset    medic_leav_phpd = getitem.medic_leav_phpd>
        <cfset    hosp_leav_phpd = getitem.hosp_leav_phpd>
		 <cfset aw1 = getitem.aw1>
        <cfset aw2 = getitem.aw2>
		<cfset aw3 = getitem.aw3>
        <cfloop from="4" to="6" index="aa">
        <cfset "aw#aa#" = evaluate('getitem.aw#aa#')>
        <cfset "allowancedesp#aa#" = evaluate('getitem.allowancedesp#aa#')>
        <cfset "allowanceamt#aa#" = evaluate('getitem.allowanceamt#aa#')>
        <cfset "allowancebillable#aa#" = evaluate('getitem.allowancebillable#aa#')>
        <cfset "allowancepayable#aa#" = evaluate('getitem.allowancepayable#aa#')>
        <cfset "prorated#aa#" = ''>
        </cfloop>
		<cfset mode="Delete">
		<!--- <cfset title="Delete Item"> --->
		<cfset title="Delete Placement">
		<cfset button="Delete">
	
	<cfelseif url.type eq "Create">
    <cfquery name="getplacementno" datasource="#dts#">
    select max(right(placementno,6)) as placementno from placement
    </cfquery>
    <cfif getplacementno.recordcount eq 0>
		<cfset placementno='000001'>
    <cfelse>
        <cfif isnumeric(left(getplacementno.placementno,1)) eq false>
        <cfset placementno = right(getplacementno.placementno,6)>
        <cfset placementno=Val(placementno) + 1>
        <cfelse>
        <cfset placementno=getplacementno.placementno + 1>
        </cfif>
      
        
     </cfif>
        
		<cfset placementdate=dateformat(now(),'dd/mm/yyyy')>
		<cfset placementtype=''>
        <cfset pm = ''>
        <cfset jobstatus = ''>
        <cfset jostatus = ''>
        <cfset jobtype = ''>
        <cfset invoicegroup = ''>
        <cfset ottable = ''>
        <cfset jobpostype = ''>
        <cfset location = ''>
        <cfset xcustno = ''>
        <cfset custname = ''>
        <cfset contactperson = ''>
        <cfset xconsultant = ''>
        <cfset billto = ''>
        <cfset xjobcode = ''>
        <cfset position = ''>
        <cfset xempno = ''>
        <cfset nric = ''>
        <cfset iname = ''>
        <cfset empname = ''>
        <cfset sex = ''>
        <!---<cfset duration = ''>--->
        <cfset startdate = ''>
        <cfset completedate = ''>
        <cfset completedate1 = ''>
        <cfset completedate2 = ''>
        <cfset clienttype = ''>
		<cfset assignmenttype=''>
        
        <cfset po_no = ''>
        <cfset po_date = ''>
        <cfset po_amount = '0.00'>
        <cfset description1 = ''>
        <cfset description2 = ''>
        <cfset emp_pay_d = ''>
        <cfset bill_d = ''>
        <cfset approvalType = ''>
        <cfset hrMgr = ''>
        <cfset hrMgrEmail = ''>
        <cfset verifier = ''>
        <cfset verifieremail = ''>
        <cfset mpPIC = ''>
		<cfset mpPICEmail = ''>
		<cfset mpPIC2 = ''>
		<cfset mpPICEmail2 = ''>
		<cfset mpPicSp = ''>
		<cfset mpPicSpEmail = ''>
        <cfset option_to_ext = ''>
        <cfset department = ''>
        <cfset supervisor = ''>
        <cfset timesheet = ''>
        <cfset system42 = ''>
        <cfset flexw = ''>
        <cfset    refer_by_client = ''>
        <cfset    inc_bill_cpf = ''>
        <cfset    cpf_amount = ''>
        <cfset    inc_bill_sdf = ''>
        <cfset    sdf_amount = ''>
        <cfset    admin_fee = 'yes'>
        <cfset    admin_fee_fix_amt = ''>
        <cfset 	  adminfeepamt = ''>
        <cfset    admin_f_min_amt = ''>
        <cfset    rebate = ''>
        <cfset    rebate_pro_rate = ''>
        <cfset    eff_d_1= ''>
        <cfset    eff_d_2 = ''>
        <cfset    eff_d_3 = ''>
        <cfset    eff_d_4 = ''>
        <cfset    eff_d_5 = ''>
        <cfset    employee_rate_1 = ''>
        <cfset    employee_rate_2 = ''>
        <cfset    employee_rate_3 = ''>
        <cfset    employee_rate_4 = ''>
        <cfset    employee_rate_5 = ''>
        <cfset    employer_rate_1 = ''>
        <cfset    employer_rate_2 = ''>
        <cfset    employer_rate_3 = ''>
        <cfset    employer_rate_4 = ''>
        <cfset    employer_rate_5 = ''>
        <cfset    allamt1 = ''>
        <cfset    allamt2 = ''>
        <cfset    allamt3 = ''>
        <cfset    allamt4 = ''>
        <cfset    allamt5 = ''>
        <cfset    adminfee1 = ''>
        <cfset    adminfee2 = ''>
        <cfset    adminfee3 = ''>
        <cfset    adminfee4 = ''>
        <cfset    adminfee5 = ''>
        <cfset    cpfamt1 = ''>
        <cfset    cpfamt2 = ''>
        <cfset    cpfamt3 = ''>
        <cfset    cpfamt4 = ''>
        <cfset    cpfamt5 = ''>
        <cfset    sdfamt1 = ''>
        <cfset    sdfamt2 = ''>
        <cfset    sdfamt3 = ''>
        <cfset    sdfamt4 = ''>
        <cfset    sdfamt5 = ''>
        <cfset    subtotalamt1 = ''>
        <cfset 	  subtotalamt2 = ''>
        <cfset    subtotalamt3 = ''>
        <cfset    subtotalamt4 = ''>
        <cfset    subtotalamt5 = ''>
        <cfset    rebateamt1 = ''>
        <cfset 	  rebateamt2 = ''>
        <cfset    rebateamt3 = ''>
        <cfset    rebateamt4 = ''>
        <cfset    rebateamt5 = ''>
        <cfset    bonuspayable = ''>
        <cfset    bonusbillable = ''>
        <cfset    bonusamt = '0.00'>
        <cfset    bonusdate = ''>
        <cfset    awspayable = ''>
        <cfset    awsbillable = ''>
        <cfset    awsamt = ''>
        <cfset    awsdate = ''>
        <cfset    bonusadmable = ''>
        <cfset    bonussdfable = ''>
        <cfset    bonuscpfable = ''>
        <cfset    bonuswiable = ''>
        <cfset    awsadmable = ''>
        <cfset    awssdfable = ''>
        <cfset    awscpfable = ''>
        <cfset    awswiable = ''>
        <cfset    mcpayable = ''>
        <cfloop query="getclaimlist">
        <cfset    "#getclaimlist.wos_group#payable" = "">
        <cfset    "#getclaimlist.wos_group#billable" = "">
        <cfset    "per#getclaimlist.wos_group#claimcap" = "">
        <cfset    "total#getclaimlist.wos_group#claimable" = "">
        <cfset    "#getclaimlist.wos_group#claimdate" ="">
        <cfset    "#getclaimlist.wos_group#claimedamt" ="">
        </cfloop>
        <cfloop query="leavelist">
        <cfif leavelist.costcode eq "NPL">
        	<cfset "#leavelist.costcode#entitle" = "Y">
		<cfelse>
        	<cfset "#leavelist.costcode#entitle" = "">
        </cfif>
        <cfset    "#leavelist.costcode#payable1" = "">
        <cfset    "#leavelist.costcode#billable1" = "">
        <cfset    "#leavelist.costcode#date" = "">
        <cfset    "#leavelist.costcode#days" = "">
        <cfset    "#leavelist.costcode#totaldays" = "">
        <cfset    "#leavelist.costcode#earndays" = "">
        <cfset    "#leavelist.costcode#earntype" = "">
        <cfset    "#leavelist.costcode#remarks" = "">
        </cfloop>  
        <cfset    ALbfdays = '0'>
        <cfset    ALtype = ''>
        <cfset    ALbfable = ''>
        <cfset    allowancedesp1 = ''>
        <cfset    allowancedesp2 = ''>
        <cfset    allowancedesp3 = ''>
        <cfset    allowanceamt1 = ''>
        <cfset    allowanceamt2 = ''>
        <cfset    allowanceamt3 = ''>
        <cfset    allowancebillable1 = ''>
        <cfset    allowancebillable2 = ''>
        <cfset    allowancebillable3 = ''>
        <cfset    allowancepayable1 = ''>
        <cfset    allowancepayable2 = ''>
        <cfset    allowancepayable3 = ''>
        <cfset    prorated1 = ''>
        <cfset    prorated2 = ''>
        <cfset    prorated3 = ''>
        <cfset    billableitem1 = ''>
        <cfset    billableitem2 = ''>
        <cfset    billableitem3 = ''>
        <cfset    billableitemamt1 = ''>
        <cfset    billableitemamt2 = ''>
        <cfset    billableitemamt3 = ''>
        <cfset    billableprorated1 = ''>
        <cfset    billableprorated2 = ''>
        <cfset    billableprorated3 = ''>
        <cfloop from="4" to="6" index="bb">
        <cfset "billableitem#bb#" = "">
        <cfset "billableitemamt#bb#" = "">
        <cfset "billableprorated#bb#" = "">
        </cfloop>
        <cfset    wd_p_week = '5'>
        <cfset    Montimestart = ''>
        <cfset    Montimeoff = ''>
        <cfset    Monbreakhour = ''>
        <cfset    Montotalhour = ''>
        <cfset    Monremark = ''>
        <cfset    Tuestimestart = ''>
        <cfset    Tuestimeoff = ''>
        <cfset    Tuesbreakhour = ''>
        <cfset    Tuestotalhour = ''>
        <cfset    Tuesremark = ''>
        <cfset    Wednestimestart = ''>
        <cfset    Wednestimeoff = ''>
        <cfset    Wednesbreakhour = ''>
        <cfset    Wednestotalhour = ''>
        <cfset    Wednesremark = ''>
        <cfset    Thurstimestart = ''>
        <cfset    Thurstimeoff = ''>
        <cfset    Thursbreakhour = ''>
        <cfset    Thurstotalhour = ''>
        <cfset    Thursremark = ''>
        <cfset    Fritimestart = ''>
        <cfset    Fritimeoff = ''>
        <cfset    Fribreakhour = ''>
        <cfset    Fritotalhour = ''>
        <cfset    Friremark = ''>
        <cfset    Saturtimestart = ''>
        <cfset    Saturtimeoff = ''>
        <cfset    Saturbreakhour = ''>
        <cfset    Saturtotalhour = ''>
        <cfset    Saturremark = ''>
        <cfset    Suntimestart = ''>
        <cfset    Suntimeoff = ''>
        <cfset    Sunbreakhour = ''>
        <cfset    Suntotalhour = ''>
        <cfset    Sunremark = ''>
        <cfloop list="Mon,Tues,Wednes,Thurs,Fri,Satur,Sun" index="i">
        <cfset "#i#halfday" = "">
        </cfloop>
        <cfset 	  sps = ''>
        <cfset    pub_holiday_phpd = ''>
        <cfset    ann_leav_phpd = ''>
        <cfset    medic_leav_phpd = ''>
        <cfset    hosp_leav_phpd = ''>
        <cfset    phpayable = ''>
        <cfset    phbillable = ''>
        <cfset    phdate = ''>
        
		<cfset mode="Create">
		<!--- <cfset title="Create Item"> --->
		<cfset title="Create Placement">
		<cfset button="Save">
         <cfset aw1 = ''>
        <cfset aw2 = ''>
		<cfset aw3 = ''>
        <cfloop from="4" to="6" index="aa">
        <cfset "aw#aa#" = "">
        <cfset "allowancedesp#aa#" = "">
        <cfset "allowanceamt#aa#" = "">
        <cfset "allowancebillable#aa#" = "">
        <cfset "allowancepayable#aa#" ="">
        <cfset "prorated#aa#" = ''>
        </cfloop>
	</cfif>
    
    <script type="text/javascript">
	function locationrefno()
	{
		<cfif mode neq "Delete" and mode neq "Edit">
		document.getElementById('placementno').value=document.getElementById('location').value+'#right(placementno,6)#';
		<cfelse>
document.getElementById('placementno').value=document.getElementById('location').value+'#right(placementno,6)#';
</cfif>
	}
    </script>
   
    <cfinclude template="select2Filter.cfm">  

  <h1>#title#</h1>
			
	<h4>
		<!--- <cfif getpin2.h1H10 eq 'T'><a href="Placementtable2.cfm?type=Create">Creating a Placement</a> </cfif> --->
		<cfif getpin2.h1H20 eq 'T'><a href="Placementtable.cfm?">List all Placement</a> </cfif>
		<cfif getpin2.h1H30 eq 'T'>|| <a href="s_Placementtable.cfm?type=Placement">Search For Placement</a></cfif>||<a href="p_Placement.cfm">Placement Listing report</a>
	</h4>
</cfoutput> 

<cfform name="PlacementForm" id="PlacementForm" action="placementtableprocess.cfm" method="post" onsubmit="return validate()">
  <cfoutput> 
    <input type="hidden" name="mode" value="#mode#">
  </cfoutput> 
  <h1 align="center"><cfoutput>Placement</cfoutput> File Maintenance</h1>
  <table align="center" >
    <cfoutput> 
    <tr>
     <th>* Placement Date :</th>
        <td>
				<cfinput type="text" size="20" name="placementdate" id="placementdate" value="#Placementdate#" maxlength="10" required="yes" validate="eurodate" validateat="onsubmit"  message="Please Check Contract Signed Date Format / Contract Date Format is Required" readonly="#readonly#"><cfif readonly neq "readonly"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('placementdate'));"></cfif>
		</td>
        <th>* Branch Code</th>
      <td>
      
      <!--- <cfquery name="getlocation" datasource="#dts#">
      SELECT location as loc,desp from iclocation
      </cfquery>
      <cfselect name="location" id="location" required="yes" message="Location is Required" onChange="locationrefno();" >
      <option value="">Choose a location</option>
      <cfloop query="getlocation">
      <cfif location eq getlocation.loc><option value="#getlocation.loc#" >#getlocation.loc# - #getlocation.desp#</option></cfif>
      </cfloop>
      </cfselect>
     --->
     <input type="text" size="20" name="location" value="#location#"  readonly="#readonly#">
      </td>
    </tr>
    
      <tr> 
        <th width="80">Placement No:</th>
        <td> 
            <cfif mode eq "Delete" or mode eq "Edit"><input type="hidden" size="20" name="oriplacementno" id="oriplacementno" value="#url.placementno#" readonly>
    </cfif>
            <input type="text" size="20" name="placementno" id="placementno" value="#placementno#" maxlength="40" readonly>
           </td>
        <th <cfif readonly eq "readonly"> style="display:none" </cfif>>Consultant</th>
      <td <cfif readonly eq "readonly"> style="display:none" </cfif>><cfselect name="consultant" id="consultant" >
      <option value="">Choose a Consultant</option>
      <cfloop query="getagent">
      <option title="#getagent.location#" value="#getagent.agent#" <cfif xconsultant eq getagent.agent>selected</cfif>>#getagent.agent# - #getagent.agent#</option>
      </cfloop>
      </cfselect></td>
      </tr>
      <tr>
      <th>PO No</th>
      <td> <input type="text" size="20" name="po_no" value="#po_no#"  readonly="#readonly#"></td>
       <th><cfset newkey = newkey + 1><label id="requiredcheck#newkey#"  style="display:inline">* </label>Current Contract Start Date</th>
      <td><cfinput type="text" size="20" name="startdate" id="startdate" value="#startdate#" maxlength="10" validate="eurodate" validateat="onsubmit" message="Please check Date Format" readonly="#readonly#"><!--- <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('startdate'));"> ---></td>
      </tr>
      <tr>
      <th>PO Date</th>
      <td><cfinput type="text" size="20" name="po_date" id="po_date" value="#po_date#" validate="eurodate"  readonly="#readonly#"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('po_date'));"></td>
      <th><cfset newkey = newkey + 1><label id="requiredcheck#newkey#"  style="display:inline">* </label>Current Contract End Date</th>
      <td><cfinput type="text" size="20" name="completedate" id="completedate" value="#completedate#" maxlength="10" validate="eurodate" message="Please check Date Format" readonly="#readonly#"><!--- <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('completedate'));"> ---></td>
      </tr>
      <tr>
      <th>PO Amount</th>
       <td><cfinput type="text" size="20" name="po_amount" id="po_amount" value="#po_amount#" validate="float" validateat="onsubmit" message="PO Amount is Invalid" readonly="#readonly#"></td>
      <th<cfif readonly eq "readonly"> style="display:none" </cfif>>
      1st Contract End Date
      </th>
        <td<cfif readonly eq "readonly"> style="display:none" </cfif>><cfinput type="text" size="20" name="completedate1" id="completedate1" value="#completedate1#" maxlength="10" validate="eurodate" message="Please check Date Format"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('completedate1'));"></td>
      </tr>
      <tr>
      <th>Description 1</th>
      <td><textarea name="description1" id="description1" cols="50" rows="2">#description1#</textarea></td>
             <th<cfif readonly eq "readonly"> style="display:none" </cfif>>
      2nd Contract End Date
      </th>
      <td<cfif readonly eq "readonly"> style="display:none" </cfif>><cfinput type="text" size="20" name="completedate2" id="completedate2" value="#completedate2#" maxlength="10" validate="eurodate" message="Please check Date Format"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('completedate2'));"></td>
      </tr>
      <tr>
     <th>Description 2</th>
      <td><textarea name="description2" id="description2" cols="50" rows="2">#description2#</textarea></td>

       <th<cfif readonly eq "readonly"> style="display:none" </cfif>>Option To Extend</th>
       <td<cfif readonly eq "readonly"> style="display:none" </cfif>><input type="text" size="50" name="option_to_ext" id="option_to_ext" value="#option_to_ext#"></td>
     
      
      </tr>
      <tr>
      
        <th><cfset newkey = newkey + 1>Employee Pay Day</th>
     <td>
     <cfselect name="emp_pay_d" id="emp_pay_d">
     <option value="">Choose a Pay Day</option>
     <cfloop from="1" to="31" index="a">
     <option value="#a#" <cfif emp_pay_d eq '#a#'>selected</cfif>>#a#</option>
     </cfloop>
     </cfselect>
     </td>
  <th>* Type</th>
      <td><cfselect name="placementtype" id="placementtype" required="yes" message="Type is Required" onChange="if(this.value == 'Temporary'){showast('Y');}else{showast('N');}">
      <option value="Temporary" <cfif placementtype eq 'Temporary'>selected</cfif>>Temporary</option>
      <option value="Permanent" <cfif placementtype eq 'Permanent'>selected</cfif>>Permanent</option>
      </cfselect>
      </td>
    
      </tr>
      <tr>
      <th>Bill Day</th>
      <td>
      	<cfselect name="bill_d" id="bill_d">
        	<option value="">Choose a Bill Day</option>
     		<cfloop from="1" to="31" index="a">
     			<option value="#a#" <cfif bill_d eq '#a#'>selected</cfif>>#a#</option>
     		</cfloop>
     	</cfselect>
      </td>
           <th><cfset newkey = newkey + 1><label id="requiredcheck#newkey#"  style="display:inline">* </label>Invoice Type</th>
       
      <td><select name="assignmenttype" id="assignmenttype">
        <option value="invoice" <cfif assignmenttype eq 'invoice'>selected</cfif>>Invoice</option>
        <!--- <option value="einvoice" <cfif assignmenttype eq 'einvoice'>selected</cfif>>E-Invoice</option> --->
         <option value="sinvoice" <cfif assignmenttype eq 'sinvoice'>selected</cfif>>S-Invoice</option>
      </select>
      
      </td>
      </tr>
      <tr>
      <th>Approval Type</th>
      <td>
      	<select id="approvalType" name="approvalType">
        	<option value="0">Please select an approval type</option>
            <option value="1" <cfif approvalType EQ "1">selected</cfif>>Button</option>
            <option value="2" <cfif approvalType EQ "2">selected</cfif>>Signature</option>
            <option value="3" <cfif approvalType EQ "3">selected</cfif>>Documents</option>
        </select>
      </td>
       <th>Time Sheet</th>
     <cfquery name="gettimesheet" datasource="#dts#">
     Select * from iccolorid order by colorid
     </cfquery>
     <td>
     <cfselect name="timesheet" id="timesheet">
     <option value="">Choose A Time Sheet</option>
     <cfloop query="gettimesheet">
     <option value="#gettimesheet.colorid#" <cfif timesheet eq gettimesheet.colorid>Selected</cfif>>#gettimesheet.desp#</option>
     </cfloop>
     </cfselect>
     </td>
      </tr>
      <tr>
      <th>Job Status</th>
      <cfset jobsta=StructNew()>
		<cfset StructInsert(jobsta, "1", "Vacant")>
        <cfset StructInsert(jobsta, "2", "Filled")>
        <cfset StructInsert(jobsta, "3", "Cancelled")>
        <cfset StructInsert(jobsta, "4", "Closed")>
        <cfset StructInsert(jobsta, "5", "Unfilled")>
        <cfset StructInsert(jobsta, "6", "F-Vendor")>
      <td>
 		<select name="JobStatus" id="JobStatus">
        <cfloop from="1" to="6" index="aa">
        <option value="#aa#" <cfif jobstatus eq "#aa#">Selected</cfif>>#jobsta[aa]#</option>
        </cfloop>
        </select>
      </td>
      <th>Job Order Status</th>
        <cfset jota=StructNew()>
		<cfset StructInsert(jota, "1", "New")>
        <cfset StructInsert(jota, "2", "Renew")>
        <cfset StructInsert(jota, "3", "Replace")>
       <td>
       <select name="JoStatus" id="JoStatus">
        <cfloop from="1" to="3" index="aa">
        <option value="#aa#" <cfif jostatus eq "#aa#">Selected</cfif>>#jota[aa]#</option>
        </cfloop>
        </select>
       </td>
      </tr>
      <tr>
      <th>Job Type</th>
      <cfset jobtysta=StructNew()>
		<cfset StructInsert(jobtysta, "1", "Firm Order")>
        <cfset StructInsert(jobtysta, "2", "Inquiry")>
        <cfset StructInsert(jobtysta, "3", "Extend")>
        <cfset StructInsert(jobtysta, "4", "Key Skill")>
        <cfset StructInsert(jobtysta, "5", "IBD")>
      <td>
 		<select name="jobtype" id="jobtype">
        <cfloop from="1" to="5" index="aa">
        <option value="#aa#" <cfif jobtype eq "#aa#">Selected</cfif>>#jobtysta[aa]#</option>
        </cfloop>
        </select>
      </td>
      <th>Job Position Type</th>
        <cfset jobpos=StructNew()>
		<cfset StructInsert(jobpos, "1", "Temp")>
        <cfset StructInsert(jobpos, "2", "Contract")>
        <cfset StructInsert(jobpos, "3", "Perm")>
        <cfset StructInsert(jobpos, "5", "Wage Master")>
       <td>
       <select name="jobpostype" id="jobpostype">
        <cfloop list="1,2,3,5" index="aa">
        <option value="#aa#" <cfif jobpostype eq "#aa#">Selected</cfif>>#jobpos[aa]#</option>
        </cfloop>
        </select>
       </td>
      </tr>
      <tr>
      <th>P.Ord Group</th>
      <td>
      <input type="text" name="invoicegroup" id="invoicegroup" value="#invoicegroup#">
      </td>
      <th>OT Table</th>
      <cfquery name="getot" datasource="#dts#">
      select sizeid from icsizeid ORDER BY sizeid 
      </cfquery>
      
      
      <td>
      <select name="ottable" id="ottable">
      <option value="">Choose an OT table</option>
      <cfloop query="getot">
      <option value="#getot.sizeid#" <cfif ottable eq getot.sizeid>Selected</cfif>>#getot.sizeid#</option>
      </cfloop>
      </select>
      </td>
      </tr>
      <tr>
      <td>&nbsp;</td>
      </tr>
      <tr>
      <td colspan="100%"><hr /></td>
      </tr>
      <tr>
      <th>* Customer No</th>
      <td>
      <!---<cfselect style="width:230px" name="custno" id="custno"  onChange="document.getElementById('custname').value=this.options[this.selectedIndex].id;locationrefno();" required="yes" message="Customer No is Required">
      <option value="">Choose a Customer Code</option>
      <cfloop query="getcustno">
      <option value="#getcustno.custno#" title="#getcustno.area#" id="#getcustno.name#<cfif getcustno.name2 neq ""> #getcustno.name2#</cfif>" <cfif xcustno eq getcustno.custno>selected</cfif> >#getcustno.custno#-#getcustno.name#<cfif getcustno.name2 neq ""> #getcustno.name2#</cfif></option>
      </cfloop>
      </cfselect>--->
      <input type="text" id="custno" name="custno" value="#xcustno#" readonly><!--- &nbsp;<input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findcustomer');" /> --->
      </td>
      <th>Contact Person</th>
      <td><cfinput type="text" name="contactperson" id="contactperson" value="#contactperson#" bind="cfc:placement.getcontact({custno},'#target_arcust#','#dts#')"></td>
      </tr>
      <tr>
      <th>* Customer Name</th>
      <td><cfinput type="text" name="custname" id="custname" value="#custname#" size="50" required="yes" message="Customer Name is Required" readonly="#readonly#"></td>
      <th>Bill to Person</th>
      <td><cfinput type="text" name="billto" id="billto" value="#billto#" bind="cfc:placement.getbillto({custno},'#target_arcust#','#dts#')" maxlength='20'></td>
     
      </tr>
      
        <tr>
      <th>Department</th>
     <td> <input type="text" name="department" id="department" value="#department#" ></td>
     <th>
     Supervisor
     </th>
     <td><input type="text" name="supervisor" id="supervisor" value="#supervisor#" readonly></td>
      </tr>
     <tr>
     <td>&nbsp;</td>
     </tr>
     <tr>
     <td colspan="100%"><hr /></td>
     </tr>
     <tr>
     <th><cfset newkey = newkey + 1><label id="requiredcheck#newkey#"  style="display:inline">* </label>Employee No</th>
      <td>
      <cfinput type="text" name="empno" id="empno" value="#xempno#" readonly="#readonly#"><!--- &nbsp;<input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findempno');" /> --->
      </td>
      <th>* Employee Name</th>
      <td>
      <cfinput type="text" name="empname" id="empname" value="#empname#" required="yes" message="Employee Name" readonly="#readonly#">
      </td>
     </tr>
     <tr <cfif readonly eq "readonly"> style="display:none" </cfif>>
     <th><cfset newkey = newkey + 1><label id="requiredcheck#newkey#"  style="display:inline">* </label>Gender</th>
      <td><cfinput type="text" name="Sex" id="sex" value="#Sex#" bind="cfc:placement.getsex({empno},'#dts#','#dts1#')"></td> 
      <th>Refer By Client</th>
     <td><input type="checkbox" name="refer_by_client" id="refer_by_client" <cfif refer_by_client eq "Y">checked</cfif>></td>
     </tr>
    <tr <cfif readonly eq "readonly"> style="display:none" </cfif>>
    <th><cfset newkey = newkey + 1><label id="requiredcheck#newkey#"  style="display:inline">* </label>Employee NRIC</th>
      <td><cfinput type="text" name="NRIC" id="nric" value="#NRIC#" bind="cfc:placement.getnric({empno},'#dts#','#dts1#')"></td>
      <th>* Job Code</th>
      <td>
      <cfselect name="jobcode" id="jobcode" onChange="document.getElementById('position').value=this.options[this.selectedIndex].id" message="Job Code is Required">
      <option value="">Choose a Job Code</option>
      <cfloop query="getenduser">
      <option id="#getenduser.name#" value="#getenduser.driverno#" <cfif xjobcode eq getenduser.driverno>selected</cfif>>#getenduser.driverno# - #getenduser.name#</option>
      </cfloop>
      </cfselect><input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findenduser');" />
      </td>
    </tr>
      <tr>
      <th>Employee Initial</th>
      <td><input type="text" name="iname" id="iname" value="#iname#" readonly></td>
      <th>* Position</th>
      <td><cfinput type="text" name="position" id="position" value="#Position#" required="yes" message="Position is Required" readonly="#readonly#"></td>
      </tr>
<tr><td></td></tr>
<tr>
	<td colspan="100%"><hr /></td>
</tr>

<script>
function myFunction(val) {
    alert("The input value has changed. The new value is: " + val);
	
}
</script>

<!---readonly hr manager email and added onchange, [20170118, Yew Yang]--->
<tr>
    <th>Hiring Manager Name</th>
    <td><input type="hidden" id="hrMgr" name="hrMgr" class="hrMgrFilter" data-placeholder="Hiring Manager" onchange="getHRmgrEmail(this.value, 'hrMgrEmail');" >
         </td>
    <th>Hiring Manager Email</th>
    <td><cfinput type="text" readonly id="hrMgrEmail" name="hrMgrEmail" value="#hrMgrEmail#" validate="email" message="Hiring Manager Email in incorrect format" style="width:80%"> </td>
</tr>
            
<tr>
    <th>Verifier Name</th>
    <td><input type="hidden" id="verifier" name="verifier" class="verifierFilter" data-placeholder="Verifier" onchange="getHRmgrEmail(this.value, 'verifieremail');" >
         </td>
    <th>Verifier Email</th>
    <td><cfinput type="text" readonly id="verifieremail" name="verifieremail" value="#verifieremail#" validate="email" message="Verifier Email in incorrect format" style="width:80%"> </td>
</tr>
<!---on change and disable textbox--->

<tr>
    <th>MP Person In Charge Primary)</th>
    <td>
      <input type="hidden" id="mpPIC" name="mpPIC" class="mpPicFilter" data-placeholder="MP PIC Primary" />
    </td>
    <th>MP Person In Charge Email (Primary)</th>
    <td>
      <cfinput type="text" id="mpPICEmail" name="mpPICEmail" value="#mpPicEmail#" validate="email" message="MP PIC 1 email in incorrect format" style="width:80%">
    </td>
</tr>
<tr>    
    <th>MP Person In Charge (Secondary)</th>
    <td>
      <input type="hidden" id="mpPIC2" name="mpPIC2" class="mpPicFilter2" data-placeholder="MP PIC Secondary" />
    </td>
    <th>MP Person In Charge Email (Secondary)</th>
    <td>
      <cfinput type="text" id="mpPICEmail2" name="mpPICEmail2" value="#mpPicEmail2#" validate="email" message="MP PIC 2 email in incorrect format" style="width:80%">
    </td>
</tr>
<tr>    
    <th>MP Supervisor of PIC</th>
    <td>
      <input type="hidden" id="mpPicSp" name="mpPicSp" class="mpPicSpFilter" data-placeholder="MP PIC Supervisor" />
    </td>
    <th>MP Supervisor of PIC Email</th>
    <td>
      <cfinput type="text" id="mpPicSpEmail" name="mpPicSpEmail" value="#mpPicSpEmail#" validate="email" message="MP PIC supervisor email in incorrect format" style="width:80%">
    </td>
</tr>   
<!------>    
<tr>
<td colspan="100%">
<hr/>
</td>
    
<!---Added by Nieo 20171219 1131 with new requirement of #74 in MP4U Pending List---> 
<tr>
    <th>Work Order ID</th>
    <td>
      <input type="text" id="workorderid" name="workorderid" value="#workorderid#" placeholder="Work Order ID" />
    </td>
    <th>Job Seeker ID</th>
    <td>
      <cfinput type="text" id="jobid" name="jobid" value="#jobid#"  placeholder="Job Seeker ID" style="width:80%">
    </td>
</tr>
<tr>
    <th>Cost Allocation / Center</th>
    <td>
      <input type="text" id="costcenter" name="costcenter" value="#costcenter#" placeholder="Cost Allocation" />
    </td>
    <th>Job Posting</th>
    <td>
      <cfinput type="text" id="jobposting" name="jobposting" value="#jobposting#" placeholder="Job Posting"  style="width:80%">
    </td>
</tr>
<tr>
    <th>Location</th>
    <td>
      <input type="text" id="cLocation" name="cLocation" value="#cLocation#" placeholder="Location" />
    </td>
    <th>Security ID</th>
    <td>
      <cfinput type="text" id="securityID" name="securityID" value="#securityID#" placeholder="Security ID" style="width:80%">
    </td>
</tr>
<tr>
    <th>Business Unit</th>
    <td>
      <input type="text" id="businessunit" name="businessunit" value="#businessunit#" placeholder="Business Unit" />
    </td>
    <th>Site</th>
    <td>
      <cfinput type="text" id="site" name="site" value="#site#" placeholder="Site" style="width:80%">
    </td>
</tr>
<td colspan="100%">
<hr/>
</td>
<!---Added by Nieo 20171219 1131 with new requirement of #74 in MP4U Pending List---> 
    
</tr>

<tr>
<th><cfset newkey = newkey + 1><label id="requiredcheck#newkey#"  style="display:inline">* </label>Rate Type</th>
      <td>
      <select name="clienttype" id="clienttype">
      <option value="">Choose a Type</option>
      <option value="hr" <cfif clienttype eq "hr">selected</cfif>>Hourly</option>
      <option value="day" <cfif clienttype eq "day">selected</cfif>>Daily</option>
      <option value="mth" <cfif clienttype eq "mth">selected</cfif>>Monthly</option>
      </select>
      </td>
      <th  <cfif readonly eq "readonly"> style="display:none" </cfif>>Admin Fee</th>
      <td  <cfif readonly eq "readonly"> style="display:none" </cfif>>
      Fixed<input type="radio" name="admin_fee" id="admin_fee1" value="Yes" checked onClick="totalallup();if(this.checked == true){document.getElementById('afamt').style.display = 'block';document.getElementById('afpercent').style.display = 'none';document.getElementById('afpercent1').style.display = 'none';document.getElementById('admin_fee_fix_amt').readOnly=false;}else{document.getElementById('afamt').style.display = 'none';document.getElementById('afpercent').style.display = 'block';document.getElementById('afpercent1').style.display = 'inline';document.getElementById('admin_fee_fix_amt').readOnly=false;}" >&nbsp;&nbsp;&nbsp;%<input type="radio" name="admin_fee" id="admin_fee2" value="No" <cfif admin_fee eq 'No'>checked </cfif>onClick="totalallup();if(this.checked == false){document.getElementById('afamt').style.display = 'block';document.getElementById('afpercent').style.display = 'none';document.getElementById('afpercent1').style.display = 'none';document.getElementById('admin_fee_fix_amt').readOnly=false;}else{document.getElementById('afamt').style.display = 'none';document.getElementById('afpercent').style.display = 'block';document.getElementById('afpercent1').style.display = 'inline';document.getElementById('admin_fee_fix_amt').readOnly=false;}" >&nbsp;&nbsp;&nbsp;Included in ER Rate<input type="radio" name="admin_fee" id="admin_fee3" value="include" onClick="if(this.checked==true){document.getElementById('admin_fee_fix_amt').value='0';document.getElementById('admin_fee_fix_amt').readOnly=true;}else{document.getElementById('admin_fee_fix_amt').readOnly=false;}" <cfif admin_fee eq 'include'>checked </cfif>>&nbsp;&nbsp;&nbsp;Nil<input type="radio" name="admin_fee" id="admin_fee4" value="Nil" <cfif admin_fee eq 'Nil'>checked </cfif>  onClick="if(this.checked==true){document.getElementById('admin_fee_fix_amt').value='0';document.getElementById('admin_fee_fix_amt').readOnly=true;}else{document.getElementById('admin_fee_fix_amt').readOnly=false;}">
      </td>
</tr>

<tr <cfif readonly eq "readonly"> style="display:none" </cfif>>
 <th>Do Not Bill CPF Seperately</th>
      <td>
      <input type="checkbox" name="inc_bill_cpf" id="inc_bill_cpf" <cfif inc_bill_cpf eq 'Y'>checked</cfif> onChange="if(this.checked == true){document.getElementById('inc_bill_sdf').checked = true;document.getElementById('admin_fee3').checked = true;} else {document.getElementById('inc_bill_sdf').checked = false;document.getElementById('admin_fee1').checked = true;}">
      </td>
       <th><div id="afamt" <cfif admin_fee neq 'yes'>style="display:none"</cfif>>* Admin Fee Fixed Amount</div><div <cfif admin_fee eq 'Yes'>style="display:none"</cfif> id="afpercent">* Admin Fee %</div></th>
      <td>
      <cfinput type="text" name="admin_fee_fix_amt" id="admin_fee_fix_amt" value="#admin_fee_fix_amt#" validate="float" message="Admin Fee is Invalid / Required" onKeyUp="totalallup();"><div <cfif admin_fee neq 'No'>style="display:none"</cfif> id="afpercent1">&nbsp;&nbsp;<input type="hidden" name="adminfeepamt" id="adminfeepamt" value="#numberformat(val(adminfeepamt),'.__')#" size="10"></div>
      </td>
</tr>


      <tr <cfif readonly eq "readonly"> style="display:none" </cfif>>
        <th>Do Not Bill SDF Seperately</th>
      <td>
       <input type="checkbox" name="inc_bill_sdf" id="inc_bill_sdf" <cfif inc_bill_sdf eq 'Y'>checked</cfif>>
      </td>
      
     <th>Admin Fee Min Amt</th>
      <td>
      <cfinput type="text" name="admin_f_min_amt" id="admin_f_min_amt" value="#admin_f_min_amt#" validate="float" message="Admin Fee Min Amt is Invalid">
      </td>
      </tr>
      <tr>
      
     
      </tr>
      <tr <cfif readonly eq "readonly"> style="display:none" </cfif>>
    <th><!--- CPF Amount ---></th>
      <td><cfinput type="hidden" name="cpf_amount" id="cpf_amount" value="#cpf_amount#" validate="float" message="CPF Amount is Invalid" onKeyUp="totalallup()">
    
      </td>
      <th>Rebate</th>
      <td><cfinput type="text" name="rebate" id="rebate" value="#rebate#" validate="float" message="Rebate is Invalid" onKeyUp="totalallup()"></td>
      </tr>
      <tr <cfif readonly eq "readonly"> style="display:none" </cfif>>
     <th><!--- SDF Amount ---></th>
      <td><cfinput type="hidden" name="sdf_amount" id="sdf_amount" value="#sdf_amount#" validate="float" message="SDF Amount is Invalid" onKeyUp="totalallup()">
      <th>Rebate Pro-Rate</th>
      <td><input type="checkbox" name="rebate_pro_rate" id="rebate_pro_rate" <cfif rebate_pro_rate eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
      <td></td>
      <td></td>
      </tr>
      <tr>
      <th colspan="100%">Pay & Bill Structure</th>
      </tr>
      <tr>
      <td colspan="100%">
      <!---Updated by Nieo 20171115 1133--->
      <!---<cfquery name="getpm" datasource="#dts#">
      SELECT * FROM manpowerpricematrix ORDER BY Priceid
      </cfquery>--->
        <input type="hidden" id='paybill' name="paybill" class="mpPriceFilter" placeholder="Choose an Price Structure">
      <!---<select name="paybill" id="paybill">
      <option value="">Choose Pay & Bill Structure</option>
      <cfloop query="getpm">
      <option value="#getpm.priceid#" <cfif pm eq getpm.priceid>Selected</cfif>>#getpm.pricename#</option>
      </cfloop>
      </select>--->
        <!---Updated by Nieo 20171115 1133--->
      &nbsp;&nbsp;&nbsp;<a onClick="if(document.getElementById('paybill').value!=''){window.open('/latest/customization/manpower_i/pricematrix/pricematrix2.cfm?action=update&priceid='+document.getElementById('paybill').value)}">View</a>
      </td>
      </tr>
      <cfif isdefined('url.placementno')>
      <tr>
      <th colspan="100%">Powerbase Pay & Bill</th>
      <cfquery name="getPBpaybill" datasource="#dts#">
      SELECT * FROM (SELECT dballid,dbjoballpayrate,dbjoballbillrate,dbjoballqty FROM ftjoballow
      WHERE dbjobno ='#url.placementno#' ORDER BY dbjoballid) as a
      LEFT JOIN
      (SELECT dballid as dbalid, dballname, dballdesc FROM ftstdallow) as b
      on a.dballid = b.dbalid
      </cfquery>
      </tr>
      <tr>
      <td colspan="100%">
      <table width="100%" border="1">
      <tr>
      <th>Name</th>
      <th>Desc</th>
      <th><div align="right">Pay</div></th>
      <th><div align="right">Bill</div></th>
      <th><div align="center">Qty</div></th>
      </tr>
      <cfloop query="getPBpaybill">
      <tr>
      <td>#getpbpaybill.dballname#</td>
      <td>#getpbpaybill.dballdesc#</td>
      <td><div align="right">#numberformat(getpbpaybill.dbjoballpayrate,',.__')#</div></td>
      <td><div align="right">#numberformat(getpbpaybill.dbjoballbillrate,',.__')#</div></td>
       <td><div align="center">#getpbpaybill.dbjoballqty#</div></td>
      </tr>
      </cfloop>
      </table>
      </td>
      </tr>
      </cfif>
      <tr>
      <td colspan="100%">
      <table width="100%" >
      <tr>
      <th><cfset newkey = newkey + 1><label id="requiredcheck#newkey#"  style="display:inline">* </label>Effective Date</th>
      <th><cfset newkey = newkey + 1><label id="requiredcheck#newkey#"  style="display:inline">* </label>Employee Rate</th>
      <th><cfset newkey = newkey + 1><label id="requiredcheck#newkey#"  style="display:inline">* </label>Employer Rate</th>
      <th <cfif readonly eq "readonly"> style="display:none" </cfif>>CPF Amount</th>
      <th <cfif readonly eq "readonly"> style="display:none" </cfif>>SDF Amount</th>
      <th <cfif readonly eq "readonly"> style="display:none" </cfif>>Sub Total</th>
      <th <cfif readonly eq "readonly"> style="display:none" </cfif>>Admin Fee</th>
      <th <cfif readonly eq "readonly"> style="display:none" </cfif>>Rebate</th>
      <th <cfif readonly eq "readonly"> style="display:none" </cfif>>Total Employer Rate</th>
      </tr>
      <cfloop from="1" to="5" index="i">
      <tr>
      <td><cfinput type="text" size="12" name="eff_d_#i#" id="eff_d_#i#" value="#evaluate('eff_d_#i#')#" validate="eurodate" message="Effective Date is Invalid" readonly="#readonly#"><!--- <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('eff_d_#i#'));"> ---></td>
      <td>
      <cfinput type="text" size="12" name="employee_rate_#i#" id="employee_rate_#i#" value="#evaluate('employee_rate_#i#')#" validate="float" message="Employee Rate is Invalid" onKeyUp="totalallup();" readonly="#readonly#">
      </td>
       <td>
      <cfinput type="text" size="12" name="employer_rate_#i#" id="employer_rate_#i#" value="#evaluate('employer_rate_#i#')#" validate="float" message="Employer Rate is Invalid" onKeyUp="totalallup();" readonly="#readonly#">
      </td>
      <td <cfif readonly eq "readonly"> style="display:none" </cfif>><cfinput type="text" size="12" name="cpfamt#i#" id="cpfamt#i#" value="#evaluate('cpfamt#i#')#" validate="float" message="CPF Amount is Invalid" onKeyUp="totalallup();"></td>
      <td<cfif readonly eq "readonly"> style="display:none" </cfif>> <cfinput type="text" size="12" name="sdfamt#i#" id="sdfamt#i#" value="#evaluate('sdfamt#i#')#" validate="float" message="SDF Amount is Invalid" onKeyUp="totalallup();"></td>
      <td<cfif readonly eq "readonly"> style="display:none" </cfif>><cfinput type="text" size="12" name="subtotalamt#i#" id="subtotalamt#i#" value="#evaluate('subtotalamt#i#')#" validate="float" message="Sub Total Amount is Invalid" onKeyUp="totalallup();" readonly="yes"></td>
      <td<cfif readonly eq "readonly"> style="display:none" </cfif>>
       <cfinput type="text" size="12" name="adminfee#i#" id="adminfee#i#" value="#evaluate('adminfee#i#')#" readonly="yes">
      </td>
      <td<cfif readonly eq "readonly"> style="display:none" </cfif>><cfinput type="text" size="12" name="rebateamt#i#" id="rebateamt#i#" value="#evaluate('rebateamt#i#')#" validate="float" message="Rebate Amount is Invalid" onKeyUp="totalallup();" readonly="yes"></td>
      <td<cfif readonly eq "readonly"> style="display:none" </cfif>>
      <cfinput type="text" size="12" name="allamt#i#" id="allamt#i#" value="#evaluate('allamt#i#')#">
      </td>
      </tr>
      </cfloop>
      </table>
      </td>
      </tr>
      <tr>
        	<th height='20' colspan='100%' onClick="javascript:shoh('r1');"><div align='center'><strong>Leave Entitlement<img src="/images/u.gif" name="imgr1" align="center"></strong></div></th>
      	</tr>
		<tr>
        	<td colspan="100%">
          		<table id="r1" align="center" width="100%" style="display:none"  >
                <tr <cfif readonly eq "readonly"> style="display:none" </cfif>>
                <td></td>
                <td></td>
       
                <th>Payable</th>
                <th>Billable</th>
                <th colspan="2">Amount</th>
                <th>Payment Date</th>
                <th>Adm</th><th>SDF</th><th>CPF</th><th>WI</th>
                </tr>
                <cfloop list="bonus,aws,ph" index="a">
                <tr <cfif readonly eq "readonly"> style="display:none" </cfif>>
                <th><cfif a eq "bonus">1<cfelseif a eq "aws">2<cfelse>3</cfif></th>
                <th><cfif a eq "bonus">Performance Bonus<cfelseif a eq "aws">AWS<cfelse>Public Holiday</cfif></th>
                <td>
                <input type="checkbox" name="#a#payable" id="#a#payable" <cfif evaluate('#a#payable') eq 'Y'> checked </cfif>>
                </td>
                <td>
                   <input type="checkbox" name="#a#billable" id="#a#billable" <cfif evaluate('#a#billable') eq 'Y'> checked</cfif>>
                </td>
              <cfif a neq "ph">  <td  colspan="2"> <cfinput  size="12" type="text" name="#a#amt" id="#a#amt" value="#evaluate('#a#amt')#" validate="float" message="Amount is Invalid"></td><cfelse><th  colspan="2">Claimable From Date</th></cfif>
                <td><cfinput type="text"  size="12" name="#a#date" id="#a#date" value="#evaluate('#a#date')#" validate="eurodate" message="Payment Date is Invalid">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('#a#date'));"></td>
                <td><cfif a neq "ph"><input type="checkbox" name="#a#admable" id="#a#admable"  <cfif evaluate('#a#admable') eq 'Y'>checked</cfif>></cfif></td>
                <td><cfif a neq "ph"><input type="checkbox" name="#a#sdfable" id="#a#sdfable" <cfif evaluate('#a#sdfable') eq 'Y'> checked</cfif>></cfif></td>
                 <td><cfif a neq "ph"><input type="checkbox" name="#a#cpfable" id="#a#cpfable"  <cfif evaluate('#a#cpfable') eq 'Y'>checked</cfif>></cfif></td>
                 <td><cfif a neq "ph"><input type="checkbox" name="#a#wiable" id="#a#wiable"  <cfif evaluate('#a#wiable') eq 'Y'>checked</cfif>></cfif></td>
                </tr>
                </cfloop>
                <tr >
                <td>&nbsp;</td>
                </tr>
                <tr >
                <td></td>
                <td></td>
                <th>Payable</th>
                <th>Billable</th>
                <th colspan="2">Claimable From Date</th>
                <th>Per Visit Cap</th>
                <th>Contract Cap</th>
                <th>Amount Claimed</th>
                </tr>
             
                <cfset claimcount = 1>
                <cfloop query="getclaimlist">
                <tr >
                <th>#val(claimcount)#</th>
                <th>#getclaimlist.desp#</th>
                 <td>
                <input type="checkbox" name="#getclaimlist.wos_group#payable" id="#getclaimlist.wos_group#payable"  <cfif evaluate("#getclaimlist.wos_group#payable") eq 'Y'>checked</cfif>>
                </td>
                <td>
                   <input type="checkbox" name="#getclaimlist.wos_group#billable" id="#getclaimlist.wos_group#billable" <cfif evaluate("#getclaimlist.wos_group#billable") eq 'Y'> checked</cfif>>
                </td>
                 <td  colspan="2"><cfinput size="12" type="text" name="#getclaimlist.wos_group#claimdate" id="#getclaimlist.wos_group#claimdate" value="#evaluate('#getclaimlist.wos_group#claimdate')#" validate="eurodate" message="Claimable from Date is Invalid">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('#getclaimlist.wos_group#claimdate'));"></td>
                <td>
                <cfinput  size="12" type="text" name="per#getclaimlist.wos_group#claimcap" id="per#getclaimlist.wos_group#claimcap" value="#evaluate('per#getclaimlist.wos_group#claimcap')#" validate="float" message="Per #getclaimlist.desp# Visit Cap is Invalid">
                </td>
                <td>
                 <cfinput  size="12" type="text" name="total#getclaimlist.wos_group#claimable" id="total#getclaimlist.wos_group#claimable" value="#evaluate('total#getclaimlist.wos_group#claimable')#"  validate="float" message="#getclaimlist.desp# Contract Cap is Invalid">
                </td>
                  <td>
                 <cfinput  size="12" type="text" name="#getclaimlist.wos_group#claimedamt" id="#getclaimlist.wos_group#claimedamt" value="#evaluate('#getclaimlist.wos_group#claimedamt')#"  validate="float" message="#getclaimlist.desp# Amount Claimed is Invalid">
                </td>
                </tr>
                <cfset claimcount = claimcount + 1>
                </cfloop>
                
                <tr>
                <td>&nbsp;</td>
                </tr>
                <tr>
                <td></td>
                <td></td>
                <th>Entitled</th>
                <th>Payable</th>
                <th>Billable</th>
                <th>Claimable from Date</th>
                <th>Days<br>
<font size="-2">(Pro-rate to contract duration)</font></th>
                <th>Carry Forward</th>
                <th>Total</th>
                <th>Earned</th>
                <th>Earned Leaves Rounding</th>
                <th>Carry Forward</th>
                <th>Remarks</th>
                </tr>
				<cfset listcount = 1>
                <cfloop query="leavelist">
                <cfset i = leavelist.costcode>
                <tr>
                <th>#listcount#<cfset listcount = listcount + 1></th>
                <th>#leavelist.Desp# </th>
                <td><input type="checkbox" name="#i#entitle" id="#i#entitle" <cfif evaluate('#i#entitle') eq 'Y'> checked</cfif>></td>
                <td><input type="checkbox" name="#i#payable1" id="#i#payable1" <cfif evaluate('#i#payable1') eq 'Y'> checked</cfif>></td>
                <td><input type="checkbox" name="#i#billable1" id="#i#billable1" <cfif evaluate('#i#billable1') eq 'Y'> checked</cfif>></td>
                <td>
                    <cfinput size="12" type="text" name="#i#date" id="#i#date" value="#evaluate('#i#date')#" validate="eurodate" message="Claimable from Date is Invalid">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('#i#date'));">
                </td>
                <td>
                    <input class="leaveinput" type="number" name="#i#days" id="#i#days" value="#evaluate('#i#days')#" step="0.5" min="0.0" 
                           onKeyUp="calculateleave('#i#')" onChange="calculateleave('#i#')">
                </td>
                <td>
                    <cfif i eq "AL">
                        <input class="leaveinput" type="number" name="#i#bfdays" id="#i#bfdays" value="#val(evaluate('#i#bfdays'))#" step="0.5" min="0.0" 
                               onKeyUp="calculateleave('#i#')" onChange="calculateleave('#i#')">
                    </cfif>
                </td>
                <td>
                    <input class="leaveinput" type="number" name="#i#totaldays" id="#i#totaldays" value="#evaluate('#i#totaldays')#" readonly>
                </td>
                <td>
                    <input type="checkbox" name="#i#earndays" id="#i#earndays" <cfif evaluate('#i#earndays') eq 'Y'> checked</cfif><cfif "#i#" NEQ 'AL'> style="display:none"</cfif>>
                </td>
                <td style="display: none;"> 
                    <cfif i eq "AL">
                        <select name="#i#type" id="#i#type" style="width:80px">
                            <option value="lmwd" <cfif altype eq "lmwd">Selected</cfif>>Last Month Work Done</option>
                            <option value="tmwd" <cfif altype eq "tmwd">Selected</cfif>>This Month Work Done</option>
                        </select>
                    </cfif>
                </td>
                <td>
                    <select name="#i#earntype" id="#i#earntype" <cfif "#i#" NEQ 'AL'> style="display:none"</cfif>>
                        <option value="Up" <cfif "#Evaluate('#i#earntype')#" EQ "Up">SELECTED</cfif>>Up</option>
                        <option value="Down" <cfif "#Evaluate('#i#earntype')#" EQ "Down">SELECTED</cfif>>Down</option>
                    </select>
                </td>
                <td>
                    <cfif i eq "AL">
                        <input type="checkbox" name="#i#bfable" id="#i#bfable" onchange="calculateleave('#i#')" <cfif evaluate('#i#bfable') eq 'Y'>checked</cfif>>
                    </cfif>
                </td>
                  <td>
                  <input type="text" name="#i#remarks" id="#i#remarks" value="#evaluate('#i#remarks')#" >
                  </td>
                </tr>
                </cfloop>
               
              
                </table>
     </td>
     </tr>
      <tr <!--- <cfif readonly eq "readonly"> style="display:none" </cfif> --->>
        	<th height='20' colspan='100%' onClick="javascript:shoh('r2');"><div align='center'><strong>Monthly Fixed Allowance<img src="/images/u.gif" name="imgr2" align="center"></strong></div></th>
      	</tr>
		<tr <!--- <cfif readonly eq "readonly"> style="display:none" </cfif> --->>
        	<td colspan="100%">
          		<table id="r2" align="center" width="100%"  style="display:none">
                <tr>
                <th>Monthly Fixed Allowance</th>
                <th>Payable</th>
                <th>Billable</th>
                <th>Amount</th>
                <th>Pro-Rated</th>
                
                </tr>
                <cfloop from="1" to="6" index="a">
                <tr>
                <td>
                <cfquery name="getaw" datasource="#dts#">
                SELECT shelf as aw_cou,desp as aw_desp FROM icshelf order by desp
                </cfquery>
                <select name="allowance#a#" id="allowance#a#" onChange="document.getElementById('allowancedesp#a#').value=this.options[this.selectedIndex].id;">
                <option value="">Choose an Allowance</option>
                <cfloop query="getaw">
                <option value="#getaw.aw_cou#" <cfif evaluate('aw#a#') eq  getaw.aw_cou>Selected</cfif> id="#getaw.aw_desp#">#getaw.aw_desp#</option>
                </cfloop>
                </select>
                <input type="text" name="allowancedesp#a#" id="allowancedesp#a#" size="30" value="#evaluate('allowancedesp#a#')#">
                </td>
               
  				<td>
                <input type="checkbox" name="allowancepayable#a#" id="allowancepayable#a#"  <cfif evaluate("allowancepayable#a#") eq 'Y'>checked</cfif>>
                </td>
                 <td>
                   <input type="checkbox" name="allowancebillable#a#" id="allowancebillable#a#" <cfif evaluate("allowancebillable#a#") eq 'Y'> checked</cfif>>
                </td>
                <td>
                <cfinput type="text" name="allowanceamt#a#" id="allowanceamt#a#" value="#evaluate('allowanceamt#a#')#" validate="float" message="Monthly Fixed Allowance Amount is Invalid">
                </td>
                <td><input type="checkbox" name="prorated#a#" id="prorated#a#" <cfif evaluate('prorated#a#') eq 'Y'> checked</cfif>></td>
                </tr>
                </cfloop>
                
                </table>
                </td>
                </tr>
     <tr <!--- <cfif readonly eq "readonly"> style="display:none" </cfif> --->>
        	<th height='20' colspan='100%' onClick="javascript:shoh('r3');"><div align='center'><strong>Monthly Billable Item<img src="/images/u.gif" name="imgr3" align="center"></strong></div></th>
      	</tr>
		<tr <!--- <cfif readonly eq "readonly"> style="display:none" </cfif> --->>
        	<td colspan="100%">
          		<table id="r3" align="center" width="100%"  style="display:none"  >
                <tr>
                <th>Monthly Billable Item</th>
                <th>Amount</th>
                <th>Pro-Rated</th>
                </tr>
                <cfquery name="getcate" datasource="#dts#">
                select * from iccate
                </cfquery>
                <cfloop from="1" to="5" index="a">
                <tr>
                <td>
                <select name="billableitem#a#" id="billableitem#a#">
                <option value="">Select a Billable Item</option>
                <cfloop query="getcate">
                <option value="#getcate.cate#" <cfif evaluate('billableitem#a#') eq '#getcate.cate#'>selected</cfif>>#getcate.cate# - #getcate.desp#</option>
                </cfloop>
                </select>
                </td>
                <td>
                <cfinput type="text" name="billableitemamt#a#" id="billableitemamt#a#" value="#evaluate('billableitemamt#a#')#" >
                </td>
              	<td>
                <input type="checkbox" name="billableprorated#a#" id="billableprorated#a#" <cfif evaluate('billableprorated#a#') eq 'Y'> checked</cfif>>
                </td>
                </tr>
                </cfloop>
                
                </table>
                </td>
                </tr>
                
                    <!---<tr> alvin - 20161229 commented out temporary as it is redundnant function with OT table
        	<th height='20' colspan='100%' onClick="javascript:shoh('r4');"><div align='center'><strong>Work Hour Pattern<img src="/images/u.gif" name="imgr4" align="center"></strong></div></th>
      	</tr>--->
		<tr>
        	<td colspan="100%">
          		<table  id="r4" align="center" width="100%"  style="display:none" >
                <tr>
                <th colspan="2">Flexible Worker</th>
                <td><input type="checkbox" name="flexw" id="flexw" value="" <cfif flexw eq "Y">checked</cfif> ></td>
                </tr>
                <tr>
                <th colspan="2"><cfset newkey = newkey + 1><label id="requiredcheck#newkey#"  style="display:inline">* </label>Workdays Per Week</th>
                <td><cfinput type="text" name="wd_p_week" id="wd_p_week" value="#wd_p_week#" size="5" validate="float" message="Workdays Per Week is Invalid" ></td>
                <th colspan="2">42 Hours System</th>
                <td>
                <input type="checkbox" name="system42" id="system42" value="" <cfif system42 eq "Y">checked</cfif> >
                </td>
                </tr>
               
                <tr>
                <th>Day</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Half Day</th>
                <th>Break Time Hour</th>
                <th>Daily Work Hour</th>
                <th>Remark</th>
                </tr>
                <cfloop list="Mon,Tues,Wednes,Thurs,Fri,Satur,Sun" index="i">
                <tr>
                <td>#i#day</td>
                <td>
                <cfif evaluate('#i#timestart') eq "">
                <cfset hr = "00">
                <cfset mina = "00">
                <cfelse>
                <cfset hr = listfirst(evaluate('#i#timestart'),':')>
                <cfset mina = listgetat(evaluate('#i#timestart'),2,':')>
                </cfif>
				<select name="#i#hr" id="#i#hr" onChange="makehour('#i#');<cfif i eq "Mon">workhrpt();</cfif>">
                <cfloop from="0" to="23" index="aaa">
                <option value="#numberformat(aaa,'00')#" <cfif hr eq numberformat(aaa,'00')>Selected</cfif>>#numberformat(aaa,'00')#</option>
                </cfloop>
                </select>
                <select name="#i#mina" id="#i#mina" onChange="makehour('#i#');<cfif i eq "Mon">workhrpt();</cfif>">
                <cfloop from="0" to="59" index="aaa">
                <option value="#numberformat(aaa,'00')#" <cfif mina eq numberformat(aaa,'00')>Selected</cfif>>#numberformat(aaa,'00')#</option>
                </cfloop>
                </select>
              	<input type="hidden" name="#i#timestart" id="#i#timestart" value="#evaluate('#i#timestart')#">
                
                <!--- <select name="#i#timestart" id="#i#timestart"  onChange="workhour('#i#');<cfif i eq "Mon">workhrpt();</cfif>" >
                <cfloop from="0" to="1425"  index="a" step="15">
                <cfset timenow = createdatetime('2013','1','1','0','0','0')>			
                <option value="#timeformat(dateadd('n',a,timenow),'HH:MM:SS')#" <cfif evaluate('#i#timestart') eq "#timeformat(dateadd('n',a,timenow),'HH:MM:SS')#">selected</cfif>>#timeformat(dateadd('n',a,timenow),'HH:MM:SS')#</option>
                </cfloop>
                </select> --->
                </td>
                <td>
                <cfif evaluate('#i#timeoff') eq "">
                <cfset hre = "">
                <cfset minae = "">
                <cfelse>
                 <cfset hre = listfirst(evaluate('#i#timeoff'),':')>
                <cfset minae = listgetat(evaluate('#i#timeoff'),2,':')>
                </cfif>
				<select name="#i#hre" id="#i#hre" onChange="makehour('#i#');<cfif i eq "Mon">workhrpt();</cfif>">
                <cfloop from="0" to="23" index="aaa">
                <option value="#numberformat(aaa,'00')#" <cfif hre eq numberformat(aaa,'00')>Selected</cfif>>#numberformat(aaa,'00')#</option>
                </cfloop>
                </select>
                <select name="#i#minae" id="#i#minae" onChange="makehour('#i#');<cfif i eq "Mon">workhrpt();</cfif>">
                <cfloop from="0" to="59" index="aaa">
                <option value="#numberformat(aaa,'00')#" <cfif minae eq numberformat(aaa,'00')>Selected</cfif>>#numberformat(aaa,'00')#</option>
                </cfloop>
                </select>
                <input type="hidden" name="#i#timeoff" id="#i#timeoff" value="#evaluate('#i#timeoff')#">
                 <!--- <select name="#i#timeoff" id="#i#timeoff" onChange="workhour('#i#');<cfif i eq "Mon">workhrpt();</cfif>">
                <cfloop from="0" to="1425"  index="a" step="15">
                <cfset timenow = createdatetime('2013','1','1','0','0','0')>
                <option value="#timeformat(dateadd('n',a,timenow),'HH:MM:SS')#" <cfif evaluate('#i#timeoff') eq "#timeformat(dateadd('n',a,timenow),'HH:MM:SS')#">selected</cfif>>#timeformat(dateadd('n',a,timenow),'HH:MM:SS')#</option>
                </cfloop>
                </select> --->
                </td>
                <td>
                <input type="checkbox" name="#i#halfday" id="#i#halfday" value="" <cfif evaluate('#i#halfday') eq "Y">checked </cfif>>
                 </td>
                <td>
                <input type="text" name="#i#breakhour" id="#i#breakhour" value="#evaluate('#i#breakhour')#" onKeyUp="makehour('#i#');<cfif i eq "Mon">workhrpt();</cfif>">
                </td>
                 <td>
                <input type="text" name="#i#totalhour" id="#i#totalhour" value="#evaluate('#i#totalhour')#" <cfif i eq "Mon">onkeyup="workhrpt();"</cfif> readonly>
                </td>
                <td>
                <input type="text" name="#i#remark" id="#i#remark" value="#evaluate('#i#remark')#" <cfif i eq "Mon">onkeyup="workhrpt();"</cfif>>
                </td>
                </tr>
                </cfloop>
                <tr>
                <th colspan="2">Special Pay Schedule</th>
                <td colspan="4"><input type="checkbox" name="sps" id="sps" value="" <cfif sps eq 'Y'>checked</cfif><!---onChange ="if(this.checked){document.getElementById('spsfield').style.display='block';}else{document.getElementById('spsfield').style.display='none';}"---> ></td>
                </tr>
                <tr>
                <td colspan="6">
               
                <table >
                <tr>
                <th>Public Holiday Pay Hour Per Day</th>
                <td><cfinput type="text" name="pub_holiday_phpd" id="pub_holiday_phpd" value="#pub_holiday_phpd#"  validate="float" message="Public Holiday Pay Hour Per Day is Invalid"></td>
                </tr>
                <tr>
                <th>Annual Leave Pay Hour Per Day</th>
                <td><cfinput type="text" name="ann_leav_phpd" id="ann_leav_phpd" value="#ann_leav_phpd#"  validate="float" message="Annual Leave Pay Hour Per Day is Invalid"></td>
                </tr>
                 <tr>
                <th>Medical Leave Pay Hour Per Day</th>
                <td><cfinput type="text" name="medic_leav_phpd" id="medic_leav_phpd" value="#medic_leav_phpd#"  validate="float" message="Medical Leave Pay Hour Per Day is Invalid"></td>
                </tr>
                 <tr>
                <th>Hospitalisation Leave Pay Hour Per Day</th>
                <td><cfinput type="text" name="hosp_leav_phpd" id="hosp_leav_phpd" value="#hosp_leav_phpd#" validate="float" message="Hospitalisation Leave Pay Hour Per Day is Invalid"></td>
                </tr>
                </table>
                
                </td>
                </tr>
                </table>
                </td>
                </tr>
                 
     
    </cfoutput> 
    <tr> 
      <td colspan="4" align="left"><cfoutput> 
          <input name="sub_btn" id="sub_btn" type="button" onClick="if(validateall()){if(_CF_checkPlacementForm(document.getElementById('PlacementForm'))){this.disabled=true;document.getElementById('PlacementForm').submit();}}" value="  #button#  ">
        </cfoutput></td>
    </tr>
  </table>
</cfform>
<cfif placementtype eq 'Temporary' or placementtype eq "">
<script type="text/javascript">
setTimeout("showast('Y');",500);
</script>
<cfelse>
<script type="text/javascript">
setTimeout("showast('N');",500);
</script>
</cfif>
<cfoutput>
<input type="hidden" name="astcount" id="astcount" value="#newkey#">
</cfoutput>
<cfif url.type eq "Edit">
<cfquery name="getemployee" datasource="#dts#">
	SELECT paystatus
	FROM #dts1#.pmast WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xempno#">
</cfquery>
<cfif getemployee.paystatus neq "A">
<script type="text/javascript">
alert('Emplyee Pay Status is Not Active');
</script>
</cfif>
</cfif>
</body>
</html>
<cfwindow center="true" width="550" height="400" name="findempno" refreshOnShow="true"
        title="Find Employee No" initshow="false"
        source="findempno.cfm?type=EmpNo" />
        
<cfwindow center="true" width="550" height="400" name="findenduser" refreshOnShow="true"
        title="Find Job Code" initshow="false"
        source="findenduser.cfm?type=Job Code" />
        
<cfwindow center="true" width="650" height="500" name="findcustomer" refreshOnShow="true"
        title="Find Customer" initshow="false"
        source="findcustomer.cfm?type=target_arcust" />