<cfquery name="getnolink" datasource="#dts#">
select * from ictran where type = "INV" and (dono = "" or dono is null)
</cfquery>

<cfloop query="getnolink">

<cfquery name="gettoinv" datasource="#dts#">
SELECT frrefno,frdate from iclink where type = "INV" and refno = "#getnolink.refno#" and frtype = "DO"
</cfquery>
<cfif gettoinv.recordcount neq 0>
<cfquery name="updateictran" datasource="#dts#">
UPDATE ictran SET dono = "#gettoinv.frrefno#" where type = "INV" and (dono = "" or dono is null) and refno = "#getnolink.refno#" and trancode = "#getnolink.trancode#" and itemno = "#getnolink.itemno#"
</cfquery>
<cfquery name="getlinkdetail" datasource="#dts#">
SELECT trancode,wos_date from ictran where itemno = "#getnolink.itemno#" and qty = "#getnolink.qty#" and refno = "#gettoinv.frrefno#" and type = "DO"
</cfquery>
<cfset trancode1 = 1>
<cfset wos_date1 = dateformat(now(),"YYYY-MM-DD")>
<cfif getlinkdetail.recordcount neq 0>
<cfset trancode1 = getlinkdetail.trancode>
<cfset wos_date1 = dateformat(getlinkdetail.wos_date,"YYYY-MM-DD")>
</cfif>
<cftry>
<cfquery name="createlink" datasource="#dts#">
INSERT INTO iclink
(type,refno,trancode,frtype,frrefno,wos_date,frtrancode,frdate,itemno,qty)
VALUES
(
"INV","#getnolink.refno#","#getnolink.trancode#","DO","#gettoinv.frrefno#","#dateformat(getnolink.wos_date,'YYYY-MM-DD')#","#trancode1#","#wos_date1#","#getnolink.itemno#","#getnolink.qty#")
</cfquery>
<cfcatch type="any">
</cfcatch>
</cftry>
</cfif>

</cfloop>