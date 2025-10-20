<cfquery name="getGSetup" datasource="#dts#">
  	select compro,compro2,compro3,compro4,compro5,compro6,compro7,gstno from gsetup 
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall from gsetup
</cfquery>
<cfset dts1=replace(dts,'_i','_p','all')>
<cfoutput>




</cfoutput>
  

<cfquery name="MyQuery" datasource="#dts#">

select a.contactperson,a.custno,a.location,a.position,a.jobcode,a.clientrate,a.newrate,a.empname,a.empno,a.sex,a.placementno,a.nric,a.duration,a.placementdate,a.startdate,a.completedate,b.custno,b.fax,b.name,b.attn,b.phone,b.phonea,b.add1,b.add2,b.add3,b.add4,c.dbirth,c.pr_from, c.bankaccno,c.add1 as c_addr1,c.add2 as c_addr2,c.phone as c_phones,c.etelno,c.bankcode,a.clienttype,a.newtype,c.postcode,c.edu,c.email,a.consultant from placement as a left join (select * from #target_arcust#)as b on a.custno=b.custno left join (select * from #replace(dts,'_i','_p')#.pmast)as c on a.empno=c.empno where placementno='#url.placementno#'

</cfquery>

<cfquery name="getbankname" datasource="payroll_main">
select bankname from bankcode where bankcode='#myquery.bankcode#'
</cfquery>

<cfreport template="placement.cfr" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getGSetup.compro#">
	<cfreportparam name="compro2" value="#getGSetup.compro2#">
	<cfreportparam name="compro3" value="#getGSetup.compro3#">
	<cfreportparam name="compro4" value="#getGSetup.compro4#">
	<cfreportparam name="compro5" value="#getGSetup.compro5#">
	<cfreportparam name="compro6" value="#getGSetup.compro6#">
	<cfreportparam name="compro7" value="#getGSetup.compro7#">
    <cfreportparam name="bankname" value="#getbankname.bankname#">
    
</cfreport>
