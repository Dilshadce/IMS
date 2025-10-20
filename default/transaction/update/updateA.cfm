<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy from dealer_menu limit 1
</cfquery>

<script type="text/javascript">

function checkall()
{
alert('1')

}


<cfif lcase(hcomid) eq "lkabb_i" or lcase(hcomid) eq "lkabp_i" or lcase(hcomid) eq "lkab_i" <!---or lcase(hcomid) eq "lkatlb_i"--->
				or lcase(hcomid) eq "lkatbh_i" or lcase(hcomid) eq "svcmm_i" or lcase(hcomid) eq "svcnvn_i" or lcase(hcomid) eq "svctm_i"
				or lcase(hcomid) eq "svcyr_i" or lcase(hcomid) eq "svcdm_i" or lcase(hcomid) eq "svcbd_i" or lcase(hcomid) eq "21bl_i"
				or lcase(hcomid) eq "21cmw_i" or lcase(hcomid) eq "jvtpy_i" or lcase(hcomid) eq "jvsbw_i" or lcase(hcomid) eq "stbrd_i"
				or lcase(hcomid) eq "stpylb_i" or lcase(hcomid) eq "stfsrg_i" or lcase(hcomid) eq "stfsk_i" or lcase(hcomid) eq "ftmps_i"
				or lcase(hcomid) eq "lkabt_i" or lcase(hcomid) eq "lkatb_i" or lcase(hcomid) eq "lkatl_i" or lcase(hcomid) eq "shell_i"
				or lcase(hcomid) eq "fttk_i" or lcase(hcomid) eq "svcnc_i" or lcase(hcomid) eq "autoserv_i">

function validate()
{
var ckbx_arr=document.getElementsByName('checkbox'); 
var ckbx_arr_ln=ckbx_arr.length;
var checkrefno=0;

for(var i=0;i<ckbx_arr_ln;i++){ 
if(ckbx_arr[i].checked == true)
{  
checkrefno = checkrefno+1
} 
}
if(checkrefno == 1)
{  
return true;
} 

alert("Please Check one check box only");
return false;
}

<cfelse>
function validate()
{
var ckbx_arr=document.getElementsByName('checkbox'); 
var ckbx_arr_ln=ckbx_arr.length;

for(var i=0;i<ckbx_arr_ln;i++){ 
if(ckbx_arr[i].checked == true)
{  
return true;
} 
}
alert("Please Check At Least One Check Box");
return false;
}

</cfif>

</script>
</head>

<cfparam name="fulfill" default="">


<cfquery name="getgsetup2" datasource='#dts#'>
  	Select * from gsetup2
</cfquery>
<cfquery name="getgsetup" datasource='#dts#'>
  	Select * from gsetup
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = ".">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<body>

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>

<!--- t1: Transaction From; t2: Transaction To --->
<!--- t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV --->
<cfif url.t2 eq "INV">
	<h1>Update to <cfoutput>#gettranname.lINV#</cfoutput></h1>

	<cfif url.t1 eq "DO">
		<cfset type = gettranname.lDO>
	<cfelseif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	<cfelseif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	<cfelseif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
	</cfif>

	<cfif isdefined("form.invset")>
		<cfset trancode = form.invset>

		<cfif form.invset eq "invno">
			<cfset tranarun = "invarun">
		<cfelseif form.invset eq "invno_2">
			<cfset tranarun = "invarun_2">
		<cfelseif form.invset eq "invno_3">
			<cfset tranarun = "invarun_3">
		<cfelseif form.invset eq "invno_4">
			<cfset tranarun = "invarun_4">
		<cfelseif form.invset eq "invno_5">
			<cfset tranarun = "invarun_5">
		<cfelseif form.invset eq "invno_6">
			<cfset tranarun = "invarun_6">
		</cfif>
	<cfelse>
		<cfset trancode = "invno">
		<cfset tranarun = "invarun">
	</cfif>
<!--- t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO --->
<cfelseif url.t2 eq "DO">
	<h1>Update to <cfoutput>#gettranname.lDO#</cfoutput></h1>

	<cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
		
	<!--- ADD ON 130608, TITLE FOR EXPORT FROM PO TO DO --->
	<cfelseif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
		
	<cfelseif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	</cfif>
    
    <cfif url.t1 eq "SAM">
		<cfset type = gettranname.lSAM>
	</cfif>

	<cfset trancode = "dono">
	<cfset tranarun = "doarun">
<!--- t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC --->
<cfelseif url.t2 eq "RC">
	<h1>Update to <cfoutput>#gettranname.lRC#</cfoutput></h1>

	<cfif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
	</cfif>
    
    <cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>

	<cfset trancode = "rcno">
	<cfset tranarun = "rcarun">
<!--- t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ --->
<cfelseif url.t2 eq "RQ">
	<h1>Update to <cfoutput>#gettranname.lRQ#</cfoutput></h1>
    
    <cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>

	<cfset trancode = "rqno">
	<cfset tranarun = "rqarun">
<!--- t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO --->
<cfelseif url.t2 eq "po">
	<h1>Update to <cfoutput>#gettranname.lPO#</cfoutput></h1>

	<cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	<cfelseif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
    <cfelseif url.t1 eq "RQ">
		<cfset type = gettranname.lRQ>
	</cfif>

	<cfset trancode = "pono">
	<cfset tranarun = "poarun">
<!--- t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO --->
<cfelseif url.t2 eq "SO">
	<h1>Update to <cfoutput>#gettranname.lSO#</cfoutput></h1>

	<cfif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	</cfif>
    
    <cfif url.t1 eq "SAM">
		<cfset type = gettranname.lSAM>
	</cfif>

	<cfset trancode = "sono">
	<cfset tranarun = "soarun">
<!--- t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS --->
<cfelseif url.t2 eq "CS">
	<h1>Update to <cfoutput>#gettranname.lCS#</cfoutput></h1>

	<cfif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	</cfif>
    
    <cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>

	<cfset trancode = "csno">
	<cfset tranarun = "csarun">
<cfelseif url.t2 eq "QUO">
<h1>Update to <cfoutput>#gettranname.lQUO#</cfoutput></h1>

	<cfif url.t1 eq "SAMM">
		<cfset type = "Sales Order">
	</cfif>

	<cfset trancode = "quono">
	<cfset tranarun = "quoarun">
</cfif>

<!--- REMARK ON 230608 AND REPLACE WITH THE BELOW ONE --->
<!---cfquery datasource="#dts#" name="getGeneralInfo">
	Select #trancode# as tranno, #tranarun# as arun from GSetup
</cfquery--->

<cfif isdefined("form.invset")>
	<!--- <cfquery datasource="main" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where userDept = '#dts#'
		and type = '#t2#'
		and counter = '#invset#'
	</cfquery> --->
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = '#t2#'
		and counter = '#invset#'
	</cfquery>
	<cfset counter = invset>
<cfelse>
	
	<!--- <cfquery datasource="main" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where userDept = '#dts#'
		and type = '#t2#'
		and counter = 1
	</cfquery> --->
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = '#t2#'
		and counter = 1
	</cfquery>
	
	<cfset invset = 1>
	<cfset counter = 1>
</cfif>

<cfoutput>
<cfif url.t2 eq "DO">
	<cfif url.t1 eq "PO">
		<form action="updateA.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#" method="post">
			<h1>Search Refno: 
				&nbsp;&nbsp;From&nbsp;&nbsp;<input type="text" name="refnofr" value="">
				&nbsp;&nbsp;To&nbsp;&nbsp;<input type="text" name="refnoto" value="">
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="Search" value="Search">
			</h1>
		</form>
	</cfif>
</cfif>
</cfoutput>

<br><br>It will display all transactions in the select <cfoutput>#type#</cfoutput>.



<!--- The coding below provide updating of DO or SO to Invoice --->
<!--- t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV --->
<cfif url.t2 eq "INV">
	<!--- Coding here is for update to Invoice --->
	<!--- t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO --->
	<cfif url.t1 eq "DO">
	  	<!--- Get information on the outstanding unbill DO--->
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#trim(url.custno)#' and type = '#t1#' and toinv = ''  and (void = '' or void is null) order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>

	  	<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
	  		<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
			<p>Last Invoice No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

			<table class="data" align="center" width="50%">
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>
              		<th>Date</th>
              		<th>Customer No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            <cfquery name="checkdoitem" datasource="#dts#">
            	select refno from ictran where type="#getupdate.type#" and refno="#getupdate.refno#"
            </cfquery>
            <cfif checkdoitem.recordcount neq 0>
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
            	</tr>
            </cfif>
		  	</cfoutput>

		  	<cfif getgeneralinfo.arun neq 1>
		    	<tr>
			  		<th colspan="2">Next Refno</th>
			  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
		  	</cfif>
		  	<!--- <tr><td colspan="100%"><hr></td></tr> --->
		  	<tr>
			  	<th>Date</th>
			  	<td colspan="4">
				  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
					<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
				</td>
			</tr>
			<tr>
            	<td colspan="5">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
		  	    	<input type="reset" name="Submit2" value="Reset">
                	<input type="submit" name="Submit" value="Submit">
              		</div>
				</td>
          	</tr>
        </table>
	</cfform>
	<!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfelseif url.t1 eq "SO">

        <cfif getmodule.auto eq "1">
        <cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#trim(url.custno)#' and type = '#t1#' and toinv = ''  and (void = '' or void is null) <cfif lcase(hcomid) eq "ltm_i"> and (rem45='' or rem45 is null or rem45='A')</cfif> order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>

	  	<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
	  		<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
			<p>Last Invoice No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

			<table class="data" align="center" width="50%">
            	<tr>
              		<th>#type#</th>
                                        <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

              		<th>Date</th>
              		<th>Customer No</th>
                    <th>Car No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                                        <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
                    <td>#rem5#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfoutput>

		  	<cfif getgeneralinfo.arun neq 1>
		    	<tr>
			  		<th colspan="2">Next Refno</th>
			  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
		  	</cfif>
		  	<!--- <tr><td colspan="100%"><hr></td></tr> --->
		  	<tr>
			  	<th>Date</th>
			  	<td colspan="4">
				  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
					<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
				</td>
			</tr>
			<tr>
            	<td colspan="5">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
		  	    	<input type="reset" name="Submit2" value="Reset">
                	<input type="submit" name="Submit" value="Submit">
              		</div>
				</td>
          	</tr>
        </table>
	</cfform>
    	<cfelseif lcase(hcomid) eq "atc2005_i">
        <cfquery datasource="#dts#" name="getupdate">
			Select * from artran where rem5 = '#url.rem5#' and type = '#t1#' and toinv = ''  and (void = '' or void is null) order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>

	  	<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
	  		<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
			<p>Last Invoice No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

			<table class="data" align="center" width="50%">
            	<tr>
              		<th>#type#</th>
                                        <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

              		<th>Date</th>
              		<th>Customer No</th>
                    <th>Delivery Date</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                                        <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
                    <td>#rem5#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfoutput>

		  	<cfif getgeneralinfo.arun neq 1>
		    	<tr>
			  		<th colspan="2">Next Refno</th>
			  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
		  	</cfif>
		  	<!--- <tr><td colspan="100%"><hr></td></tr> --->
		  	<tr>
			  	<th>Date</th>
			  	<td colspan="4">
				  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(getupdate.wos_date,"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
					<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
				</td>
			</tr>
			<tr>
            	<td colspan="5">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
		  	    	<input type="reset" name="Submit2" value="Reset">
                	<input type="submit" name="Submit" value="Submit">
              		</div>
				</td>
          	</tr>
        </table>
	</cfform>
        
        <cfelse>
		<cfquery datasource="#dts#" name="getupdate">
			Select i.* from ictran i 
            left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
            where i.custno = '#trim(url.custno)#' and i.type = '#t1#' and (i.shipped+i.writeoff) < i.qty_bil and (i.void = '' or i.void is null)   group by i.refno order by a.<cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
		</cfquery>

		<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
			</cfoutput>
		  <p>Last Invoice No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

			<table class="data" align="center">
            <cfoutput>
				<tr>
					<th>#type#</th>
                                        <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

  					<th>Date</th>
					<th>Customer No</th>
					<th>To Bill</th>
					<!--- <th>Qty To Fulfill</th>  --->
					<th>User</th>
				</tr>
			</cfoutput>

			<cfoutput query="getupdate">
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td>#refno#</td>
                                        <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

					<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
					<td>#custno#</td>
				  <cfif trim(itemno) eq ''>
						<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
						<cfset xitemno = 'YHFTOKCF'>
					<cfelse>
						<cfset xitemno = itemno>
					</cfif>

					<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>

					<cfquery name="getid" datasource="#dts#">
						select userid from artran where refno = '#refno#' and type='#URLEncodedFormat(t1)#'
					</cfquery>
					<td>#getid.userid#</td>
				</tr>
			</cfoutput>
				<tr>
					<td colspan="3">
					<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit">
					</div>
					</td>
				</tr>
			</table>
		</cfform>
        </cfif>
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfelseif url.t1 eq "QUO">
		<cfquery datasource="#dts#" name="getupdate">
			Select * from ictran where custno = '#trim(url.custno)#' and type = '#t1#' and shipped < qty and (void = '' or void is null) group by refno order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
		</cfquery>

		<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>

			<p>Last Invoice No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

			<table class="data" align="center">
				<tr>
					<th>#type#</th>
                                        <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

					<th>Date</th>
					<th>Customer No</th>
					<th>To Bill</th>
					<th>User</th>
				</tr>
			</cfoutput>

			<cfoutput query="getupdate">
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td>#refno#</td>
                                        <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

					<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
					<td>#custno#</td>
					<cfif trim(#itemno#) eq ''>
						<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
						<cfset xitemno = 'YHFTOKCF'>
					<cfelse>
						<cfset xitemno = itemno>
					</cfif>
					<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>

					<cfquery name="getid" datasource="#dts#">
						select userid from artran where refno = '#refno#' and type='#URLEncodedFormat(t1)#'
					</cfquery>

					<td>#getid.userid#</td>
				</tr>
				</cfoutput>
		  		<tr>
            		<td colspan="3">
			  			<div align="right">
                        <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
                		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              			</div>
					</td>
          		</tr>
			</table>
		</cfform>
	<!--- t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO --->
	<cfelseif url.t1 eq "PO">

	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran  
			where custno = '#url.custno#' and type = '#t1#'
			and order_cl = '' and exported = ''  and (void = '' or void is null)
			order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>
	  	
	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
			  <input type="hidden" name="invset2" value="#invset#">
			</cfif>
        	<p>Last Invoice No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

			<table class="data" align="center">
            	<tr>
              		<th>#type#</th>
                                        <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

              		<th>Date</th>
              		<th>Supplier No</th>
              		<th>To Bill</th>
             	 	<th>User</th>
           	 	</tr>
          	</cfoutput>

		  	<cfoutput query="getupdate">
       	  <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                                        <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
			  		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
					<td>#userid#</td>
            	</tr>
          	</cfoutput>
		  	<tr>
            	<td colspan="3">
			  	<div align="right">
                <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
               	 	<input type="reset" name="Submit2" value="Reset">
                	<input type="submit" name="Submit" value="Submit">
              	</div>
				</td>
          	</tr>
        	</table>
	  	</cfform>
	</cfif>
<!--- t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO --->
<cfelseif url.t2 eq "DO">
	<!--- Coding here is for update to DO --->
	<cfif url.t1 eq "SO">
	  	<!--- <cfquery datasource="#dts#" name="getupdate">
			Select i.refno,date_format(i.wos_date,'%d/%m/%y') as wos_date,i.custno,
			if(i.itemno='',"YHFTOKCF",i.itemno) as itemno,a.userid from ictran i
			left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
			where i.custno = '#url.custno#' and i.type='#t1#' and shipped < qty 
			group by refno 
			order by refno
	  	</cfquery> --->
	  	
	  	<cfquery datasource="#dts#" name="getupdate">
			Select i.refno,date_format(i.wos_date,'%d/%m/%y') as wos_date,i.custno,a.desp,
			if(i.itemno='',"YHFTOKCF",i.itemno) as itemno,a.userid from ictran i
			left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
			where i.custno = '#url.custno#' and i.type='#t1#' and (shipped+writeoff) < qty_bil  and (i.void = '' or i.void is null) 
			group by refno 
			order by <cfif lcase(hcomid) eq "regismospl_i">wos_date ASC,refno ASC <cfelseif lcase(hcomid) eq "trisen_i">a.wos_date,a.trdatetime<cfelse><cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif></cfif>
	  	</cfquery>

	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Delivery Order No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        	<table class="data" align="center">
			<tr>
				<th>#type#</th>
                <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                <th>Description</th>
                </cfif>
				<th>Date</th>
				<th>Customer No</th>
				<th>To Bill</th>
				<th>User</th>
			</tr>
          	</cfoutput>

		  	<cfoutput query="getupdate">
		  		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    <cfset xitemno=itemno>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>
              		<td>#wos_date#</td>
              		<td>#custno#</td>
			  		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
					<td>#userid#</td>
          		</tr>
          	</cfoutput>
			<tr>
				<td colspan="3">
				<div align="right">
                <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
					<input type="reset" name="Submit2" value="Reset">
					<input type="submit" name="Submit" value="Submit">
				</div>
				</td>
			</tr>
        	</table>
		</cfform>
	<cfelseif url.t1 eq "QUO">
		<cfquery datasource="#dts#" name="getupdate">
			Select i.refno,date_format(i.wos_date,'%d/%m/%y') as wos_date,i.custno,a.desp,
			if(i.itemno='',"YHFTOKCF",i.itemno) as itemno,a.userid from ictran i
			left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
			where i.custno = '#url.custno#' and i.type='#t1#' and (shipped+writeoff) < qty_bil  and (i.void = '' or i.void is null)
			group by refno 
			order by <cfif lcase(hcomid) eq "regismospl_i">wos_date ASC,refno ASC <cfelse><cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif></cfif>
	  	</cfquery>
	  	
	  	<cfif getgsetup.quoChooseItem eq 1>
			<cfset updateurl = "update2.cfm">
        <cfelse>
        	<cfset updateurl = "update3.cfm">
        </cfif>

	  	<cfform action="#updateurl#?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Delivery Order No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        	<table class="data" align="center">
			<tr>
				<th>#type#</th>
                <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                <th>Description</th>
               </cfif>
				<th>Date</th>
				<th>Customer No</th>
				<th>To Bill</th>
				<th>User</th>
			</tr>
          	</cfoutput>

		  	<cfoutput query="getupdate">
		  		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    <cfset xitemno=itemno>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>
              		<td>#wos_date#</td>
              		<td>#custno#</td>
			  		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
					<td>#userid#</td>
          		</tr>
          	</cfoutput>
		  	<cfif getgsetup.quoChooseItem neq 1>
				<cfif getgeneralinfo.arun neq 1>
			  		<tr>
				  		<th colspan="2">Next Refno</th>
				  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
					</tr>
			  	</cfif>
				<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
			</cfif>
			<tr>
				<td colspan="3">
				<div align="right">
                <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
					<input type="reset" name="Submit2" value="Reset">
					<input type="submit" name="Submit" value="Submit">
				</div>
				</td>
			</tr>
        	</table>
		</cfform>
    <cfelseif url.t1 eq "SAM">
    <!--- ADDED ON 11/5/2011 FROM SAMPLE TO DO --->
		<cfquery datasource="#dts#" name="getupdate">
			Select i.refno,date_format(i.wos_date,'%d/%m/%y') as wos_date,i.custno,a.desp,
			if(i.itemno='',"YHFTOKCF",i.itemno) as itemno,a.userid from ictran i
			left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
			where i.custno = '#url.custno#' and i.type='#t1#' and (shipped+writeoff) < qty_bil  and (i.void = '' or i.void is null)
			group by refno 
			order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>
	  	
        <cfif lcase(hcomid) eq "asaiki_i">
        <cfset updateurl = "update2.cfm">
        <cfelse>
			<cfset updateurl = "update2.cfm">
        </cfif>

	  	<cfform action="#updateurl#?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Delivery Order No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        	<table class="data" align="center">
			<tr>
				<th>#type#</th>
                <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                 <th>Description</th>
                 </cfif>

				<th>Date</th>
				<th>Customer No</th>
				<th>To Bill</th>
				<th>User</th>
			</tr>
          	</cfoutput>

		  	<cfoutput query="getupdate">
		  		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    <cfset xitemno=itemno>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>
              		<td>#wos_date#</td>
              		<td>#custno#</td>
			  		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
					<td>#userid#</td>
          		</tr>
          	</cfoutput>
            <cfif lcase(hcomid) neq "asaiki_i">
		  	<cfif getgsetup.quoChooseItem neq 1>
				<cfif getgeneralinfo.arun neq 1>
			  		<tr>
				  		<th colspan="2">Next Refno</th>
				  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
					</tr>
			  	</cfif>
				<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
			</cfif>
            </cfif>
			<tr>
				<td colspan="3">
				<div align="right">
                <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
					<input type="reset" name="Submit2" value="Reset">
					<input type="submit" name="Submit" value="Submit">
				</div>
				</td>
			</tr>
        	</table>
		</cfform>
	<!--- ADD ON 130608, THE TRANSACTION FOR EXPORT FROM PO TO DO --->
	<cfelseif url.t1 eq "PO">
		<cfif isdefined("form.Search")>
			<cfquery datasource="#dts#" name="exactResult">
				Select i.refno,date_format(i.wos_date,'%d/%m/%y') as wos_date,i.custno,i.name,
				if(i.itemno='',"YHFTOKCF",i.itemno) as itemno,a.userid from ictran i
				left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
				where i.type='#t1#' and shipped < qty 
				and i.refno between '#form.refnofr#' and '#form.refnoto#' and (i.void = '' or i.void is null)
				group by refno 
				order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  		</cfquery>

			<h2>Result</h2>
			<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
            <cfset session.formName="updatepage">
			<cfoutput>
        	<p>Last Delivery Order No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        	<table class="data" align="center" width="60%">
			<tr>
				<th>#type#</th>
                <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                <th>Description</th>
                </cfif>

				<th>Date</th>
				<th>Supplier Name</th>
				<th>To Bill</th>
				<th>User</th>
			</tr>
          	</cfoutput>

		  	<cfoutput query="exactResult">
		  		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    <cfset xitemno=itemno>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#wos_date#</td>
              		<td>#custno# - #name#</td>
			  		<td align="center"><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
					<td align="center">#userid#</td>
          		</tr>
          	</cfoutput>
			<tr>
				<td colspan="3">
				<div align="center">
                <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
					<input type="reset" name="Submit2" value="Reset">
					<input type="submit" name="Submit" value="Submit">
				</div>
				</td>
			</tr>
        	</table>
			</cfform>
		<cfelse>
			<cfquery datasource="#dts#" name="getupdate">
				Select i.refno,date_format(i.wos_date,'%d/%m/%y') as wos_date,i.custno,i.name,
				if(i.itemno='',"YHFTOKCF",i.itemno) as itemno,a.userid from ictran i
				left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
				where i.type='#t1#' and shipped < qty  and (i.void = '' or i.void is null)
				group by refno 
				order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
				limit 50
	  		</cfquery>

	  		<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#" method="post" name="updatepage" onsubmit="return validate();">
            <cfset session.formName="updatepage">
				<cfoutput>
        		<p>Last Delivery Order No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        		<table class="data" align="center" width="60%">
				<tr>
					<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

					<th>Date</th>
					<th>Supplier Name</th>
					<th>To Bill</th>
					<th>User</th>
				</tr>
          		</cfoutput>

			  	<cfoutput query="getupdate">
		  			<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    	<cfset xitemno=itemno>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              			<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>
              			<td>#wos_date#</td>
              			<td>#custno# - #name#</td>
			  			<td align="center"><input type="checkbox" name="checkbox" id="checkbox" id="checkbox" value="#refno#;"></td>
						<td align="center">#userid#</td>
          			</tr>
          		</cfoutput>
				<tr>
					<td colspan="3">
					<div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit">
					</div>
					</td>
				</tr>
        		</table>
			</cfform>
		</cfif>
	</cfif>
<!--- t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC --->
<cfelseif url.t2 eq "RC">
	<!--- Coding here is for update to Purchase Order --->
	<cfif url.t1 eq "PO">
        <cfif getgsetup.poapproval eq 'Y'>
        <cfquery datasource="#dts#" name="getupdate">
			Select a.* from ictran as a left join (select printstatus,refno from artran where type='#t1#')as b on a.refno=b.refno where a.custno = '#trim(url.custno)#' and a.type = '#t1#' and (a.shipped+a.writeoff) < a.qty_bil and  b.printstatus = 'a3' and (a.void = '' or a.void is null)  group by a.refno order by a.refno desc
	  	</cfquery>
        <cfelse>
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from ictran where custno = '#url.custno#' and type = '#t1#' and (shipped+writeoff) < qty_bil and (void = '' or void is null)  group by refno order by refno desc
	  	</cfquery>
		</cfif>
	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Purchase Receive No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        	<table class="data" align="center">
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    <th>Job</th>
                    </cfif>
              		<th>Date</th>
              		<th>Supplier No</th>
                    <cfif lcase(hcomid) eq "colorinc_i">
                    <th>Amount</th>
                    <th>Foreign Amount</th>
                    </cfif>
              		<th>To Bill</th>
              		<th>User</th>
            	</tr>
          </cfoutput>

		  <cfoutput query="getupdate">
		  		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    <td>#source#</td>
                    </cfif>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
                    <cfif lcase(hcomid) eq "colorinc_i">
                    <cfquery datasource="#dts#" name="gettotalamt">
                    select grand,grand_bil from artran where type='#type#' and refno='#refno#'
					</cfquery>
                    <td>#numberformat(gettotalamt.grand,',_.__')#</td>
                    <td>#numberformat(gettotalamt.grand_bil,',_.__')#</td>
                    </cfif>
              		<cfif trim(itemno) eq ''>
			    		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    		<cfset xitemno = 'YHFTOKCF'>
			  		<cfelse>
			    		<cfset xitemno = itemno>
			  		</cfif>

			  		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
              		<!---<cfquery name="getid" datasource="#dts#">
                		select userid from artran where refno = '#refno#'
              		</cfquery>--->

					<td>#getupdate.userid#</td>
            	</tr>
			</cfoutput>
		  		<tr>
            		<td colspan="3">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
                		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
	  	</cfform>
	</cfif>
    <!---T1 = SO --->
    <cfif url.t1 eq "SO">
	  	<cfquery datasource="#dts#" name="getupdate">
			Select b.* from artran a, ictran b where a.refno = b.refno and a.type = b.type and a.custno = '#url.custno#' and a.type = '#t1#'
			and a.exported = '' and b.exported = '' <cfif getgsetup.updatetopo neq 'Y'>and a.order_cl = '' and b.toinv = ''</cfif><cfif hcomid eq "asiasoft_i" and url.t1 eq "SO"> and printstatus = "a3"</cfif>  and (b.void = '' or b.void is null) group by a.refno order by a.<cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>

	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Purchase Order No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>
			<br>
            Update Material<input type="checkbox" name="updatemat" id="updatemat" value="1" onClick="if(document.getElementById('updatemat').checked == true){ajaxFunction(document.getElementById('matajax'),'updateAmatajax.cfm?updatemat=1&custno=#url.custno#&t1=#t1#');}else{ajaxFunction(document.getElementById('matajax'),'updateAmatajax.cfm?updatemat=0&custno=#url.custno#&t1=#t1#');}">
            <div id="matajax">
			<table class="data" align="center">
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

              		<th>Date</th>
              		<th>Customer No</th>
              		<th>To Bill</th>
             	 	<th>User</th>
           	 	</tr>
          	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<cfif trim(itemno) eq ''>
			    		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    		<cfset xitemno = 'YHFTOKCF'>
			  		<cfelse>
			    		<cfset xitemno = itemno>
			  		</cfif>

			  		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
              		<cfquery name="getid" datasource="#dts#">
                		select userid from artran where refno = '#refno#' and type='#URLEncodedFormat(t1)#'
              		</cfquery>

					<td>#getid.userid#</td>
            	</tr>
          </cfoutput>
		  		<tr>
            		<td colspan="3">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
               	 		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
            </div>
	  	</cfform>
	</cfif>
    
<!--- t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ --->
<cfelseif url.t2 eq "RQ">
    <!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
    <cfif url.t1 eq "SO">
	  	<cfquery datasource="#dts#" name="getupdate">
			Select b.* from artran a, ictran b where a.refno = b.refno and a.type = b.type and a.custno = '#trim(url.custno)#' and a.type = '#t1#'
			and a.exported = '' and b.exported = '' <cfif getgsetup.updatetopo neq 'Y'>and a.order_cl = '' and b.toinv = ''</cfif><cfif hcomid eq "asiasoft_i" and url.t1 eq "SO"> and printstatus = "a3"</cfif>  and (b.void = '' or b.void is null) group by a.refno order by a.<cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>

	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Purchase Requisition No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>
			<br>
            Update Material<input type="checkbox" name="updatemat" id="updatemat" value="1" onClick="if(document.getElementById('updatemat').checked == true){ajaxFunction(document.getElementById('matajax'),'updateAmatajax.cfm?updatemat=1&custno=#url.custno#&t1=#t1#');}else{ajaxFunction(document.getElementById('matajax'),'updateAmatajax.cfm?updatemat=0&custno=#url.custno#&t1=#t1#');}">
            <div id="matajax">
			<table class="data" align="center">
            <tr>
            <td>Remarks</td>
            <td colspan="100%"><input type="text" name="remarks" id="remarks" maxlength="80"></td>
            </tr>
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

              		<th>Date</th>
              		<th>Customer No</th>
              		<th>To Bill</th>
             	 	<th>User</th>
           	 	</tr>
          	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<cfif trim(itemno) eq ''>
			    		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    		<cfset xitemno = 'YHFTOKCF'>
			  		<cfelse>
			    		<cfset xitemno = itemno>
			  		</cfif>

			  		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
              		<cfquery name="getid" datasource="#dts#">
                		select userid from artran where refno = '#refno#' and type='#URLEncodedFormat(t1)#'
              		</cfquery>

					<td>#getid.userid#</td>
            	</tr>
          </cfoutput>
		  		<tr>
            		<td colspan="3">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
               	 		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
            </div>
	  	</cfform>
	</cfif>
<!--- t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO --->
<cfelseif url.t2 eq "PO">
	<!--- Coding here is for update to PO --->
	<cfif url.t1 eq "SO" or url.t1 eq "QUO">
	  	<cfquery datasource="#dts#" name="getupdate">
			Select b.* from artran a, ictran b where a.refno = b.refno and a.type = b.type and a.custno = '#trim(url.custno)#' and a.type = '#t1#'
			and a.exported = '' and b.exported = '' <cfif getgsetup.updatetopo neq 'Y'>and a.order_cl = '' and b.toinv = ''</cfif><cfif hcomid eq "asiasoft_i" and url.t1 eq "SO"> and printstatus = "a3"</cfif> and (b.void = '' or b.void is null) group by a.refno order by a.<cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>

	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Purchase Order No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>
			<br>
            Update Material<input type="checkbox" name="updatemat" id="updatemat" value="1" onClick="if(document.getElementById('updatemat').checked == true){ajaxFunction(document.getElementById('matajax'),'updateAmatajax.cfm?updatemat=1&custno=#url.custno#&t1=#t1#');}else{ajaxFunction(document.getElementById('matajax'),'updateAmatajax.cfm?updatemat=0&custno=#url.custno#&t1=#t1#');}">
            <div id="matajax">
			<table class="data" align="center">
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

              		<th>Date</th>
              		<th>Customer No</th>
              		<th>To Bill</th>
             	 	<th>User</th>
           	 	</tr>
          	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<cfif trim(itemno) eq ''>
			    		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    		<cfset xitemno = 'YHFTOKCF'>
			  		<cfelse>
			    		<cfset xitemno = itemno>
			  		</cfif>

			  		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
              		<cfquery name="getid" datasource="#dts#">
                		select userid from artran where refno = '#refno#' and type='#URLEncodedFormat(t1)#'
              		</cfquery>

					<td>#getid.userid#</td>
            	</tr>
          </cfoutput>
		  		<tr>
            		<td colspan="3">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
               	 		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
            </div>
	  	</cfform>
	</cfif>
    <cfif url.t1 eq "RQ">
		<cfif getgsetup.rqapproval eq 'Y'>
	  	<cfquery datasource="#dts#" name="getupdate">
			Select a.* from ictran as a left join (select printstatus,refno,type from artran where type = '#t1#' and toinv='' and (void = '' or void is null)) as b on a.refno=b.refno and a.type=b.type where <!---custno = '#url.custno#' and---> a.type = '#t1#' and a.toinv='' and (a.void = '' or a.void is null) and b.printstatus = "a3" group by a.refno order by <cfif getdealer_menu.transactionSortBy neq "">a.#getdealer_menu.transactionSortBy#<cfelse>a.refno</cfif>
	  	</cfquery>
        <cfelse>
        <cfquery datasource="#dts#" name="getupdate">
			Select * from ictran where <!---custno = '#url.custno#' and---> type = '#t1#' and toinv='' and (void = '' or void is null)  group by refno order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>
        </cfif>
		<!---</cfif>--->
	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Purchase Order No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        	<table class="data" align="center">
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>
              		<th>Date</th>
              		<th>Supplier No</th>
                    <cfif lcase(hcomid) eq "colorinc_i">
                    <th>Amount</th>
                    <th>Foreign Amount</th>
                    </cfif>
              		<th>To Bill</th>
              		<th>User</th>
            	</tr>
          </cfoutput>

		  <cfoutput query="getupdate">
		  		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#-#name#</td>
                   
                    <cfif lcase(hcomid) eq "colorinc_i">
                    <cfquery datasource="#dts#" name="gettotalamt">
                    select grand,grand_bil from artran where type='#type#' and refno='#refno#'
					</cfquery>
                    <td></td>
                    
                    <td>#numberformat(gettotalamt.grand,',_.__')#</td>
                    <td>#numberformat(gettotalamt.grand_bil,',_.__')#</td>
                    </cfif>
                     
              		<cfif trim(itemno) eq ''>
			    		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    		<cfset xitemno = 'YHFTOKCF'>
			  		<cfelse>
			    		<cfset xitemno = itemno>
			  		</cfif>

			  		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
              		<cfquery name="getid" datasource="#dts#">
                		select userid from artran where refno = '#refno#' and type='#URLEncodedFormat(t1)#'
              		</cfquery>

					<td>#getid.userid#</td>
            	</tr>
			</cfoutput>
		  		<tr>
            		<td colspan="3">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
                		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
	  	</cfform>
	</cfif>
    
<!--- t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO --->
<cfelseif url.t2 eq "SO">
	<cfif url.t1 eq "QUO" and lcase(HcomID) neq "steel_i">
	  	<!--- Get information on the outstanding unbill DO--->
        <cfif lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i">
        <cfquery datasource="#dts#" name="getupdate">
        Select * from artran where custno = '#url.custno#' and type = '#t1#' and order_cl = '' and (void = '' or void is null) and (permitno='' or permitno is null)
        union all
			Select a.* from artran as a left join (select id,accountno from #replace(dts,'_i','_c','all')#.lead)as b on a.permitno=b.id where (b.accountno!='' ) and a.custno = '#url.custno#' and a.type = '#t1#' and a.order_cl = '' and (a.void = '' or a.void is null) and a.permitno!='' order by <cfif lcase(hcomid) eq "regismospl_i">wos_date ASC,refno ASC <cfelse><cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif></cfif>
	  	</cfquery>
        <cfelse>
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#trim(url.custno)#' and type = '#t1#' and order_cl = '' and (void = '' or void is null) <cfif getgsetup.priceminctrlemail eq "1"> and (printstatus = 'a3' or printstatus="" or printstatus is null)</cfif> order by <cfif lcase(hcomid) eq "regismospl_i">wos_date ASC,refno ASC <cfelse><cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif></cfif>
	  	</cfquery>
        </cfif>
        <cfif getgsetup.quoChooseItem eq 1>
			<cfset updateurl = "update2.cfm">
        <cfelse>
        	<cfset updateurl = "update3.cfm">
        </cfif>
	  	<cfform action="#updateurl#?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
        	<p>Last Sales Order No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        	<table class="data" align="center" width="50%">
            <cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
            <tr>
            <td>Remarks</td>
            <td colspan="100%"><input type="text" name="remarks" id="remarks" maxlength="80"></td>
            </tr>
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>
					<cfif lcase(hcomid) eq "bnbm_i" or lcase(hcomid) eq "bnbp_i">
					<th>Lead Account</th>
                    </cfif>
              		<th>Date</th>
              		<th>Customer No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>
					<cfif lcase(hcomid) eq "bnbm_i" or lcase(hcomid) eq "bnbp_i">
                    <cfquery name="getleadname" datasource="#dts#">
                    select * from #replace(dts,'_i','_c')#.lead where id='#permitno#'
                    </cfquery>
                    <td>#permitno# - #getleadname.leadname#</td>
                    </cfif>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfoutput>

		  	<cfif getgeneralinfo.arun neq 1>
		  		<tr>
			  		<th colspan="2">Next Refno</th>
			  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
				</tr>
		  	</cfif>
		  	<cfif getgsetup.quoChooseItem neq 1>
				<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
			</cfif>
				<tr>
            		<td colspan="5">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
		  	    		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
      	</cfform>
	<cfelseif url.t1 eq "QUO" and lcase(HcomID) eq "steel_i">
	  	<!--- Get information on the outstanding unbill DO--->
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#trim(url.custno)#' and type = '#t1#' and order_cl = '' and (void = '' or void is null) order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>

	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
        	<p>Last Sales Order No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        	<table class="data" align="center" width="50%">
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>
              		<th>Date</th>
              		<th>Customer No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfoutput>
				<tr>
            		<td colspan="5">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
		  	    		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
      	</cfform>
        
        <cfelseif url.t1 eq "SAM">
	  	<!--- Get information on the outstanding unbill DO--->
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#url.custno#' and type = '#t1#' and order_cl = '' and (void = '' or void is null) order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>
        <cfif getgsetup.quoChooseItem eq 1>
			<cfset updateurl = "update2.cfm">
        <cfelse>
        	<cfset updateurl = "update3.cfm">
        </cfif>
	  	<cfform action="#updateurl#?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
        	<p>Last Sales Order No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        	<table class="data" align="center" width="50%">
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

              		<th>Date</th>
              		<th>Customer No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfoutput>

		  	<cfif getgeneralinfo.arun neq 1>
		  		<tr>
			  		<th colspan="2">Next Refno</th>
			  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
				</tr>
		  	</cfif>
		  	<cfif getgsetup.quoChooseItem neq 1>
				<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
			</cfif>
				<tr>
            		<td colspan="5">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
		  	    		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
      	</cfform>
	</cfif>
    
    
	
    
<!--- t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS --->
<cfelseif url.t2 eq "CS">
	<cfif url.t1 eq "QUO">
	  	<!--- Get information on the outstanding unbill DO--->
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#url.custno#' and type = '#t1#' and generated = '' and toinv = '' and order_cl='' and (void = '' or void is null) order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>
        <cfif getgsetup.quoChooseItem eq 1>
			<cfset updateurl = "update2.cfm">
        <cfelse>
        	<cfset updateurl = "update3.cfm">
        </cfif>
	  	<cfform action="#updateurl#?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
        	<p>Last Cash Sales No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        	<table class="data" align="center" width="50%">
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

              		<th>Date</th>
              		<th>Customer No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfoutput>

		  	<cfif getgeneralinfo.arun neq 1>
		  		<tr>
			  		<th colspan="2">Next Refno</th>
			  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
				</tr>
		  	</cfif>
		  	<cfif getgsetup.quoChooseItem neq 1>
				<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
			</cfif>
				<tr>
            		<td colspan="5">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
		  	    		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
      	</cfform>
        
        <cfelseif url.t1 eq "SO">
	  	<!--- Get information on the outstanding unbill DO--->
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#trim(url.custno)#' and type = '#t1#' <!---and generated = ''---> and toinv = '' and order_cl='' and (void = '' or void is null) order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>
        <cfif getgsetup.quoChooseItem eq 1>
			<cfset updateurl = "update2.cfm">
        <cfelse>
        	<cfset updateurl = "update3.cfm">
        </cfif>
	  	<cfform action="#updateurl#?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
        	<p>Last Cash Sales No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>
		<h1>Search By :
		<select name="searchType">
                <option value="refno">Referece No</option>	
                <option value="wos_date">Date</option>				
		</select>
		Search : 
		<input type="text" name="searchStr" value="" onKeyUp="ajaxFunction(document.getElementById('updateAajax'),'/default/transaction/update/updateAajax.cfm?t1=#t1#&t2=#t2#&custno=#url.custno#&searchType='+escape(document.getElementById('searchType').value)+'&searchStr='+escape(document.getElementById('searchStr').value));">
		</h1>
        <div id="updateAajax">
        
        	<table class="data" align="center" width="50%">
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

              		<th>Date</th>
              		<th>Customer No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfoutput>

		  	<cfif getgeneralinfo.arun neq 1>
		  		<tr>
			  		<th colspan="2">Next Refno</th>
			  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
				</tr>
		  	</cfif>
		  	<cfif getgsetup.quoChooseItem neq 1>
				<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
			</cfif>
				<tr>
            		<td colspan="5">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
		  	    		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
        </div>
      	</cfform>
	</cfif>

<cfelseif url.t2 eq "Quo">
<cfif url.t1 eq "SAMM">
	  	<!--- Get information on the outstanding unbill DO--->
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#trim(url.custno)#' and type = '#t1#' and generated = '' and toinv = '' and order_cl='' and (void = '' or void is null) order by <cfif getdealer_menu.transactionSortBy neq "">#getdealer_menu.transactionSortBy#<cfelse>refno</cfif>
	  	</cfquery>
        <cfif getgsetup.quoChooseItem eq 1>
			<cfset updateurl = "update2.cfm">
        <cfelse>
        	<cfset updateurl = "update3.cfm">
        </cfif>
	  	<cfform action="#updateurl#?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
        	<p>Last Cash Sales No : <font size="2"><cfoutput>#getGeneralInfo.tranno#</cfoutput></font></p>

        	<table class="data" align="center" width="50%">
            	<tr>
              		<th>#type#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

              		<th>Date</th>
              		<th>Customer No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfoutput>

		  	<cfif getgeneralinfo.arun neq 1>
		  		<tr>
			  		<th colspan="2">Next Refno</th>
			  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
				</tr>
		  	</cfif>
		  	<cfif getgsetup.quoChooseItem neq 1>
				<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
			</cfif>
				<tr>
            		<td colspan="5">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
		  	    		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
      	</cfform>
	</cfif>
</cfif>
</body>
</html>