<cfparam name="status" default="">

<cfif type eq "arcust">
	<cfset title = "Copy Customer File to ARCUST.CSV">	
	<cfset ptype = target_arcust>
	<cfset filename = "ARCUST9.csv">
<cfelseif type eq "apvend">
	<cfset title = "Copy Supplier File to APVEND.CSV">	
	<cfset ptype = target_apvend>
	<cfset filename = "APVEND9.csv">
</cfif>

<cftry>
	<cffile action = "delete" file = "C:\\Inetpub\\wwwroot\\IMS\Download\\#dts#\\ver9.0\\#filename#">
<cfcatch type="any">
</cfcatch>
</cftry>
    <cfquery name="getDefaultCurr" datasource="#dts#">
    SELECT bcurr from gsetup
    </cfquery>
<cftry>
    <cfquery name="outfile" datasource="#dts#">		
    	SELECT 
        EDI_ID,CUSTNO,NAME,NAME2,ADD1,ADD2,ADD3,ADD4,ATTN,
        DADDR1,DADDR2,DADDR3,DADDR4,DATTN,CONTACT,PHONE,PHONEA,FAX,
        E_MAIL,WEB_SITE,BANKACCNO,'' as REGION,AREA,AGENT,BUSINESS,TERM,
        CRLIMIT,if(CURRCODE = "SGD","",currcode) as CURRCODE,CURRENCY,CURRENCY1,CURRENCY2,POINT_BF,AUTOPAY,
        LC_EX,CT_GROUP,TEMP,TARGET,MOD_DEL,
        ARREM1,ARREM2,ARREM3,ARREM4,GROUPTO,STATUS,CUST_TYPE,ACCSTATUS,
        concat(day(DATE),'/',month(DATE),'/',right(year(DATE),2)) as DATE,
        INVLIMIT,TERMEXCEED,CHANNEL,SALEC,SALECNC,TERM_IN_M,CR_AP_REF,
        concat(day(CR_AP_DATE),'/',month(CR_AP_DATE),'/',right(year(CR_AP_DATE),2)) as CR_AP_DATE,
        COLLATERAL,GUARANTOR,DISPEC_CAT,DISPEC1,DISPEC2,DISPEC3,
        COMMPERC,OUTSTAND,NGST_CUST,PERSONIC1,POSITION1,DEPT1,CONTACT1,
        '' as DUEDATE,'' as OVERDUE,SITENAME,SITEADD1,SITEADD2,
       	EDITED,ACC_CODE,PROV_DISC,'' as FOOT_DISC,'' as CLASSCODE,
        CREATED_BY,UPDATED_BY,CREATED_ON,UPDATED_ON
        into outfile 'C:\\Inetpub\\wwwroot\\IMS\\Download\\#dts#\\ver9.0\\#filename#' 
        fields terminated by ',' 
        enclosed by '"' 
        lines terminated by '\r\n' 
        FROM #ptype#
		<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
			WHERE custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#">
		</cfif>
    </cfquery>
	
	<cfset status="#filename# is Exported Successfully!">  
<cfcatch type="any">
	<!--- <cfoutput>#cfcatch.Message#<br />#cfcatch.Detail#</cfoutput><cfabort> --->
	<cfset status="#cfcatch.Message#">
</cfcatch>
</cftry>

<cfoutput>
  <form name="done" action="export_to_csv_list.cfm?process=done" method="post">
	<input name="status" value="#status#" type="hidden">
  </form>
</cfoutput>

<script>
	done.submit();
</script>