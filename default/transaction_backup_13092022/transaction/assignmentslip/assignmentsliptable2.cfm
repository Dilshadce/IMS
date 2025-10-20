<cfajaximport tags="cfform">
<html>
<head>
<title><cfoutput>Assignmentslip</cfoutput> Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
</head>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
<script type="text/javascript">
<cfset dts2=replace(dts,'_i','','all')>
 <cfquery name="getmonth" datasource="payroll_main">
  SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
 </cfquery>
function checkmonth()
{<cfif url.type eq "create">
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

function calselfottotal()
{
	var selfot1=document.getElementById('selfot1').value * 1;
	var selfot2=document.getElementById('selfot2').value * 1;
	var selfot3=document.getElementById('selfot3').value * 1;
	var selfot4=document.getElementById('selfot4').value * 1;
	
	document.getElementById('selfottotal').value=(selfot1+selfot2+selfot3+selfot4+0.00001).toFixed(2);
	
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

function calcustottotal()
{
	var custot1=document.getElementById('custot1').value * 1;
	var custot2=document.getElementById('custot2').value * 1;
	var custot3=document.getElementById('custot3').value * 1;
	var custot4=document.getElementById('custot4').value * 1;
	
	document.getElementById('custottotal').value=(custot1+custot2+custot3+custot4).toFixed(2);
	
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
	
	document.getElementById('selfallowance').value=((selfallowancerate1*selfallowancehour1+0.00001).toFixed(2)*1+(selfallowancerate2*selfallowancehour2+0.00001).toFixed(2)*1+(selfallowancerate3*selfallowancehour3+0.00001).toFixed(2)*1+(selfallowancerate4.toFixed(2)*1+selfallowancerate5.toFixed(2)*1+selfallowancerate6.toFixed(2)*1)).toFixed(2);

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
	
	document.getElementById('custallowance').value=((custallowancerate1*custallowancehour1+0.00001).toFixed(2)*1+(custallowancerate2*custallowancehour2+0.00001).toFixed(2)*1+(custallowancerate3*custallowancehour3+0.00001).toFixed(2)*1+(custallowancerate4.toFixed(2)*1+custallowancerate5.toFixed(2)*1+custallowancerate6.toFixed(2)*1)).toFixed(2);

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
	
function caltax2()
	{
	var net = document.getElementById('custnet').value;

	var taxper = document.getElementById('taxper').value;
	var taxamt = document.getElementById('taxamt');
	var grand = document.getElementById('custtotal');
	var taxval = 0;
	taxper = parseFloat(taxper);
	net = parseFloat(net);

	var custsalary = document.getElementById('custsalary').value * 1 ;
	var custottotal = document.getElementById('custottotal').value * 1;
	var custcpf = document.getElementById('custcpf').value * 1;
	var custsdf = document.getElementById('custsdf').value * 1;
	var custallowance = document.getElementById('custallowance').value * 1;
	var custpayback = document.getElementById('custpayback').value * 1;
	
	var addchargecust = document.getElementById('addchargecust').value * 1;
	var addchargecust2 = document.getElementById('addchargecust2').value * 1;
	var addchargecust3 = document.getElementById('addchargecust3').value * 1;
	var addchargecust4 = document.getElementById('addchargecust4').value * 1;
	var addchargecust5 = document.getElementById('addchargecust5').value * 1;
	var addchargecust6 = document.getElementById('addchargecust6').value * 1;
	
	var custallowancerate1 = ((document.getElementById('custallowancerate1').value * 1+0.00001).toFixed(2)) * 1;
	var custallowancehour1 = ((document.getElementById('custallowancehour1').value * 1+0.00001).toFixed(2)) * 1;
	
	var custallowancerate2 = ((document.getElementById('custallowancerate2').value * 1+0.00001).toFixed(2)) * 1;
	var custallowancehour2 = ((document.getElementById('custallowancehour2').value * 1+0.00001).toFixed(2)) * 1;
	
	var custallowancerate3 = ((document.getElementById('custallowancerate3').value * 1+0.00001).toFixed(2)) * 1;
	var custallowancehour3 = ((document.getElementById('custallowancehour3').value * 1+0.00001).toFixed(2)) * 1;
	
	var custallowancerate4 = ((document.getElementById('custallowancerate4').value * 1+0.00001).toFixed(2)) * 1;
	var custallowancerate5 = ((document.getElementById('custallowancerate5').value * 1+0.00001).toFixed(2)) * 1;
	var custallowancerate6 = ((document.getElementById('custallowancerate6').value * 1+0.00001).toFixed(2)) * 1;
	
	taxval1 = ((taxper/100)*custsalary+0.00001).toFixed(2);
	taxval2 = ((taxper/100)*custottotal+0.00001).toFixed(2);
	taxval3 = 0;
	taxval4 = ((taxper/100)*custcpf+0.00001).toFixed(2);
	taxval5 = ((taxper/100)*custsdf+0.00001).toFixed(2);
	taxval6 = ((taxper/100)*addchargecust+0.00001).toFixed(2);
	taxval7 = ((taxper/100)*addchargecust2+0.00001).toFixed(2);
	taxval8 = ((taxper/100)*addchargecust3+0.00001).toFixed(2);
	taxval9 = ((taxper/100)*addchargecust4+0.00001).toFixed(2);
	taxval10 = ((taxper/100)*custpayback+0.00001).toFixed(2);
	taxval11 = ((taxper/100)*addchargecust5+0.00001).toFixed(2);
	taxval12 = ((taxper/100)*addchargecust6+0.00001).toFixed(2);
	taxval13 = ((taxper/100)*custallowancerate1*custallowancehour1+0.00001).toFixed(2);
	taxval14 = ((taxper/100)*custallowancerate2*custallowancehour2+0.00001).toFixed(2);
	taxval15 = ((taxper/100)*custallowancerate3*custallowancehour3+0.00001).toFixed(2);
	taxval16 = ((taxper/100)*custallowancerate4+0.00001).toFixed(2);
	taxval17 = ((taxper/100)*custallowancerate5+0.00001).toFixed(2);
	taxval18 = ((taxper/100)*custallowancerate6+0.00001).toFixed(2);
	
	taxval = ((taxval1*1)+(taxval2*1)+(taxval3*1)+(taxval4*1)+(taxval5*1)+(taxval6*1)+(taxval7*1)+(taxval8*1)+(taxval9*1)+(taxval10*1)+(taxval11*1)+(taxval12*1)+(taxval13*1)+(taxval14*1)+(taxval15*1)+(taxval16*1)+(taxval17*1)+(taxval18*1)+0.00001).toFixed(2);
	<!---taxval = ((taxper/100)*net).toFixed(2);--->
	
    taxamt.value = taxval;
	var netb = (net * 1) + (taxval * 1);
	var custdeduction = document.getElementById('custdeduction').value * 1;
	var custcpf = ((taxper+100)/100) * (document.getElementById('custcpf').value * 1);
	grand.value = (netb-custdeduction).toFixed(2);
<!--- <cfif getauthuser() eq "ultracai">
alert(taxval1+'\n'+taxval2+'\n'+taxval3+'\n'+taxval4+'\n'+taxval5+'\n'+taxval6+'\n'+taxval7+'\n'+taxval8+'\n'+taxval9+'\n'+taxval10+'\n'+taxval11+'\n'+taxval12+'\n'+taxval13+'\n'+taxval14+'\n'+taxval15+'\n'+taxval16+'\n'+taxval17+'\n'+taxval18+'\n');
</cfif> --->
	}


function calselftotal()
{
	
	
	var selfsalary = document.getElementById('selfsalary').value * 1 ;
	var selfexception = document.getElementById('selfexception').value * 1;
	var selfottotal = document.getElementById('selfottotal').value * 1;
	var selfcpf = document.getElementById('selfcpf').value * 1;
	var selfsdf = document.getElementById('selfsdf').value * 1;
	var selfallowance = document.getElementById('selfallowance').value * 1;
	var selfpayback = document.getElementById('selfpayback').value * 1;
	var addchargeself = document.getElementById('addchargeself').value * 1;
	var addchargeself2 = document.getElementById('addchargeself2').value * 1;
	var addchargeself3 = document.getElementById('addchargeself3').value * 1;
	var addchargeself4 = document.getElementById('addchargeself4').value * 1;
	var addchargeself5 = document.getElementById('addchargeself5').value * 1;
	var addchargeself6 = document.getElementById('addchargeself6').value * 1;
	
	document.getElementById('selfnet').value=(selfsalary+selfexception+selfottotal-selfcpf+selfsdf+addchargeself+addchargeself2+addchargeself3+addchargeself4+addchargeself5+addchargeself6+selfallowance+selfpayback).toFixed(2);
	
	document.getElementById('addchargeselftotal').value=(addchargeself+addchargeself2+addchargeself3+addchargeself4+addchargeself5+addchargeself6).toFixed(2);
	
	
	caltax2();
}

function calcusttotal()
{
	
	
	var custsalary = document.getElementById('custsalary').value * 1 ;
	var custexception = document.getElementById('custexception').value * 1 ;
	var custottotal = document.getElementById('custottotal').value * 1;
	var custcpf = document.getElementById('custcpf').value * 1;
	var custsdf = document.getElementById('custsdf').value * 1;
	var custallowance = document.getElementById('custallowance').value * 1;
	var custpayback = document.getElementById('custpayback').value * 1;
	
	var addchargecust = document.getElementById('addchargecust').value * 1;
	var addchargecust2 = document.getElementById('addchargecust2').value * 1;
	var addchargecust3 = document.getElementById('addchargecust3').value * 1;
	var addchargecust4 = document.getElementById('addchargecust4').value * 1;
	var addchargecust5 = document.getElementById('addchargecust5').value * 1;
	var addchargecust6 = document.getElementById('addchargecust6').value * 1;

	document.getElementById('custnet').value=(custsalary+custottotal+custexception+custallowance+custcpf+custsdf+addchargecust+addchargecust2+addchargecust3+addchargecust4+addchargecust5+addchargecust6+custpayback).toFixed(2);
	
	document.getElementById('addchargecusttotal').value=(addchargecust+addchargecust2+addchargecust3+addchargecust4+addchargecust5+addchargecust6).toFixed(2);
	
	setTimeout('caltax2()',500);
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
	ColdFusion.Window.show('Waiting');
	var calpayurl = '/default/transaction/assignmentslip/processpay.cfm?empno='+document.getElementById("empno").value+'&placement='+document.getElementById('placementno').value+'&invoiceno='+document.getElementById('refno').value+'&selfsalaryhrs='+document.getElementById('selfsalaryhrs').value+'&selfsalaryday='+document.getElementById('selfsalaryday').value+'&AL='+document.getElementById('AL').value+'&MC='+document.getElementById('MC').value+'&NPL='+document.getElementById('NPL').value+'&selfexceptionrate='+document.getElementById('selfexceptionrate').value+'&selfexceptionhrs='+document.getElementById('selfexceptionhrs').value+'&selfotrate1='+document.getElementById('selfotrate1').value+'&selfothour1='+document.getElementById('selfothour1').value+'&selfotrate2='+document.getElementById('selfotrate2').value+'&selfothour2='+document.getElementById('selfothour2').value+'&selfotrate3='+document.getElementById('selfotrate3').value+'&selfothour3='+document.getElementById('selfothour3').value+'&selfotrate4='+document.getElementById('selfotrate4').value+'&selfothour4='+document.getElementById('selfothour4').value+'&selfusualpay='+document.getElementById('selfusualpay').value+'&paytype='+document.getElementById('paymenttype').value+'&selfsdf='+document.getElementById('selfsdf').value+'&totaw='+document.getElementById('selfallowance').value+'&backpay='+document.getElementById('selfpayback').value+'&emppaymenttype='+document.getElementById('emppaymenttype').value+'&basicpay='+document.getElementById('selfsalary').value+'&custbasicpay='+document.getElementById('custsalary').value+'&custexception='+document.getElementById('custexception').value+'&custotpay='+document.getElementById('custottotal').value+'&custallowance='+document.getElementById('custallowance').value+'&custpayback='+document.getElementById('custpayback').value+'&paydate='+document.getElementById('paydate').value+'&dedpay='+document.getElementById('selfdeduction').value+'&nsded='+document.getElementById('nsded').value;
<!--- 	<cfif getauthuser() eq "ultracai">
	prompt("Message", calpayurl);
	</cfif> --->
	 new Ajax.Request(calpayurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('paydata').innerHTML = getdetailback.responseText;
        },
        onFailure: function(){ 
		alert('Error Calculate Pay'); },		
		onComplete: function(transport){
		<cfif url.type eq "create">
		document.getElementById('submit1').disabled = false;
		document.getElementById('submit2').disabled = false;
		</cfif>
		getpaydata();
		calcusttotal();
		updateprocess();
        }
      })
}

function updateprocess()
{
	var updateprocessurl = "/default/transaction/assignmentslip/updateprocess.cfm?empno="+escape(document.getElementById('empno').value)
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
        }
      })
	
}

function getpaydata()
{
	document.getElementById('selfsalary').value=document.getElementById('basicpay').value;
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
	document.getElementById('selfallowance').value=document.getElementById('totalaw').value;
	document.getElementById('selfcpf').value=document.getElementById('employeecpf').value;
	document.getElementById('custsdf').value=document.getElementById('employersdl').value;
	document.getElementById('custcpf').value=document.getElementById('employercpf').value;
	var addchargeself = document.getElementById('addchargeself').value * 1;
	var addchargeself2 = document.getElementById('addchargeself2').value * 1;
	var addchargeself3 = document.getElementById('addchargeself3').value * 1;
	var addchargeself4 = document.getElementById('addchargeself4').value * 1;
	var addchargeself5 = document.getElementById('addchargeself5').value * 1;
	var addchargeself6 = document.getElementById('addchargeself6').value * 1;
	document.getElementById('selfnet').value=(parseFloat(document.getElementById('grosspay').value)+parseFloat((addchargeself+addchargeself2+addchargeself3+addchargeself4+addchargeself5+addchargeself6))).toFixed(2);
	document.getElementById('selftotal').value=((parseFloat(document.getElementById('netpay').value)+(addchargeself+addchargeself2+addchargeself3+addchargeself4+addchargeself5+addchargeself6)).toFixed(2) - parseFloat(document.getElementById('selfdeduction').value)).toFixed(2);
	<!--- document.getElementById('selfdeduction').value=document.getElementById('totalded').value; --->
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
	var checkpayurl = '/default/transaction/assignmentslip/checkpay.cfm?<cfif url.type eq "create">newassignment=true&</cfif>jobdate='+document.getElementById('Assignmentslipdate').value+'&assignmentno='+document.getElementById('emppaymenttype').value+'&paydate='+document.getElementById('paydate').value+'&empno='+document.getElementById('empno').value+'&refno='+document.getElementById('refno').value;
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
		if(document.getElementById('checkclash').value == "0")
		{
			calculatepay();
		}
		else
		{
			alert("Current Assignment Has Clashed With Assignment " +document.getElementById('checkclash').value+" of Current Selected Pay Day");
			document.getElementById('submit1').disabled = true;
			document.getElementById('submit2').disabled = true;
		}
        }
      })
	
}

function dedcal()
{
var nsded = parseFloat(document.getElementById('nsded').value).toFixed(2);
var ded1 = parseFloat(document.getElementById('ded1').value).toFixed(2);
var ded2 = parseFloat(document.getElementById('ded2').value).toFixed(2);
var ded3 = parseFloat(document.getElementById('ded3').value).toFixed(2);
document.getElementById('selfdeduction').value = (parseFloat(nsded) + parseFloat(ded1) + parseFloat(ded2) + parseFloat(ded3)).toFixed(2);
}

function submitform()
{
	if(checkmonth() == true)
	{
	document.getElementById('AssignmentslipForm').action = 'Assignmentsliptableprocess.cfm';
	document.getElementById('AssignmentslipForm').submit();
	}
}

function submitform2()
{
	if(checkmonth() == true)
	{
	document.getElementById('AssignmentslipForm').action = 'Assignmentsliptableprocess.cfm?createnew=true';
	document.getElementById('AssignmentslipForm').submit();
	}
}


</script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
<cfset dts1 = replace(dts,'_i','_p','All')>

<!--- <cfquery name="getemployee" datasource="#dts#">
	SELECT *
	FROM #dts1#.pmast
</cfquery> --->

<cfquery name="getlocation" datasource="#dts#">
	SELECT *
	FROM iclocation
</cfquery>

<cfquery name="getcustno" datasource="#dts#">
	SELECT *
	FROM #target_arcust#
</cfquery>

<cfquery name="getagent" datasource="#dts#">
	SELECT *
	FROM icagent
</cfquery>

<cfquery name="getproject" datasource="#dts#">
	SELECT *
	FROM #dts1#.project
</cfquery>

<cfquery name="getplacement" datasource="#dts#">
	SELECT *
	FROM placement
</cfquery>

<body>
<cfoutput>
	<cfif url.type eq "Edit">
		<cfquery datasource='#dts#' name="getitem">
			Select * from Assignmentslip where refno='#url.refno#'
		</cfquery>
		<cfset posted = getitem.posted>
		<cfset refno=getitem.refno>
		<cfset assignmentslipdate=dateformat(getitem.assignmentslipdate,'DD/MM/YYYY')>
        <cfset xcustno = getitem.custno>
		<cfset xplacementno=getitem.placementno>
        <cfset payno = getitem.payno>
        <cfset chequeno = getitem.chequeno>
        <cfset empno = getitem.empno>
        <cfset lastworkingdate = dateformat(getitem.lastworkingdate,'DD/MM/YYYY')>
        <cfset startdate = dateformat(getitem.startdate,'DD/MM/YYYY')>
        <cfset completedate = dateformat(getitem.completedate,'DD/MM/YYYY')>
        <cfset  selfusualpay= getitem.selfusualpay>
        <cfset  custusualpay= getitem.custusualpay>
        <cfset  selfsalaryhrs= getitem.selfsalaryhrs>
        <cfset  selfsalaryday= getitem.selfsalaryday>
        <cfset  custsalaryhrs= getitem.custsalaryhrs>
        <cfset  custsalaryday= getitem.custsalaryday>
        <cfset  selfsalary= getitem.selfsalary>
        <cfset  custsalary= getitem.custsalary>
        <cfset selfexceptionrate= getitem.selfexceptionrate>
        <cfset selfexceptionhrs= getitem.selfexceptionhrs>
        <cfset selfexceptionday= getitem.selfexceptionday>
        <cfset selfexception= getitem.selfexception>
        <cfset selfotrate1= getitem.selfotrate1>
        <cfset selfothour1= getitem.selfothour1>
        <cfset custotrate1= getitem.custotrate1>
        <cfset custothour1= getitem.custothour1>
        <cfset selfot1= getitem.selfot1>
        <cfset custot1= getitem.custot1>
        <cfset selfotrate2= getitem.selfotrate2>
        <cfset selfothour2= getitem.selfothour2>
        <cfset custotrate2= getitem.custotrate2>
        <cfset custothour2= getitem.custothour2>
        <cfset selfot2= getitem.selfot2>
        <cfset custot2= getitem.custot2>
        <cfset selfotrate3= getitem.selfotrate3>
        <cfset selfothour3= getitem.selfothour3>
        <cfset custotrate3= getitem.custotrate3>
        <cfset custothour3= getitem.custothour3>
        <cfset selfot3= getitem.selfot3>
        <cfset custot3= getitem.custot3>
        <cfset selfotrate4= getitem.selfotrate4>
        <cfset selfothour4= getitem.selfothour4>
        <cfset custotrate4= getitem.custotrate4>
        <cfset custothour4= getitem.custothour4>
        <cfset selfot4= getitem.selfot4>
        <cfset custot4= getitem.custot4>
        <cfset selfottotal= getitem.selfottotal>
        <cfset custottotal= getitem.custottotal>
        
        <cfset addchargedesp= getitem.addchargedesp>
        <cfset addchargeself= getitem.addchargeself>
        <cfset addchargecust= getitem.addchargecust>
        
        <cfset addchargedesp2= getitem.addchargedesp2>
        <cfset addchargeself2= getitem.addchargeself2>
        <cfset addchargecust2= getitem.addchargecust2>
        
        <cfset addchargedesp3= getitem.addchargedesp3>
        <cfset addchargeself3= getitem.addchargeself3>
        <cfset addchargecust3= getitem.addchargecust3>
        
        <cfset addchargedesp4= getitem.addchargedesp4>
        <cfset addchargeself4= getitem.addchargeself4>
        <cfset addchargecust4= getitem.addchargecust4>
        
        <cfset selfcpf= getitem.selfcpf>
        <cfset custcpf= getitem.custcpf>
        
        <cfset selfsdf= getitem.selfsdf>
        <cfset custsdf= getitem.custsdf>
        
        <cfset selfallowancerate1= getitem.selfallowancerate1>
        <cfset selfallowancehour1= getitem.selfallowancehour1>
        <cfset custallowancerate1= getitem.custallowancerate1>
        <cfset custallowancehour1= getitem.custallowancehour1>
        <cfset selfallowancerate2= getitem.selfallowancerate2>
        <cfset selfallowancehour2= getitem.selfallowancehour2>
        <cfset custallowancerate2= getitem.custallowancerate2>
        <cfset custallowancehour2= getitem.custallowancehour2>
        <cfset selfallowancerate3= getitem.selfallowancerate3>
        <cfset selfallowancehour3= getitem.selfallowancehour3>
        <cfset custallowancerate3= getitem.custallowancerate3>
        <cfset custallowancehour3= getitem.custallowancehour3>
        <cfset selfallowancerate4= getitem.selfallowancerate4>
        <cfset selfallowancehour4= getitem.selfallowancehour4>
        <cfset custallowancerate4= getitem.custallowancerate4>
        <cfset custallowancehour4= getitem.custallowancehour4>
        <cfset selfallowance= getitem.selfallowance>
        <cfset custallowance= getitem.custallowance>
        <cfset selfpayback= getitem.selfpayback>
        <cfset custpayback= getitem.custpayback>
        <cfset selfdeduction= getitem.selfdeduction>
        <cfset custdeduction= getitem.custdeduction>
        <cfset selfnet= getitem.selfnet>
        <cfset custnet= getitem.custnet>
        <cfset taxcode=getitem.taxcode>
        <cfset taxper=getitem.taxper>
        <cfset taxamt=getitem.taxamt>
        <cfset selftotal= getitem.selftotal>
        <cfset custtotal= getitem.custtotal>
        <cfset payrollperiod=getitem.payrollperiod>
        <cfset custname=getitem.custname>
        <cfset empname=getitem.empname>
        <cfset assignmenttype=getitem.assignmenttype>
        <cfset paymenttype=getitem.paymenttype>
        <cfset AL=getitem.AL>
        <cfset MC=getitem.MC>
		<cfset emppaymenttype = getitem.emppaymenttype>
        <cfset paydate = getitem.paydate>
        <cfset aw101desp = getitem.aw101desp>
        <cfset aw102desp = getitem.aw102desp>
        <cfset aw103desp = getitem.aw103desp>
        <cfset aw104desp = getitem.aw104desp>
        <cfset aw105desp = getitem.aw105desp>
        <cfset aw106desp = getitem.aw106desp>
        <cfset selfallowancerate5 = getitem.selfallowancerate5>
        <cfset selfallowancerate6 = getitem.selfallowancerate6>
        <cfset custallowancerate5 = getitem.custallowancerate5>
        <cfset custallowancerate6 = getitem.custallowancerate6>
        <cfset addchargedesp5= getitem.addchargedesp5>
        <cfset addchargeself5= getitem.addchargeself5>
        <cfset addchargecust5= getitem.addchargecust5>
        <cfset addchargedesp6= getitem.addchargedesp6>
        <cfset addchargeself6= getitem.addchargeself6>
        <cfset addchargecust6= getitem.addchargecust6>
        <cfset claimadd1 = getitem.claimadd1>
        <cfset claimadd2 = getitem.claimadd2>
        <cfset claimadd3 = getitem.claimadd3>
        <cfset claimadd4 = getitem.claimadd4>
        <cfset claimadd5 = getitem.claimadd5>
        <cfset claimadd6 = getitem.claimadd6>
        <cfset CUSTEXCEPTION = getitem.CUSTEXCEPTION>
        <cfset NPL=getitem.NPL>
        <CFSET CUSTNPL = getitem.custnpl>
        <cfset workd = getitem.workd>
        <cfset nsded = getitem.nsded>
        <cfset nsdeddesp = getitem.nsdeddesp>
        <cfset ded1 = getitem.ded1>
        <cfset ded1desp = getitem.ded1desp>
        <cfset ded2 = getitem.ded2>
        <cfset ded2desp = getitem.ded2desp>
        <cfset ded3 = getitem.ded3>
        <cfset ded3desp = getitem.ded3desp>
        
        
		<cfset mode="Edit">
		<!--- <cfset title="Edit Item"> --->
		<cfset title="Edit Assignmentslip">
		<cfset button="Edit">
	
	<cfelseif url.type eq "Delete">
		<cfquery datasource='#dts#' name="getitem">
			Select * from Assignmentslip where refno='#url.refno#'
		</cfquery>
		<cfset posted = getitem.posted>
		<cfset refno=getitem.refno>
		<cfset assignmentslipdate=dateformat(getitem.assignmentslipdate,'DD/MM/YYYY')>
        <cfset xcustno = getitem.custno>
		<cfset xplacementno=getitem.placementno>
        <cfset payno = getitem.payno>
        <cfset chequeno = getitem.chequeno>
        <cfset empno = getitem.empno>
        <cfset lastworkingdate = dateformat(getitem.lastworkingdate,'DD/MM/YYYY')>
        <cfset startdate = dateformat(getitem.startdate,'DD/MM/YYYY')>
        <cfset completedate = dateformat(getitem.completedate,'DD/MM/YYYY')>
        <cfset  selfusualpay= getitem.selfusualpay>
        <cfset  custusualpay= getitem.custusualpay>
        <cfset  selfsalaryhrs= getitem.selfsalaryhrs>
        <cfset  selfsalaryday= getitem.selfsalaryday>
        <cfset  custsalaryhrs= getitem.custsalaryhrs>
        <cfset  custsalaryday= getitem.custsalaryday>
        <cfset  selfsalary= getitem.selfsalary>
        <cfset  custsalary= getitem.custsalary>
        <cfset selfexceptionrate= getitem.selfexceptionrate>
        <cfset selfexceptionhrs= getitem.selfexceptionhrs>
        <cfset selfexceptionday= getitem.selfexceptionday>
        <cfset selfexception= getitem.selfexception>
        <cfset selfotrate1= getitem.selfotrate1>
        <cfset selfothour1= getitem.selfothour1>
        <cfset custotrate1= getitem.custotrate1>
        <cfset custothour1= getitem.custothour1>
        <cfset selfot1= getitem.selfot1>
        <cfset custot1= getitem.custot1>
        <cfset selfotrate2= getitem.selfotrate2>
        <cfset selfothour2= getitem.selfothour2>
        <cfset custotrate2= getitem.custotrate2>
        <cfset custothour2= getitem.custothour2>
        <cfset selfot2= getitem.selfot2>
        <cfset custot2= getitem.custot2>
        <cfset selfotrate3= getitem.selfotrate3>
        <cfset selfothour3= getitem.selfothour3>
        <cfset custotrate3= getitem.custotrate3>
        <cfset custothour3= getitem.custothour3>
        <cfset selfot3= getitem.selfot3>
        <cfset custot3= getitem.custot3>
        <cfset selfotrate4= getitem.selfotrate4>
        <cfset selfothour4= getitem.selfothour4>
        <cfset custotrate4= getitem.custotrate4>
        <cfset custothour4= getitem.custothour4>
        <cfset selfot4= getitem.selfot4>
        <cfset custot4= getitem.custot4>
        <cfset selfottotal= getitem.selfottotal>
        <cfset custottotal= getitem.custottotal>
        <cfset selfcpf= getitem.selfcpf>
        <cfset custcpf= getitem.custcpf>
        <cfset addchargedesp= getitem.addchargedesp>
        <cfset addchargeself= getitem.addchargeself>
        <cfset addchargecust= getitem.addchargecust>
        
        <cfset selfsdf= getitem.selfsdf>
        <cfset custsdf= getitem.custsdf>
        <cfset selfallowancerate1= getitem.selfallowancerate1>
        <cfset selfallowancehour1= getitem.selfallowancehour1>
        <cfset custallowancerate1= getitem.custallowancerate1>
        <cfset custallowancehour1= getitem.custallowancehour1>
        <cfset selfallowancerate2= getitem.selfallowancerate2>
        <cfset selfallowancehour2= getitem.selfallowancehour2>
        <cfset custallowancerate2= getitem.custallowancerate2>
        <cfset custallowancehour2= getitem.custallowancehour2>
        <cfset selfallowancerate3= getitem.selfallowancerate3>
        <cfset selfallowancehour3= getitem.selfallowancehour3>
        <cfset custallowancerate3= getitem.custallowancerate3>
        <cfset custallowancehour3= getitem.custallowancehour3>
        <cfset selfallowancerate4= getitem.selfallowancerate4>
        <cfset selfallowancehour4= getitem.selfallowancehour4>
        <cfset custallowancerate4= getitem.custallowancerate4>
        <cfset custallowancehour4= getitem.custallowancehour4>
        <cfset selfallowance= getitem.selfallowance>
        <cfset custallowance= getitem.custallowance>
        <cfset selfpayback= getitem.selfpayback>
        <cfset custpayback= getitem.custpayback>
        <cfset selfdeduction= getitem.selfdeduction>
        <cfset custdeduction= getitem.custdeduction>
        <cfset selfnet= getitem.selfnet>
        <cfset custnet= getitem.custnet>
        <cfset taxcode=getitem.taxcode>
        <cfset taxper=getitem.taxper>
        <cfset taxamt=getitem.taxamt>
        <cfset selftotal= getitem.selftotal>
        <cfset custtotal= getitem.custtotal>
        <cfset addchargedesp2= getitem.addchargedesp2>
        <cfset addchargeself2= getitem.addchargeself2>
        <cfset addchargecust2= getitem.addchargecust2>
        <cfset addchargedesp3= getitem.addchargedesp3>
        <cfset addchargeself3= getitem.addchargeself3>
        <cfset addchargecust3= getitem.addchargecust3>
        
        <cfset addchargedesp4= getitem.addchargedesp4>
        <cfset addchargeself4= getitem.addchargeself4>
        <cfset addchargecust4= getitem.addchargecust4>
        <cfset payrollperiod=getitem.payrollperiod>
        <cfset custname=getitem.custname>
        <cfset empname=getitem.empname>
        <cfset assignmenttype=getitem.assignmenttype>
        <cfset paymenttype=getitem.paymenttype>
        <cfset AL=getitem.AL>
        <cfset MC=getitem.MC>
		<cfset emppaymenttype = getitem.emppaymenttype>
        <cfset paydate = getitem.paydate>
        <cfset aw101desp = getitem.aw101desp>
        <cfset aw102desp = getitem.aw102desp>
        <cfset aw103desp = getitem.aw103desp>
        <cfset aw104desp = getitem.aw104desp>
        <cfset aw105desp = getitem.aw105desp>
        <cfset aw106desp = getitem.aw106desp>
        <cfset selfallowancerate5 = getitem.selfallowancerate5>
        <cfset selfallowancerate6 = getitem.selfallowancerate6>
        <cfset custallowancerate5 = getitem.custallowancerate5>
        <cfset custallowancerate6 = getitem.custallowancerate6>
        <cfset addchargedesp5= getitem.addchargedesp5>
        <cfset addchargeself5= getitem.addchargeself5>
        <cfset addchargecust5= getitem.addchargecust5>
        <cfset addchargedesp6= getitem.addchargedesp6>
        <cfset addchargeself6= getitem.addchargeself6>
        <cfset addchargecust6= getitem.addchargecust6>
        <cfset claimadd1 = getitem.claimadd1>
        <cfset claimadd2 = getitem.claimadd2>
        <cfset claimadd3 = getitem.claimadd3>
        <cfset claimadd4 = getitem.claimadd4>
        <cfset claimadd5 = getitem.claimadd5>
        <cfset claimadd6 = getitem.claimadd6>
        <cfset CUSTEXCEPTION = getitem.CUSTEXCEPTION>
        <cfset NPL=getitem.NPL>
        <CFSET CUSTNPL = getitem.custnpl>
        <cfset workd = getitem.workd>
        <cfset nsded = getitem.nsded>
        <cfset nsdeddesp = getitem.nsdeddesp>
        <cfset ded1 = getitem.ded1>
        <cfset ded1desp = getitem.ded1desp>
        <cfset ded2 = getitem.ded2>
        <cfset ded2desp = getitem.ded2desp>
        <cfset ded3 = getitem.ded3>
        <cfset ded3desp = getitem.ded3desp>
		<cfset mode="Delete">
		<!--- <cfset title="Delete Item"> --->
		<cfset title="Delete Assignmentslip">
		<cfset button="Delete">
	
	<cfelseif url.type eq "Create">
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
        <cfset xcustno = "">
		<cfset xplacementno="">
        <cfset payno = "">
        <cfset chequeno = "">
        <cfset empno = "">
        <cfset lastworkingdate = "">
        <cfset startdate = "">
        <cfset completedate = "">
        <cfset  selfusualpay= "0.00">
        <cfset  custusualpay= "0.00">
        <cfset  selfsalaryhrs= "0">
        <cfset  selfsalaryday= "0">
        <cfset  custsalaryhrs= "0">
        <cfset  custsalaryday= "0">
        <cfset  selfsalary= "0.00">
        <cfset  custsalary= "0.00">
        <cfset selfexceptionrate= "0.00">
        <cfset selfexceptionhrs= "0">
        <cfset selfexceptionday= "0">
        <cfset selfexception= "0.00">
        <cfset selfotrate1= "0.00">
        <cfset selfothour1= "0">
        <cfset custotrate1= "0.00">
        <cfset custothour1= "0">
        <cfset selfot1= "0.00">
        <cfset custot1= "0.00">
        <cfset selfotrate2= "0.00">
        <cfset selfothour2= "0">
        <cfset custotrate2= "0.00">
        <cfset custothour2= "0">
        <cfset selfot2= "0.00">
        <cfset custot2= "0.00">
        <cfset selfotrate3= "0.00">
        <cfset selfothour3= "0">
        <cfset custotrate3= "0.00">
        <cfset custothour3= "0">
        <cfset selfot3= "0.00">
        <cfset custot3= "0.00">
        <cfset selfotrate4= "0.00">
        <cfset selfothour4= "0">
        <cfset custotrate4= "0.00">
        <cfset custothour4= "0">
        <cfset selfot4= "0.00">
        <cfset custot4= "0.00">
        <cfset selfottotal= "0.00">
        <cfset custottotal= "0.00">
        <cfset selfcpf= "0.00">
        <cfset custcpf= "0.00">
        <cfset addchargedesp2= "">
        <cfset addchargeself2= "0.00">
        <cfset addchargecust2= "0.00">
        
        <cfset addchargedesp3= "">
        <cfset addchargeself3= "0.00">
        <cfset addchargecust3= "0.00">
        <cfset addchargedesp4= "">
        <cfset addchargeself4= "0.00">
        <cfset addchargecust4= "0.00">
        <cfset emppaymenttype = "">
        <cfset selfsdf= "0.00">
        <cfset custsdf= "0.00">
        <cfset selfallowancerate1= "0.00">
        <cfset selfallowancehour1= "0">
        <cfset custallowancerate1= "0.00">
        <cfset custallowancehour1= "0">
        <cfset selfallowancerate2= "0.00">
        <cfset selfallowancehour2= "0">
        <cfset custallowancerate2= "0.00">
        <cfset custallowancehour2= "0">
        <cfset selfallowancerate3= "0.00">
        <cfset selfallowancehour3= "0">
        <cfset custallowancerate3= "0.00">
        <cfset custallowancehour3= "0">
        <cfset selfallowancerate4= "0.00">
        <cfset selfallowancehour4= "0">
        <cfset custallowancerate4= "0.00">
        <cfset custallowancehour4= "0">
        <cfset selfallowance= "0.00">
        <cfset custallowance= "0.00">
        <cfset selfpayback= "0.00">
        <cfset custpayback= "0.00">
        <cfset selfdeduction= "0.00">
        <cfset custdeduction= "0.00">
        <cfset selfnet= "0.00">
        <cfset custnet= "0.00">
        <cfset taxcode="">
        <cfset taxper="0">
        <cfset taxamt="0.00">
        <cfset selftotal= "0.00">
        <cfset custtotal= "0.00">
        <cfset custname="">
        <cfset empname="">
        <cfset assignmenttype="">
        <cfset paymenttype="">
        <cfset AL="0">
        <cfset MC="0">
        
        <cfset addchargedesp= "">
        <cfset addchargeself= "0.00">
        <cfset addchargecust= "0.00">
        <cfset dts2=replace(dts,'_i','','all')>
        <cfset paydate = "">
        <cfset aw101desp = "">
        <cfset aw102desp = "">
        <cfset aw103desp = "">
        <cfset aw104desp = "">
        <cfset aw105desp = "">
        <cfset aw106desp = "">
        <cfset selfallowancerate5 = "0.00">
        <cfset selfallowancerate6 = "0.00">
        <cfset custallowancerate5 = "0.00">
        <cfset custallowancerate6 = "0.00">
        <cfset addchargedesp5= "">
        <cfset addchargeself5= "0.00">
        <cfset addchargecust5= "0.00">
        <cfset addchargedesp6= "">
        <cfset addchargeself6= "0.00">
        <cfset addchargecust6= "0.00">
        <cfset claimadd1 = "">
        <cfset claimadd2 = "">
        <cfset claimadd3 = "">
        <cfset claimadd4 = "">
        <cfset claimadd5 = "">
        <cfset claimadd6 = "">
        <cfset CUSTEXCEPTION = "0.00">
        <cfset NPL="0">
         <CFSET CUSTNPL = "0">
        <cfset workd = "0">
        <cfset nsded = "0.00">
        <cfset nsdeddesp = "">
        <cfset ded1 ="0.00">
        <cfset ded1desp = "">
        <cfset ded2 = "0.00">
        <cfset ded2desp = "">
        <cfset ded3 = "0.00">
        <cfset ded3desp = "">
      <cfquery name="company_details" datasource="payroll_main">
        SELECT * FROM gsetup WHERE comp_id = "#dts2#"
      </cfquery>
      <cfset payrollperiod=company_details.mmonth>
		
		<cfset mode="Create">
		<!--- <cfset title="Create Item"> --->
		<cfset title="Create Assignmentslip">
		<cfset button="Create">
	</cfif>

  <h1>#title#</h1>
			
	<h4>
		<a href="Assignmentsliptable2.cfm?type=Create">Create Assignment Slip</a> 
		|| <a href="Assignmentsliptable.cfm?">List all Assignment Slip</a> 
		|| <a href="s_Assignmentsliptable.cfm?type=Assignmentslip">Search For Assignment Slip</a>
        ||  <a href="printcheque.cfm">Print Claim Cheque</a>
        || <a href="printclaim.cfm">Print Claim Voucher</a>
        || <a href="generatecheqno.cfm">Record Claim Cheque No</a>
        || <a href="definecheqno.cfm">Predefined Cheque No</a>
        	</h4>
</cfoutput> 

<cfform name="AssignmentslipForm" id="AssignmentslipForm" action="Assignmentsliptableprocess.cfm" method="post" onsubmit="return checkmonth();" >
  <cfoutput> 
    <input type="hidden" name="mode" id="mode" value="#mode#">
  </cfoutput> 
  <h1 align="center">Assignment Slip</h1>
  <table align="center" class="data">
    <cfoutput> 
      <tr> 
        <th width="150">Invoice No:</th>
        <td> <cfif mode eq "Delete" or mode eq "Edit">
            <input type="text" size="20" name="refno" id="refno" value="#url.refno#" readonly>
            <cfelse>
            <cfinput type="text" size="20" name="refno" id="refno" value="#refno#" maxlength="40" required="yes" message="Invoice No is Required">
          </cfif> </td>
        <th width="150">Invoice Date :</th>
        <td>
				<cfif mode eq "Delete" or mode eq "Edit">
				<cfinput type="text" size="20" name="Assignmentslipdate" id="Assignmentslipdate" value="#Assignmentslipdate#" maxlength="10" validate="eurodate" message="Please check Date Format">
				<cfelse>
				<cfinput type="text" size="20" name="Assignmentslipdate" id="Assignmentslipdate" value="#Assignmentslipdate#" maxlength="10" validate="eurodate" message="Please check Date Format" >
				</cfif>
				
				<cfif mode eq "Delete" or mode eq "Edit"><cfelse><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('Assignmentslipdate'));">DD/MM/YYYY</cfif>
		</td>
      </tr>
      <tr>
      <th>Customer No</th>
      <td>
      <!---
      <cfselect name="custno" id="custno">
      <option value="">Choose a Customer Code</option>
      <cfloop query="getcustno">
      <option value="#getcustno.custno#" <cfif xcustno eq getcustno.custno>selected</cfif>>#getcustno.custno# - #getcustno.name#</option>
      </cfloop>
      </cfselect>--->
      <cfinput type="text" name="custno" id="custno" value="#xcustno#" readonly>
      <br><cfinput type="text" name="custname" id="custname" size='40' value="#custname#" bind="cfc:assignmentslip.getcustname({custno},'#dts#')"  readonly>
      </td>
      <th>Placement</th>
      <td>
      <cfinput required="yes" message="Placement is Required" type="text" name="placementno" id="placementno" onChange="ajaxFunction(window.document.getElementById('itemDetail'),'getallowanceAjax.cfm?placementno='+encodeURI(this.value));setTimeout('setallowancerate()',1000);setTimeout('updatecustno()',1000);" value="#xplacementno#" readonly>

      <input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findplacement');" />

      <!---<select name="placementno" onChange="ajaxFunction(window.document.getElementById('itemDetail'),'getallowanceAjax.cfm?placementno='+encodeURI(this.value));setTimeout('setallowancerate()',1000);setTimeout('updatecustno()',1000);" <cfif mode eq "Delete" or mode eq "Edit">readonly</cfif>>
      <option value="">Choose a Placement No</option>
      <cfloop query="getplacement">
      <option value="#getplacement.placementno#" <cfif xplacementno eq getplacement.placementno>selected</cfif>>#getplacement.placementno#</option>
      </cfloop>
      </select>--->
      <div id="itemDetail"></div>
      </td>
      </tr>
      <tr>
      <th>Pay No</th>
      <td><input type="text" name="payno" id="payno" value="#payno#" readonly></td>
      <th>Cheque No</th>
      <td><input type="text" name="chequeno" id="chequeno" value="#chequeno#"></td>
      </tr>
      <tr>
      <th>Employee No<br/>
  		&nbsp;
      </th>
      <td><cfinput type="text" name="empno" id="empno" value="#empno#" bind="cfc:assignmentslip.getempno({placementno},'#dts#')">
      <br><cfinput type="text" name="empname" id="empname" size='40' value="#empname#" readonly>
      </td>
      <th>Period</th>
      
      <td>
      <select name="payrollperiod" id="payrollperiod">
      <cfloop from="1" to="12" index="i">
      <option value="#i#" <cfif i eq payrollperiod>selected</cfif>>#i#</option>
      </cfloop>
      </select>
     </td>
      </tr>
      <tr>
      <th>Last Working Date</th>
      <td>
      <cfinput type="text" size="20" name="lastworkingdate" value="#lastworkingdate#" id="lastworkingdate" maxlength="10" validate="eurodate" message="Please check Date Format"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(lastworkingdate);">DD/MM/YYYY
      </td>
      <th>Payment Type</th>
      <td>
      <select name="paymenttype" id="paymenttype">
      <option value="">Choose A Payment Type</option>
      <option value="hr" <cfif paymenttype eq "hr">selected</cfif>>Hr</option>
      <option value="day" <cfif paymenttype eq "day">selected</cfif>>Day</option>
      <option value="mth" <cfif paymenttype eq "mth">selected</cfif>>Mth</option>
      </select>
      <input type="hidden" name="paymenttype2" id="paymenttype2" value="#paymenttype#">
      </td>

      <tr><th>Current Assignment</th>
      <td>
      <select name="emppaymenttype" id="emppaymenttype">
      <option value="payweek1" <cfif emppaymenttype eq "payweek1" or  emppaymenttype eq "2nd Half">Selected</cfif>>1st Assignment</option>
      <option value="payweek2" <cfif emppaymenttype eq "payweek2" or  emppaymenttype eq "1st Half">Selected</cfif> >2nd Assignment</option>
      <option value="payweek3" <cfif emppaymenttype eq "payweek3">Selected</cfif> >3rd Assignment</option>
      <option value="payweek4" <cfif emppaymenttype eq "payweek4">Selected</cfif> >4th Assignment</option>
      <option value="payweek5" <cfif emppaymenttype eq "payweek5">Selected</cfif> >5th Assignment</option>
      <option value="payweek6" <cfif emppaymenttype eq "payweek6">Selected</cfif> >6th Assignment</option>
      </select></td>
      <th>Type</th>
      <td>
      <select name="assignmenttype" id="assignmenttype">
      <option value="invoice" <cfif assignmenttype eq 'invoice'>selected</cfif>>Invoice</option>
      <option value="einvoice" <cfif assignmenttype eq 'einvoice'>selected</cfif>>E-Invoice</option>
      <option value="noinvoice" <cfif assignmenttype eq 'noinvoice'>selected</cfif>>No Invoice</option>
      </select>
      </td>
      </tr>
      <tr>
      <th>Pay Day</th>
      <td>
      <select name="paydate" id="paydate" <cfif url.type eq "edit">onChange="if(this.value != '#paydate#'){alert('Please Remember to Calculate Pay On Change Pay Day Before Save');}"</cfif>>
      <option value="paytra1" <cfif paydate eq "paytra1">Selected</cfif>>1st Pay Day</option>
      <option value="paytran" <cfif paydate eq "paytran">Selected</cfif>>2nd Pay Day</option>
      </select>
      </td>
      </tr>

      </cfoutput></table>
      
      <table align="center" class="data">
      <cfoutput>
      
      <tr>
      <th colspan="4">Job Start Date&nbsp;&nbsp;&nbsp;<cfinput type="text" size="15" name="startdate" id="startdate" value="#startdate#" maxlength="10" validate="eurodate" required="yes" message="Job Start Date Required / Invalid"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(startdate);">DD/MM/YYYY</td>
      <th colspan="4">Job Completed Date&nbsp;&nbsp;&nbsp;<cfinput type="text" size="15" name="completedate" id="completedate" value="#completedate#" maxlength="10" validate="eurodate" required="yes" message="Job Start Completed Required / Invalid"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(completedate);">DD/MM/YYYY</td>

      </tr>
      <tr><td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td><strong><u>Employee</u></strong></td>
      <td><strong><u>Employer</u></strong></td>
      </tr>

      <th colspan="6"><div align="right">Basic Rate</div></th>
            <td><cfinput type="text" name="selfusualpay" id="selfusualpay" value="#numberformat(selfusualpay,'.__')#" onKeyUp="calculateselfhour();"  size='10'></td>
      <td><cfinput type="text" name="custusualpay" id="custusualpay" value="#numberformat(custusualpay,'_.__')#" onKeyUp="calculatecusthour();"  size='10'></td>
      </td>
      <tr>
      <th>Work Days/Hrs</th>
      <td>
      <input type="text" size='10' name="selfsalaryhrs" id="selfsalaryhrs" value="#selfsalaryhrs#" onKeyUp="setselfallow();"> Hrs      </td>
      <td><input type="text" size='10' name="selfsalaryday" id="selfsalaryday" value="#selfsalaryday#" onKeyUp="setselfallow();"> Days</td>
      <td width="50"></td>
      <td>
      <input type="text" size='10' name="custsalaryhrs" id="custsalaryhrs" value="#custsalaryhrs#" onKeyUp="setcustallow();"> Hrs      </td>
      <td><input type="text" size='10' name="custsalaryday" id="custsalaryday" value="#custsalaryday#" onKeyUp="setcustallow();"> Days</td>
      </tr>
      
      <tr>
      <th>Actual Working Days</th>
      <td><input type="text" size='10' name="workd" id="workd" value="#workd#" onKeyUp="selfnpl()"></td>
      
      <td></td>
      <th>NPL</th>
      <td><input type="text" size='10' name="NPL" id="NPL" value="#NPL#" onKeyUp="selfnpl()"> yee</td>
      <td><input type="text" size='10' name="CUSTNPL" id="CUSTNPL" value="#CUSTNPL#"> yer</td>
      </tr>
      <tr>
       <th>AL</th>
      <td><input type="text" size='10' name="AL" id="AL" value="#AL#"></td>
      <td></td><th>MC</th>
      <td><input type="text" size='10' name="MC" id="MC" value="#MC#"></td>
     
      <td></td>
      </tr>
    
      <tr>
      <th colspan="6"><div align="right">Basic Pay</div></th>
             <td><cfinput type="text" size='10' name="selfsalary" id="selfsalary" value="#numberformat(selfsalary,'_.__')#" onKeyUp="calselftotal();"></td>
       <td><cfinput type="text" size='10' name="custsalary" id="custsalary" value="#numberformat(custsalary,'_.__')#" onKeyUp="calcusttotal();"></td>
      </tr>
      <tr>
      <th>Exception</th>
      <td>
      <input type="text" size='10' name="selfexceptionrate" id="selfexceptionrate" value="#selfexceptionrate#" onKeyUp="calselfexception();"> Rate</td>
      <td>
      <input type="text" size='10' name="selfexceptionhrs" id="selfexceptionhrs" value="#selfexceptionhrs#" onKeyUp="calselfexception();"> Hrs / Days
      </td>
      <td width="50"></td>
      <td ><inpu tstyle="display:none" type="text" size='10' name="selfexceptionday" id="selfexceptionday" value="#selfexceptionday#"><!---  Days ---></td>
      <td></td>

       <td><input type="text" size='10' name="selfexception"  id="selfexception" value="#selfexception#"></td><td><input type="text" size='10' name="custexception"  id="custexception" value="#custexception#"></td>
      </tr>
      
      <tr>
      <th>OT 1</th>
      <td>
      <input type="text" size='10' name="selfotrate1" id="selfotrate1" value="#selfotrate1#" onKeyUp="calselfot1();"> Rate      </td>
      <td><input type="text" size='10' name="selfothour1" id="selfothour1" value="#selfothour1#" onKeyUp="calselfot1();"> Hours</td>
      <td width="50"></td>
      <td>
      <input type="text" size='10' name="custotrate1" id="custotrate1" value="#custotrate1#" onKeyUp="calcustot1();"> Rate      </td>
      <td><input type="text" size='10' name="custothour1" id="custothour1" value="#custothour1#" onKeyUp="calcustot1();"> Hours</td>

       <td><input type="text" size='10' name="selfot1" id="selfot1" value="#numberformat(selfot1,'_.__')#"></td><td><input type="text" size='10' name="custot1" id="custot1" value="#numberformat(custot1,'_.__')#" readonly></td>
      </tr>
      
      <tr>
      <th>OT 1.5</th>
      <td>
      <input type="text" size='10' name="selfotrate2" id="selfotrate2" value="#selfotrate2#" onKeyUp="calselfot2();"> Rate      </td>
      <td><input type="text" size='10' name="selfothour2" id="selfothour2" value="#selfothour2#" onKeyUp="calselfot2();"> Hours</td>
      <td width="50"></td>
      <td>
      <input type="text" size='10' name="custotrate2" id="custotrate2" value="#custotrate2#" onKeyUp="calcustot2();"> Rate      </td>
      <td><input type="text" size='10' name="custothour2" id="custothour2" value="#custothour2#" onKeyUp="calcustot2();"> Hours</td>

       <td><input type="text" size='10' name="selfot2"  id="selfot2" value="#numberformat(selfot2,'_.__')#"></td><td><input type="text" size='10' name="custot2" id="custot2" value="#numberformat(custot2,'_.__')#" readonly></td>
      </tr>
      
      <tr>
      <th>OT 2</th>
      <td>
      <input type="text" size='10' name="selfotrate3" id="selfotrate3" value="#selfotrate3#" onKeyUp="calselfot3();"> Rate      </td>
      <td><input type="text" size='10' name="selfothour3" id="selfothour3" value="#selfothour3#" onKeyUp="calselfot3();"> Hours</td>
      <td width="50"></td>
      <td>
      <input type="text" size='10' name="custotrate3" id="custotrate3" value="#custotrate3#" onKeyUp="calcustot3();"> Rate      </td>
      <td><input type="text" size='10' name="custothour3" id="custothour3" value="#custothour3#" onKeyUp="calcustot3();"> Hours</td>

       <td><input type="text" size='10' name="selfot3" id="selfot3" value="#numberformat(selfot3,'_.__')#"></td><td><input type="text" size='10' name="custot3" id="custot3" value="#numberformat(custot3,'_.__')#" readonly></td>
      </tr>
      
      <tr>
      <th>OT 3</th>
      <td>
      <input type="text" size='10' name="selfotrate4" id="selfotrate4" value="#selfotrate4#" onKeyUp="calselfot4();"> Rate      </td>
      <td><input type="text" size='10' name="selfothour4" id="selfothour4" value="#selfothour4#" onKeyUp="calselfot4();"> Hours</td>
      <td width="50"></td>
      <td>
      <input type="text" size='10' name="custotrate4" id="custotrate4" value="#custotrate4#" onKeyUp="calcustot4();"> Rate      </td>
      <td><input type="text" size='10' name="custothour4" id="custothour4" value="#custothour4#" onKeyUp="calcustot4();"> Hours</td>

       <td><input type="text" size='10' name="selfot4" id="selfot4" value="#numberformat(selfot4,'_.__')#"></td><td><input type="text" size='10' name="custot4" id="custot4" value="#numberformat(custot4,'_.__')#" readonly></td>
      </tr>
      <tr>
      <th colspan="6"><div align="right">Total Over Time</div></th>
      <td><input type="text" size='10' name="selfottotal" id="selfottotal" value="#numberformat(selfottotal,'_.__')#" readonly></td>
      <td><input type="text" size='10' name="custottotal" id="custottotal" value="#numberformat(custottotal,'_.__')#" readonly></td>
      </tr>
       <tr>
      <th colspan="100%" align="center"><div align="center">Hour Rate Allowance</div></th>

      </tr>
      
      <tr>
      <th>Allowance 1</th>
      <td>
      <input type="text" name="aw101desp" id="aw101desp" value="#aw101desp#">
      </td>
      <td colspan="2">
      <input type="text" size='5' name="selfallowancerate1" id="selfallowancerate1" value="#selfallowancerate1#"  onKeyUp="calselfallow();"> Rate&nbsp;&nbsp;&nbsp;<input type="text" size='5' name="selfallowancehour1" id="selfallowancehour1" value="#selfallowancehour1#" onKeyUp="calselfallow();"> Hrs</td>
      
      <td>
      <input type="text" size='5' name="custallowancerate1" id="custallowancerate1" value="#custallowancerate1#" onKeyUp="calcustallow();"> Rate      </td>
      <td><input type="text" size='5' name="custallowancehour1" id="custallowancehour1" value="#custallowancehour1#" onKeyUp="calcustallow();"> Hrs</td>

      <td></td>
      <td></td>
      </tr>
      <tr>
      <th>Allowance 2</th>
      <td>
      <input type="text" name="aw102desp" id="aw102desp" value="#aw102desp#">
      </td>
      <td colspan="2">
      <input type="text" size='5' name="selfallowancerate2"  id="selfallowancerate2"value="#selfallowancerate2#" onKeyUp="calselfallow();"> Rate&nbsp;&nbsp;&nbsp;<input type="text" size='5' name="selfallowancehour2" id="selfallowancehour2" value="#selfallowancehour2#" onKeyUp="calselfallow();"> Hrs</td>
  
      <td>
      <input type="text" size='5' name="custallowancerate2"  id="custallowancerate2" value="#custallowancerate2#" onKeyUp="calcustallow();"> Rate      </td>
      <td><input type="text" size='5' name="custallowancehour2" id="custallowancehour2" value="#custallowancehour2#" onKeyUp="calcustallow();"> Hrs</td>

      <td></td>
      <td></td>
      </tr>
      
      <tr>
      <th>Allowance 3</th>
      <td>
      <input type="text" name="aw103desp" id="aw103desp" value="#aw103desp#">
      </td>
      <td colspan="2">
      <input type="text" size='5' name="selfallowancerate3" id="selfallowancerate3" value="#selfallowancerate3#" onKeyUp="calselfallow();"> Rate&nbsp;&nbsp;&nbsp;<input type="text" size='5' name="selfallowancehour3" id="selfallowancehour3" value="#selfallowancehour3#" onKeyUp="calselfallow();"> Hrs</td>
      
      <td>
      <input type="text" size='5' name="custallowancerate3"  id="custallowancerate3" value="#custallowancerate3#" onKeyUp="calcustallow();"> Rate      </td>
      <td><input type="text" size='5' name="custallowancehour3" id="custallowancehour3" value="#custallowancehour3#" onKeyUp="calcustallow();"> Hrs</td>

      <td></td>
      <td></td>
      </tr>
      <tr>
      <th colspan="8"><div align="center">Allowance</div></th>
      </tr>
      <tr>
      <td colspan="4"></td>
      <td>Employee</td>
      <td>Employer</td>
      </tr>
      <tr>
      <th>Allowance 4</th>
      <td colspan="3">
      <input type="text" name="aw104desp" id="aw104desp" size="50" value="#aw104desp#">
      </td>
      <td><input type="text" size='10' name="selfallowancerate4"  id="selfallowancerate4" value="#selfallowancerate4#" onKeyUp="calselfallow();">
       </td>
      <td><input type="text" size='10' name="custallowancerate4" value="#custallowancerate4#" id="custallowancerate4" onKeyUp="calcustallow();"></td>
      </tr>
      <tr>
      <th>Allowance 5</th>
      <td colspan="3">
      <input type="text" name="aw105desp" id="aw105desp" size="50" value="#aw105desp#">
      </td>
      <td><input type="text" size='10' name="selfallowancerate5"  id="selfallowancerate5" value="#selfallowancerate5#" onKeyUp="calselfallow();">
       </td>
      <td><input type="text" size='10' name="custallowancerate5" value="#custallowancerate5#" id="custallowancerate5" onKeyUp="calcustallow();"></td>
      </tr>
      <tr>
      <th>Allowance 6</th>
      <td colspan="3">
      <input type="text" name="aw106desp" id="aw106desp" size="50" value="#aw106desp#">
      </td>
      <td><input type="text" size='10' name="selfallowancerate6"  id="selfallowancerate6" value="#selfallowancerate6#" onKeyUp="calselfallow();">
       </td>
      <td><input type="text" size='10' name="custallowancerate6" value="#custallowancerate6#" id="custallowancerate6" onKeyUp="calcustallow();"></td>
      </tr>
      <tr>
      <th colspan="6"><div align="right">Total Allowance</div>
      </th>
      <td><input type="text" size='10' name="selfallowance"  id="selfallowance" value="#numberformat(selfallowance,'_.__')#"></td>
      <td><input type="text" size='10' name="custallowance"  id="custallowance" value="#numberformat(custallowance,'_.__')#"></td>
      </tr>
      <tr>
       <tr>
      <th colspan="6"><div align="right">Back Pay / Over Pay</div>
      </th>
      <td>
      <input type="text" size='10' name="selfpayback" id="selfpayback" value="#selfpayback#" onKeyUp="calselftotal();"><!---  Rate  --->     </td>
      <td>
      <input type="text" size='10' name="custpayback"  id="custpayback" value="#custpayback#" onKeyUp="calcusttotal();"><!---  Rate   --->    </td>
      </tr>
      <tr>
      <th colspan="6"><div align="right">CPF</div><!--- <div align="right"><input type="button" name="followcpf" id="followcpf" value="Calculate CPF" onClick="getemployeecpf();setTimeout('calselftotal()',500);setTimeout('calcusttotal()',500);"></div> ---><div id="getcpfajax"></div><div id="getbasicajax"></div></th>
      
      <td><input type="text" size='10' name="selfcpf" id="selfcpf" value="#numberformat(selfcpf,'_.__')#" onKeyUp="calselftotal();"></td>
      <td><input type="text" size='10' name="custcpf" id="custcpf" value="#numberformat(custcpf,'_.__')#" onKeyUp="calcusttotal();"></td>
      </tr>
      <tr>
      <th colspan="6"><div align="right">SDF</div><div align="right"><!--- <input type="button" name="countsdf" id="countsdf" value="Calculate SDF" onClick="calculatesdf();setTimeout('calselftotal()',500);setTimeout('calcusttotal()',500);"> ---></div></th>
      <td><input type="hidden" size='10' name="selfsdf" id="selfsdf" value="#numberformat(selfsdf,'_.__')#" onKeyUp="calselftotal();"></td>
      <td><input type="text" size='10' name="custsdf" id="custsdf" value="#numberformat(custsdf,'_.__')#" onKeyUp="calcusttotal();"></td>
      </tr>
      <tr>
      <th colspan="100%" align="center"><div align="center">Additional Charges</div></th>
      </tr>
      <tr>
      <th>Description</th>
      <td colspan="3"><input type="text" name="addchargedesp" id="addchargedesp" size="50" value="#addchargedesp#"></td>

       <td><input type="text" name="addchargeself" id="addchargeself" value="#numberformat(addchargeself,'_.__')#" onKeyUp="calselftotal();"  size='10'  ><input type="checkbox" name="claimadd1" id="claimadd1" value="1" <cfif claimadd1 eq "Y">checked</cfif>></td>
       <td><input type="text" name="addchargecust" id="addchargecust" value="#numberformat(addchargecust,'_.__')#" onKeyUp="calcusttotal();"  size='10'></td>
       <td colspan="2"></td>
      </tr>
       <tr>
      <th>Description 2</th>
      <td colspan="3"><input type="text" name="addchargedesp2" id="addchargedesp2" size="50" value="#addchargedesp2#"></td>

       <td><input type="text" name="addchargeself2" id="addchargeself2" value="#numberformat(addchargeself2,'_.__')#" onKeyUp="calselftotal();"  size='10'  ><input type="checkbox" name="claimadd2" id="claimadd2" value="2"<cfif claimadd2 eq "Y">checked</cfif>></td>
       <td><input type="text" name="addchargecust2" id="addchargecust2" value="#numberformat(addchargecust2,'_.__')#" onKeyUp="calcusttotal();"  size='10'></td>
       <td colspan="2"></td>
      </tr>
      
       <tr>
      <th>Description 3</th>
      <td colspan="3"><input type="text" name="addchargedesp3" id="addchargedesp3" size="50" value="#addchargedesp3#"></td>

       <td><input type="text" name="addchargeself3" id="addchargeself3" value="#numberformat(addchargeself3,'_.__')#" onKeyUp="calselftotal();"  size='10' ><input type="checkbox" name="claimadd3" id="claimadd3" value="3" <cfif claimadd3 eq "Y">checked</cfif>></td>
       <td><input type="text" name="addchargecust3" id="addchargecust3" value="#numberformat(addchargecust3,'_.__')#" onKeyUp="calcusttotal();"  size='10'></td>
       <td colspan="2"></td>
      </tr>
      
       <tr>
      <th>Description 4</th>
      <td colspan="3"><input type="text" name="addchargedesp4" id="addchargedesp4" size="50" value="#addchargedesp4#"></td>

       <td><input type="text" name="addchargeself4" id="addchargeself4" value="#numberformat(addchargeself4,'_.__')#" onKeyUp="calselftotal();"  size='10' ><input type="checkbox" name="claimadd4" id="claimadd4" value="4" <cfif claimadd4 eq "Y">checked</cfif>></td>
       <td><input type="text" name="addchargecust4" id="addchargecust4" value="#numberformat(addchargecust4,'_.__')#" onKeyUp="calcusttotal();"  size='10'></td>
       <td colspan="2"></td>
      </tr>
      <tr>
      <th>Description 5</th>
      <td colspan="3"><input type="text" name="addchargedesp5" id="addchargedesp5" size="50" value="#addchargedesp5#"></td>

       <td><input type="text" name="addchargeself5" id="addchargeself5" value="#numberformat(addchargeself5,'_.__')#" onKeyUp="calselftotal();"  size='10' ><input type="checkbox" name="claimadd5" id="claimadd5" value="5" <cfif claimadd5 eq "Y">checked</cfif>></td>
       <td><input type="text" name="addchargecust5" id="addchargecust5" value="#numberformat(addchargecust5,'_.__')#" onKeyUp="calcusttotal();"  size='10'></td>
       <td colspan="2"></td>
      </tr>
       <tr>
      <th>Description 6</th>
      <td colspan="3"><input type="text" name="addchargedesp6" id="addchargedesp6" size="50" value="#addchargedesp6#"></td>

       <td><input type="text" name="addchargeself6" id="addchargeself6" value="#numberformat(addchargeself6,'_.__')#" onKeyUp="calselftotal();"  size='10' ><input type="checkbox" name="claimadd6" id="claimadd6" value="6" <cfif claimadd6 eq "Y">checked</cfif>></td>
       <td><input type="text" name="addchargecust6" id="addchargecust6" value="#numberformat(addchargecust6,'_.__')#" onKeyUp="calcusttotal();"  size='10'></td>
       <td colspan="2"></td>
      </tr>
       <tr>
      <th colspan="6"><div align="right">Total Addtional Charges</div></th>

       <td><input type="text" name="addchargeselftotal" id="addchargeselftotal" value="" onKeyUp="calselftotal();"  size='10'></td>
       <td><input type="text" name="addchargecusttotal" id="addchargecusttotal" value="" onKeyUp="calcusttotal();"  size='10'></td>
      </tr>
      <tr>
      <th colspan="6">
      <div align="right">
      Gross Pay
      </div>
      </th>
      <td><input type="text" size='10' name="selfnet" id="selfnet" value="#numberformat(selfnet,'_.__')#"></td>
      <td><input type="text" size='10' name="custnet" id="custnet" value="#numberformat(custnet,'_.__')#"></td>
      </tr>
      <tr>
      <th>NS Deduction</th>
      <td colspan="3"><input type="text" name="nsdeddesp" id="nsdeddesp" size="50" value="#nsdeddesp#"></td>
      <td><input type="text" name="nsded" id="nsded" value="#numberformat(nsded,'_.__')#" onKeyUp="dedcal();"  size='10' ></td>
      </tr>
      <tr>
      <th>Deduction 1</th>
      <td colspan="3"><input type="text" name="ded1desp" id="ded1desp" size="50" value="#ded1desp#"></td>
      <td><input type="text" name="ded1" id="ded1" value="#numberformat(ded1,'_.__')#" onKeyUp="dedcal();"  size='10' ></td>
      </tr>
      <tr>
      <th>Deduction 2</th>
      <td colspan="3"><input type="text" name="ded2desp" id="ded2desp" size="50" value="#ded2desp#"></td>
      <td><input type="text" name="ded2" id="ded2" value="#numberformat(ded2,'_.__')#" onKeyUp="dedcal();"  size='10' ></td>
      </tr>
      <tr>
      <th>Deduction 3</th>
      <td colspan="3"><input type="text" name="ded3desp" id="ded3desp" size="50" value="#ded3desp#"></td>
      <td><input type="text" name="ded3" id="ded3" value="#numberformat(ded3,'_.__')#" onKeyUp="dedcal();"  size='10' ></td>
      </tr>
      <tr>
      <th colspan="6">
      <div align="right">
      Total Deduction
      </div>
      </th>
<td><input type="text" size='10' name="selfdeduction" id="selfdeduction" value="#selfdeduction#" > </td>
      <td>
      <input type="text" size='10' name="custdeduction" id="custdeduction" value="#custdeduction#" onKeyUp="calcusttotal();">      </td>
      </tr>
      
      <tr style="display:none">
      <th>Back Pay</th>
      
      <th>Total Deduction<br><input type="button" name="followded" id="followded" value="Calc Deduction" onClick="getemployeeded();setTimeout('calselftotal()',500);setTimeout('calcusttotal()',500);"><div id="getdedajax"></div></th>
      
      
      <td></td>
      </tr>
      
      <tr>
      <th></th>
  <cfquery name="getTaxCode" datasource="#dts#">
  SELECT "" as code, "" as rate1
  union all
  SELECT code,rate1 FROM #target_taxtable#
  </cfquery>
  <td colspan="4"><input type="hidden" name="tran" id="tran" value="INV">   </td>
      
      <th><div align="right">Employee Net Pay Amount</div></th>
      <td><input type="text" size='10' name="selftotal" id="selftotal" value="#numberformat(selftotal,'_.__')#" onKeyUp="calselftotal();"></td>
      <td></td>
      
      </tr>
      <tr>
      <td>&nbsp;</td>
      <td></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <th>Tax</th>
      <td><cfselect name="taxcode" id="taxcode" bind="CFC:tax.getTaxQry('#dts#','#target_taxtable#',{tran})" value="code" display="code" onChange="setTimeout('caltax2()',500);" bindonload="yes"/>&nbsp;&nbsp;<cfinput type="text" name="taxper" id="taxper" value="0" size="3" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" onKeyUp="caltax2();" bindonload="yes"  /></td>
      <td>
  <cfinput type="text" name="taxamt" id="taxamt" value="0.00" size="10" onKeyUp="caltax2();" readonly/></td>
      </tr>
      <tr>
      <td>&nbsp;</td>
      <td></td>
      <td></td>
      <td>&nbsp;</td>
      <td></td>
      <th><div align="right">Customer Net Pay Amount</div></th>
      <td></td>
      <td><input type="text" size='10' name="custtotal" id="custtotal" value="#numberformat(custtotal,'_.__')#" onKeyUp="calcusttotal();"></td>
      </tr>
    </cfoutput> 
    <tr> 
      <td height="23"></td>
      <td colspan="4" align="right"><cfoutput> 
      <input type="button" name="calculateemppay" value="Calculate Employee Pay" <cfif posted eq "P">disabled</cfif> onClick="<cfif posted neq "P">checkpay()<cfelse>alert('This assignment has been posted!')</cfif>;">&nbsp;&nbsp;&nbsp;&nbsp;
          <input name="submit1" id="submit1" type="button" onClick="submitform();" value="  #button#  " <cfif url.type eq "create" or posted eq "P">disabled</cfif>>
          &nbsp;&nbsp;&nbsp;&nbsp;
          <input name="submit2" id="submit2" type="button" onClick="submitform2();"  value="#button# and Create New"<cfif url.type eq "create" or posted eq "P">disabled</cfif>>
        </cfoutput></td>
    </tr>
  </table>
</cfform>
<cfoutput>
<div id="paydata">
</div>
<div id="paycheck">
</div>
<div id="updateprocesspay">
</div>
</cfoutput>
</body>
</html>

<script type="text/javascript">
setTimeout('calselftotal();',2000);
setTimeout('calcusttotal();',2000);
setTimeout('caltax2();',2500);
<!--- setTimeout('caltax();',2500); --->

</script>
<cfwindow center="true" width="550" height="400" name="findplacement" refreshOnShow="true"
        title="Find Placement" initshow="false"
        source="findplacement.cfm?type=Placement" />
<cfwindow name="calempded" center="true" source="calempded.cfm?empno={empno}" modal="true" closable="true" width="800" height="500" refreshonshow="true" title="Calculate Deduction" />
<cfwindow name="Waiting" title="Calculating!" modal="true" closable="false" width="350" height="260" center="true" >
<p align="center">Processing, Please Wait!</p>
<p align="center"><img src="/images/loading.gif" name="Cash Sales" width="30" height="30"></p>
<br />
</cfwindow>