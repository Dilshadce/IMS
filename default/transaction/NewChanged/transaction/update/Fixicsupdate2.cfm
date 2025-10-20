<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
</head>
<script type="text/javascript">
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
</script>

<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,poapproval,
	po_oneset,so_oneset, quo_oneset, assm_oneset, tr_oneset, oai_oneset, oar_oneset, sam_oneset,updatetopo,rem5
	from gsetup
</cfquery>

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>


<body>

	<h1>Update to Tickets</h1>
	
	<cfif url.t1 eq "DO">
		<cfset type = gettranname.lDO>
	<cfelseif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	<cfelseif url.t1 eq "INV">
		<cfset type = gettranname.lINV>
	</cfif>


<br>
This page will show all outstanding bills<br><hr>
	  	
	  	<cfform action="fixicsupdate2a.cfm?t1=#URLEncodedFormat(t1)#&refno=#url.refno#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">

			
			<table class="data" align="center">
				<cfoutput> 
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Supplier No</th>
					<th>Item No</th>
					<th>Item Description</th>
                   
					<th>Qty Order</th>
					<th>Qty Outstanding</th>		
                    	
          			<th>To Bill</th>
					<th>Unit Price</th>
            		<th>Total Value</th>				
        			<th>User</th>
				</tr>
				</cfoutput> 
				<cfquery datasource="#dts#" name="getupdate">
					Select * from ictran where refno = '#url.refno#' and type = '#t1#' <!---and (ticket = '' or ticket is null)---> and (toinv='' or toinv is null) order by refno
				</cfquery>
                
					<cfoutput query="getupdate">					
						<cfquery datasource="#dts#" name="getupqty">
							select sum(qty)as sumqty from iclink where frrefno = '#url.refno#' 
							and frtype = '#t1#' and type = 'TKT' and itemno = '#getupdate.itemno#' and frtrancode = '#getupdate.trancode#'
						</cfquery>
						
						<cfif getupqty.sumqty neq "">
							<cfset upqty = getupqty.sumqty>
						<cfelse>
							<cfset upqty = 0>
						</cfif>
					
						<cfif getupdate.recordcount gt 0>
							<cfset order = getupdate.qty>
						<cfelse>
							<cfset order = 0>
						</cfif>
					
						<cfset qtytoful = order - upqty>
						<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
							<td>#refno#</td>
							<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
							<td>#custno#</td>
							<td>#itemno#</td>
							<td nowrap>#desp#</td>
                         
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
							
							<input type="hidden" name="qtytoful" value="#qtytoful#">
							
							<cfif trim(itemno) eq ''>
								<cfset xitemno = 'YHFTOKCF'>
							<cfelse>
								<cfset xitemno = itemno>
							</cfif>
							
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							<td><div align="right">#numberformat(price,"__,___.__")#</div></td>
							<cfset amt=val(qtytoful)*val(price)>
							<td><div align="right">#numberformat(amt,"__,___.__")#</div></td>
							
							<cfquery name="getid" datasource="#dts#">
								select userid from artran where refno = '#refno#' and type = '#t1#' 
							</cfquery>
							
							<td>#getid.userid#</td>
						</tr>
					</cfoutput> 
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
             			<input type="submit" name="Submit" value="Submit"></div>
					</td>
          		</tr>
			</table>
		</cfform>

</body>
</html>