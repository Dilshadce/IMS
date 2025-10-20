<cfsetting showdebugoutput="no">

<cfinclude template="creditnotescript.cfm">
    
<cfset gstper = form.gstrate>

<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt_bil) as sumsubtotal,count(trancode) as notran,sum(taxamt_bil) as sumtaxtotal FROM ictrantempcn where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(form.uuid)#" />
</cfquery>

<cfif lcase(tran) eq 'dn'>
    
<cfquery name="getcustgsttype" datasource="#dts#">
select arrem5 from #target_arcust# where custno='#form.custno#'
</cfquery>

<cfif form.newcustno neq ''>
    <cfquery name="getcustgsttype" datasource="#dts#">
    SELECT arrem5 FROM #target_arcust# WHERE custno = "#form.newcustno#"
    </cfquery>
</cfif>

</cfif>
    
<cfset check = false>
    
<cfif form.invno neq ''>
    
<cfquery name="getgstrate" datasource="#dts#">
SELECT taxp1 FROM artran 
WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invno#" />
AND (void = '' or void is null)
</cfquery>
    
<cfquery name="checktotaltemp" datasource="#dts#">
    SELECT sum(amt_bil) totalbill FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    GROUP BY refno2
</cfquery>
    
<cfquery name="checktotalbefore" datasource="#dts#">
    SELECT sum(amt_bil) totalbill FROM ictran 
    WHERE type = '#tran#' 
    AND refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invno#" />
    AND (void = '' or void is null)
</cfquery>
    
<cfset check = checktotaltemp.totalbill neq checktotalbefore.totalbill>
    
</cfif>

<cfif form.invno eq '' or lcase(tran) eq 'dn' or check>
    
<cfinclude template="manpowergstcalc.cfm">
    
<cfquery name="getSum_ictran" datasource="#dts#">
    SELECT refno,type,round((sum(amt_bil)*#gstper#/100),2) AS sumTaxAmt
    FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    AND note_a = 'SR'
    GROUP BY refno
</cfquery>
    
<cfset getsum.sumtaxtotal = getSum_ictran.sumTaxAmt>
    
<cfelse>
    
<cfquery name="getSum_artran" datasource="#dts#">
    SELECT tax_bil*-1 AS sumTaxAmt
    FROM artran
    WHERE refno = (
    SELECT refno2 FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    GROUP BY refno2
    )    
</cfquery>
    
<cfif getSum_artran.sumTaxAmt neq "">
    <cfset getsum.sumtaxtotal = getSum_artran.sumTaxAmt>
</cfif>
    
<cfif form.gstrate eq 0>
    <cfset getsum.sumtaxtotal = 0>
</cfif>
    
</cfif>
    
<cfinclude template="manpowergstcalc.cfm">

<cfoutput>
    
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hidtaxtotal" id="hidtaxtotal" value="#numberformat(getsum.sumtaxtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.notran#" />



<cfquery name="getictrantemp" datasource="#dts#">
    SELECT * FROM ictrantempcn 
    WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> 
    order by length(trancode),trancode,refno2
</cfquery>
    
    <cfinclude template="creditnotetablebody.cfm">
</cfoutput>