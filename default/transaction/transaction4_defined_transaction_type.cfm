<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>


<cfif tran eq "RC">
	<cfset tranname = words[664]>
  	<cfset trancode = "rcno">
  	<cfset tranarun = "rcarun">

	<cfif getpin2.h2102 eq "T">
  		<cfset alcreate = 1>
	</cfif>
<cfelseif tran eq "PR">
  	<cfset tranname = words[188]>
  	<cfset trancode = "prno">
  	<cfset tranarun = "prarun">

	<cfif getpin2.h2201 eq "T">
 		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "DO">
	<cfset tranname = words[665]>
	<cfset trancode = "dono">
    <cfset tranarun = "doarun">

	<cfif getpin2.h2301 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "INV">
	<cfset tranname = words[666]>
  	<cfset trancode = "invno">
  	<cfset tranarun = "invarun">

	<cfif getpin2.h2401 eq "T">
  		<cfset alcreate = 1>
  	</cfif>

<cfelseif tran eq "CS">
  	<cfset tranname = words[185]>
  	<cfset trancode = "csno">
  	<cfset tranarun = "csarun">

	<cfif getpin2.h2501 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "CN">
  	<cfset tranname = words[689]>
  	<cfset trancode = "cnno">
  	<cfset tranarun = "cnarun">

	<cfif getpin2.h2601 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "DN">
	<cfset tranname = words[667]>
  	<cfset trancode = "dnno">
  	<cfset tranarun = "dnarun">

	<cfif getpin2.h2701 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "PO">
  	<cfset tranname = words[690]>
  	<cfset trancode = "pono">
  	<cfset tranarun = "poarun">

	<cfif getpin2.h2861 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "RQ">
  	<cfset tranname = words[961]>
  	<cfset trancode = "rqno">
  	<cfset tranarun = "rqarun">

	<cfif getpin2.h28G1 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "QUO">
  	<cfset tranname = words[668]>
  	<cfset trancode = "quono">
  	<cfset tranarun = "quoarun">

	<cfif getpin2.h2871 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "SO">
	<cfset tranname = words[673]>
  	<cfset trancode = "sono">
  	<cfset tranarun = "soarun">

	<cfif getpin2.h2881 eq "T">
 		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "SAM">
	<cfset tranname = words[674]>
	<cfset trancode = "samno">
	<cfset tranarun = "samarun">

	<cfif getpin2.h2851 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "SAMM" and lcase(hcomid) eq "hunting_i">
	<cfset tran = "SAMM">
	<cfset tranname = "Sales Order">
	<cfset trancode = "sammno">
	<cfset tranarun = "sammarun">

	<cfif getpin2.h2851 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>