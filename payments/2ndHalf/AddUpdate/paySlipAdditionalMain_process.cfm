<cfloop from=1 to=6 index="i">
<cfquery name="BPO_qry" datasource="#dts#">
UPDATE paynote
SET BRATE = "#form.BRATE#",
	WDAY = "#form.WDAY#",
	DW = "#form.DW#",
	PH = "#form.PH#",
	AL = "#form.AL#",
	MC = "#form.MC#",
	MT = "#form.MT#",
    CC = "#form.CC#",
	MR = "#form.MR#",
	CL = "#form.CL#",
	HL = "#form.HL#",
	LS = "#form.LS#",
	NPL = "#form.NPL#",
	AB = "#form.AB#",
	HR#i# = "#evaluate('form.HR#i#')#",
	WORKHR = "#form.WORKHR#",
	LATEHR = "#form.LATEHR#",
	EARLYHR = "#form.EARLYHR#",
	NOPAYHR = "#form.NOPAYHR#",
	OOB = "#form.OOB#"
WHERE empno = "#form.empno#"
</cfquery>
</cfloop>

<cfloop from=101 to=117 index="i">
<cfquery name="AW_qry" datasource="#dts#">
UPDATE paynote
SET DIRFEE = "#form.DIRFEE#",
	AW#i# = "#evaluate('form.AW#i#')#"
WHERE empno = "#form.empno#"
</cfquery>
</cfloop>

<cfloop from=101 to=115 index="i">
<cfquery name="DED_qry" datasource="#dts#">
UPDATE paynote
SET DED#i# = "#evaluate('form.DED#i#')#",
	ADVANCE = "#form.advance#"
WHERE empno = "#form.empno#"
</cfquery>
</cfloop>

<cfquery name="OTH_qry" datasource="#dts#">
UPDATE paynote
SET	MFUND = "#form.MFUND#",
	DFUND = "#form.DFUND#",
	EPFWW = "#form.EPFWW#",
	EPFCC = "#form.EPFCC#",
	EPGWW = "#form.EPGWW#",
	EPGCC = "#form.EPGCC#"
WHERE empno = "#form.empno#"
</cfquery>

<cfloop from=1 to=30 index="i">
<cfquery name="UDRate_qry" datasource="#dts#">
UPDATE paynote
SET DIRFEE = "#form.DIRFEE#",
	UDRATE#i# = "#evaluate('form.UDRATE#i#')#"
WHERE empno = "#form.empno#"
</cfquery>
</cfloop>

<cflocation url="/payments/2ndHalf/addUpdate/paySlipAdditionalForm.cfm?empno=#form.empno#">