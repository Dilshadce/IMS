<cfquery name="getnolink" datasource="#dts#">
SELECT refno,itemno,qty,trancode,wos_date from ictran where type = "DO" and (toinv = "" or toinv is null)
</cfquery>

<cfloop query="getnolink">
<cfquery name="gettoinv" datasource="#dts#">
SELECT toinv from artran where refno = "#getnolink.refno#" and type = "DO"
</cfquery>
<cfif gettoinv.toinv neq "">
<cfquery name="updateictran" datasource="#dts#">
UPDATE ictran SET toinv = "#gettoinv.toinv#" where type = "DO" and (toinv = "" or toinv is null) and refno = "#getnolink.refno#"
</cfquery>

<cfquery name="getlinkdetail" datasource="#dts#">
SELECT trancode,wos_date from ictran where itemno = "#getnolink.itemno#" and qty = "#getnolink.qty#" and refno = "#gettoinv.toinv#" and type = "INV"
</cfquery>

<cfset trancode1 = 1>
<cfset wos_date1 = dateformat(now(),"YYYY-MM-DD")>
<cfif getlinkdetail.recordcount neq 0>
<cfquery name="updateictran" datasource="#dts#">
UPDATE ictran SET dono = "#getnolink.refno#"
where itemno = "#getnolink.itemno#" and qty = "#getnolink.qty#" and refno = "#gettoinv.toinv#" and type = "INV"
</cfquery>
<cfset trancode1 = getlinkdetail.trancode>
<cfset wos_date1 = dateformat(getlinkdetail.wos_date,"YYYY-MM-DD")>
</cfif>
<cftry>
<cfquery name="createlink" datasource="#dts#">
INSERT INTO iclink
(type,refno,trancode,frtype,frrefno,wos_date,frtrancode,frdate,itemno,qty)
VALUES
(
"INV","#gettoinv.toinv#","#trancode1#","DO","#getnolink.refno#","#wos_date1#","#getnolink.trancode#","#dateformat(getnolink.wos_date,'YYYY-MM-DD')#","#getnolink.itemno#","#getnolink.qty#")
</cfquery>
<cfcatch type="any">
</cfcatch>
</cftry>
</cfif>

</cfloop>