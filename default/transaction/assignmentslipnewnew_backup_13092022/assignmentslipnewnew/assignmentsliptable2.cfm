<cfajaximport tags="cfform">
<html>
	<head>
		<title>
			<cfoutput>
				Assignmentslip
			</cfoutput>
			Page
		</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
		<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	</head>
	<cfset dts2=replace(dts,'_i','','all')>
        
    <!---<cfset adminfeelist = "1,20,21">
    <cfset otlist = "22,23,24,25,26,27">
    <cfset govlist = "15,16,42,126">

    <cfquery name="getaw" datasource="#dts#" cachedwithin="#createtimespan(0,0,1,0)#">
    SELECT shelf as aw_cou, desp as aw_desp,allowance FROM icshelf 
    WHERE shelf NOT IN (#adminfeelist#,#otlist#,#govlist#)
    and allowance
    order by desp
    </cfquery>--->
        
	<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
	<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControlbeps.js"></script>
	<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
	<script type="text/javascript">
        
/*Added by Nieo 20181025 1212
function addoption(fieldid){
    
    var optonfield = document.getElementById(fieldid);
    
    <!---<cfoutput>
    <cfloop query="getaw">
        var option#getaw.currentrow# = document.createElement("option");
        option#getaw.currentrow#.title = "#getaw.allowance#";
        option#getaw.currentrow#.text = "#getaw.aw_desp#";
        option#getaw.currentrow#.id = "#getaw.aw_desp#";
        option#getaw.currentrow#.value = "#getaw.aw_cou#";
        optonfield.add(option#getaw.currentrow#);
    </cfloop>
    </cfoutput>--->
}
Added by Nieo 20181025 1212*/
        
function checklvl(i)
{
	if(document.getElementById('lvltype'+i).value != '')
	{
		document.getElementById('lvldesp'+i).readOnly = false;
		document.getElementById('lvleedayhr'+i).readOnly = false;
		document.getElementById('lvleerate'+i).readOnly = false;
		document.getElementById('lvlerdayhr'+i).readOnly = false;
		document.getElementById('lvlerrate'+i).readOnly = false;
		document.getElementById('lvlhr'+i).readOnly = false;
		
	}
	else
	{
		document.getElementById('lvldesp'+i).readOnly = true;
		document.getElementById('lvleedayhr'+i).readOnly = true;
		document.getElementById('lvleerate'+i).readOnly = true;
		document.getElementById('lvlerdayhr'+i).readOnly = true;
		document.getElementById('lvlerrate'+i).readOnly = true;
		document.getElementById('lvlhr'+i).readOnly = true;
		document.getElementById('lvldesp'+i).value = '';
		document.getElementById('lvleedayhr'+i).value = '0.00';
		document.getElementById('lvleerate'+i).value = '0.00';
		document.getElementById('lvlerdayhr'+i).value = '0.00';
		document.getElementById('lvlerrate'+i).value = '0.00';
		document.getElementById('lvlhr'+i).value = '0.00';
	}
}

<cfset dts2=replacenocase(dts,'_i','','all')>
 <cfquery name="getmonth" datasource="payroll_main">
  SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
 </cfquery>
 <cfoutput>
function calextra()
{
	var fields = [
	"firstrate","secondrate"
	];

	for(var i = 0; i < fields.length;i++){
		if(isNaN(document.getElementById(fields[i]).value) || 
		document.getElementById(fields[i]).value == '')
		{
			document.getElementById(fields[i]).value = 0.00;
		}		
	}
	document.getElementById('custsalary').value = parseFloat(parseFloat(document.getElementById('firstrate').value) + parseFloat(document.getElementById('secondrate').value)).toFixed(2);
	calcusttotal();
}


function adminfeecal()
{
    var npl = (parseFloat(document.getElementById('lvltotaler1').value)+parseFloat(document.getElementById('lvltotaler2').value)).toFixed(2);
    var npl_yee = (parseFloat(document.getElementById('lvltotalee1').value)+parseFloat(document.getElementById('lvltotalee2').value)).toFixed(2);
    var customtotalfixaw = parseFloat(document.getElementById('customtotalfixaw').value).toFixed(2);
	var caladminurl = 'calculateadminfee.cfm?empno='+document.getElementById("empno").value+'&placement='+document.getElementById('placementno').value+'&emppaymenttype='+document.getElementById('emppaymenttype').value+'&custepf='+document.getElementById('custcpf').value+'&custsocso='+document.getElementById('custsdf').value+'&custeis='+document.getElementById('custeis').value+'&basicsalary='+document.getElementById('custsalary').value+'&epfpayin='+document.getElementById('epfpayin').value+'&socsopayin='+document.getElementById('socsopayin').value+'&additionalsocso='+document.getElementById('additionalsocso').value+'&additionalepf='+document.getElementById('additionalepf').value+'&nplamt='+npl+'&nplyeeamt='+npl_yee+'&basicsalary_yee='+document.getElementById('selfsalary').value+'&specialfixawamt='+customtotalfixaw;
	
	for(var i=1;i<=8;i++)
	{
		try{
			<!--- caladminurl=caladminurl+'&selfot'+i+'='+document.getElementById('selfot'+i).value; --->
			caladminurl=caladminurl+'&custot'+i+'='+document.getElementById('custot'+i).value;
			
		}
		catch(err)
		{
			caladminurl=caladminurl+'&custot'+i+'=';
		}
	}
	
	for(var i=1;i<=6;i++)
	{
		try{
			caladminurl=caladminurl+'&fixawcode'+i+'='+document.getElementById('fixawcode'+i).value;
			caladminurl=caladminurl+'&fixawer'+i+'='+document.getElementById('fixawer'+i).value;
			caladminurl=caladminurl+'&fixawee'+i+'='+document.getElementById('fixawee'+i).value;
			
		}
		catch(err)
		{
			caladminurl=caladminurl+'&fixawcode'+i+'=';
			caladminurl=caladminurl+'&fixawer'+i+'=';
			caladminurl=caladminurl+'&fixawee'+i+'=';
		}
	}
	
	for(var i=1;i<=18;i++)
	{
			caladminurl=caladminurl+'&allowance'+i+'='+document.getElementById('allowance'+i).value;
			caladminurl=caladminurl+'&awer'+i+'='+document.getElementById('awer'+i).value;
			caladminurl=caladminurl+'&awee'+i+'='+document.getElementById('awee'+i).value;
	}
	
	for(var i=1;i<=6;i++)
	{
			caladminurl=caladminurl+'&billitem'+i+'='+document.getElementById('billitem'+i).value;
			caladminurl=caladminurl+'&billitemamt'+i+'='+document.getElementById('billitemamt'+i).value;
	}
	
	new Ajax.Request(caladminurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('adminfeedata').innerHTML = getdetailback.responseText;
        },
        onFailure: function(){ 
		alert('Error Calculate Pay'); },		
		onComplete: function(transport){
		try{
document.getElementById('adminfee').value = document.getElementById('totaladminfee').value;
            for(var i=1;i<=6;i++)
            {
                // only for hrdf
                if (document.getElementById('billitem'+i).value == '136') {
                    document.getElementById('billitemamt'+i).value = document.getElementById('totalhrdf').value;
                    break;
                } 
            }
dedcalcust();
		}
		catch(err)
		{
		}
        }
      })
	  
		var custsalary = document.getElementById('custsalary').value * 1 ;
		var custphnlsalaryamt = document.getElementById('custphnlsalary').value * 1 ;
		var custottotal = document.getElementById('custottotal').value * 1;
		var custcpf = document.getElementById('custcpf').value * 1;
		var custsdf = document.getElementById('custsdf').value * 1;
		var custallowance = document.getElementById('custallowance').value * 1;
		var custpayback = document.getElementById('custpayback').value * 1;
		var custpbawsamt = document.getElementById('custpbaws').value * 1;
		var totalcustamt=(custsalary+custottotal+custphnlsalaryamt).toFixed(2);
		
	for(var i =1;i<=3; i++)
	{
		if(document.getElementById('billitempercent'+i).value != 0)
		{
			document.getElementById('billitemamt'+i).value = parseFloat((totalcustamt * parseFloat(document.getElementById('billitempercent'+i).value)/100).toFixed(2));
		}
	}
	var adminfeeamt = 0;
	if(document.getElementById('adminfeepercent').value != 0)
	{
		
		adminfeeamt = parseFloat((totalcustamt * parseFloat(document.getElementById('adminfeepercent').value)/100).toFixed(2));
		if(document.getElementById('adminfeeminamt').value != 0)
			{
				if(adminfeeamt != 0 && parseFloat(adminfeeamt) < parseFloat(document.getElementById('adminfeeminamt').value))
				{
					adminfeeamt = parseFloat(document.getElementById('adminfeeminamt').value);
				}
			}
	document.getElementById('adminfee').value = adminfeeamt;
	
	} 
	
}
 
function pbawscal()
{
	var pbamtee = document.getElementById('pbeeamt').value;
	var pbamter = document.getElementById('pberamt').value;
	var awsamtee = document.getElementById('awseeamt').value;
	var awsamter = document.getElementById('awseramt').value;
	var totalpbmisc = parseFloat(document.getElementById('pbcpf').value) + parseFloat(document.getElementById('pbsdf').value) + parseFloat(document.getElementById('pbwi').value) + parseFloat(document.getElementById('pbadm').value);
	var totalawsmisc = parseFloat(document.getElementById('awscpf').value) + parseFloat(document.getElementById('awssdf').value) + parseFloat(document.getElementById('awswi').value) + parseFloat(document.getElementById('awsadm').value);
	document.getElementById('totalpbmiscfield').value = parseFloat(totalpbmisc).toFixed(2);
	document.getElementById('totalawsmiscfield').value = parseFloat(totalawsmisc).toFixed(2);
	var pbawseetotal = 0;
	var pbawsertotal = 0;
	
	if(pbamtee != '' && parseFloat(pbamtee) != 0)
	{
		pbawseetotal = parseFloat(pbawseetotal) + parseFloat(pbamtee);
	}
	if(awsamtee != '' && parseFloat(awsamtee) != 0)
	{
		pbawseetotal = parseFloat(pbawseetotal) + parseFloat(awsamtee);
	}
	document.getElementById('selfpbaws').value = parseFloat(pbawseetotal).toFixed(2);
	
	if(pbamter != '' && parseFloat(pbamter) != 0)
	{
		pbawsertotal = parseFloat(pbawsertotal) + parseFloat(pbamter);
	}
	if(awsamter != '' && parseFloat(awsamter) != 0)
	{
		pbawsertotal = parseFloat(pbawsertotal) + parseFloat(awsamter);
	}
	pbawsertotal = parseFloat(pbawsertotal) + parseFloat(parseFloat(totalpbmisc).toFixed(2)) + parseFloat(parseFloat(totalawsmisc).toFixed(2));
	
	document.getElementById('custpbaws').value = parseFloat(pbawsertotal).toFixed(2);
	calselftotal();
	calcusttotal();
	caltax2();
}



function leaveself()
{
	for(var i =1;i<=10; i++)
	{
        var hdtaken = document.getElementById('lvleedayhr'+i).value;
        if(hdtaken.trim() != ""){
            hdtaken = parseFloat(document.getElementById('lvleedayhr'+i).value);
        }else{
            hdtaken =0;
        }
        var ratetaken = document.getElementById('lvleerate'+i).value;
        if(ratetaken.trim() != ""){
            ratetaken = parseFloat(document.getElementById('lvleerate'+i).value);
        }else{
            ratetaken = 0;
        }
		//if(hdtaken != '')
		//{
			document.getElementById('lvltotalee'+i).value = (hdtaken * ratetaken).toFixed(2);
		//}
	}
	
	var totallvleeamt = 0;
	for(var i =1;i<=10; i++)
	{
		var totalleaveamt = document.getElementById('lvltotalee'+i).value;
		if(totalleaveamt != '')
		{
			totallvleeamt = parseFloat(totallvleeamt) + parseFloat(totalleaveamt);;
		}
	}
	
	document.getElementById('selfphnlsalary').value =parseFloat(totallvleeamt).toFixed(2);
    
	calselftotal();
}

function leavecust()
{
	for(var i =1;i<=10; i++)
	{
        var hdtaken = document.getElementById('lvlerdayhr'+i).value;
        if(hdtaken.trim() != ""){
            hdtaken = parseFloat(document.getElementById('lvlerdayhr'+i).value);
        }else{
            hdtaken = 0;
        }
        var ratetaken = document.getElementById('lvlerrate'+i).value;
		if(ratetaken.trim() != ""){
            ratetaken = parseFloat(document.getElementById('lvlerrate'+i).value);
        }else{
            ratetaken = 0;
        }
		//if(hdtaken != '')
		//{
			document.getElementById('lvltotaler'+i).value = (hdtaken * ratetaken).toFixed(2);
		//}
	}
	
	var totallvleramt = 0;
	for(var i =1;i<=10; i++)
	{
		var totalleaveamt = document.getElementById('lvltotaler'+i).value;
		if(totalleaveamt != '')
		{
			totallvleramt = parseFloat(totallvleramt) + parseFloat(totalleaveamt);;
		}
	}
	
	document.getElementById('custphnlsalary').value =parseFloat(totallvleramt).toFixed(2);
	calcusttotal();
}
 
 function dateajaxfunction(newworkd)
{
	getpanel(document.getElementById('placementno').value,newworkd);
}

function validatets()
{
	var msg = "";
	if(document.getElementById('paymenttype').value == "mth")
	{
		if(parseFloat(document.getElementById('workd').value) != parseFloat(document.getElementById('tstotalwd').value))
		{
			msg = msg + "Working days in time sheet is not sames with value calculated from placement!\n";
		}
		if(parseFloat(document.getElementById('selfsalaryday').value) != parseFloat(document.getElementById('tstotaldw').value))
		{
			msg = msg + "Days Worked in time sheet is not sames with value calculated from placement!\n";
		}
	}
	else if (document.getElementById('paymenttype').value == "day")
	{
		if(parseFloat(document.getElementById('workd').value) != parseFloat(document.getElementById('tstotalwd').value))
		{
			msg = msg + "Working days in time sheet is not sames with value calculated from placement!\n";
		}
		if(parseFloat(document.getElementById('selfsalaryday').value) != parseFloat(document.getElementById('tstotaldaysw').value))
		{
			msg = msg + "Days Worked in time sheet is not sames with value calculated from placement!\n";
		}
		
		for(var i =1;i<=10; i++)
	{
		var hdtaken = document.getElementById('lvleedayhr'+i).value;
		var typetaken = document.getElementById('lvltype'+i).value;
		try{
			if(parseFloat(document.getElementById('ts'+typetaken+'days').value) != parseFloat(hdtaken))
		{
			msg = msg + typetaken+" in time sheet is not sames with value calculated from placement!\n";
		}
				}
		catch(err)
		{
		}
	}
	
	}
	
		else if (document.getElementById('paymenttype').value == "hr")
	{
		
		if(parseFloat(document.getElementById('selfsalaryhrs').value) != parseFloat(document.getElementById('tstotalhour').value))
		{
			msg = msg + "Hours Worked in time sheet is not sames with value calculated from placement!\n";
		}
		
		for(var i =1;i<=10; i++)
	{
		var hdtaken = document.getElementById('lvleedayhr'+i).value;
		var typetaken = document.getElementById('lvltype'+i).value;
		try{
			if(parseFloat(document.getElementById('ts'+typetaken+'hours').value) != parseFloat(hdtaken))
		{
			msg = msg + typetaken+" in time sheet is not sames with value calculated from placement!\n";
		}
				}
		catch(err)
		{
		}
	}
	
	}
	
	if(msg != '')
	{
		alert(msg);
	}
}


function gettimesheet(pno,empno)
{
	ColdFusion.Window.show('timesheet');
}

function processtimesheet(pno,empno)
{
	var formurl = 'tsprocess.cfm?placementno='+pno+'&empno='+empno;
	<!--- ajaxFunction(document.getElementById('assignmentfield'),'assignajax.cfm?type=#url.type#&pno='+placeno+'&startdate='+escape(datestart)+'&enddate='+escape(datecomplete)); --->
	 new Ajax.Request(formurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('timesheetfield').innerHTML = getdetailback.responseText;
        },
        onFailure: function(getresponse){ 
		alert(getresponse.statusText);
		},		
		onComplete: function(transport){
		getpanel(pno);
		document.getElementById('timesheeton').value = '1';
        }
      })
}

function loadpanel(placeno,newworkd)
{
    gettax();
	var datestart = document.getElementById('startdate').value;
	var datecomplete = document.getElementById('completedate').value;
	var formurl = 'assignajax.cfm?<cfif isdefined('url.pno')>auto=#url.id#&</cfif><cfif isdefined('url.placementno')>auto2=#url.auto2#&</cfif><cfif url.type eq "edit" or url.type eq "delete">typenew=#url.type#&</cfif>type=Create&pno='+placeno+'&startdate='+escape(datestart)+'&enddate='+escape(datecomplete)+'&newworkd='+newworkd<cfif #IsDefined('url.backdated')#>+'&bdflag=yes&bdstartdate=#url.firstday#&bdenddate=#url.lastday#'</cfif>;
	<!--- ajaxFunction(document.getElementById('assignmentfield'),'assignajax.cfm?type=#url.type#&pno='+placeno+'&startdate='+escape(datestart)+'&enddate='+escape(datecomplete)); --->
	 new Ajax.Request(formurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('assignmentfield').innerHTML = getdetailback.responseText;
        <cfoutput>
        <cfloop index='a' from='1' to='18'>
            addoption('allowance#a#');
        </cfloop>
        </cfoutput>
        //Added by Nieo 20180405 1530
        checkallowance();
        var checkname = document.getElementById('custname').value;
        if(checkname.toLowerCase().indexOf('venture') >= 0){
            unlockOT();
            checkforOT();
            //console.log('loaded');
        }
        },
        onFailure: function(){
		alert('Please kindly check placement pay effective date!');
		},
		onComplete: function(transport){
		generaterefno();
        
		if(document.getElementById('timesheeton').value == '1')
		{
			validatets();
		}

		<cfloop from="1" to="4" index="a">
<cfoutput>
calselfot#a#();
calcustot#a#();
</cfoutput>
</cfloop>

calselfallow();
calcustallow();
dedcalcust();
calselftotal();
calcusttotal();

<cfif isdefined('url.placementno')>
setTimeout(checkpay(),1000);
</cfif>

        }
      })

}



function generaterefno()
{
	var assignmenttype1 = escape(document.getElementById('assignmenttype').value);
	var refnoplacementno = document.getElementById('placementno').value;
	var newrefnourl = 'newrefno.cfm?<cfif url.type eq "edit" or url.type eq "delete">refno=#url.refno#&</cfif>assignmenttype='+assignmenttype1+'&placementno='+refnoplacementno;
	 new Ajax.Request(newrefnourl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('newrefnofield').innerHTML = getdetailback.responseText;
        },
        onFailure: function(){
		},
		onComplete: function(transport){
		document.getElementById('refno').value=document.getElementById('getrefno').value;
        }
      })

}
</cfoutput>

function checkmonth()
{
	<!--- if(parseFloat(document.getElementById('selfallowance').value) < 0)
	{
		alert("Total Payment and Deduction cannot be negative.  Please enter negative amount(s) via Backpay column with the right description");
		return false;
	} --->

	<cfif url.type eq "create">
	var getdate = document.getElementById('Assignmentslipdate').value;
	var getdatesplit = getdate.split('/');
	var slipmonth = getdatesplit[1];
	var slipyear = getdatesplit[2];
	if(slipmonth != <cfoutput>'#numberformat(getmonth.mmonth,'00')#' || slipyear != '#getmonth.myear#'</cfoutput>)
	{
		if(confirm('Assignment Slip Date is Not Same With Payroll Date. Do you want to proceed?'))
		{
			return true;
		}
		else
		{
		return false;
		}
	}
	else
	{
		return true;
	}
<cfelse>
	return true;
	</cfif>
}

<!--- function validate(){
  if(document.AssignmentslipForm.source.value==''){
	alert("Your Assignmentslip's No. cannot be blank.");
	document.AssignmentslipForm.source.focus();
	return false;
  }

<!---   if(document.AssignmentslipForm.PorJ.value==''){
	alert("You must choose P or J.");
	document.AssignmentslipForm.PorJ.focus();
	return false;
  } --->
  return true;
} --->

function limitText(field,maxlimit){
	if (field.value.length > maxlimit) // if too long...trim it!
		field.value = field.value.substring(0, maxlimit);
		// otherwise, update 'characters left' counter
}

function calselfexception()
{

	var selfexceptionrate = document.getElementById('selfexceptionrate').value;
	var selfexceptionhrs = document.getElementById('selfexceptionhrs').value;

	selfexceptionrate = selfexceptionrate * 1;
	selfexceptionhrs = selfexceptionhrs * 1;

	document.getElementById('selfexception').value=(selfexceptionrate*selfexceptionhrs+0.00001).toFixed(2);

	calselftotal();
}

function calselfot1()
{
	var selfotrate1 = document.getElementById('selfotrate1').value;
	var selfothour1 = document.getElementById('selfothour1').value;

	selfotrate1 = selfotrate1 * 1;
	selfothour1 = selfothour1 * 1;

	document.getElementById('selfot1').value=(selfotrate1*selfothour1+0.00001).toFixed(2);

	calselfottotal();
}

function calselfot2()
{
	var selfotrate2 = document.getElementById('selfotrate2').value;
	var selfothour2 = document.getElementById('selfothour2').value;

	selfotrate2 = selfotrate2 * 1;
	selfothour2 = selfothour2 * 1;

	document.getElementById('selfot2').value=(selfotrate2*selfothour2+0.00001).toFixed(2);

	calselfottotal();
}

function calselfot3()
{
	var selfotrate3 = document.getElementById('selfotrate3').value;
	var selfothour3 = document.getElementById('selfothour3').value;

	selfotrate3 = selfotrate3 * 1;
	selfothour3 = selfothour3 * 1;

	document.getElementById('selfot3').value=(selfotrate3*selfothour3+0.00001).toFixed(2);

	calselfottotal();
}

function calselfot4()
{
	var selfotrate4 = document.getElementById('selfotrate4').value;
	var selfothour4 = document.getElementById('selfothour4').value;

	selfotrate4 = selfotrate4 * 1;
	selfothour4 = selfothour4 * 1;

	document.getElementById('selfot4').value=(selfotrate4*selfothour4+0.00001).toFixed(2);

	calselfottotal();
}

function calselfot(i)
{
	var selfotrate = document.getElementById('selfotrate'+i).value;
	var selfothour = document.getElementById('selfothour'+i).value;

	selfotrate = selfotrate * 1;
	selfothour = selfothour * 1;

	document.getElementById('selfot'+i).value=(selfotrate*selfothour+0.00001).toFixed(2);

	calselfottotal();
}


function calselfottotal()
{
	var selfot1=document.getElementById('selfot1').value * 1;
	var selfot2=document.getElementById('selfot2').value * 1;
	var selfot3=document.getElementById('selfot3').value * 1;
	var selfot4=document.getElementById('selfot4').value * 1;
	var selfot5=document.getElementById('selfot5').value * 1;
	var selfot6=document.getElementById('selfot6').value * 1;
	var selfot7=document.getElementById('selfot7').value * 1;
	var selfot8=document.getElementById('selfot8').value * 1;

	document.getElementById('selfottotal').value=(selfot1+selfot2+selfot3+selfot4+selfot5+selfot6+selfot7+selfot8+0.00001).toFixed(2);

	calselftotal();
}

function calcustot1()
{
	var custotrate1 = document.getElementById('custotrate1').value;
	var custothour1 = document.getElementById('custothour1').value;

	custotrate1 = custotrate1 * 1;
	custothour1 = custothour1 * 1;

	document.getElementById('custot1').value=(custotrate1*custothour1+0.00001).toFixed(2);

	calcustottotal();
}

function calcustot2()
{
	var custotrate2 = document.getElementById('custotrate2').value;
	var custothour2 = document.getElementById('custothour2').value;

	custotrate2 = custotrate2 * 1;
	custothour2 = custothour2 * 1;

	document.getElementById('custot2').value=(custotrate2*custothour2+0.00001).toFixed(2);

	calcustottotal();
}

function calcustot3()
{
	var custotrate3 = document.getElementById('custotrate3').value;
	var custothour3 = document.getElementById('custothour3').value;

	custotrate3 = custotrate3 * 1;
	custothour3 = custothour3 * 1;

	document.getElementById('custot3').value=(custotrate3*custothour3+0.00001).toFixed(2);

	calcustottotal();
}

function calcustot4()
{
	var custotrate4 = document.getElementById('custotrate4').value;
	var custothour4 = document.getElementById('custothour4').value;

	custotrate4 = custotrate4 * 1;
	custothour4 = custothour4 * 1;

	document.getElementById('custot4').value=(custotrate4*custothour4+0.00001).toFixed(2);

	calcustottotal();
}

function calcustot(i)
{
	var custotrate = document.getElementById('custotrate'+i).value;
	var custothour = document.getElementById('custothour'+i).value;

	custotrate = custotrate * 1;
	custothour = custothour * 1;

	document.getElementById('custot'+i).value=(custotrate*custothour+0.00001).toFixed(2);

	calcustottotal();
}

function calcustottotal()
{
	var custot1=document.getElementById('custot1').value * 1;
	var custot2=document.getElementById('custot2').value * 1;
	var custot3=document.getElementById('custot3').value * 1;
	var custot4=document.getElementById('custot4').value * 1;
	var custot5=document.getElementById('custot5').value * 1;
	var custot6=document.getElementById('custot6').value * 1;
	var custot7=document.getElementById('custot7').value * 1;
	var custot8=document.getElementById('custot8').value * 1;

	document.getElementById('custottotal').value=(custot1+custot2+custot3+custot4+custot5+custot6+custot7+custot8).toFixed(2);

	calcusttotal();
}


function calselfallow()
{

	var selfallowancerate1 = document.getElementById('selfallowancerate1').value;
	var selfallowancehour1 = document.getElementById('selfallowancehour1').value;

	var selfallowancerate2 = document.getElementById('selfallowancerate2').value;
	var selfallowancehour2 = document.getElementById('selfallowancehour2').value;

	var selfallowancerate3 = document.getElementById('selfallowancerate3').value;
	var selfallowancehour3 = document.getElementById('selfallowancehour3').value;

	var selfallowancerate4 = document.getElementById('selfallowancerate4').value;
	var selfallowancerate5 = document.getElementById('selfallowancerate5').value;
	var selfallowancerate6 = document.getElementById('selfallowancerate6').value;


	selfallowancerate1 = ((selfallowancerate1 * 1+0.00001).toFixed(2)) * 1;
	selfallowancehour1 = ((selfallowancehour1 * 1+0.00001).toFixed(2)) * 1;
	selfallowancerate2 = ((selfallowancerate2 * 1+0.00001).toFixed(2)) * 1;
	selfallowancehour2 = ((selfallowancehour2 * 1+0.00001).toFixed(2)) * 1;
	selfallowancerate3 = ((selfallowancerate3 * 1+0.00001).toFixed(2)) * 1;
	selfallowancehour3 = ((selfallowancehour3 * 1+0.00001).toFixed(2)) * 1;
	selfallowancerate4 = ((selfallowancerate4 * 1+0.00001).toFixed(2)) * 1;
	selfallowancerate5 = ((selfallowancerate5 * 1+0.00001).toFixed(2)) * 1;
	selfallowancerate6 = ((selfallowancerate6 * 1+0.00001).toFixed(2)) * 1;

	var totalotheraw = 0;
	for(var i=1;i<=6;i++)
	{
		if(document.getElementById('fixawee'+i).value != '' && parseFloat(document.getElementById('fixawee'+i).value) != 0)
		{
			totalotheraw= parseFloat(totalotheraw) + parseFloat((parseFloat(document.getElementById('fixawee'+i).value)+0.00001).toFixed(2));
		}
	}
	for(var i=1;i<=18;i++)
	{
		if(document.getElementById('awee'+i).value != '' && parseFloat(document.getElementById('awee'+i).value) != 0)
		{
			totalotheraw= parseFloat(totalotheraw) + parseFloat((parseFloat(document.getElementById('awee'+i).value)+0.00001).toFixed(2));
		}
	}


	document.getElementById('selfallowance').value=((totalotheraw).toFixed(2)*1+(selfallowancerate1*selfallowancehour1+0.00001).toFixed(2)*1+(selfallowancerate2*selfallowancehour2+0.00001).toFixed(2)*1+(selfallowancerate3*selfallowancehour3+0.00001).toFixed(2)*1+(selfallowancerate4.toFixed(2)*1+selfallowancerate5.toFixed(2)*1+selfallowancerate6.toFixed(2)*1)).toFixed(2);

calselftotal();
}


function calcustallow()
{
	var custallowancerate1 = document.getElementById('custallowancerate1').value;
	var custallowancehour1 = document.getElementById('custallowancehour1').value;

	var custallowancerate2 = document.getElementById('custallowancerate2').value;
	var custallowancehour2 = document.getElementById('custallowancehour2').value;

	var custallowancerate3 = document.getElementById('custallowancerate3').value;
	var custallowancehour3 = document.getElementById('custallowancehour3').value;

	var custallowancerate4 = document.getElementById('custallowancerate4').value;
	var custallowancerate5 = document.getElementById('custallowancerate5').value;
	var custallowancerate6 = document.getElementById('custallowancerate6').value;

	custallowancerate1 = ((custallowancerate1 * 1+0.00001).toFixed(2)) * 1;
	custallowancehour1 = ((custallowancehour1 * 1+0.00001).toFixed(2)) * 1;
	custallowancerate2 = ((custallowancerate2 * 1+0.00001).toFixed(2)) * 1;
	custallowancehour2 = ((custallowancehour2 * 1+0.00001).toFixed(2)) * 1;
	custallowancerate3 = ((custallowancerate3 * 1+0.00001).toFixed(2)) * 1;
	custallowancehour3 = ((custallowancehour3 * 1+0.00001).toFixed(2)) * 1;
	custallowancerate4 = ((custallowancerate4 * 1+0.00001).toFixed(2)) * 1;
	custallowancerate5 = ((custallowancerate5 * 1+0.00001).toFixed(2)) * 1;
	custallowancerate6 = ((custallowancerate6 * 1+0.00001).toFixed(2)) * 1;

	var totalotheraw = 0;
	for(var i=1;i<=6;i++)
	{
		if(document.getElementById('fixawer'+i).value != '' && parseFloat(document.getElementById('fixawer'+i).value) != 0)
		{
			totalotheraw= parseFloat(totalotheraw) + parseFloat((parseFloat(document.getElementById('fixawer'+i).value)+0.00001).toFixed(2));
		}
	}
	for(var i=1;i<=18;i++)
	{
		if(document.getElementById('awer'+i).value != '' && parseFloat(document.getElementById('awer'+i).value) != 0)
		{
			totalotheraw= parseFloat(totalotheraw) + parseFloat((parseFloat(document.getElementById('awer'+i).value)+0.00001).toFixed(2));
		}
	}

	document.getElementById('custallowance').value=((totalotheraw).toFixed(2)*1+(custallowancerate1*custallowancehour1+0.00001).toFixed(2)*1+(custallowancerate2*custallowancehour2+0.00001).toFixed(2)*1+(custallowancerate3*custallowancehour3+0.00001).toFixed(2)*1+(custallowancerate4.toFixed(2)*1+custallowancerate5.toFixed(2)*1+custallowancerate6.toFixed(2)*1)).toFixed(2);

calcusttotal();
}

<!--- function caltax()
	{
var net = document.getElementById('selfnet').value;

	var taxper = document.getElementById('taxper').value;
	var taxamt = document.getElementById('taxamt');
	var grand = document.getElementById('selftotal');
	var taxval = 0;
	taxper = parseFloat(taxper);
	net = parseFloat(net);

	taxval = 0;
	<!---taxamt.value = taxval;--->
	var netb = (net * 1) ;
	var selfdeduction = document.getElementById('selfdeduction').value * 1;
	var selfcpf = document.getElementById('selfcpf').value * 1;

	grand.value = (netb-selfdeduction).toFixed(2);

	} --->
        
function gettax(){
    var formurl = 'gettaxamt.cfm?custno='+document.getElementById("custno").value+"&completedate="+document.getElementById('completedate').value;
        
    new Ajax.Request(formurl,
    {
    method:'get',
    onSuccess: function(getdetailback){
    document.getElementById('gettaxfield').innerHTML = getdetailback.responseText;
    },
    onFailure: function(){
        alert("Please try to calculate again.")
    },
    onComplete: function(transport){
        document.getElementById('taxitemlist').value = document.getElementById('taxitem').value;
    }
    })
    
}

function caltax2()
	{
        
	var net = document.getElementById('custnet').value;

	var taxper = document.getElementById('taxper').value* 1;
	var taxamtfield = document.getElementById('taxamt');
	var grand = document.getElementById('custtotal');
	var taxval = 0;
	taxper = parseFloat(taxper);
	net = parseFloat(net);

	var custsalary = parseFloat(document.getElementById('custsalary').value);
	var custottotal = document.getElementById('custottotal').value * 1;
	var custcpf = document.getElementById('custcpf').value * 1;
	var custsdf = document.getElementById('custsdf').value * 1;
    var custeis = document.getElementById('custeis').value * 1;
	var custallowance = document.getElementById('custallowance').value * 1;
	var custpayback = document.getElementById('custpayback').value * 1;

	var addchargecust = document.getElementById('addchargecust').value * 1;
	var addchargecust2 = document.getElementById('addchargecust2').value * 1;
	var addchargecust3 = document.getElementById('addchargecust3').value * 1;

	var custallowancerate4 = ((document.getElementById('custallowancerate4').value * 1+0.00001).toFixed(2)) * 1;
	var custallowancerate5 = ((document.getElementById('custallowancerate5').value * 1+0.00001).toFixed(2)) * 1;
	var custallowancerate6 = ((document.getElementById('custallowancerate6').value * 1+0.00001).toFixed(2)) * 1;
        
    var adminfee = document.getElementById('adminfee').value * 1;
    
    var taxitemlist = document.getElementById('taxitemlist').value;
        
    var taxitem = taxitemlist.split(',');

	var lvltaxtotal = 0;
        
    if(taxitemlist == ""){
        for(var i =1;i<=10;i++)
        {
            if(document.getElementById('lvltotaler'+i).value !='')
            {
            lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('lvltotaler'+i).value)+0.00001).toFixed(5));
            }
        }    
	}    

    if(taxitemlist != ""){
        
        for(var i =1;i<=6;i++)
        {
            if(document.getElementById('fixawer'+i).value !='' && parseFloat(document.getElementById('fixawer'+i).value) !=0 && taxitem.indexOf(document.getElementById('fixawcode'+i).value) != -1)
            {                
            lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('fixawer'+i).value)+0.00001).toFixed(5));
            //console.log(document.getElementById('fixawcode'+i).value+": "+taxitem.indexOf(document.getElementById('fixawcode'+i).value));
            }
        }

        for(var i =1;i<=18;i++)
        {
            if(document.getElementById('awer'+i).value !='' && parseFloat(document.getElementById('awer'+i).value) !=0 && taxitem.indexOf(document.getElementById('allowance'+i).value) != -1)
            {
            lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('awer'+i).value)+0.00001).toFixed(5));
            //console.log(document.getElementById('allowance'+i).value+": "+taxitem.indexOf(document.getElementById('allowance'+i).value));
            }
        }
        
    }else{
        
        for(var i =1;i<=6;i++)
        {
            if(document.getElementById('fixawer'+i).value !='' && parseFloat(document.getElementById('fixawer'+i).value) !=0)
            {
            lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('fixawer'+i).value)+0.00001).toFixed(5));
            }
        }

        for(var i =1;i<=18;i++)
        {
            if(document.getElementById('awer'+i).value !='' && parseFloat(document.getElementById('awer'+i).value) !=0)
            {
            lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('awer'+i).value)+0.00001).toFixed(5));
            }
        }
        
        
    }
    

	if(parseFloat(document.getElementById('pberamt').value) != 0)
	{
		lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('pberamt').value)+0.00001).toFixed(2));
	}

	if(parseFloat(document.getElementById('awseramt').value) != 0)
	{
		lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('awseramt').value)+0.00001).toFixed(2));
	}

	if(parseFloat(document.getElementById('totalpbmiscfield').value) != 0)
	{
		lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('totalpbmiscfield').value)+0.00001).toFixed(2));
	}

	if(parseFloat(document.getElementById('totalawsmiscfield').value) != 0)
	{
		lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('totalawsmiscfield').value)+0.00001).toFixed(2));
	}

	if(parseFloat(document.getElementById('nscustded').value) != 0)
	{
		lvltaxtotal = parseFloat(lvltaxtotal) - parseFloat(((taxper/100)*parseFloat(document.getElementById('nscustded').value)+0.00001).toFixed(2));
	}

	if(parseFloat(document.getElementById('adminfee').value) != 0)
	{
		lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('adminfee').value)+0.00001).toFixed(5));
	}
        //console.log(parseFloat(document.getElementById('adminfee').value));
        
	if(parseFloat(document.getElementById('rebate').value) != 0)
	{
		lvltaxtotal = parseFloat(lvltaxtotal) - parseFloat(((taxper/100)*parseFloat(document.getElementById('rebate').value)+0.00001).toFixed(2));
	}

    if(taxitemlist != ""){
        for(var i =1;i<=6;i++)
        {
            if(document.getElementById('billitemamt'+i).value !='' && parseFloat(document.getElementById('billitemamt'+i).value) !=0 && taxitem.indexOf(document.getElementById('billitem'+i).value) != -1)
            {
            lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('billitemamt'+i).value)+0.00001).toFixed(5));
            //console.log(document.getElementById('billitem'+i).value+': '+taxitem.indexOf(document.getElementById('billitem'+i).value));
            }
        }
    }else{
        for(var i =1;i<=6;i++)
        {
            if(document.getElementById('billitemamt'+i).value !='' && parseFloat(document.getElementById('billitemamt'+i).value) !=0)
            {
            lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('billitemamt'+i).value)+0.00001).toFixed(5));
            }
        }
    }
        
    if(document.getElementById('addchargecust').value !='' && parseFloat(document.getElementById('addchargecust').value) !=0 && taxitem.indexOf(document.getElementById('addchargecode').value) != -1)
    {
    lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('addchargecust').value)+0.00001).toFixed(5));
    }
        
    if(document.getElementById('addchargecust2').value !='' && parseFloat(document.getElementById('addchargecust2').value) !=0 && taxitem.indexOf(document.getElementById('addchargecode2').value) != -1)
    {
    lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('addchargecust2').value)+0.00001).toFixed(5));
    }
        
    if(document.getElementById('addchargecust3').value !='' && parseFloat(document.getElementById('addchargecust3').value) !=0 && taxitem.indexOf(document.getElementById('addchargecode3').value) != -1)
    {
    lvltaxtotal = parseFloat(lvltaxtotal) + parseFloat(((taxper/100)*parseFloat(document.getElementById('addchargecust3').value)+0.00001).toFixed(5));
    }

	for(var i =1;i<=3;i++)
	{
		if(document.getElementById('dedcust'+i).value !='' && parseFloat(document.getElementById('dedcust'+i).value) !=0)
		{
		lvltaxtotal = parseFloat(lvltaxtotal) - parseFloat(((taxper/100)*parseFloat(document.getElementById('dedcust'+i).value)+0.00001).toFixed(5));
		}
	}

	if(parseFloat(document.getElementById('secondrate').value) != 0 && parseFloat(document.getElementById('firstrate').value) != 0 )
	{
	taxval1 = parseFloat(parseFloat(((taxper/100)*parseFloat(document.getElementById('firstrate').value)+0.00001).toFixed(5)) + parseFloat(((taxper/100)*parseFloat(document.getElementById('secondrate').value)+0.00001).toFixed(2))).toFixed(5);
	}
	else
	{
	taxval1 = ((taxper/100)*custsalary+0.00001).toFixed(5);
	}
	taxval2 = ((taxper/100)*custottotal+0.00001).toFixed(5);
	taxval3 = ((taxper/100)*custeis+0.00001).toFixed(5);
	taxval4 = ((taxper/100)*custcpf+0.00001).toFixed(5);
	taxval5 = ((taxper/100)*custsdf+0.00001).toFixed(5);
	taxval6 = ((taxper/100)*addchargecust+0.00001).toFixed(5);
	taxval7 = ((taxper/100)*addchargecust2+0.00001).toFixed(5);
	taxval8 = ((taxper/100)*addchargecust3+0.00001).toFixed(5);
	taxval9 = 0;
	taxval10 = ((taxper/100)*custpayback+0.00001).toFixed(5);
	taxval11 = 0;
	taxval12 = 0;
	taxval13 = 0;
	taxval14 = 0;
	taxval15 = 0;
	taxval16 = ((taxper/100)*custallowancerate4+0.00001).toFixed(5);
	taxval17 = ((taxper/100)*custallowancerate5+0.00001).toFixed(5);
	taxval18 = ((taxper/100)*custallowancerate6+0.00001).toFixed(5);
    
    if(taxitemlist != ""){
        taxval = ((lvltaxtotal*1)+0.00001).toFixed(2);
        //console.log(lvltaxtotal);
    }else{
	   taxval = ((taxval1*1)+(taxval2*1)+(taxval3*1)+(taxval4*1)+(taxval5*1)+(taxval6*1)+(taxval7*1)+(taxval8*1)+(taxval9*1)+(taxval10*1)+(taxval11*1)+(taxval12*1)+(taxval13*1)+(taxval14*1)+(taxval15*1)+(taxval16*1)+(taxval17*1)+(taxval18*1)+(lvltaxtotal*1)+0.00001).toFixed(2);
    }
	<!---taxval = ((taxper/100)*net).toFixed(2);--->

    taxamtfield.value = taxval;
	<!--- calcusttotal();
	var netb = (net * 1) + (taxval * 1);
	var custdeduction = document.getElementById('custdeduction').value * 1;
	var custcpf = ((taxper+100)/100) * (document.getElementById('custcpf').value * 1);
	grand.value = (netb-custdeduction).toFixed(2);
<cfif getauthuser() eq "ultracai">
alert(taxval1+'\n'+taxval2+'\n'+taxval3+'\n'+taxval4+'\n'+taxval5+'\n'+taxval6+'\n'+taxval7+'\n'+taxval8+'\n'+taxval9+'\n'+taxval10+'\n'+taxval11+'\n'+taxval12+'\n'+taxval13+'\n'+taxval14+'\n'+taxval15+'\n'+taxval16+'\n'+taxval17+'\n'+taxval18+'\n');
</cfif> --->
	}


function calselftotal()
{


	var selfsalary = document.getElementById('selfsalary').value * 1 ;
	var selfphnlsalaryamt = document.getElementById('selfphnlsalary').value * 1;
	var selfottotal = document.getElementById('selfottotal').value * 1;
	var selfcpf = document.getElementById('selfcpf').value * 1;
	var selfsdf = document.getElementById('selfsdf').value * 1;
    var selfeis = document.getElementById('selfeis').value * 1;
	var selfallowance = document.getElementById('selfallowance').value * 1;
	var selfpayback = document.getElementById('selfpayback').value * 1;
	var selfpbawsamt = document.getElementById('selfpbaws').value * 1;
	var selfdeductionamt = document.getElementById('selfdeduction').value * 1;
    
	document.getElementById('selftotal').value=(selfsalary+selfphnlsalaryamt+selfottotal-selfcpf-selfsdf-selfeis+selfallowance+selfpbawsamt+selfdeductionamt+selfpayback).toFixed(2);
}

function calcusttotal()
{
	var fields = [
	"adminfee"
	];

	for(var i = 0; i < fields.length;i++){
		if(isNaN(document.getElementById(fields[i]).value) ||
		document.getElementById(fields[i]).value == '')
		{
			document.getElementById(fields[i]).value = 0.00;
		}
	}
	caltax2();
	var custsalary = document.getElementById('custsalary').value * 1 ;
	var custphnlsalaryamt = document.getElementById('custphnlsalary').value * 1 ;
	var custottotal = document.getElementById('custottotal').value * 1;
	var custcpf = document.getElementById('custcpf').value * 1;
	var custsdf = document.getElementById('custsdf').value * 1;
    var custeis = document.getElementById('custeis').value * 1;
	var custallowance = document.getElementById('custallowance').value * 1;
	var custpayback = document.getElementById('custpayback').value * 1;
	var custpbawsamt = document.getElementById('custpbaws').value * 1;
	var custdeductionamt = document.getElementById('custdeduction').value * 1;
	var taxamtamt = document.getElementById('taxamt').value * 1;
	var adminfeeamt = parseFloat(parseFloat(document.getElementById('adminfee').value).toFixed(2));

	document.getElementById('custtotal').value=(custsalary+custottotal+custphnlsalaryamt+custallowance+custcpf+custsdf+custeis+custpbawsamt+custdeductionamt+custpayback+adminfeeamt+taxamtamt).toFixed(2);
	document.getElementById('custtotalgross').value=(custsalary+custottotal+custphnlsalaryamt+custallowance+custcpf+custsdf+custeis+custpbawsamt+custdeductionamt+custpayback+adminfeeamt).toFixed(2);

}

function selectlist(varval,varattb){
		for (var idx=0;idx<document.getElementById(varattb).options.length;idx++)
		{
			if (varval.toLowerCase()==document.getElementById(varattb).options[idx].value.toLowerCase())
			{
				document.getElementById(varattb).options[idx].selected=true;

			}
		}
		}

function updatecustno()
{
selectlist(document.getElementById('custno1').value,'custno');
}

function updatepaymenttype()
{

selectlist(document.getElementById('paymenttype2').value,'paymenttype');

}

function calculateselfhour()
{
if(document.getElementById('paymenttype').value == "hr")
{
document.getElementById('selfsalary').value=(document.getElementById('selfsalaryhrs').value*document.getElementById('selfusualpay').value+0.00001).toFixed(2);
hrotrate('self');
calselfot1();
calselfot2();
calselfot3();
calselfot4();
calselfot(5);
calselfot(6);
calselfot(7);
calselfot(8);
calselftotal();

}
else if(document.getElementById('paymenttype').value == "day"){
document.getElementById('selfsalary').value=(document.getElementById('selfsalaryday').value*document.getElementById('selfusualpay').value+0.00001).toFixed(2);
calselftotal();
}
}

function selfnpl()
{
		if(document.getElementById('paymenttype').value == "mth"){
			var workingday = parseFloat(document.getElementById('workd').value);
			var selfnpl = parseFloat(document.getElementById('NPL').value);
			var selfrate = parseFloat(document.getElementById('selfusualpay').value);
			if(selfnpl == 0 || selfnpl == '')
			{
				document.getElementById('selfsalary').value=selfrate.toFixed(2);
			}
			else
			{
				var newpay = ((workingday - selfnpl) / workingday) * selfrate+0.00001;
				document.getElementById('selfsalary').value=newpay.toFixed(2);
			}
			calselftotal();
	}
}

function custnpl()
{
		if(document.getElementById('paymenttype').value == "mth"){
			var workingday = parseFloat(document.getElementById('workd').value);
			var custnpl = parseFloat(document.getElementById('CUSTNPL').value);
			var custrate = parseFloat(document.getElementById('custusualpay').value);
			if(custnpl == 0 || custnpl == '')
			{
				document.getElementById('custsalary').value=custrate.toFixed(2);
			}
			else
			{
				var newpay = ((workingday - custnpl) / workingday) * custrate+0.00001;
				document.getElementById('custsalary').value=newpay.toFixed(2);
			}
			calcusttotal();
	}
}

function setselfallow()
{
calculateselfhour();



<!--- document.getElementById('selfallowancehour1').value=document.getElementById('selfsalaryhrs').value;
document.getElementById('selfallowancehour2').value=document.getElementById('selfsalaryhrs').value;
document.getElementById('selfallowancehour3').value=document.getElementById('selfsalaryhrs').value;
document.getElementById('selfallowancehour4').value=document.getElementById('selfsalaryhrs').value; --->

calselfallow();
}

function calculatecusthour()
{
if(document.getElementById('paymenttype').value == "hr")
{
document.getElementById('custsalary').value=(document.getElementById('custsalaryhrs').value*document.getElementById('custusualpay').value+0.00001).toFixed(2);
hrotrate('cust');
calcustot1();
calcustot2();
calcustot3();
calcustot4();
calcustot(5);
calcustot(6);
calcustot(7);
calcustot(8);
calcusttotal();

}
else if(document.getElementById('paymenttype').value == "day"){
document.getElementById('custsalary').value=(document.getElementById('custsalaryday').value*document.getElementById('custusualpay').value+0.00001).toFixed(2);
calcusttotal();
}
}

function setcustallow()
{
calculatecusthour();


<!---document.getElementById('custallowancehour1').value=document.getElementById('custsalaryhrs').value;
document.getElementById('custallowancehour2').value=document.getElementById('custsalaryhrs').value;
document.getElementById('custallowancehour3').value=document.getElementById('custsalaryhrs').value;
 document.getElementById('custallowancehour4').value=document.getElementById('custsalaryhrs').value; --->

calcustallow();
}

function setallowancerate()
{
document.getElementById('selfallowancerate1').value=document.getElementById('hdallowance1').value;
document.getElementById('selfallowancerate2').value=document.getElementById('hdallowance2').value;
document.getElementById('selfallowancerate3').value=document.getElementById('hdallowance3').value;
document.getElementById('selfallowancerate4').value=document.getElementById('hdallowance4').value;
document.getElementById('custallowancerate1').value=document.getElementById('hdallowance1').value;
document.getElementById('custallowancerate2').value=document.getElementById('hdallowance2').value;
document.getElementById('custallowancerate3').value=document.getElementById('hdallowance3').value;
document.getElementById('custallowancerate4').value=document.getElementById('hdallowance4').value;

document.getElementById('selfusualpay').value=document.getElementById('husualpayrate').value;
document.getElementById('custusualpay').value=document.getElementById('hclientrate').value;
hrotrate('self');
hrotrate('cust');
calselfallow();
calcustallow();
}


function calculatesdf()
{
var sdfamount = document.getElementById("selftotal").value*0.0025;

if ((sdfamount*1) < 2)
{
document.getElementById("selfsdf").value=2;
document.getElementById("custsdf").value=2;
}
else if ((sdfamount*1) > 11.25)
{
document.getElementById("selfsdf").value=11.25;
document.getElementById("custsdf").value=11.25;
}
else
{
document.getElementById("selfsdf").value=(sdfamount).toFixed(2);
document.getElementById("custsdf").value=(sdfamount).toFixed(2);
}
}

function getemployeecpf()
{
	var tabletype = "paytran";
if (document.getElementById("emppaymenttype").value == '1st Half')
{
	tabletype = "paytra1";
}

ajaxFunction(window.document.getElementById('getcpfajax'),'getcpfajax.cfm?empno='+document.getElementById('empno').value+'&tabletype='+tabletype);


setTimeout('document.getElementById("selfcpf").value=document.getElementById("employeecpf").value',500);
setTimeout('document.getElementById("custcpf").value=document.getElementById("employercpf").value',500);
}

function getbasicrate()
{
	var tabletype = "paytran";
if (document.getElementById("emppaymenttype").value == '1st Half')
{
	tabletype = "paytra1";
}

ajaxFunction(window.document.getElementById('getbasicajax'),'getbasicajax.cfm?empno='+document.getElementById('empno').value+'&tabletype='+tabletype);


setTimeout('document.getElementById("selfsalary").value=document.getElementById("employeebrate").value',500);
}



function getemployeeded()
{
		var tabletype = "paytran";
if (document.getElementById("emppaymenttype").value == '1st Half')
{
	tabletype = "paytra1";
}
ajaxFunction(window.document.getElementById('getdedajax'),'getdedajax.cfm?empno='+document.getElementById('empno').value+'&tabletype='+tabletype);


setTimeout('document.getElementById("selfdeduction").value=document.getElementById("employeeded").value',500);
setTimeout('document.getElementById("custdeduction").value=document.getElementById("employeeded").value',500);
}

<!--- function openpaymentwindow()
{
if (document.getElementById("emppaymenttype").value == '1st Half') {window.open('/payments/1stHalf/AddUpdate/normalPayEditForm.cfm?empno='+document.getElementById("empno").value
+'&placement='+document.getElementById('placementno').value
+'&invoiceno='+document.getElementById('refno').value
+'&selfsalaryhrs='+document.getElementById('selfsalaryhrs').value
+'&selfsalaryday='+document.getElementById('selfsalaryday').value
+'&AL='+document.getElementById('AL').value
+'&MC='+document.getElementById('MC').value
+'&selfexceptionrate='+document.getElementById('selfexceptionrate').value
+'&selfexceptionhrs='+document.getElementById('selfexceptionhrs').value
+'&selfotrate1='+document.getElementById('selfotrate1').value
+'&selfothour1='+document.getElementById('selfothour1').value
+'&selfotrate2='+document.getElementById('selfotrate2').value
+'&selfothour2='+document.getElementById('selfothour2').value
+'&selfotrate3='+document.getElementById('selfotrate3').value
+'&selfothour3='+document.getElementById('selfothour3').value
+'&selfotrate4='+document.getElementById('selfotrate4').value
+'&selfothour4='+document.getElementById('selfothour4').value
+'&selfusualpay='+document.getElementById('selfusualpay').value
+'&paytype='+document.getElementById('paymenttype').value
+'&selfsdf='+document.getElementById('selfsdf').value
);

}
else{window.open('/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno='+document.getElementById("empno").value+'&placement='+document.getElementById('placementno').value+'&invoiceno='+document.getElementById('refno').value+'&selfsalaryhrs='+document.getElementById('selfsalaryhrs').value
+'&selfsalaryday='+document.getElementById('selfsalaryday').value
+'&AL='+document.getElementById('AL').value
+'&MC='+document.getElementById('MC').value
+'&selfexceptionrate='+document.getElementById('selfexceptionrate').value
+'&selfexceptionhrs='+document.getElementById('selfexceptionhrs').value
+'&selfotrate1='+document.getElementById('selfotrate1').value
+'&selfothour1='+document.getElementById('selfothour1').value
+'&selfotrate2='+document.getElementById('selfotrate2').value
+'&selfothour2='+document.getElementById('selfothour2').value
+'&selfotrate3='+document.getElementById('selfotrate3').value
+'&selfothour3='+document.getElementById('selfothour3').value
+'&selfotrate4='+document.getElementById('selfotrate4').value
+'&selfothour4='+document.getElementById('selfothour4').value+'&selfusualpay='+document.getElementById('selfusualpay').value+'&paytype='+document.getElementById('paymenttype').value+'&selfsdf='+document.getElementById('selfsdf').value);}
} --->



 function calculatepay()
{

	<cfoutput>
	<cfloop from="4" to="17" index="a">
	document.getElementById('hidawee#a#').value=0;
	document.getElementById('hidawer#a#').value=0;
	</cfloop>
	</cfoutput>
	for(var i =1;i<=6;i++)
	{


		if(document.getElementById('fixawcode'+i).value != '')
		{
			var currentcode = document.getElementById('epffixawcode'+i).value;
			if( parseFloat(document.getElementById('fixawee'+i).value) != 0)
			{
			document.getElementById('hidawee'+currentcode).value=parseFloat(document.getElementById('hidawee'+currentcode).value)+ parseFloat(document.getElementById('fixawee'+i).value);

			}
			if(parseFloat(document.getElementById('fixawer'+i).value) != 0)
			{
			document.getElementById('hidawer'+currentcode).value=parseFloat(document.getElementById('hidawer'+currentcode).value)+ parseFloat(document.getElementById('fixawer'+i).value);

			}

		}
		}
		for(var i =1;i<=18;i++)
	{
		if(document.getElementById('allowance'+i).value != '')
		{
			var currentcode = document.getElementById('allowance'+i).options[document.getElementById('allowance'+i).selectedIndex].title;
			if(parseFloat(document.getElementById('awee'+i).value) != 0)
			{
			document.getElementById('hidawee'+currentcode).value=parseFloat(document.getElementById('hidawee'+currentcode).value)+ parseFloat(document.getElementById('awee'+i).value);
			}
			if(parseFloat(document.getElementById('awer'+i).value) != 0)
			{
			document.getElementById('hidawer'+currentcode).value=parseFloat(document.getElementById('hidawer'+currentcode).value)+ parseFloat(document.getElementById('awer'+i).value);
			}

		}

	}
	<cfoutput>
	<cfloop from="4" to="17" index="i">
	var postawee#i# = document.getElementById('hidawee#i#').value;
	var postawer#i# = document.getElementById('hidawer#i#').value;
	</cfloop>
	var ot6 = 0;
	<cfloop from="5" to="8" index="a">
	ot6=parseFloat(ot6)+parseFloat(document.getElementById('selfot#a#').value);
	</cfloop>
	</cfoutput>
	ColdFusion.Window.show('Waiting');

	var calpayurl = '/default/transaction/assignmentslipnewnew/processpay.cfm?empno='+document.getElementById("empno").value+'&placement='+document.getElementById('placementno').value+'&invoiceno='+document.getElementById('refno').value+'&selfsalaryhrs='+document.getElementById('selfsalaryhrs').value+'&selfsalaryday='+document.getElementById('selfsalaryday').value+'&AL='+document.getElementById('AL').value+'&MC='+document.getElementById('MC').value+'&NPL='+document.getElementById('NPL').value+'&selfexceptionrate='+document.getElementById('selfexceptionrate').value+'&selfexceptionhrs='+document.getElementById('selfexceptionhrs').value+'&selfotrate1='+document.getElementById('selfotrate1').value+'&selfothour1='+document.getElementById('selfothour1').value+'&selfotrate2='+document.getElementById('selfotrate2').value+'&selfothour2='+document.getElementById('selfothour2').value+'&selfotrate3='+document.getElementById('selfotrate3').value+'&selfothour3='+document.getElementById('selfothour3').value+'&selfotrate4='+document.getElementById('selfotrate4').value+'&selfothour4='+document.getElementById('selfothour4').value+'&selfotrate5='+ot6+'&selfothour5=1&selfusualpay='+document.getElementById('selfusualpay').value+'&selfotpay='+document.getElementById('selfottotal').value+'&paytype='+document.getElementById('paymenttype').value+'&selfsdf='+document.getElementById('selfsdf').value+'&totaw='+document.getElementById('selfallowance').value+'&backpay='+document.getElementById('selfpayback').value+'&emppaymenttype='+document.getElementById('emppaymenttype').value+'&basicpay='+document.getElementById('selfsalary').value+'&custbasicpay='+document.getElementById('custsalary').value+'&custexception='+document.getElementById('custexception').value+'&custotpay='+document.getElementById('custottotal').value+'&custallowance='+document.getElementById('custallowance').value+'&custpayback='+document.getElementById('custpayback').value+'&paydate='+document.getElementById('paydate').value+'&dedpay='+document.getElementById('selfdeduction').value+'&nsded='+document.getElementById('nsded').value+'&pbee='+document.getElementById('pbeeamt').value+'&pber='+document.getElementById('pberamt').value+'&awsee='+document.getElementById('awseeamt').value+'&awser='+document.getElementById('awseramt').value+'&selfphnlsalary='+document.getElementById('selfphnlsalary').value+'&custphnlsalary='+document.getElementById('custphnlsalary').value+'&paymenttype='+document.getElementById('paymenttype').value<cfoutput><cfloop from="4" to="17" index="i">+'&awee#i#='+postawee#i#+'&awer#i#='+postawer#i#</cfloop><cfloop from="1" to="18" index="i">+'&allowance#i#='+document.getElementById('allowance#i#').value</cfloop><cfloop from="1" to="18" index="i">+'&aweetax#i#='+document.getElementById('awee#i#').value</cfloop><cfloop from="1" to="6" index="i">+'&fixawcode#i#='+document.getElementById('fixawcode#i#').value+'&fixawee#i#='+document.getElementById('fixawee#i#').value+'&fixawer#i#='+document.getElementById('fixawer#i#').value</cfloop></cfoutput>;
<!--- 	<cfif getauthuser() eq "ultranieo">
	alert("Message", calpayurl);
	</cfif> --->
	//console.log(calpayurl);
	 new Ajax.Request(calpayurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('paydata').innerHTML = getdetailback.responseText;
        },
        onFailure: function(){
		alert('Error Calculate Pay'); },
		onComplete: function(transport){
		try{
		document.getElementById('submit1').disabled = false;
		document.getElementById('submit2').disabled = false;
		}
		catch(err)
		{
		}

		getpaydata();
		calcustallow();
		calselfallow();
		pbawscal();
		dedcalcust();
		dedcal();
		adminfeecal();
		calcusttotal();
		calselftotal();
		updateprocess();
        }
      })
}

function updateprocess()
{

	var updateprocessurl = "/default/transaction/assignmentslipnewnew/updateprocess.cfm?empno="+escape(document.getElementById('empno').value)
	 new Ajax.Request(updateprocessurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('updateprocesspay').innerHTML = getdetailback.responseText;

        },
        onFailure: function(){
		alert('Error Update & Process'); },
		onComplete: function(transport){
			ColdFusion.Window.hide('Waiting');
			<cfif isdefined('url.placementno') or (isdefined('url.pno') and url.type eq "create")>
			setTimeout(submitform(),'800');
			</cfif>
        }
      })

}

function getpaydata()
{
	<!--- document.getElementById('selfsalary').value=document.getElementById('basicpay').value; --->
	document.getElementById('selfexceptionrate').value=document.getElementById('RATE5').value;
	document.getElementById('selfexception').value=document.getElementById('OT5').value;
	document.getElementById('selfotrate1').value=document.getElementById('RATE1').value;
	document.getElementById('selfot1').value=document.getElementById('OT1').value;
	document.getElementById('selfotrate2').value=document.getElementById('RATE2').value;
	document.getElementById('selfot2').value=document.getElementById('OT2').value;
	document.getElementById('selfotrate3').value=document.getElementById('RATE3').value;
	document.getElementById('selfot3').value=document.getElementById('OT3').value;
	document.getElementById('selfotrate4').value=document.getElementById('RATE4').value;
	document.getElementById('selfot4').value=document.getElementById('OT4').value;
	document.getElementById('selfottotal').value=document.getElementById('otpay').value;
	<!--- document.getElementById('selfallowance').value=document.getElementById('totalaw').value; --->
	document.getElementById('selfcpf').value=document.getElementById('employeecpf').value;
	document.getElementById('custsdf').value=document.getElementById('ersocso').value;
	document.getElementById('selfsdf').value=document.getElementById('eesocso').value;
    document.getElementById('custeis').value=document.getElementById('ereis').value;
	document.getElementById('selfeis').value=document.getElementById('eeeis').value;
	document.getElementById('custcpf').value=document.getElementById('employercpf').value;
	document.getElementById('pbcpf').value=document.getElementById('pbercpf').value;
	document.getElementById('awscpf').value=document.getElementById('awsercpf').value;
	document.getElementById('pbsdf').value=document.getElementById('pbersdf').value;
	document.getElementById('awssdf').value=document.getElementById('awsersdf').value;
	<!---var addchargeself = document.getElementById('addchargeself').value * 1;
	var addchargeself2 = document.getElementById('addchargeself2').value * 1;
	var addchargeself3 = document.getElementById('addchargeself3').value * 1;
	var addchargeself4 = document.getElementById('addchargeself4').value * 1;
	var addchargeself5 = document.getElementById('addchargeself5').value * 1;
	var addchargeself6 = document.getElementById('addchargeself6').value * 1;
	document.getElementById('selfnet').value=(parseFloat(document.getElementById('grosspay').value)+parseFloat((addchargeself+addchargeself2+addchargeself3+addchargeself4+addchargeself5+addchargeself6))).toFixed(2);
	document.getElementById('selftotal').value=((parseFloat(document.getElementById('netpay').value)+(addchargeself+addchargeself2+addchargeself3+addchargeself4+addchargeself5+addchargeself6)).toFixed(2) - parseFloat(document.getElementById('selfdeduction').value)).toFixed(2);
	 document.getElementById('selfdeduction').value=document.getElementById('totalded').value; --->
}

function hrotrate(custselfvar)
{
	if(document.getElementById('paymenttype').value == "hr")
	{

		var brate = parseFloat(document.getElementById(custselfvar+'usualpay').value);
		document.getElementById(custselfvar+'otrate1').value = brate.toFixed(2);
		document.getElementById(custselfvar+'otrate2').value = (brate * 1.5 +0.000001).toFixed(2);
		document.getElementById(custselfvar+'otrate3').value = (brate * 2 +0.000001).toFixed(2);
		document.getElementById(custselfvar+'otrate4').value = (brate * 3 +0.000001).toFixed(2);
	}
}

function checkpay()
{
	var checkpayurl = '/default/transaction/assignmentslipnewnew/checkpay.cfm?<cfif url.type eq "create">newassignment=true&</cfif>jobdate='+document.getElementById('Assignmentslipdate').value+'&assignmentno='+document.getElementById('emppaymenttype').value+'&paydate='+document.getElementById('paydate').value+'&empno='+document.getElementById('empno').value+'&refno='+document.getElementById('refno').value+'&placementno='+document.getElementById('placementno').value+'&payrollperiod='+document.getElementById('payrollperiod').value;
	<!--- document.getElementById('paycheck').innerHTML=checkpayurl; --->
	 new Ajax.Request(checkpayurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('paycheck').innerHTML = getdetailback.responseText;
        },
        onFailure: function(){
		alert('Error Check Pay'); },
		onComplete: function(transport){
		//console.log(transport);
		if(document.getElementById('checkclash').value == "0")
		{
			calculatepay();
		}
		else
		{
			<!---<cfif isdefined('url.placementno')>
			var paytype = document.getElementById('emppaymenttype');
            var paytypeBefore = paytype.selectedIndex;
			paytype.selectedIndex=paytype.selectedIndex+1;
            
			if(paytype.selectedIndex <= 5 && paytype.selectedIndex >= 0)
			{
				checkpay();
			}else{
                paytype.selectedIndex=paytypeBefore;
                
                alert("Current Assignment Has Clashed With Assignment " +document.getElementById('checkclash').value+" of Current Selected Pay Day");
                document.getElementById('submit1').disabled = true;
                document.getElementById('submit2').disabled = true;
            }
            <cfelse>
			alert("Current Assignment Has Clashed With Assignment " +document.getElementById('checkclash').value+" of Current Selected Pay Day");
			document.getElementById('submit1').disabled = true;
			document.getElementById('submit2').disabled = true;
			</cfif>--->
            
            <cfif isdefined('url.placementno')>
                var paytype = document.getElementById('emppaymenttype');
                paytype.selectedIndex=paytype.selectedIndex+1;
                if(paytype.selectedIndex < 5)
                {
                    checkpay();
                }
            <Cfelse>
                alert("Current Assignment Has Clashed With Assignment " +document.getElementById('checkclash').value+" of Current Selected Pay Day");
                document.getElementById('submit1').disabled = true;
                document.getElementById('submit2').disabled = true;
			</cfif>
		}
        }
      })

}

function dedcalcust()
{
var fields = [
"nscustded","billitemamt1","billitemamt2","billitemamt3","addchargecust","addchargecust2"
,"addchargecust3","rebate","dedcust1","dedcust2","dedcust3","billitemamt4","billitemamt5"
,"billitemamt6"
];

for(var i = 0; i < fields.length;i++){
	if(isNaN(document.getElementById(fields[i]).value) ||
	document.getElementById(fields[i]).value == '')
	{
		document.getElementById(fields[i]).value = 0.00;
	}
}
var nscustdedamt = parseFloat(document.getElementById('nscustded').value).toFixed(2);
var adminfeeamt = 0;
var billitem1amt = parseFloat(document.getElementById('billitemamt1').value).toFixed(2);
var billitem2amt = parseFloat(document.getElementById('billitemamt2').value).toFixed(2);
var billitem3amt = parseFloat(document.getElementById('billitemamt3').value).toFixed(2);
var billitem4amt = parseFloat(document.getElementById('billitemamt4').value).toFixed(2);
var billitem5amt = parseFloat(document.getElementById('billitemamt5').value).toFixed(2);
var billitem6amt = parseFloat(document.getElementById('billitemamt6').value).toFixed(2);
var addchargecustamt = parseFloat(document.getElementById('addchargecust').value).toFixed(2);
var addchargecust2amt = parseFloat(document.getElementById('addchargecust2').value).toFixed(2);
var addchargecust3amt = parseFloat(document.getElementById('addchargecust3').value).toFixed(2);
var rebateamt = parseFloat(document.getElementById('rebate').value).toFixed(2);
var dedcust1amt = parseFloat(document.getElementById('dedcust1').value).toFixed(2);
var dedcust2amt = parseFloat(document.getElementById('dedcust2').value).toFixed(2);
var dedcust3amt = parseFloat(document.getElementById('dedcust3').value).toFixed(2);
document.getElementById('custdeduction').value = (parseFloat(adminfeeamt) + parseFloat(billitem1amt) + parseFloat(billitem2amt) + parseFloat(billitem3amt) + parseFloat(addchargecustamt) + parseFloat(addchargecust2amt) + parseFloat(addchargecust3amt)+ parseFloat(billitem4amt) + parseFloat(billitem5amt) + parseFloat(billitem6amt) - parseFloat(dedcust1amt) - parseFloat(dedcust2amt) - parseFloat(dedcust3amt) - parseFloat(nscustdedamt) - parseFloat(rebateamt )).toFixed(2);
caltax2();
calcusttotal();
}

function dedcal()
{
var nsdedamt = parseFloat(document.getElementById('nsded').value).toFixed(2);
var ded1amt = parseFloat(document.getElementById('ded1').value).toFixed(2);
var ded2amt = parseFloat(document.getElementById('ded2').value).toFixed(2);
var ded3amt = parseFloat(document.getElementById('ded3').value).toFixed(2);
var addchargeselfamt = parseFloat(document.getElementById('addchargeself').value).toFixed(2);
var addchargeself2amt = parseFloat(document.getElementById('addchargeself2').value).toFixed(2);
var addchargeself3amt = parseFloat(document.getElementById('addchargeself3').value).toFixed(2);
document.getElementById('selfdeduction').value = (parseFloat(addchargeselfamt) + parseFloat(addchargeself2amt) + parseFloat(addchargeself3amt) - parseFloat(ded1amt) - parseFloat(ded2amt) - parseFloat(ded3amt) - parseFloat(nsdedamt)).toFixed(2);
calselftotal();
}

function submitform()
{
	<cfif url.type eq "Delete">
	if(document.getElementById('reason').value == "")
	{
		alert('Reason For Delete is Required');
		return false
	} else</cfif> if(checkmonth() == true)
	{
	document.getElementById('AssignmentslipForm').action = 'Assignmentsliptableprocess.cfm';
	ColdFusion.Window.show('submitformwait');
	document.getElementById('AssignmentslipForm').submit();
	}
}

function submitform2()
{
	<cfif url.type eq "Delete">
	if(document.getElementById('reason').value == "")
	{
		alert('Reason For Delete is Required');
		return false
	} else</cfif> if(checkmonth() == true)
	{
        console.log('submitform2');
	document.getElementById('AssignmentslipForm').action = 'Assignmentsliptableprocess.cfm?createnew=true';
	ColdFusion.Window.show('submitformwait');
	document.getElementById('AssignmentslipForm').submit();
	}
}
    

/*Added by Nieo 20171206 1626*/
function calcvaraw(rate,qty,totalfield){
    var intial_value = parseFloat(document.getElementById(totalfield).value);
    
    rate = Number(rate);
    qty = Number(qty);

    if(isNaN(rate)){
        var newrate  = 0.00;
    }else{
        var newrate  = rate;
    }
    if(isNaN(qty)){
        var newqty  = 0.00;
    }else{            
        var newqty  = qty;
    }
    var totalvaraw = newrate*newqty;

    document.getElementById(totalfield).value = totalvaraw.toFixed(2);
    
    if (totalfield.indexOf('fixawee') !== -1) {
        var customtotalfixaw = parseFloat(document.getElementById('customtotalfixaw').value);
        if (customtotalfixaw > 0 && qty == 0) {
            document.getElementById('customtotalfixaw').value = (customtotalfixaw - intial_value).toFixed(2);
        } else if (qty > 0) {
            document.getElementById('customtotalfixaw').value = (customtotalfixaw + totalvaraw).toFixed(2);
        }
        
    }
}
/*Added by Nieo 20171206 1626*/
    
/*Added by Nieo 20180405 1421*/
function checkitem(code,pos){
    var blockpay = [43,54,55,41,125,96];  
    var blockbill = [38];  
    
    for(var i = 0; i < blockpay.length;i++){
        if(blockpay[i] == code){
            document.getElementById("aweeqty"+pos).value = 0;
            document.getElementById("aweerate"+pos).value = 0;
            document.getElementById("awee"+pos).value = 0;
            document.getElementById("aweeqty"+pos).readOnly = true;
            document.getElementById("aweerate"+pos).readOnly = true;
        }
    }
    
    calselfallow();
    
    for(var i = 0; i < blockbill.length;i++){
        if(blockbill[i] == code){
            document.getElementById("awerqty"+pos).value = 0;
            document.getElementById("awerrate"+pos).value = 0;
            document.getElementById("awer"+pos).value = 0;
            document.getElementById("awerqty"+pos).readOnly = true;
            document.getElementById("awerrate"+pos).readOnly = true;
        }
    }
    
    calcustallow();

}
    
function checkfixitem(code,pos){
    var blockpay = [43,54,55,41,125,96];  
    var blockbill = [38];  
    
    for(var i = 0; i < blockpay.length;i++){
        if(blockpay[i] == code){
            document.getElementById("fixaweerate"+pos).value = 0;
            document.getElementById("fixaweeqty"+pos).value = 0;
            document.getElementById("fixawee"+pos).value = 0;
            document.getElementById("fixaweerate"+pos).readOnly = true;
            document.getElementById("fixaweeqty"+pos).readOnly = true;
        }
    }
    
    calselfallow();
    
    /*for(var i = 0; i < blockbill.length;i++){
        if(blockbill[i] == code){
            document.getElementById("awerqty"+pos).value = 0;
            document.getElementById("awerrate"+pos).value = 0;
            document.getElementById("awer"+pos).value = 0;
            document.getElementById("awerqty"+pos).readOnly = true;
            document.getElementById("awerrate"+pos).readOnly = true;
        }
    }
    
    calcustallow();*/

}
    
function checkallowance(){
    for(var i = 1; i < 19;i++){
        checkitem(document.getElementById("allowance"+i).value,i) ;
    }
    
    for(var i = 1; i < 7;i++){
        checkfixitem(document.getElementById("fixawcode"+i).value,i) ;
    }
};
/*Added by Nieo 20180405 1421*/
    
/*Added by Nieo 20180821 1455*/
function checkforOT(){
    
    /*if(document.getElementById("custsalary").value != 0 || document.getElementById("selfsalary").value != 0){
        lockOT();
        return 0;
    }
    
    for(var i = 1; i <=6;i++){
        if(document.getElementById("fixawer"+i).value != 0 || document.getElementById("fixawee"+i).value != 0){
            lockOT();
            return 0;
        } 
    }
    
    for(var i = 1; i <= 18;i++){
        if(document.getElementById("awer"+i).value != 0 || document.getElementById("awee"+i).value != 0){
            lockOT();
            return 0;
        }
    }

    for(var i =1; i<=8;i++){
        document.getElementById("selfothour"+i).readOnly = false;
        document.getElementById("custothour"+i).readOnly = false;
    }*/
    
};
    
function lockOT(){
    for(var i =1; i<=8;i++){
        document.getElementById("selfothour"+i).value = 0;
        document.getElementById("custothour"+i).value = 0;
        document.getElementById("selfot"+i).value = 0.00.toFixed(2);
        document.getElementById("custot"+i).value = 0.00.toFixed(2);
        document.getElementById("selfothour"+i).readOnly = true;
        document.getElementById("custothour"+i).readOnly = true;
    }
}
    
function unlockOT(){
    for(var i =1; i<=8;i++){
        document.getElementById("selfothour"+i).readOnly = false;
        document.getElementById("custothour"+i).readOnly = false;
    }
}
/*Added by Nieo 20180821 1455*/
    
/*Added by Nieo 20180919 1530*/
function refreshotrate(){
    var getnewotrateurl = "/default/transaction/assignmentslipnewnew/newotrate.cfm?placementno="+escape(document.getElementById('placementno').value)+"&refno="+escape(document.getElementById('refno').value);
    
    getnewotrateurl = getnewotrateurl<cfoutput><cfloop index='ii' from="1" to="6">+"&fixawcode#ii#=" + escape(document.getElementById('fixawcode#ii#').value)+"&fixawee#ii#=" + escape(document.getElementById('fixawee#ii#').value)+"&fixawer#ii#=" + escape(document.getElementById('fixawer#ii#').value)</cfloop><cfloop index='ii' from="1" to="18">+"&allowance#ii#=" + escape(document.getElementById('allowance#ii#').value)+"&awee#ii#=" + escape(document.getElementById('awee#ii#').value)+"&awer#ii#=" + escape(document.getElementById('awer#ii#').value)</cfloop></cfoutput>+"&selfsalary="+escape(document.getElementById('selfsalary').value)+"&custsalary="+escape(document.getElementById('custsalary').value)+"&selfusualpay="+escape(document.getElementById('selfusualpay').value)+"&custusualpay="+escape(document.getElementById('custusualpay').value);
    
     new Ajax.Request(getnewotrateurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
            document.getElementById('newotrate').innerHTML = getdetailback.responseText;
            for(var i=1;i<9;i++){
                document.getElementById('selfotrate'+i).value = document.getElementById('xselfotrate'+i).value;   
                document.getElementById('custotrate'+i).value = document.getElementById('xcustotrate'+i).value;   
            }
            
        },
        onFailure: function(){
            alert('Error Get New OT Rate');
            refreshotrate();
        },
        onComplete: function(transport){
            <cfoutput>
            <cfloop index='a' from='1' to='4'>
            calselfot#a#();
            calcustot#a#();
            </cfloop>
            <cfloop index='a' from='5' to='8'>
            calselfot(#a#);
            calcustot(#a#);
            </cfloop>
            </cfoutput>
        }
      })
}
/*Added by Nieo 20180919 1530*/
    
/*Added by Nieo 20181025 1424*/
function getpanel(placeno,newworkd){
    
    var datecomplete = document.getElementById('completedate').value;
    
    var pno = document.getElementById('placementno').value;
    
    var formurl = 'checkenddate.cfm?enddate='+datecomplete+'&pno='+pno;
    
    new Ajax.Request(formurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
            document.getElementById('enddatecheck').innerHTML = getdetailback.responseText;
            if(document.getElementById('checkenddate').value == 1){
                if(confirm('Pleacement has ended. Are you sure to continue create Assignment Slip?')){
                    loadpanel(placeno,newworkd);
                }else{
                    document.getElementById("assignmentfield").innerHTML = "";
                }
            }else{
                loadpanel(placeno,newworkd);
            }
            
        },
        onFailure: function(){
            if(document.getElementById('completedate').value == ''){
                alert('Job Completed Date are empty. Please select a Job Completed Date');
           }
        },
        onComplete: function(transport){
        }
      })
}
/*Added by Nieo 20181025 1424*/
    
</script>
	<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
	<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfoutput>
		<cfloop from="4" to="18" index="a">
			<input type="hidden" name="hidawee#a#" id="hidawee#a#" value="0">
			<input type="hidden" name="hidawer#a#" id="hidawer#a#" value="0">
		</cfloop>
	</cfoutput>
	<body>
		<cfoutput>
			<cfif url.type eq "Edit" or url.type eq "Delete">
				<cfquery datasource='#dts#' name="getitem">
                    Select * from Assignmentslip where refno='#url.refno#'
                </cfquery>
				<cfset posted = getitem.posted>
				<cfset refno="">
				<cfset assignmentslipdate=dateformat(getitem.assignmentslipdate,'DD/MM/YYYY')>
				<cfset xcustno = getitem.custno>
				<cfset xplacementno=getitem.placementno>
				<cfset payno = getitem.payno>
				<cfset chequeno = getitem.chequeno>
				<cfset empno = getitem.empno>
				<cfset lastworkingdate = dateformat(getitem.lastworkingdate,'DD/MM/YYYY')>
				<cfset startdate = dateformat(getitem.startdate,'DD/MM/YYYY')>
				<cfset completedate = dateformat(getitem.completedate,'DD/MM/YYYY')>
				<cfset payrollperiod=getitem.payrollperiod>
				<cfset custname=getitem.custname>
				<cfset custname2 = getitem.custname2>
				<cfset iname = getitem.iname>
				<cfset supervisor = getitem.supervisor>
				<cfset assigndesp = getitem.assigndesp>
                <cfset invrem = getitem.invrem>
				<cfset empname=getitem.empname>
				<cfset assignmenttype=getitem.assignmenttype>
				<cfset paymenttype=getitem.paymenttype>
				<cfset emppaymenttype = getitem.emppaymenttype>
				<cfset paydate = getitem.paydate>
				<cfset mode=url.type>
				<cfset title="#url.type# Assignmentslip">
				<cfset button=url.type>
                <cfset cosworkday=getitem.cosworkday>
                <cfset include=getitem.include>
			<cfelseif url.type eq "Create">
				<cfinclude template="validaterun.cfm">
				<cfinclude template="autorun.cfm">
				<cfquery datasource="#dts#" name="getlastusedno">
                    select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                    from refnoset
                    where type = 'INV'
                </cfquery>
				<cftry>
					<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#getlastusedno.tranno#" returnvariable="refnonew"/>
					<cfcatch>
						<cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastusedno.tranno#" returnvariable="refnonew" />
					</cfcatch>
				</cftry>
				<cfset getlastusedno.tranno = refnonew>
				<cfset refno=getlastusedno.tranno>
				<cfquery name="checkexistrefno" datasource="#dts#">
                select refno from artran where type='INV' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getlastusedno.tranno#">
                </cfquery>
				<cfif checkexistrefno.recordcount neq 0>
					<cfquery datasource="#dts#" name="getGeneralInfo">
                        select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                        from refnoset
                        where type = 'INV'
                        and counter = 1
                    </cfquery>
					<cfif getGeneralInfo.arun eq "1">
						<cfset refnocheck = 0>
						<cfset refno1 = checkexistrefno.refno>
						<cfloop condition="refnocheck eq 0">
							<cftry>
								<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="refno"/>
								<cfcatch>
									<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refno" />
								</cfcatch>
							</cftry>
							<cfquery name="checkexistence" datasource="#dts#">
                            SELECT refno FROM artran WHERE
                            refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = 'INV'
                            </cfquery>
							<cfif checkexistence.recordcount eq 0>
								<cfset refnocheck = 1>
							<cfelse>
								<cfset refno1 = refno>
							</cfif>
						</cfloop>
					<cfelse>
						<cfset refno = ''>
						<cfabort />
					</cfif>
				</cfif>
				<cfset posted = "">
				<cfif isdefined('getmonth')>
					<cfif month(now()) neq val(getmonth.mmonth)>
						<cfset assignmentslipdate=dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),daysinmonth(createdate(val(getmonth.myear),val(getmonth.mmonth),1))),'DD/MM/YYYY')>
					<cfelse>
						<cfset assignmentslipdate=dateformat(now(),'DD/MM/YYYY')>
					</cfif>
				<cfelse>
					<cfset assignmentslipdate=dateformat(now(),'DD/MM/YYYY')>
				</cfif>
				<cfif isdefined('valcustno')>
					<cfset xcustno = valcustno>
				<cfelse>
					<cfset xcustno = "">
				</cfif>
				<cfif isdefined('valplacementno')>
					<cfset xplacementno=valplacementno>
				<cfelse>
					<cfset xplacementno="">
				</cfif>
				<cfset payno = "">
				<cfset chequeno = "">
				<cfif isdefined('valempno')>
					<cfset empno = valempno>
				<cfelse>
					<cfset empno = "">
				</cfif>
				<cfif isdefined('vallastworkingdate')>
					<cfset lastworkingdate = vallastworkingdate>
				<cfelse>
					<cfset lastworkingdate = "">
				</cfif>
				<cfif isdefined('firstday')>
                    <!---Added backdated flag to modify the date, [20170913, Alvin]--->
				    <cfif #IsDefined('url.backdated')#>
				        <cfset startdate = #DateFormat(DateAdd('m', 1, '#firstday#'), 'DD/MM/YYYY')#>
				    <cfelse>
					    <cfset startdate =  dateformat(firstday,'DD/MM/YYYY')>
                    </cfif>
                    <!---added backdated flag--->
				<cfelse>
					<cfset startdate =  dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),1),'DD/MM/YYYY')>
				</cfif>
				<cfif isdefined('lastday')>
				    <!---Added backdated flag to modify the date, [20170913, Alvin]--->
				    <cfif #IsDefined('url.backdated')#>
				        <cfset completedate = #DateFormat(DateAdd('m', 1, '#lastday#'), 'DD/MM/YYYY')#>
				        <cfquery name="gettimecycle" datasource="#dts#">
				            SELECT timesheet FROM placement
				            WHERE placementno = "#url.pno#"
				        </cfquery>
				        <cfif #gettimecycle.timesheet# EQ '01-31'>
				            <cfset completedate = "#LsDateFormat(DateAdd('d', 1, CreateDate(year(LsDateFormat(completedate, 'yyyy-mm-dd', 'en_AU')), month(LsDateFormat(completedate, 'yyyy-mm-dd', 'en_AU')), day(DaysInMonth(LsDateFormat(completedate, 'yyyy-mm-dd', 'en_AU'))))), 'DD/MM/YYYY', 'en_AU')#">
                        </cfif>
				    <cfelse>
					    <cfset completedate = dateformat(lastday,'DD/MM/YYYY')>
                    </cfif>
					<!---added backdated flag--->
				<cfelse>
					<cfset completedate = dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),daysinmonth(createdate(val(getmonth.myear),val(getmonth.mmonth),1))),'DD/MM/YYYY')>
				</cfif>
				<cfif isdefined('valxcustname')>
					<cfset custname=valxcustname>
				<cfelse>
					<cfset custname="">
				</cfif>
				<cfif isdefined('valcustname2')>
					<cfset custname2 = valcustname2>
				<cfelse>
					<cfset custname2 = "">
				</cfif>
				<cfif isdefined('valiname')>
					<cfset iname = valiname>
				<cfelse>
					<cfset iname = "">
				</cfif>
				<cfif isdefined('valsupervisor')>
					<cfset supervisor = valsupervisor>
				<cfelse>
					<cfset supervisor = "">
				</cfif>
				<cfset assigndesp = "">
                <cfset invrem = "">
				<cfif isdefined('valempname')>
					<cfset empname=valempname>
				<cfelse>
					<cfset empname="">
				</cfif>
				<cfif isdefined('valassignmenttype')>
					<cfset assignmenttype=valassignmenttype>
				<cfelse>
					<cfset assignmenttype="">
				</cfif>
				<cfif isdefined('valpaymenttype')>
					<cfset paymenttype=valpaymenttype>
				<cfelse>
					<cfset paymenttype="">
				</cfif>
				<cfset paydate = "">
				<cfset emppaymenttype = "">                
				<cfquery name="company_details" datasource="payroll_main">
                    SELECT * FROM gsetup WHERE comp_id = "#dts2#"
                  </cfquery>
				<cfset payrollperiod=company_details.mmonth>
				<cfset mode="Create">
				<!--- <cfset title="Create Item"> --->
				<cfset title="Create Assignmentslip">
				<cfset button="Create">
                <cfset cosworkday = "N">
                <cfset include = "N">
			</cfif>
			<h1>
				#title#
			</h1>
			<h4>
				<a href="/default/transaction/assignmentslipnewnew/Assignmentsliptable2.cfm?type=Create">
					Create Assignment Slip
				</a>
				||
				<a href="/default/transaction/assignmentslipnewnew/Assignmentsliptable.cfm?">
					List all Assignment Slip
				</a>
				||
				<a href="/default/transaction/assignmentslipnewnew/s_Assignmentsliptable.cfm?type=Assignmentslip">
					Search For Assignment Slip
				</a>
				||
				<a href="/default/transaction/assignmentslipnewnew/assignbatches/batchassignment.cfm">
					Assign Batch Control
				</a>
				||
				<a href="/default/transaction/assignmentslipnewnew/assignbatches/s_batchtable.cfm">
					List Batch Control
				</a>
				<!---         ||  <a href="/default/transaction/assignmentslipnewnew/printcheque.cfm">Print Claim Cheque</a>
					|| <a href="/default/transaction/assignmentslipnewnew/printclaim.cfm">Print Claim Voucher</a>
					|| <a href="/default/transaction/assignmentslipnewnew/generatecheqno.cfm">Record Claim Cheque No</a>
					|| <a href="/default/transaction/assignmentslipnewnew/definecheqno.cfm">Predefined Cheque No</a> --->
			</h4>
		</cfoutput>
		<cfform name="AssignmentslipForm" id="AssignmentslipForm" action="/default/transaction/assignmentslipnewnew/Assignmentsliptableprocess.cfm" method="post" onsubmit="return checkmonth();" >
			<cfoutput>
				<cfif isdefined('url.placementno')>
					<input type="hidden" name="auto2" id="auto2" value="#url.auto2#">
				</cfif>
				<input type="hidden" name="mode" id="mode" value="#mode#">
				<input type="hidden" name="timesheeton" id="timesheeton" value="0">
			</cfoutput>
			<h1 align="center">
				Assignment Slip
			</h1>
			<table align="center" class="data" width="80%">
				<cfoutput>
					<tr>
						<th width="150">
							Assignment No:
						</th>
						<td>
							<cfif mode eq "Delete" or mode eq "Edit">
								<cfinput type="text" size="20" name="refno" id="refno" value="#url.refno#" required="yes" message="Invoice No is Required" readonly>
								<input type="hidden" size="20" name="refnotrue" id="refnotrue" value="#url.refno#" readonly>
							<cfelse>
								<cfinput type="text" size="20" name="refno" id="refno" value="" maxlength="40" required="yes" message="Invoice No is Required" readonly="yes">
							</cfif>
						</td>
						<th>
							Period
						</th>
						<td>
							<input type="text" name="payrollperiod" id="payrollperiod" value="#payrollperiod#" size="2" readonly>
						</td>
					</tr>
					<tr>
						<th width="150">
							Assignment Date :
						</th>
						<td>
							<cfif mode eq "Delete" or mode eq "Edit">
								<cfinput type="text" size="20" name="Assignmentslipdate" id="Assignmentslipdate" value="#Assignmentslipdate#" maxlength="10" validate="eurodate" message="Please check Date Format">
							<cfelse>
								<cfinput type="text" size="20" name="Assignmentslipdate" id="Assignmentslipdate" value="#Assignmentslipdate#" maxlength="10" validate="eurodate" message="Please check Date Format" >
							</cfif>
							<cfif mode eq "Delete" or mode eq "Edit">
							<cfelse>
								<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('Assignmentslipdate'));">
								DD/MM/YYYY
							</cfif>
						</td>
						<th>
							Placement
						</th>
						<td>
							<cfinput required="yes" message="Placement is Required" type="text" name="placementno" id="placementno" value="#xplacementno#" readonly="yes">
							<cfif url.type eq "Edit" or url.type eq "Delete">
								<cfquery name="getas" datasource="#dts#">
                                    SELECT posted, locked, combine FROM assignmentslip WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
                                </cfquery>
								<cfif getas.posted neq "P" and getas.locked neq "Y" and getas.combine neq "Y">
									<cfquery name="getitemno" datasource="#dts#">
                                        select placementno as xplacementno,empno as xempno,custname as xcustname,custno as xcustno,empno as xempno ,clienttype,startdate,completedate,assignmenttype,iname,supervisor from placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xplacementno#">
                                    </cfquery>
									<cfquery name="company_details" datasource="payroll_main">
                                        SELECT * FROM gsetup WHERE comp_id = "#dts2#"
                                    </cfquery>
									<cfquery name="gettimesheet" datasource="#dts1#">
                                        SELECT tsrowcount FROM timesheet WHERE empno = "#getitemno.xempno#" and tmonth = "#company_details.mmonth#" and editable = "Y" ORDER BY tsrowcount
                                    </cfquery>
									<cfquery name="getemployeename" datasource="#dts#">
                                        SELECT name,paystatus,dbirth
                                        FROM #dts1#.pmast where empno='#getitemno.xempno#'
                                    </cfquery>
                                        
									<input type="button" size="10" value="Refresh Assignment" onClick="if(confirm('Are You Sure You Want to Refresh Assignment?')){document.getElementById('placementno').value='#getitemno.xplacementno#';document.getElementById('custno').value='#getitemno.xcustno#';selectlist('#getitemno.clienttype#','paymenttype');document.getElementById('paymenttype2').value='#getitemno.clienttype#';document.getElementById('empno').value='#getitemno.xempno#';document.getElementById('custname').value=unescape('#URLEncodedFormat(getitemno.xcustname)#');document.getElementById('custname2').value=unescape('#URLEncodedFormat(getitemno.xcustname)#');document.getElementById('empname').value='#getemployeename.name#';selectlist('#getitemno.assignmenttype#','assignmenttype');document.getElementById('iname').value='#getitemno.iname#';document.getElementById('supervisor').value='#getitemno.supervisor#';<cfif gettimesheet.recordcount neq 0>gettimesheet('#getitemno.xplacementno#','#getitemno.xempno#');<cfelse>getpanel('#getitemno.xplacementno#');</cfif>}" />
								</cfif>
							<cfelse>
								<input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findplacement');" />
							</cfif>
							<div id="itemDetail">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;
						</td>
					</tr>
					<tr>
						<th>
							Customer No
						</th>
						<td>
							<cfinput type="text" name="custno" id="custno" value="#xcustno#" readonly>
						</td>
						<th>
							Employee No
							<br/>
							&nbsp;
						</th>
						<td>
							<cfinput type="text" name="empno" id="empno" value="#empno#" bind="cfc:assignmentslip.getempno({placementno},'#dts#')">
						</td>
					</tr>
					<tr>
						<th>
							Customer Name
						</th>
						<td>
							<cfinput type="text" name="custname" id="custname" size='40' value="#custname#" bind="cfc:assignmentslip.getcustname({custno},'#dts#')"   readonly>
						</td>
						<th>
							Employee Name
						</th>
						<td>
							<cfinput type="text" name="empname" id="empname" size='40' value="#empname#" readonly>
						</td>
					</tr>
					<tr>
						<th>
							Customer Name (text)
						</th>
						<td>
							<cfinput type="text" name="custname2" id="custname2" size='40' value="#custname2#" maxlength="45">
						</td>
						<th>
							Employee Initial
						</th>
						<td>
							<input type="text" name="iname" id="iname" value="#iname#">
						</td>
					</tr>
					<tr>
						<th>
							Supervisor
						</th>
						<td>
							<input type="text" name="supervisor" id="supervisor" value="#supervisor#">
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;
						</td>
					</tr>
					<tr>
						<th>
							Assignment Type
						</th>
						<td>
							<input type="text" name="assignmenttype" id="assignmenttype" value="#assignmenttype#">
							<!---  <select name="assignmenttype" id="assignmenttype" onChange="generaterefno()">
								<cfif url.type eq "Edit" or url.type eq "Delete">
								<option value="#assignmenttype#"><cfif assignmenttype eq 'invoice'>Invoice<cfelseif assignmenttype eq 'einvoice'>E-Invoice<cfelse>S-Invoice</cfif></option>
							<cfelse>
								<option value="invoice" <cfif assignmenttype eq 'invoice'>selected</cfif>>Invoice</option>
								<option value="einvoice" <cfif assignmenttype eq 'einvoice'>selected</cfif>>E-Invoice</option>
								<option value="sinvoice" <cfif assignmenttype eq 'noinvoice' or assignmenttype eq 'sinvoice'>selected</cfif>>S-Invoice</option>
								</cfif>
								</select> --->
						</td>
						<th>
							Rate Type
						</th>
						<td>
							<select name="paymenttype" id="paymenttype">
								<option value="">
									Choose A Payment Type
								</option>
								<option value="hr"
								<cfif paymenttype eq "hr">
									selected
								</cfif>
								>Hr</option> <option value="day"
								<cfif paymenttype eq "day">
									selected
								</cfif>
								>Day</option> <option value="mth"
								<cfif paymenttype eq "mth">
									selected
								</cfif>
								>Mth</option>
							</select>
							<input type="hidden" name="paymenttype2" id="paymenttype2" value="#paymenttype#">
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;
						</td>
					</tr>
					<tr>
						<th>
							Pay Group
						</th>
						<td>
							<select name="paydate" id="paydate"
							<cfif url.type eq "edit">
								onChange="document.getElementById('calculateemppay').click();"
							</cfif>
							> <option value="paytra1"
							<cfif paydate eq "paytra1">
								Selected
							</cfif>
							>Normal Pay Out</option> <option value="paytran"
							<cfif paydate eq "paytran">
								Selected
							</cfif>
							>Exception Pay Out</option> </select>
						</td>
						<th>
							Last Working Date
						</th>
						<td>
							<cfinput type="text" size="20" name="lastworkingdate" value="#lastworkingdate#" id="lastworkingdate" maxlength="10" validate="eurodate" message="Please check Date Format">
							<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(lastworkingdate);">
							DD/MM/YYYY
						</td>
					</tr>
					<tr>
					<tr>
						<th>
							Current Assignment
						</th>
						<td>
							<select name="emppaymenttype" id="emppaymenttype">
								<option value="payweek1"
								<cfif emppaymenttype eq "payweek1" or  emppaymenttype eq "2nd Half">
									Selected
								</cfif>
								>1st Assignment</option> <option value="payweek2"
								<cfif emppaymenttype eq "payweek2" or  emppaymenttype eq "1st Half">
									Selected
								</cfif>
								>2nd Assignment</option> <option value="payweek3"
								<cfif emppaymenttype eq "payweek3">
									Selected
								</cfif>
								>3rd Assignment</option> <option value="payweek4"
								<cfif emppaymenttype eq "payweek4">
									Selected
								</cfif>
								>4th Assignment</option> <option value="payweek5"
								<cfif emppaymenttype eq "payweek5">
									Selected
								</cfif>
								>5th Assignment</option> <option value="payweek6"
								<cfif emppaymenttype eq "payweek6">
									Selected
								</cfif>
								>6th Assignment</option>
							</select>
						</td>
						<td colspan="2">
							<div id="timesheetfield">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;
						</td>
					</tr>
					<tr>
						<th>
							Job Start Date
						</th>
						<td>
							<cfinput type="text" size="15" name="startdate" id="startdate" value="#startdate#" maxlength="10" validate="eurodate" required="yes" message="Job Start Date Required / Invalid">
							<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('startdate'));">
							DD/MM/YYYY
						</td>
						<th>
							Job Completed Date
						</th>
						<td>
							<cfinput type="text" size="15" name="completedate" id="completedate" value="#completedate#" maxlength="10" validate="eurodate" required="yes" message="Job Start Completed Required / Invalid">
							<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('completedate'));">
							DD/MM/YYYY
						</td>
					</tr>
                    <tr>
						<td>
							&nbsp;
						</td>
                        <td>
							<span id="jobstartdate"></span>
						</td>
                        <td>
							&nbsp;
						</td>
                        <td>
							<span  id="jobcompletedate"></span>
						</td>
					</tr>
					<tr>
						<th>
							Remarks
						</th>
						<td>
							<input type="text" name="assigndesp" id="assigndesp" value="#assigndesp#" size="50">
						</td>
                        <th>Exclude Weekend: </th>
                          <td>
                              <input type="checkbox" name="cosworkday" id="cosworkday" value="<cfif cosworkday eq 'T'>Y<cfelse>N</cfif>" onclick="if(this.value =='N'){dateajaxfunction('Y');this.value='Y';}else{dateajaxfunction('N');this.value='N';}" <cfif cosworkday eq 'T'>checked</cfif>>
                          </td>
					</tr>
                    <tr>
						<td>
							&nbsp;
						</td>
					</tr>
                    <tr>
						<th>
							Invoice Remarks
						</th>
						<td>
							<input type="text" name="invrem" id="invrem" value="#invrem#" size="50">
						</td>
                        <th>Include in Report: <br>(L'oreal Report) </th>
                      <td>
                          <input type="checkbox" name="include" id="include" value="<cfif include eq 'T'>T<cfelse>N</cfif>"
                                 onclick="if(document.getElementById('include').value=='N'){document.getElementById('include').value='T'}else{document.getElementById('include').value='N'};" <cfif include eq 'T'>checked</cfif>>
                      </td>
					</tr>
                    <tr>
						<td>
							&nbsp;
						</td>
					</tr>
					<tr style="display:none">
						<th >
							Pay No
						</th>
						<td>
							<input type="text" name="payno" id="payno" value="#payno#" readonly>
						</td>
						<th>
							Cheque No
						</th>
						<td>
							<input type="text" name="chequeno" id="chequeno" value="#chequeno#">
						</td>
					</tr>
				</cfoutput>
			</table>            
			<div id="assignmentfield">
			</div>
		</cfform>
		<cfoutput>
			<cfif url.type eq "Edit" or url.type eq "Delete">
				<script type="text/javascript">
function getpanel2(assignno)
{
    gettax();
	var datestart = document.getElementById('startdate').value;
	var datecomplete = document.getElementById('completedate').value;
	var formurl = 'assignajax.cfm?type=#url.type#&refno='+assignno;
	 new Ajax.Request(formurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('assignmentfield').innerHTML = getdetailback.responseText;
        <cfoutput>
        <cfloop index='a' from='1' to='18'>
            addoption('allowance#a#');
        </cfloop>
        </cfoutput>
        //Added by Nieo 20180405 1530
        checkallowance();
        var checkname = document.getElementById('custname').value;
        checkname = checkname.toLowerCase();
        //console.log(checkname);
        if(checkname.indexOf('venture')>=0){
            unlockOT();
            checkforOT();
            //console.log('loaded');
        }
        },
        onFailure: function(){
		alert('1');
		},
		onComplete: function(transport){
        }
      })

}
getpanel2('#url.refno#');
</script>
			</cfif>
			<div id="paydata">
			</div>
			<div id="adminfeedata">
			</div>
			<div id="paycheck">
			</div>
			<div id="updateprocesspay">
			</div>
			<div id="newrefnofield">
			</div>
            <div id="gettaxfield">
			</div>
            <div id="newotrate">
			</div>
            <div id="enddatecheck">
			</div>
            <input type="hidden" name="taxitemlist" id="taxitemlist" value="">
		</cfoutput>
	</body>
</html>
<cfwindow center="true" width="800" height="600" name="findplacement" refreshOnShow="true"
	title="Find Placement" initshow="false"
	source="findplacement.cfm?type=Placement" />
<cfwindow name="calempded" center="true" source="calempded.cfm?empno={empno}" modal="true" closable="true" width="800" height="600" refreshonshow="true" title="Calculate Deduction" />
<cfwindow name="Waiting" title="Calculating!" modal="true" closable="false" width="350" height="260" center="true" >
	<p align="center">
		Processing, Please Wait!
	</p>
	<p align="center">
		<img src="/images/loading.gif" name="Cash Sales" width="30" height="30">
	</p>
	<br />
</cfwindow>
<cfwindow center="true" width="900" height="600" name="timesheet" refreshOnShow="true"
	title="Time Sheet" initshow="false"
	source="timesheet.cfm?empno={empno}&placementno={placementno}" resizable="false" />
<cfwindow name="submitformwait" title="Processing!!! Please Wait!!!" modal="true" closable="false" width="350" height="260" center="true" >
	<p align="center">
		Processing, Please Wait!
	</p>
	<p align="center">
		<img src="/images/loading.gif" name="Cash Sales" width="30" height="30">
	</p>
	<br />
</cfwindow>
