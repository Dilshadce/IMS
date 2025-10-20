
<cfabort>
<cfoutput>
<cfquery name="checkexistitemno" datasource="#dts#">
select * from #target_arcust# where custno='#form.custno#'
</cfquery>


<cfif checkexistitemno.recordcount eq 0>

<cfquery name="insertcust" datasource="#dts#">
				insert into #target_arcust#
				(`EDI_ID`,`CUSTNO`,`NAME`,`NAME2`,`ADD1`,`ADD2`,`ADD3`,`ADD4`,`ATTN`,`DADDR1`,`DADDR2`,`DADDR3`,`DADDR4`,
				`DATTN`,`CONTACT`,`PHONE`,`PHONEA`,`DPHONE`,`FAX`,`DFAX`,`E_MAIL`,`WEB_SITE`,`BANKACCNO`,`AREA`,`AGENT`,`BUSINESS`,
				`TERM`,`CRLIMIT`,`CURRCODE`,`CURRENCY`,`CURRENCY1`,`CURRENCY2`,`POINT_BF`,`AUTOPAY`,`LC_EX`,`CT_GROUP`,`TEMP`,`TARGET`,
				`MOD_DEL`,`ARREM1`,`ARREM2`,`ARREM3`,`ARREM4`,`GROUPTO`,`STATUS`,`CUST_TYPE`,`ACCSTATUS`,`DATE`,`INVLIMIT`,`TERMEXCEED`,
				`CHANNEL`,`SALEC`,`SALECNC`,`TERM_IN_M`,`CR_AP_REF`,`CR_AP_DATE`,`COLLATERAL`,`GUARANTOR`,`DISPEC_CAT`,`DISPEC1`,`DISPEC2`,
				`DISPEC3`,`COMMPERC`,`OUTSTAND`,`NGST_CUST`,`PERSONIC1`,`POSITION1`,`DEPT1`,`CONTACT1`,`SITENAME`,`SITEADD1`,`SITEADD2`,`EDITED`,
				`ACC_CODE`,`PROV_DISC`,`comuen`,`CREATED_BY`,`UPDATED_BY`,`CREATED_ON`,`UPDATED_ON`,`gstno`,`country`,`postalcode`,
				`D_COUNTRY`,`D_POSTALCODE`,`END_USER`,`DELETED_BY`,`DELETED_ON`) 
				select
                a.EDI_ID,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,a.NAME,a.NAME2,a.ADD1,a.ADD2,a.ADD3,a.ADD4,a.ATTN,a.DADDR1,a.DADDR2,a.DADDR3,a.DADDR4,a.DATTN,a.CONTACT,a.PHONE,a.PHONEA,a.DPHONE,a.FAX,a.DFAX,a.E_MAIL,a.WEB_SITE,a.BANKACCNO,a.AREA,a.AGENT,a.BUSINESS,a.TERM,a.CRLIMIT,a.CURRCODE,a.CURRENCY,a.CURRENCY1,a.CURRENCY2,a.POINT_BF,a.AUTOPAY,a.LC_EX,a.CT_GROUP,a.TEMP,a.TARGET,a.MOD_DEL,a.ARREM1,a.ARREM2,a.ARREM3,a.ARREM4,a.GROUPTO,a.STATUS,a.CUST_TYPE,a.ACCSTATUS,a.DATE,a.INVLIMIT,a.TERMEXCEED,a.CHANNEL,a.SALEC,a.SALECNC,a.TERM_IN_M,a.CR_AP_REF,a.CR_AP_DATE,a.COLLATERAL,a.GUARANTOR,a.DISPEC_CAT,a.DISPEC1,a.DISPEC2,a.DISPEC3,a.COMMPERC,a.OUTSTAND,a.NGST_CUST,a.PERSONIC1,a.POSITION1,a.DEPT1,a.CONTACT1,a.SITENAME,a.SITEADD1,a.SITEADD2,a.EDITED,a.ACC_CODE,a.PROV_DISC,a.comuen,a.CREATED_BY,a.UPDATED_BY,a.CREATED_ON,a.UPDATED_ON,a.gstno,a.country,a.postalcode,a.D_COUNTRY,a.D_POSTALCODE,a.END_USER,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.huserid#">,now()
				from <cfif arguments.hlinkams eq "Y">#arguments.dts1#.</cfif>#form.target_table# as a
				where a.custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ff_custno#">
			</cfquery>

<cfset status='Customer #form.custno# has been Created'>
<cfelse>
<cfset status='Customer No Existed'>
</cfif>

</cfoutput>

<html>
<head>
	<title></title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
	<center><h3>#status#</h3></center>
	<form action="" method="post">
	<br><br>
	<div align="center"><input type="button" value="Close" onClick="window.close();window.opener.location.reload();"></div>
	</form>
</cfoutput>
</body>
</html>
<cfabort>