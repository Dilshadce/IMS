 <cfif left(hcomid,4) eq "beps">
 <cfquery name="geteinv" datasource="#dts#">
SELECT refno FROM assignmentslip WHERE assignmenttype='einvoice'
UNION all
SELECT refno FROM artran WHERE left(refno,2) = "BE"
</cfquery>
 </cfif>
 
  <cfquery name="getrefno" datasource="#dts#">
   		select refno as xrefno,desp from artran WHERE refno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.refno#%"> <cfif url.fperiod neq ''>and fperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.fperiod#"></cfif> and fperiod <> 99
and (void = "" or void is null)
<cfif left(hcomid,4) eq "beps">
and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(geteinv.refno)#" list="yes" separator=",">)
</cfif>
 order by refno limit 500
	</cfquery>

	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="300px">DESP</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getrefno" >
    
    <tr>
    <td>#getrefno.xrefno#</td>
    <td>#getrefno.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getrefno.xrefno#','inv#url.fromto#');<cfif url.fromto eq "frm">selectlist('#getrefno.xrefno#','invto');</cfif>ColdFusion.Window.hide('findbill');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>