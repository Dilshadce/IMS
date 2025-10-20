<cfoutput>

<cfif isdefined('url.profileid')>
<cfquery name="getCFSEmpProfile" datasource="#dts#">
SELECT * FROM cfsempinprofile 
WHERE profileid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
</cfquery>

<cfquery name="getprofilelist" datasource="#dts#">
SELECT profilename,ratetype,payrate,billrate,adminfee FROM paybillprofile
WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
</cfquery>

<cfquery name="getemplist" datasource="#dts#">
SELECT id,icno,name,name2 FROM cfsemp
WHERE icno IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#valuelist(getCFSEmpProfile.icno)#">)
</cfquery>
</cfif>

<script type="text/javascript">
function calpaybill(qty,ratetype,payrate,billrate,adminfee,id){
	if (ratetype == "day")
	{
		var totalpay = Number(payrate)*Number(qty);
		var totalbill = Number(billrate)*Number(qty);
		if(adminfee.search('%') == 1){
			var admin = adminfee.replace('%','');
			var totaladmin = Number(totalbill)*(Number(admin)/100);
			document.getElementById('adminfeeamt'+id+'').value = totaladmin;
		}else{
			document.getElementById('adminfeeamt'+id+'').value = adminfee;
		}
		document.getElementById('totalpayamt'+id+'').value = totalpay;
		document.getElementById('totalbillamt'+id+'').value = totalbill;
	}else if(ratetype == "hour")
	{
		var totalpay = Number(payrate)*Number(qty);
		var totalbill = Number(billrate)*Number(qty);
		if(adminfee.search('%') == 1){
			var admin = adminfee.replace('%','');
			var totaladmin = Number(totalbill)*(Number(admin)/100);
			document.getElementById('adminfeeamt'+id+'').value = totaladmin;
		}else{
			document.getElementById('adminfeeamt'+id+'').value = adminfee;
		}
		document.getElementById('totalpayamt'+id+'').value = totalpay;
		document.getElementById('totalbillamt'+id+'').value = totalbill;
	}else
	{
		alert("Rate type empty");
	}
};

function recalc(miscamt,id,adminfee){
	var newpayamt = '0.00';
	if(adminfee.search('%') == 1){
			var admin = adminfee.replace('%','');
			var totalbill = document.getElementById('totalbillamt'+id+'').value;
			var totaladmin = Number(totalbill)*(Number(admin)/100);
			document.getElementById('adminfeeamt'+id+'').value = totaladmin;
	}	
	
	var payamt = document.getElementById('totalpayamt'+id+'').value;
	if(miscamt.search('-') == 1){
		var misc = miscamt.replace('-','');
		newpayamt = (Number(payamt)*1)-(Number(misc)*1);
	}else{
		newpayamt = (Number(payamt)*1)+(Number(miscamt)*1);
	}
	document.getElementById('totalpayamt'+id+'').value = Number(newpayamt);
};
</script>


<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid ##dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: ##dddddd;
}
</style>

<cfif isdefined('url.type') and isdefined('url.id')>

<cfquery name="gettran" datasource="#dts#">
SELECT * FROM geninvbankfile
WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
</cfquery>

<cfform action="/CFSpaybill/generateInvoiceBankfileprocess.cfm?type='edit&profileid=#url.profileid#" name="form">
<table>
	<tr>
        <th>Name</th>
        <th>IC No.</th>
        <th>Total #getprofilelist.ratetype# worked</th>
        <th>Misc</th>
        <th>Total Pay</th>
        <th>Total Bill</th>
        <th>Total Admin Fee</th>
    </tr>
	
    <cfif getemplist.recordcount eq 0> 
    	<tr>
            <td valign="top" colspan="100%" class="dataTables_empty">No data available in table</td>                    
        </tr>
    <cfelse>
    <cfloop query="getemplist">
    <tr>
        <td>#getemplist.name# #getemplist.name2#</td>
        <td>#getemplist.icno#</td>
        <td>
        	<input type="text" id="workdays#getemplist.id#"  name="workdays#getemplist.id#" value="0" onKeyUp="calpaybill(this.value,'#getprofilelist.ratetype#','#getprofilelist.payrate#','#getprofilelist.billrate#','#getprofilelist.adminfee#','#getemplist.id#')">            
        </td>
        <td>
        	<input type="text" id="miscrem1#getemplist.id#"  name="miscrem1#getemplist.id#" value="" placeholder="Remark 1">&nbsp;<input type="text" id="misc1#getemplist.id#"  name="misc1#getemplist.id#" value="0" onChange="recalc(this.value,'#getemplist.id#','#getprofilelist.adminfee#')"><br>          
        	<input type="text" id="miscrem2#getemplist.id#"  name="miscrem2#getemplist.id#" value=""  placeholder="Remark 2">&nbsp;<input type="text" id="misc2#getemplist.id#"  name="misc2#getemplist.id#" value="0" onChange="recalc(this.value,'#getemplist.id#','#getprofilelist.adminfee#')"><br>
        	<input type="text" id="miscrem3#getemplist.id#"  name="miscrem3#getemplist.id#" value="" placeholder="Remark 3">&nbsp;<input type="text" id="misc3#getemplist.id#"  name="misc3#getemplist.id#" value="0" onChange="recalc(this.value,'#getemplist.id#','#getprofilelist.adminfee#')"><br>
        	<input type="text" id="miscrem4#getemplist.id#"  name="miscrem4#getemplist.id#" value=""  placeholder="Remark 4">&nbsp;<input type="text" id="misc4#getemplist.id#"  name="misc4#getemplist.id#" value="0" onChange="recalc(this.value,'#getemplist.id#','#getprofilelist.adminfee#')"><br>
        	<input type="text" id="miscrem5#getemplist.id#"  name="miscrem5#getemplist.id#" value=""  placeholder="Remark 5">&nbsp;<input type="text" id="misc5#getemplist.id#"  name="misc5#getemplist.id#" value="0"  onChange="recalc(this.value,'#getemplist.id#','#getprofilelist.adminfee#')">       
        </td>
        <td>
        	<input type="text" id="totalpayamt#getemplist.id#"  name="totalpayamt#getemplist.id#" value="0" readonly><br>
            Pay rate: #getprofilelist.payrate#         
        </td>
        <td>
        	<input type="text" id="totalbillamt#getemplist.id#"  name="totalbillamt#getemplist.id#" value="0" readonly><br>
            Bill rate: #getprofilelist.billrate#            
        </td>
        <td>
        	<input type="text" id="adminfeeamt#getemplist.id#"  name="adminfeeamt#getemplist.id#" value="0" readonly><br>
            Admin Fee: #getprofilelist.adminfee#         
        </td>
    </tr>
    </cfloop>
    <tr>
        <td colspan="100%" style="text-align:right">
            <cfif getemplist.recordcount eq 0>
            
            <cfelse>
            <cfinput  type="submit" name="Submit" value=" Save " validate="submitonce"/>&nbsp;&nbsp;<cfinput  type="submit" name="Submit" value=" Generate Bankfile Now " validate="submitonce"/>
            
            </cfif>
        </td>
      </tr>
      </cfif>
</table>
</cfform>
<cfelse>
<cfform action="/CFSpaybill/generateInvoiceBankfileprocess.cfm?profileid=#url.profileid#" name="form">
<table>
	<tr>
        <th>Name</th>
        <th>IC No.</th>
        <th>Total #getprofilelist.ratetype# worked</th>
        <th>Misc</th>
        <th>Total Pay</th>
        <th>Total Bill</th>
        <th>Total Admin Fee</th>
    </tr>
	
    <cfif getemplist.recordcount eq 0> 
    	<tr>
            <td valign="top" colspan="100%" class="dataTables_empty">No data available in table</td>                    
        </tr>
    <cfelse>
    <cfloop query="getemplist">
    <tr>
        <td>#getemplist.name# #getemplist.name2#</td>
        <td>#getemplist.icno#</td>
        <td>
        	<input type="text" id="workdays#getemplist.id#"  name="workdays#getemplist.id#" value="0" onKeyUp="calpaybill(this.value,'#getprofilelist.ratetype#','#getprofilelist.payrate#','#getprofilelist.billrate#','#getprofilelist.adminfee#','#getemplist.id#')">            
        </td>
        <td>
        	<input type="text" id="miscrem1#getemplist.id#"  name="miscrem1#getemplist.id#" value="" placeholder="Remark 1">&nbsp;<input type="text" id="misc1#getemplist.id#"  name="misc1#getemplist.id#" value="0" onChange="recalc(this.value,'#getemplist.id#','#getprofilelist.adminfee#')"><br>          
        	<input type="text" id="miscrem2#getemplist.id#"  name="miscrem2#getemplist.id#" value=""  placeholder="Remark 2">&nbsp;<input type="text" id="misc2#getemplist.id#"  name="misc2#getemplist.id#" value="0" onChange="recalc(this.value,'#getemplist.id#','#getprofilelist.adminfee#')"><br>
        	<input type="text" id="miscrem3#getemplist.id#"  name="miscrem3#getemplist.id#" value="" placeholder="Remark 3">&nbsp;<input type="text" id="misc3#getemplist.id#"  name="misc3#getemplist.id#" value="0" onChange="recalc(this.value,'#getemplist.id#','#getprofilelist.adminfee#')"><br>
        	<input type="text" id="miscrem4#getemplist.id#"  name="miscrem4#getemplist.id#" value=""  placeholder="Remark 4">&nbsp;<input type="text" id="misc4#getemplist.id#"  name="misc4#getemplist.id#" value="0" onChange="recalc(this.value,'#getemplist.id#','#getprofilelist.adminfee#')"><br>
        	<input type="text" id="miscrem5#getemplist.id#"  name="miscrem5#getemplist.id#" value=""  placeholder="Remark 5">&nbsp;<input type="text" id="misc5#getemplist.id#"  name="misc5#getemplist.id#" value="0"  onChange="recalc(this.value,'#getemplist.id#','#getprofilelist.adminfee#')">       
        </td>
        <td>
        	<input type="text" id="totalpayamt#getemplist.id#"  name="totalpayamt#getemplist.id#" value="0" readonly><br>
            Pay rate: #getprofilelist.payrate#         
        </td>
        <td>
        	<input type="text" id="totalbillamt#getemplist.id#"  name="totalbillamt#getemplist.id#" value="0" readonly><br>
            Bill rate: #getprofilelist.billrate#            
        </td>
        <td>
        	<input type="text" id="adminfeeamt#getemplist.id#"  name="adminfeeamt#getemplist.id#" value="0" readonly><br>
            Admin Fee: #getprofilelist.adminfee#         
        </td>
    </tr>
    </cfloop>
    <tr>
        <td colspan="100%" style="text-align:right">
            <cfif getemplist.recordcount eq 0>
            
            <cfelse>
            <cfinput  type="submit" name="Submit" value=" Save " validate="submitonce"/>&nbsp;&nbsp;<cfinput  type="submit" name="Submit" value=" Generate Bankfile Now " validate="submitonce"/>
            
            </cfif>
        </td>
      </tr>
      </cfif>
</table>
</cfform>

</cfif>

</cfoutput>