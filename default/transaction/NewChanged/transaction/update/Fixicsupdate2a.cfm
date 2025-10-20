<html><cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
</head>


<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,poapproval,
	po_oneset,so_oneset, quo_oneset, assm_oneset, tr_oneset, oai_oneset, oar_oneset, sam_oneset,updatetopo,rem5
	from gsetup
</cfquery>
<cfquery name="getlocation" datasource="#dts#">
SELECT "emptylocation" as location, "Choose a Location" as desp 
union all
SELECT location,concat(location,' - ',desp) as desp FROM iclocation
</cfquery>
<script type="text/javascript">
function showlocbal(itemno)
{
document.getElementById('locitemno').value = encodeURI(itemno);
ColdFusion.Window.show('showlocbal');
}
</script>

<cfquery name="check_compulsory_location_setting" datasource="#dts#">
	select 
	compulsory_location
	from transaction_menu;
</cfquery>
<cfset needlocation = "No">
<cfif check_compulsory_location_setting.compulsory_location eq "Y">
<cfset needlocation = "yes">
</cfif>

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>
<cfquery name="checklocation" datasource='#dts#'>
  	Select chooselocation from gsetup
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
	  	
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="Fixicsupdateprocess.cfm?t1=#URLEncodedFormat(t1)#&refno=#url.refno#" method="post" name="updatepage">
        <cfset session.formName="updatepage">
			<cfoutput>
				<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
			</cfoutput>
			<table class="data" align="center">
			<tr> 
				<th><cfoutput>#type#</cfoutput></th>
				<th>Date</th>
				<th>Supplier No</th>
				<th>Item No</th>
				<th>Item Description</th>
                    
				<th>Qty Order</th>
				<th>Qty Outstanding</th>
                       
				<th>Qty To Fulfill</th> 
               
				<th>User</th>
			</tr>
	
			<cfloop from="1" to="#cnt#" index="i" step="+3">
				<cfset xParam1 = listgetat(mylist,i,";")>
					
				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
					<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
					<cfset xParam2 = ''>
				<cfelse>
					<cfset xParam2 = listgetat(mylist,i+1,";")>
				</cfif>
					
				<cfset xParam3 = listgetat(mylist,i+2,";")>
	
				<cfquery datasource="#dts#" name="getupdate">
					Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and type = '#t1#'
				</cfquery> 
					 
				<cfoutput query="getupdate">				
					<cfquery datasource="#dts#" name="getupqty">
						select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
						and frtype = '#t1#' and (type = 'TKT') and itemno = '#getupdate.itemno#' 
						and frtrancode = '#getupdate.trancode#'
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
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						<!--- Add & modified on 041008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                            select * from igrade 
                            where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                            and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                        </cfquery>
                        <cfif getigrade.recordcount neq 0>
                            <cfset qtytoful = 0>
                        <cfelse>
                            <cfset qtytoful = qtytoful>
                        </cfif>
                        <input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
                        <input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                       
                        <td>
                            <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
                            <cfif getigrade.recordcount neq 0>
                                <input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','DO','#getupdate.trancode#');">
                            </cfif>
                        </td>
						
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'
						</cfquery>
						<td>#getid.userid#</td>
					</tr>
				</cfoutput> 
			</cfloop>
            
			<tr>             
				<td colspan="5"> <div align="right">
				<input type="reset" name="Submit2" value="Reset">
				<input type="submit" name="Submit" value="Submit">
						 
				 </div></td>
			</tr>
		</table>
		</cfform>

</body>
</html>