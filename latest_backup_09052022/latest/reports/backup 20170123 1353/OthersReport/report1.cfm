<script type="text/javascript">
function validate()
{
var ckbx_arr_ln=document.getElementById('totalrecord').value;

for(var i=1;i<=ckbx_arr_ln;i++){
if (document.getElementById('list_'+i).checked == true)
{
return true;
} 
}

alert("Please Check At Least One Check Box");
return false;

}</script>	        
<cfif getpin2.h4G00 eq "T">
<script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;

</script>
</cfif>

<script type="text/javascript">
function checkedAll(){
        if (document.getElementById('CheckAll').checked == false)
		{
		
		for (var i = 1; i <= document.getElementById('totalrecord').value ; i++) {	
		
		document.getElementById('list_'+i).checked = false;
		}
		
		}
		else 
		{for (var i = 1; i <= document.getElementById('totalrecord').value ; i++) {	
		
		document.getElementById('list_'+i).checked = true;
		}
		}
	  }
</script>

<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfparam name="ndatefrom" default="">
<cfparam name="ndateto" default="">
<cfparam name="totalamt" default="0">
<cfparam name="totaldisc" default="0">
<cfparam name="totalnet" default="0">
<cfparam name="totaltax" default="0">
<cfparam name="totalgrand" default="0">
<cfparam name="totalfcamt" default="0">
<cfparam name="totaldeposit" default="0">
<cfparam name="totalbalance" default="0">
	
<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>

	<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>

	<cfif dd greater than '12'>
		<cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

<cfquery datasource="#dts#" name="gettran">
	select 
	a.*
	from artran as a 
	where 
	a.type='#form.billType#' 
	and (a.void='' or a.void is null)
	<cfif ndatefrom neq "" and ndateto neq "">
		and a.wos_date between '#ndatefrom#' and '#ndateto#'
	<cfelse>
		<cfif lcase(hcomid) neq "taftc_i">
		and a.wos_date > #getgeneral.lastaccyear#
    </cfif>
	</cfif>
	
	<cfif trim(form.refNoFrom) neq "" and trim(form.refNoTo) neq "">
		and a.refno between '#form.refNoFrom#' and '#form.refNoTo#'
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod between '#form.periodfrom#' and '#form.periodto#' 
	</cfif>
    <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
        <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
        <cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
        
	group by a.type,a.refno
    <cfif isdefined('form.cbdate')>
    order by a.wos_date
    <cfelse>
	order by a.refno
    </cfif>
    </cfquery>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",.">
		
		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

        <html>
		<head>
			<title>View Bill Listing Report</title>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
			<link href = "../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
			<style type="text/css" media="print">
				.noprint { display: none; }
			</style>
		</head>

		<body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>> 
        <form name="mail" action="bill_email.cfm" onSubmit="return validate()" method="post" >
		<table align="center" cellpadding="3" cellspacing="0" width="100%">
   
		<cfoutput>
             
			<tr>
				<td colspan="100%"><div align="center"><font size="3" face="Arial, Helvetica, sans-serif"><strong>#form.billType# Report</strong></font></div><input type="hidden" name="totalrecord" id="totalrecord" value="#gettran.recordcount#"><input type="hidden" name="trancode" id="trancode" value="#form.billType#"><input type="hidden" name="format" id="format" value="#form.format#"></td>
			</tr>
		  <cfif ndatefrom neq "" and ndateto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
		  <cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Period From #form.periodfrom# To #form.periodto#</font></div></td>
				</tr>
			</cfif>
        <cfif form.refNoFrom neq "" and form.refNoTo neq "">
	 <tr>
					<td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Ref From #form.refNoFrom# To #form.refNoTo#</font></div></td>
				</tr>
		</cfif>
			<tr>
				<td colspan="80%"><font size="1.5" face="Arial, Helvetica, sans-serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="20%"><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
		</cfoutput>
       
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
                <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>No</strong></font></div></td>
                <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Refno</strong></font></div></td>
				<td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Date</strong></font></div></td>
				<td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Cust No</strong></font></div></td>
				<td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Name</strong></font></div></td>
        		<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Grand Local</strong></font></div></td>
			  	<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Grand Foreign</strong></font></div></td>
               <td><div align="right">
   <input type="checkbox" name="CheckAll" id="CheckAll" value="Check All"
onClick="checkedAll()">
</div></td>
              </tr>  
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<cfset count=1>
		  <cfoutput query="gettran">
				<cfif currrate neq "">
					<cfset xcurrrate = currrate>
				<cfelse>
					<cfset xcurrrate = 1>
				</cfif>
		
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#count#</strong></font></div></td>
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#gettran.refno#</font></div></td>
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#dateformat(wos_date,"dd-mm-yy")#</font></div></td>
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#custno#</font></div></td>
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#name#</font></div></td>
					<cfif form.billType neq "TR">
						<cfset xamt = val(gettran.invgross)>
						<cfset xdisc = val(gettran.discount)>
                        <cfif gettran.taxincl eq 'T'>
                        <cfset xnet = val(gettran.net)-val(gettran.tax)>
                        <cfelse>
                        <cfset xnet = val(gettran.net)>
                        </cfif>
						<cfset xtax = val(gettran.tax)>
						<cfset xgrand = val(gettran.grand)>
						<cfset xcurrrate = val(gettran.currrate)>
					<cfelse>
						<cfset xamt = val(gettran.invgross) / 2>
						<cfset xdisc = val(gettran.discount) / 2>
                        <cfset xnet = val(gettran.net) / 2>
						<cfset xtax = val(gettran.tax) / 2>
						<cfset xgrand = val(gettran.grand) / 2>
						<cfset xcurrrate = val(gettran.currrate)>
					</cfif>	
					
					
					<td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(xgrand,",.__")#</font></div></td>
					
		
					<cfif xcurrrate eq "1">
                    
                    <cfif lcase(HcomID) eq "powernas_i">
                            <cfquery name="getictranqty4" datasource="#dts#">
                            select qty4 from ictran where refno='#gettran.refno#' and type='#gettran.type#'
                            </cfquery>
			    <cfif getictranqty4.recordcount neq 0>
			    <cfset xfcamt = val(gettran.grand_bil/getictranqty4.qty4)>
				<cfelse>
                            <cfset xfcamt = val(gettran.grand_bil)>
				</cfif>
                        <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">SGD #numberformat(xfcamt,stDecl_UPrice)#</font></div></td>
                            <cfelse>
						<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">-</font></div></td>
                        </cfif>
					<cfelse>
						<cfif gettran.grand_bil neq "">
							<cfif form.billType neq "TR">
                            <cfif lcase(HcomID) eq "powernas_i">
                            <cfquery name="getictranqty4" datasource="#dts#">
                            select qty4 from ictran where refno='#gettran.refno#' and type='#gettran.type#'
                            </cfquery>
			    <cfif getictranqty4.recordcount neq 0>
			    <cfset xfcamt = val(gettran.grand_bil/getictranqty4.qty4)>
				<cfelse>
                            <cfset xfcamt = val(gettran.grand_bil)>
				</cfif>

                            <cfelse>
								<cfset xfcamt = val(gettran.grand_bil)>
                            </cfif>
							<cfelse>
								<cfset xfcamt = val(gettran.grand_bil) / 2>
							</cfif>
                        
                 
                   
						</cfif>
						<td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#currcode# #numberformat(xfcamt,stDecl_UPrice)#</font></div></td>
						<cfset totalfcamt = totalfcamt + xfcamt>
					</cfif>
					<td><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">
						<cfif form.billType eq "CS" and lcase(Hcomid) eq "ovas_i">
							#agenno#
						<cfelse>
							#userid#
						</cfif>
						</font></div>
					</td>
                    <td>          
<input type="checkbox"  name="list_#count#" id="list_#count#" value="#refno#" />


                         </td>
                  
				</tr>
           
				<cfset totalamt = totalamt + numberformat(xamt,".__")>				
				<cfset totaldisc = totaldisc + numberformat(xdisc,".__")>
                <cfset totalnet = totalnet + numberformat(xnet,".__")>
                <cfif lcase(HcomID) neq "sdc_i">
				<cfset totaltax = totaltax + numberformat(xtax,".__")>
                </cfif>
				<cfset totalgrand = totalgrand + numberformat(xgrand,".__")>
                <cfset count=count+1>
			</cfoutput>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<cfoutput>
               
				<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Total:</strong></font></div></td>
				
				<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#numberformat(totalgrand,",.__")#</strong></font></div></td>
				</cfoutput>
			</tr>

            <tr>
 
           <td>
  


<input type="submit" name="submit" value="submit"  >
     
            
			</td></tr>
	 
		</table>
		</form>
		<br><br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
         
		</body>
		</html>