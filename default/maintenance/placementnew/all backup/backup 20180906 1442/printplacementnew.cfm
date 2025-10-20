<cfquery name="getGSetup" datasource="#dts#">
  	select compro,compro2,compro3,compro4,compro5,compro6,compro7,gstno from gsetup 
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall from gsetup
</cfquery>
<cfset dts1=replace(dts,'_i','_p','all')>
<cfoutput>




</cfoutput>
  

<cfquery name="getkey" datasource="#dts#">
SELECT empno,custno,eff_d_5,eff_d_4,eff_d_3,eff_d_2,eff_d_1 FROM placement WHERE placementno='#url.placementno#'
</cfquery>

<cfset addkey = 0>
<cfif getkey.eff_d_5 neq "">
<cfset addkey = 2>
<cfelseif getkey.eff_d_4 neq "">
<cfset addkey = 1>
</cfif>

<cfquery name="MyQuery" datasource="#dts#">
SELECT * FROM (
SELECT * FROM placement WHERE placementno = '#url.placementno#' ) as a
LEFT JOIN
(SELECT empno as emp,nricn,pr_from,dbirth,edu,email,phone as c_phones,add1 as vadd1 ,add2 as vadd2 ,postcode,etelno,bankcode,bankaccno,brancode FROM #dts1#.pmast WHERE empno = "#getkey.empno#")
as b
on a.empno = b.emp
LEFT JOIN
(select add1,add2,add3,add4,phone,name,name2,custno as cno from #target_Arcust# WHERE custno = "#getkey.custno#" ) as c
on a.custno = c.cno
</cfquery>

<cfquery name="getbankname" datasource="payroll_main">
select bankname from bankcode where bankcode='#myquery.bankcode#'
</cfquery>

<cfif myquery.bankcode eq "7171" and (myquery.brancode eq "081" or len(myquery.bankaccno) lte 9)>
<cfset getbankname.bankname = right(trim(getbankname.bankname),4)>
<cfelseif myquery.bankcode eq "7171">
<cfset getbankname.bankname = left(trim(getbankname.bankname),3)>
</cfif>


<cfreport template="placement.cfr" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getGSetup.compro#">
	<cfreportparam name="compro2" value="#getGSetup.compro2#">
	<cfreportparam name="compro3" value="#getGSetup.compro3#">
	<cfreportparam name="compro4" value="#getGSetup.compro4#">
	<cfreportparam name="compro5" value="#getGSetup.compro5#">
	<cfreportparam name="compro6" value="#getGSetup.compro6#">
	<cfreportparam name="compro7" value="#getGSetup.compro7#">
    <cfreportparam name="bankname" value="#getbankname.bankname#">
    <cfreportparam name="addkey" value="#addkey#">
</cfreport>
