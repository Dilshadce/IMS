<cfquery name="getlocalcurr" datasource="#dts#">
SELECT bcurr FROM gsetup
</cfquery>

<cfquery name="checkartran1" datasource="#dts#">
SELECT refno,type FROM artran WHERE currcode = "#getlocalcurr.bcurr#" and currrate <> 1
</cfquery>

<cfquery name="updateartran" datasource="#dts#">
UPDATE artran SET 
currrate = 1,
invgross = gross_bil,
net = net_bil,
tax = tax_bil,
grand=grand_bil,
discount=disc_bil,
tax1=tax1_bil 
WHERE currcode = "#getlocalcurr.bcurr#" and currrate <> 1
</cfquery>
<cfloop query="checkartran1">
<cfquery name="updateictran" datasource="#dts#">
UPDATE ictran SET 
currrate = 1,
price = price_bil,
amt = amt_bil,
amt1 = amt1_bil,
taxamt=taxamt_bil,
disamt=disamt_bil
WHERE refno = "#checkartran1.refno#" and type = "#checkartran1.type#" and currrate <> 1
</cfquery>
</cfloop>


<cfquery name="getcurrecy" datasource="#dts#">
SELECT * FROM currency WHERE currcode = "US"
</cfquery>

<cfquery name="getdamage" datasource="#dts#">
select * from (select type ,custno,refno,currcode,grand,grand_bil,currrate,fperiod from artran where currcode = "US" and currrate <> 1) as a left join (select custno as acustno, currcode as acurrcode from arcust) as b on a.custno=b.acustno where b.acustno is not null and a.currcode <> b.acurrcode
</cfquery>

<cfloop query="getdamage">
<cfif getdamage.currrate neq 0 and getdamage.currrate neq 1>
<cfset currp = "currp"&ceiling(getdamage.fperiod)>
<cfset nowcurr = getcurrecy[#currp#]>
<cfif val(nowcurr) eq 0>
<cfset nowcurr = 1>
</cfif> 
<cfelse>
<cfset nowcurr = getdamage.currrate>
</cfif>
<cfquery name="updateartran11" datasource="#dts#">
UPDATE artran SET 
currrate = 1,
currcode = "IDR",
invgross = gross_bil * #nowcurr#,
gross_bil = gross_bil * #nowcurr#,
net = net_bil * #nowcurr#,
net_bil = net_bil * #nowcurr#,
tax = tax_bil * #nowcurr#,
tax_bil = tax_bil * #nowcurr#,
grand=grand_bil * #nowcurr#,
grand_bil=grand_bil * #nowcurr#,
discount=disc_bil * #nowcurr#,
disc_bil=disc_bil * #nowcurr#,
tax1=tax1_bil  * #nowcurr#,
tax1_bil=tax1_bil  * #nowcurr#
WHERE refno = "#getdamage.refno#" and type = "#getdamage.type#"
</cfquery>

<cfquery name="updateictran11" datasource="#dts#">
UPDATE ictran SET 
currrate = 1,
price = price_bil * #nowcurr#,
price_bil = price_bil * #nowcurr#,
amt = amt_bil * #nowcurr#,
amt_bil = amt_bil * #nowcurr#,
amt1 = amt1_bil * #nowcurr#,
amt1_bil = amt1_bil * #nowcurr#,
taxamt=taxamt_bil * #nowcurr#,
taxamt_bil=taxamt_bil * #nowcurr#,
disamt=disamt_bil * #nowcurr#,
disamt_bil=disamt_bil * #nowcurr#
WHERE refno = "#getdamage.refno#" and type = "#getdamage.type#" 
</cfquery>
</cfloop>

<cfquery name="getdamage" datasource="#dts#">
select * from (select type ,custno,refno,currcode,grand,grand_bil,currrate,fperiod from artran where currcode = "US" and currrate <> 1) as a left join (select custno as acustno, currcode as acurrcode from apvend) as b on a.custno=b.acustno where b.acustno is not null and a.currcode <> b.acurrcode
</cfquery>

<cfloop query="getdamage">
<cfif getdamage.currrate neq 0 and getdamage.currrate neq 1>
<cfset currp = "currp"&ceiling(getdamage.fperiod)>
<cfset nowcurr = getcurrecy[#currp#]>
<cfif val(nowcurr) eq 0>
<cfset nowcurr = 1>
</cfif> 
<cfelse>
<cfset nowcurr = getdamage.currrate>
</cfif>
<cfquery name="updateartran0" datasource="#dts#">
UPDATE artran SET 
currrate = 1,
currcode = "IDR",
invgross = gross_bil * #nowcurr#,
gross_bil = gross_bil * #nowcurr#,
net = net_bil * #nowcurr#,
net_bil = net_bil * #nowcurr#,
tax = tax_bil * #nowcurr#,
tax_bil = tax_bil * #nowcurr#,
grand=grand_bil * #nowcurr#,
grand_bil=grand_bil * #nowcurr#,
discount=disc_bil * #nowcurr#,
disc_bil=disc_bil * #nowcurr#,
tax1=tax1_bil  * #nowcurr#,
tax1_bil=tax1_bil  * #nowcurr#
WHERE refno = "#getdamage.refno#" and type = "#getdamage.type#"
</cfquery>

<cfquery name="updateictran0" datasource="#dts#">
UPDATE ictran SET 
currrate = 1,
price = price_bil * #nowcurr#,
price_bil = price_bil * #nowcurr#,
amt = amt_bil * #nowcurr#,
amt_bil = amt_bil * #nowcurr#,
amt1 = amt1_bil * #nowcurr#,
amt1_bil = amt1_bil * #nowcurr#,
taxamt=taxamt_bil * #nowcurr#,
taxamt_bil=taxamt_bil * #nowcurr#,
disamt=disamt_bil * #nowcurr#,
disamt_bil=disamt_bil * #nowcurr#
WHERE refno = "#getdamage.refno#" and type = "#getdamage.type#" 
</cfquery>
</cfloop>

<cfquery name="checkartran" datasource="#dts#">
SELECT refno,type,fperiod FROM artran WHERE currcode = "US" and (currrate = 1 or currrate = 0) and type not in ("iss") and grand_bil <> 0
</cfquery>

<cfloop query="checkartran">
<cfset currp = "currp"&ceiling(checkartran.fperiod)>
<cfset nowcurr = getcurrecy[#currp#]>
<cfif val(nowcurr) eq 0>
<cfset nowcurr = 1>
</cfif> 
<cfquery name="updateartran1" datasource="#dts#">
UPDATE artran SET 
currrate = #nowcurr#,
invgross = gross_bil * #nowcurr#,
net = net_bil * #nowcurr#,
tax = tax_bil * #nowcurr#,
grand=grand_bil * #nowcurr#,
discount=disc_bil * #nowcurr#,
tax1=tax1_bil  * #nowcurr#
WHERE refno = "#checkartran.refno#" and type = "#checkartran.type#"
</cfquery>

<cfquery name="updateictran1" datasource="#dts#">
UPDATE ictran SET 
currrate = #nowcurr#,
price = price_bil * #nowcurr#,
amt = amt_bil * #nowcurr#,
amt1 = amt1_bil * #nowcurr#,
taxamt=taxamt_bil * #nowcurr#,
disamt=disamt_bil * #nowcurr#
WHERE refno = "#checkartran.refno#" and type = "#checkartran.type#" 
</cfquery>
</cfloop>