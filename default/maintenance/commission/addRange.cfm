<cfquery name="insertinto" datasource="#dts#">
INSERT INTO commrate
(commname,rangeFrom,rangeto,rate,type,created_on,created_by)
VALUES
("#url.commname#","#url.rFrom#","#url.rTo#","#url.cRate#","N",now(),"#huserid#")
</cfquery>