<cfoutput>
<cfset nametype = 'inv'>
<cfif left(hcomid,4) eq "beps">
<cfquery name="geteinv" datasource="#dts#">
SELECT refno FROM assignmentslip WHERE assignmenttype='einvoice'
UNION all
SELECT refno FROM artran WHERE left(refno,2) = "BE"
</cfquery>
</cfif>

	<cfquery name="getrefno" datasource="#dts#">
   		select refno as xrefno,fperiod,wos_date from artran where 0=0 and fperiod <> 99
and (void = "" or void is null)
<cfif left(hcomid,4) eq "beps">
and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(geteinv.refno)#" list="yes" separator=",">)
</cfif>
 limit 15
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="refno1" size="8" id="refno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'findbillAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&refno='+document.getElementById('refno1').value+'&fperiod='+document.getElementById('fperiod1').value+'&date='+document.getElementById('wos_date').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />&nbsp;PERIOD :&nbsp;<input type="text" name="fperiod1" id="fperiod1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'findbillAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&refno='+document.getElementById('refno1').value+'&fperiod='+document.getElementById('fperiod1').value+'&date='+document.getElementById('wos_date').value);" size="12" /><input type="hidden" name="wos_date" id="wos_date" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'findbillAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&refno='+document.getElementById('refno1').value+'&fperiod='+document.getElementById('fperiod1').value+'&date='+document.getElementById('wos_date').value);" size="12" />&nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField2" name="ajaxField2">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="400px">PERIOD</th>
    <th width="400px">DATE</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getrefno" >
    <tr>
    <td>#getrefno.xrefno#</td>
    <td>#getrefno.fperiod#</td>
    <td>#dateformat(getrefno.fperiod,'DD/MM/YYYY')#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getrefno.xrefno#','inv#url.fromto#');<cfif url.fromto eq "frm">selectlist('#getrefno.xrefno#','invto');</cfif>ColdFusion.Window.hide('findbill');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>