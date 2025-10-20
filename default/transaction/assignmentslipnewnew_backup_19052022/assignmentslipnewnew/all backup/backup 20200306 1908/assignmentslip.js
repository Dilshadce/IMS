
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
	var caladminurl = 'calculateadminfee.cfm?empno='+document.getElementById("empno").value+'&placement='+document.getElementById('placementno').value+'&emppaymenttype='+document.getElementById('emppaymenttype').value+'&custepf='+document.getElementById('custcpf').value+'&custsocso='+document.getElementById('custsdf').value+'&basicsalary='+document.getElementById('custsalary').value+'&epfpayin='+document.getElementById('epfpayin').value+'&socsopayin='+document.getElementById('socsopayin').value+'&additionalsocso='+document.getElementById('additionalsocso').value+'&additionalepf='+document.getElementById('additionalepf').value+'&nplamt='+document.getElementById('lvltotaler1').value;
	
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
		var ratetaken = document.getElementById('lvleerate'+i).value;
		if(hdtaken != '')
		{
			document.getElementById('lvltotalee'+i).value = (hdtaken * ratetaken + 0.000001).toFixed(2);
		}
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
		var ratetaken = document.getElementById('lvlerrate'+i).value;
		if(hdtaken != '')
		{
			document.getElementById('lvltotaler'+i).value = (hdtaken * ratetaken + 0.000001).toFixed(2);
		}
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
 
 function dateajaxfunction()
{
	getpanel(document.getElementById('placementno').value);
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


/*


                          _ooOoo_
                         o8888888o
                         88" . "88
                         (| -_- |)
                          O\ = /O
                      ____/`---'\____
                    .   ' \\| |// `.
                     / \\||| : |||// \
                  // _||||| -:- |||||- \
                     | | \\\ - /// | |
                   | \_| ''\---/'' | |
                    \ .-\__ `-` ___/-. /
                 ___`. .' /--.--\ `. . __
              ."" '< `.___\_<|>_/___.' >'"".
             | | : `- \`.;`\ _ /`;.`/ - ` : | |
               \ \ `-. \_ __\ /__ _/ .-` / /
       ======`-.____`-.___\_____/___.-`____.-'======
                          `=---='
         .............................................
                                                佛祖保佑             永无BUG


*/