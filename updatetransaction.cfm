<cfquery name="getall" datasource="#dts#">
SELECT * FROM artran WHERE type = "inv" and wos_date between "#form.datefrom#" and "#form.dateto#"
</cfquery> 

<cfloop query="getall">
<cfquery name="sumall" datasource="#dts#">
SELECT sum(amt-taxamt) as sumallamt FROM ictran WHEre refno = "#getall.refno#" and type = "inv"
</cfquery>

<cfquery name="update" datasource="#dts#">
UPDATE artran SET invgross = "#sumall.sumallamt#", currrate = 1,cs_pm_cash = if(cs_pm_debt + cs_pm_vouc + cs_pm_crcd = 0,grand,grand-cs_pm_vouc-cs_pm_crcd) WHEre refno = "#getall.refno#" and type = "inv"
</cfquery>

<cfquery name="update" datasource="#dts#">
UPDATE ictran SET currrate = 1 WHEre refno = "#getall.refno#" and type = "inv"
</cfquery>

</cfloop>