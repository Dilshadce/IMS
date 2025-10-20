<cfloop from=1 to=6 index="i">
<cfquery name="update" datasource="#dts#">
UPDATE paytra1
SET RATE#i# = "#val(evaluate('form.rate#i#'))#",
	HR#i# = "#val(evaluate('form.hr#i#'))#",
	EPFWW = "#val(form.EPFWW)#",
	EPFCC = "#val(form.EPFCC)#",
	FIXOESP = "#form.FIXOESP#"
WHERE EMPNO = "#url.empno#"
</cfquery>
</cfloop>
<cflocation url="/payments/1stHalf/addUpdate/editOTRateCPFForm.cfm?empno=#empno#">