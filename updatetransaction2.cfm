<cfquery name="getall" datasource="#dts#">
SELECT * FROM artran WHERE type = "rc" and wos_date between "#form.datefrom#" and "#form.dateto#" and left(refno,1) = "T"
</cfquery> 

<cfquery name="updateictran" datasource="#dts#">
UPDATE ictran SET currrate = 1 WHERE type = "rc" and wos_date between "#form.datefrom#" and "#form.dateto#" and left(refno,1) = "P"
</cfquery>

<cfloop query="getall">

<cfquery name="update" datasource="#dts#">
UPDATE artran SET cs_pm_cash = grand WHEre refno = "#getall.refno#" and type = "rc"
</cfquery>

<cfquery name="update" datasource="#dts#">
UPDATE ictran SET currrate = 1 WHEre refno = "#getall.refno#" and type = "rc"
</cfquery>

</cfloop>