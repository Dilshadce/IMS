<cfquery name="getPackDetail" datasource="#dts#">
SELECT * FROM PACKLIST WHERE packID = "#packID#"
</cfquery>
<cfset packidlist = form.packidlist >
<cfoutput>
<cfif getPackDetail.totalbill eq packidlist>
SUCCESS
<cfelse>

<cfloop list="#form.packidlist#" index="i">
<cfquery name="checkexist2" datasource="#dts#">
select reftype,billrefno from PACKLISTBILL where billrefno='#i#' and reftype="SO"
</cfquery>
<cfif checkexist2.recordcount eq 0>
<cfquery name="insertPackBill" datasource="#dts#">
INSERT INTO PACKLISTBILL
(PACKID,billRefno,reftype)
VALUES
("#packID#","#i#","SO")
</cfquery>
<cfquery name="updateArtran" datasource="#dts#">
UPDATE artran SET PACKED = "Y", PACKED_ON = now(), PACKED_BY = "#Husername#" WHERE REFNO = "#i#" and type = "SO"
</cfquery>

<cfelse>
<cfset errormsg = errormsg&"<br />"&i>
</cfif>
</cfloop>
<cfquery name="updatePackID" datasource="#dts#">
UPDATE packlist SET totalbill = "#form.packidlist#",updated_by = "#Husername#",updated_on = now() WHERE packid = "#packID#"
</cfquery>

EDIT SUCCESS!
</cfif>
<input type="button" name="closeBtn" id="closeBtn" value="CLOSE"  onClick="ColdFusion.Window.hide('editPackList');"/>

</cfoutput>