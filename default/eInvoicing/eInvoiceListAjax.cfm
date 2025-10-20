<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "773,702,1097,706,965,1278">
<cfinclude template="/latest/words.cfm">
<cfsetting showdebugoutput="no">
<cfset gtSubmitedRecord = 0>
<cfif left(lcase(hcomid),4) eq "beps">
    <cfquery name="getalleinvoice" datasource="#dts#">
        SELECT refno 
        FROM assignmentslip 
        WHERE assignmenttype='einvoice'
        UNION ALL
        SELECT refno 
        FROM artran 
        WHERE left(refno,2) = "BE"
    </cfquery>
</cfif>

<cfquery name="getInvoice" datasource="#dts#">
    SELECT refno,custno,Frem0,wos_date,grand_bil,eInvoice_Submited,SUBMITED_ON 
    FROM ARTRAN 
    WHERE type = "INV" AND fperiod <> 99 AND (void = "" OR void IS NULL)
    <cfif isdefined('url.invfrom')>
        AND refno >= "#url.invfrom#"
    </cfif>
    <cfif isdefined('url.invto')>
        AND refno <= "#url.invto#"
    </cfif>
    <cfif isdefined('url.comfrom')>
        AND custno >= "#url.comfrom#"
    </cfif>
    <cfif isdefined('url.comto')>
        AND custno <= "#url.comto#"
    </cfif>
    <cfif isdefined('url.periodfrom')>
        AND fperiod >= #url.periodfrom#
    </cfif>
    <cfif isdefined('url.periodto')>
        AND fperiod <= #url.periodto#
    </cfif>
    <cfif isdefined('url.userfrom')>
        AND created_by >= "#url.userfrom#"
    </cfif>
    <cfif isdefined('url.userto')>
        AND created_by <= "#url.userto#"
    </cfif>
    <cfif isdefined('url.datefrom')>
        <cfinvoke component="cfc.Date" method="getDbDate" inputDate="#url.datefrom#" returnvariable="nDateCreate"/>
        AND wos_date >= "#nDateCreate#"
    </cfif>
    <cfif isdefined('url.dateto')>
        <cfinvoke component="cfc.Date" method="getDbDate" inputDate="#url.dateto#" returnvariable="nDateCreate"/>
        AND wos_date <= "#nDateCreate#"
    </cfif>
    <cfif isdefined('url.showsubmited') eq false>
        AND (eInvoice_Submited IS NULL OR eInvoice_Submited = "")
    </cfif>
    <cfif isdefined('url.excludegeneratedinvoice')>
        AND (eInvoice_generated IS NULL OR eInvoice_generated = "")
    </cfif>
    <cfif left(lcase(hcomid),4) eq "beps">
        AND refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getalleinvoice.refno)#" list="yes" separator=",">)
    </cfif>
    ORDER BY custno, refno
</cfquery>
<cfoutput>
<form name="einvoice" action="/default/eInvoicing/eInvoiceProcess.cfm" method="post">
    <table width="80%" border="0" class="data" align="center">
        <tr>
            <th>Submit Date:</th>
             <td colspan="3"><input type="text" readonly name="submitdate" id="submitdate" maxlength="10" size="10" value="#dateformat(now(),'dd/mm/yyyy')#">&nbsp;
             <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(submitdate);">(DD/MM/YYYY)</td>
        </tr>
        <tr>
            <th>Hash:</th>
             <td colspan="3"><input type="text" name="hashcode" id="hashcode" maxlength="100" size="10"></td>
        </tr>
        <tr>
            <th width="100px">#words[773]#</th>
            <th width="150px">Company Name</th>
            <cfif left(dts,4) eq "beps">
                <th width="200px">Employe Name</th>
            </cfif> 
            <th width="100px">#words[702]#</th>
            <th width="100px">#words[1097]#</th>
            <th width="50px">#words[706]#</th>
            <th width="70px">#words[965]#&nbsp;&nbsp;&nbsp;&nbsp;<cfif getInvoice.recordcount neq 0><input type="checkbox" name="checkall" id="checkall" onClick="checkalllist(document.einvoice.einvoicelist)" value="uncheckall" checked ></cfif></th>
        </tr>
        <cfloop query="getInvoice">
            <tr  <cfif getInvoice.eInvoice_Submited eq "Y">style="background-color:##FF0000"</cfif>>
                <td>#getInvoice.refno#</td>
                <td>#getInvoice.custno#-#getInvoice.Frem0#</td>
                <cfif left(dts,4) eq "beps">
                    <cfquery name="getempname" datasource="#dts#">
                        SELECT empname 
                        FROM assignmentslip 
                        WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getInvoice.refno#">
                    </cfquery>
                    <td>#getempname.empname#</td>
                </cfif>
                <td>#dateformat(getInvoice.wos_date,'YYYY-MM-DD')#</td>
                <td align="right">#numberformat(getInvoice.grand_bil,'.__')#</td>
                <td>#getInvoice.eInvoice_Submited#</td>
                <td align="right"><input type="checkbox" name="einvoicelist" id="einvoicelist" value="#getInvoice.refno#" checked ></td>
            </tr>
        </cfloop>
        <tr>
            <td colspan="6" align="center">
            <cfif getInvoice.recordcount neq 0>
                <input type="submit" value="#words[1278]#" >
            </cfif>
            </td>
        </tr>
    </table>
</form>
</cfoutput>