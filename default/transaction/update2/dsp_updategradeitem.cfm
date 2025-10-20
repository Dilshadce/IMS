<cfquery name="getgrade" datasource="#dts#">
	select a.* from icgroup a, icitem b
	where a.wos_group = b.wos_group
    and b.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
</cfquery>

<cfquery name="getfrigrade" datasource="#dts#">
	select * from igrade 
    where type = '#frtype#'
    and refno = <cfqueryparam cfsqltype="cf_sql_char" value="#frrefno#">
    and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
	and trancode = <cfqueryparam cfsqltype="cf_sql_char" value="#frtrancode#">
</cfquery>

<cfquery name="geticlink" datasource="#dts#">
	select * from iclink 
	where frrefno = <cfqueryparam cfsqltype="cf_sql_char" value="#frrefno#">
    and frtype = '#frtype#'
	and 
	<cfif lcase(hcomid) eq "steel_i" and frtype eq 'QUO'>
		(type = 'INV' or type = 'SO')
	<cfelse>
		<cfif totype eq 'INV' or totype eq 'DO'>
            (type = 'INV' or type = 'DO')
        <cfelse>
            type = '#totype#'
        </cfif> 
	</cfif>
	
	and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
	and frtrancode = '#frtrancode#'
</cfquery>

<cfset totcol = 3>
<cfset firstcount = 11>
<cfset maxcounter = 70>
<cfset totalrecord = (maxcounter - firstcount + 1)>
<cfset totrow = ceiling(totalrecord / totcol)>


<html>
<head>
	<title>Edit Item - Grade Opening Quantity</title>
	<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		<cfoutput>
			var frtrancode = #frtrancode#;
		</cfoutput>
		function AllowNumericCharacters() 
		{
			if((event.keyCode<=47 || event.keyCode>57 ))event.returnValue = false; 
		}
		
		function updateqty(){
			var totalrecord = document.itemform.totalrecord.value;
			
			var totqty = 0;
			
			varlist = document.itemform.varlist.value;
			bgrdlist = document.itemform.bgrdlist.value;
			var newArray = varlist.split(",");
			
			newlistvalue = "";
			for(i=0;i<newArray.length;i++){
				totqty = totqty + parseInt(document.getElementById(newArray[i]).value);
				if(i==0){
					newlistvalue = document.getElementById(newArray[i]).value;
				}
				else{
					newlistvalue = newlistvalue + "," + document.getElementById(newArray[i]).value;
				}
			}
			var frtype = document.itemform.frtype.value;
			var frrefno = document.itemform.frrefno.value;
			//alert('fulfill_'+frtype+'_'+frrefno+'_'+frtrancode);
			opener.document.getElementById('fulfill_'+frtype+'_'+frrefno+'_'+frtrancode).value = totqty;
			opener.document.getElementById('grdcolumnlist_'+frtype+'_'+frrefno+'_'+frtrancode).value =varlist;
			opener.document.getElementById('grdvaluelist_'+frtype+'_'+frrefno+'_'+frtrancode).value = newlistvalue;
			opener.document.getElementById('totalrecord_'+frtype+'_'+frrefno+'_'+frtrancode).value = totalrecord;
			opener.document.getElementById('bgrdcolumnlist_'+frtype+'_'+frrefno+'_'+frtrancode).value = bgrdlist;
			//alert();
			window.close();
		}
		
		function checkqty(thisqty,tofullfill){
			var qtytofullfill = parseInt(document.getElementById(tofullfill).value);
			if(parseInt(thisqty) > qtytofullfill){
				alert('Qty to Fullfill cannot more than ' + qtytofullfill + '!');
			}	
		}
	</script>
</head>
<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">
<body> 

<cfloop from="#firstcount#" to="#maxcounter#" index="i">
	<cfif i eq firstcount>
		<cfset mylist = i>
		<cfset varlist = "grd"&i>
		<cfset bgrdlist = "bgrd"&i>
	<cfelse>
		<cfset mylist = mylist&","&i>
		<cfset varlist = varlist&",grd"&i>
		<cfset bgrdlist = bgrdlist&",bgrd"&i>
	</cfif>	
</cfloop>

<cfset myArray = ListToArray(mylist,",")>
<form name="itemform">
<cfoutput>
	<input type="hidden" name="itemno" value="#convertquote(itemno)#">
	<input type="hidden" name="firstcount" value="#firstcount#">
	<input type="hidden" name="maxcounter" value="#maxcounter#">
	<input type="hidden" name="totalrecord" value="#totalrecord#">
	<input type="hidden" name="varlist" value="#varlist#">
	<input type="hidden" name="bgrdlist" value="#bgrdlist#">
    <input type="hidden" name="frtype" value="#frtype#">
    <input type="hidden" name="frrefno" value="#frrefno#">
</cfoutput>
<table border="0" align="center" width="100%" cellpadding="0" cellspacing="0">
	<cfloop from="1" to="#totrow#" index="i">
		<tr>
			<cfloop from="0" to="#totcol-1#" index="j">
				<cfset thisrecord = i+(j*totrow)>
				<cfif thisrecord LTE totalrecord>
					<cfoutput>
						<cfif Evaluate("getgrade.GRADD#myArray[thisrecord]#") neq "">
								
							<td width="12%">#Evaluate("getgrade.GRADD#myArray[thisrecord]#")#</td>
							<td width="23%">
                                <cfif getfrigrade.recordcount neq 0>
									<cfset thisqty = Evaluate("getfrigrade.GRD#myArray[thisrecord]#")>
									<cfif geticlink.recordcount neq 0>
										<cfloop query="geticlink">
											<cfquery name="getgeneratedqty" datasource="#dts#">
												select * from igrade
												where type='#geticlink.type#' and refno = '#geticlink.refno#' and trancode = '#geticlink.trancode#'
											</cfquery>
											<cfset thisqty = thisqty - val(Evaluate("getgeneratedqty.GRD#myArray[thisrecord]#"))>
										</cfloop>
									</cfif>
                                    <cfif val(getfrigrade.factor2) neq 0>
										<cfset thisqty = thisqty * val(getfrigrade.factor1) / val(getfrigrade.factor2)>
                                    <cfelse>
                                    	<cfset thisqty = 0>
									</cfif>
								<cfelse>
									<cfset thisqty = 0>
								</cfif>
                                <input type="text" value="#thisqty#" size="8" id="grd#myArray[thisrecord]#" name="grd#myArray[thisrecord]#" onBlur="if(this.value==''){this.value = '0'};checkqty(this.value,'qtytofulfill_grd#myArray[thisrecord]#');" onKeyPress="AllowNumericCharacters();">
								<input type="text" value="#thisqty#" size="8" id="qtytofulfill_grd#myArray[thisrecord]#" name="qtytofulfill_grd#myArray[thisrecord]#" readonly>
							</td>
						<cfelse>
							<td width="12%">&nbsp;</td>
							<td width="23%">&nbsp;</td>
							<input type="hidden" value="0" size="15" id="grd#myArray[thisrecord]#" name="grd#myArray[thisrecord]#">
						</cfif>
					</cfoutput>
				</cfif>
			</cfloop>
		</tr>
	</cfloop>
	<tr><td colspan="100%" align="center" height="10"></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="button" value="Ok" onClick="updateqty();">
		</td>
	</tr>
</table>
</form>
</body>
</html>