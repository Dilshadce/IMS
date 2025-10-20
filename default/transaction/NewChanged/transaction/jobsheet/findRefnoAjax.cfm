<cftry>
	<cfset invDate = dateformat(createDate(right(url.invoiceDate,4),mid(url.invoiceDate,4,2),left(url.invoiceDate,2)),'yyyy-mm-dd')>  
<cfcatch>
	<cfset invDate=url.invoiceDate>
</cfcatch>
</cftry>

<cftry>
	 <cfset endContractDate = dateformat(createDate(right(url.endContractDate,4),mid(url.endContractDate,4,2),left(url.endContractDate,2)),'yyyy-mm-dd')>
<cfcatch>
	 <cfset endContractDate=url.endContractDate>
</cfcatch>
</cftry>

<cfquery name="getcustsupp" datasource="#dts#">
   		SELECT * FROM artran
        WHERE type ='#url.type#' 
        AND refno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custno#%"> 
        AND (name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> OR custno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%">)
        AND rem5 LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.vehino#%"> 
        AND wos_date LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#invDate#%">
        AND DATE_ADD(wos_date, INTERVAL 12 MONTH) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#endContractDate#%">  
        ORDER BY refno limit 20
	</cfquery>

<cfoutput>
  <table width="680px">
    <tr>
      <th width="100px"><font style="text-transform:uppercase">REF NO #url.type#</font></th>
      <th width="105px"><font style="text-transform:uppercase">INVOICE DATE</font></th>
      <th width="105px"><font style="text-transform:uppercase">END CONTRACT DATE</font></th>
      <th width="300px">CUSTOMER</th>
      <th width="300px">VEHICLE NO</th>
      <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getcustsupp" >
      <tr>
        <td>#getcustsupp.refno#</td>
        <td>#DateFormat(getcustsupp.wos_date,"dd/mm/yyyy")#</td>
        <cfset endContractDate = DateAdd("m",12,getcustsupp.wos_date)>
        <td>#DateFormat(endContractDate,"dd/mm/yyyy")#</td>
        <td>#getcustsupp.custno# - #getcustsupp.name#</td>
        <td>#getcustsupp.rem5#</td>
        <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="javascript:ColdFusion.Window.hide('findRefno');selectlist('#getcustsupp.refno#','refno');"><u>SELECT</u></a></td>
      </tr>
    </cfloop>
  </table>
  </div>
</cfoutput>