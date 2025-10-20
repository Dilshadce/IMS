<cfsetting showdebugoutput="no">
<cfset periodfrom=val(url.periodfrom)*1>
<cfset periodto=val(url.periodto)*1>

<cfquery name="getperiod" datasource="#dts#">
SELECT lastaccyear FROM gsetup
</cfquery>
<cfset lastdate = getperiod.lastaccyear>

<cfquery name="getlist3" datasource="#dts#">
select chequeno as refno,concat(chequeno,'-',refno) as desp from assignmentslip where (
claimadd1 = "Y"
or claimadd2 = "Y"
or claimadd3 = "Y"
or claimadd4 = "Y"
or claimadd5 = "Y"
or claimadd6 = "Y")
and (coalesce(addchargeself,0)+coalesce(addchargeself2,0)+coalesce(addchargeself3,0)+coalesce(addchargeself4,0)+coalesce(addchargeself5,0)+coalesce(addchargeself6,0) > 0)
and chequeno <> "" and chequeno is not null
<cfif url.periodfrom neq '' and url.periodto neq ''>
and assignmentslipdate between "#dateformat(createdate(year(dateadd('m',url.periodfrom,lastdate)),month(dateadd('m',url.periodfrom,lastdate)),'1'),'YYYY-MM-DD')#" and "#dateformat(createdate(year(dateadd('m',url.periodto,lastdate)),month(dateadd('m',url.periodto,lastdate)),DaysInMonth(dateadd('m',url.periodto,lastdate))),'YYYY-MM-DD')#"
</cfif>
order by chequeno
</cfquery>
<cfoutput>
<select name="assignmentto" id="assignmentto">
<option value="">Choose a Cheque no of Assignment With Claim</option>
<cfloop query="getlist3">
<option value="#getlist3.refno#">#getlist3.desp#</option>
</cfloop>
</select>
</cfoutput>
