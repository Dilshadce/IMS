<cfset ndatefrom=''>
<cfif isdate(url.date)>
<cfset dd=dateformat(url.date, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom=dateformat(url.date,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom=dateformat(url.date,"YYYYDDMM")>
	</cfif>
</cfif>

<cfquery name="getcustsupp" datasource="#dts#">
   		select refno,name from artran WHERE type ='#url.type#' and refno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custno#%"> 
        <cfif ndatefrom neq ''>
        wos_date='#ndatefrom#'
        </cfif>
        and refno2 like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%">
        <cfif url.period neq ''>
        and fperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.period#">
        </cfif>
        order by refno limit 100
	</cfquery>
	<cfoutput>  
   
       <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">REF NO #url.type#</font></th>
    <th width="300px">CUSTOMER NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getcustsupp" >
    <tr>
    <td>#getcustsupp.refno#</td>
    <td>#getcustsupp.name#</td>
    <td>
    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('billno#url.fromto#').value='#getcustsupp.refno#';javascript:ColdFusion.Window.hide('findRefno');"><u>SELECT</u></a>
   
</td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>