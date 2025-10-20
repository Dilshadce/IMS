<cfset uuid = CreateUUID()>
<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,date_format(a.lastaccyear,'%Y-%m-%d') as lastaccyear,concat(',.',repeat('_',b.decl_uprice))as decl_uprice,agentlistuserid
	from gsetup as a, gsetup2 as b;
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>
<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfset grandtotal = 0>
<cfset monthtotal = arraynew(1)>

<cfif isdefined('form.agentbycust')>

<cfif form.agentfrom neq "" and form.agentto neq "">
<cfquery name="getagentlist" datasource="#dts#">
select custno from #target_arcust# where 0=0
and agent >='#form.agentfrom#' and agent <= '#form.agentto#'
</cfquery>
<cfset agentlist=valuelist(getagentlist.custno)>
</cfif>

<cfif form.teamfrom neq "" and form.teamto neq "">
<cfquery name="getteamlist" datasource="#dts#">
select custno from #target_arcust# where agent in (select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
</cfquery>
<cfset teamlist=valuelist(getteamlist.custno)>
</cfif>

</cfif>


<cfswitch expression="#form.label#">
	<cfcase value="salesqty">
		<cfset stDecl_UPrice = ".__">
	</cfcase>
	<cfdefaultcase>
		<cfset stDecl_UPrice = getgeneral.decl_uprice>
	</cfdefaultcase>
</cfswitch>

<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
	<cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.thislastaccdate#
		limit 1
	</cfquery>

<cfquery name="getitem" datasource="#dts#">
SELECT * FROM (
SELECT itemno,operiod FROM ictran 
WHERE type in("INV","CS"<cfif isdefined('form.include')>,"DN","CN"</cfif>)
and (void = '' or void is null) 
<!---and wos_date > "#getgeneral.lastaccyear#"--->
and wos_date > #getdate.LastAccDate#
and wos_date <= #getdate.ThisAccDate#  
and (linecode = "" or linecode is null)
<cfif form.period eq "1">
and operiod between "01" and "06"
<cfelseif form.period eq "2">
and operiod between "07" and "12"
<cfelseif form.period eq "3">
and operiod between "13" and "18"
<cfelseif form.period eq "4">
and operiod between "01" and "18"
<cfelseif form.period eq "5">
and operiod = "#form.poption#"
<cfelseif form.period eq "6">
and operiod between "#numberformat(form.periodfrom,'00')#" and "#numberformat(form.periodto,'00')#"
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and custno in (select custno from #target_arcust# where area between "#form.areafrom#" and "#form.areato#" group by custno)
</cfif>
<cfif form.userfrom neq "" and form.userto neq "">
and van between "#form.userfrom#" and "#form.userto#"
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and category between "#form.catefrom#" and "#form.cateto#"
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
<cfif form.itemfrom neq "" and form.itemto neq "">
and itemno between '#form.itemfrom#' and '#form.itemto#' 
</cfif>

<!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
        <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
<cfelse>
       <!---Agent from Bill--->
<cfif form.agentfrom neq "" and form.agentto neq "">
and agenno between "#form.agentfrom#" and "#form.agentto#"
</cfif>
<cfif form.teamfrom neq "" and form.teamto neq "">
and agenno in(select agent from #target_icagent# where  team >= '#form.teamfrom#' and  <= '#form.teamto#')
</cfif>
<cfif url.alown eq "1">
<cfif getgeneral.agentlistuserid eq "Y">
and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
<cfelse>
and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
</cfif>
<cfelse>
<cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
<cfelse>
<cfif Huserloc neq "All_loc">
and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
</cfif>
</cfif>
</cfif>
</cfif>
group by itemno,operiod order by operiod)
as g

left join (

SELECT 
<cfif form.label eq "salesqty">
sum(qty)
<cfelse>
sum(amt)
</cfif>
as sumtotal
,itemno,operiod FROM ictran 
WHERE type in("INV","CS"<cfif isdefined('form.include')>,"DN"</cfif>)
and (void = '' or void is null) 
<!---and wos_date > "#getgeneral.lastaccyear#"--->
and wos_date > #getdate.LastAccDate#
and wos_date <= #getdate.ThisAccDate#  
and (linecode = "" or linecode is null)
<cfif form.period eq "1">
and operiod between "01" and "06"
<cfelseif form.period eq "2">
and operiod between "07" and "12"
<cfelseif form.period eq "3">
and operiod between "13" and "18"
<cfelseif form.period eq "4">
and operiod between "01" and "18"
<cfelseif form.period eq "5">
and operiod = "#form.poption#"
<cfelseif form.period eq "6">
and operiod between "#numberformat(form.periodfrom,'00')#" and "#numberformat(form.periodto,'00')#"
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and custno in (select custno from #target_arcust# where area between "#form.areafrom#" and "#form.areato#" group by custno)
</cfif>
<cfif form.userfrom neq "" and form.userto neq "">
and van between "#form.userfrom#" and "#form.userto#"
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and category between "#form.catefrom#" and "#form.cateto#"
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
<cfif form.itemfrom neq "" and form.itemto neq "">
and itemno between '#form.itemfrom#' and '#form.itemto#' 
</cfif>

<!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
        <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
<cfelse>
       <!---Agent from Bill--->
<cfif form.agentfrom neq "" and form.agentto neq "">
and agenno between "#form.agentfrom#" and "#form.agentto#"
</cfif>
<cfif form.teamfrom neq "" and form.teamto neq "">
and agenno in(select agent from #target_icagent# where  team >= '#form.teamfrom#' and  <= '#form.teamto#')
</cfif>
<cfif url.alown eq "1">
<cfif getgeneral.agentlistuserid eq "Y">
and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
<cfelse>
and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
</cfif>
<cfelse>
<cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
<cfelse>
<cfif Huserloc neq "All_loc">
and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
</cfif>
</cfif>
</cfif>
</cfif>
group by itemno,operiod order by operiod)
as a
ON a.itemno = g.itemno and a.operiod = g.operiod
<cfif isdefined('form.include')>
LEFT JOIN 
(
SELECT 
<cfif form.label eq "salesqty">
sum(qty)
<cfelse>
sum(amt)
</cfif>
as sumtotalcn
,itemno as itemnocn,fperiod as fperiodcn FROM ictran 
WHERE type = "CN"
and (void = '' or void is null) 
and wos_date > #getdate.LastAccDate#
and wos_date <= #getdate.ThisAccDate#  
and (linecode = "" or linecode is null)
<cfif form.period eq "1">
and operiod between "01" and "06"
<cfelseif form.period eq "2">
and operiod between "07" and "12"
<cfelseif form.period eq "3">
and operiod between "13" and "18"
<cfelseif form.period eq "4">
and operiod between "01" and "18"
<cfelseif form.period eq "5">
and operiod = "#form.poption#"
<cfelseif form.period eq "6">
and operiod between "#numberformat(form.periodfrom,'00')#" and "#numberformat(form.periodto,'00')#"
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and custno in (select custno from #target_arcust# where area between "#form.areafrom#" and "#form.areato#" group by custno)
</cfif>
<cfif form.userfrom neq "" and form.userto neq "">
and van between "#form.userfrom#" and "#form.userto#"
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and category between "#form.catefrom#" and "#form.cateto#"
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
<cfif form.itemfrom neq "" and form.itemto neq "">
and itemno between '#form.itemfrom#' and '#form.itemto#' 
</cfif>

<!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
        <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
<cfelse>
       <!---Agent from Bill--->
<cfif form.agentfrom neq "" and form.agentto neq "">
and agenno between "#form.agentfrom#" and "#form.agentto#"
</cfif>
<cfif form.teamfrom neq "" and form.teamto neq "">
and agenno in(select agent from #target_icagent# where  team >= '#form.teamfrom#' and  <= '#form.teamto#')
</cfif>
<cfif url.alown eq "1">
<cfif getgeneral.agentlistuserid eq "Y">
and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
<cfelse>
and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
</cfif>
<cfelse>
<cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
<cfelse>
<cfif Huserloc neq "All_loc">
and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
</cfif>
</cfif>
</cfif>
</cfif>
group by itemno,operiod order by operiod)
as b
ON g.itemno = b.itemnocn and g.operiod = b.fperiodcn
</cfif>
</cfquery>


<cfquery name="emptyold" datasource="#dts#">
DELETE from salesmonthreport WHERE reportime < "#dateformat(dateadd('d','-1',now()),'YYYY-MM-DD')#"
</cfquery>

<cfquery name="insertitem" datasource="#dts#">
INSERT INTO salesmonthreport (subject,uuid,desp) select itemno,"#uuid#" as uuid,concat(desp,' ',despa) as desp from icitem WHERE 1=1
<cfif form.itemfrom neq "" and form.itemto neq "">
and itemno between '#form.itemfrom#' and '#form.itemto#' 
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and category between "#form.catefrom#" and "#form.cateto#"
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
</cfquery>

<cfloop query="getitem">
<cfif isdefined('form.include')>
<cfset lasamount = val(getitem.sumtotal) - val(getitem.sumtotalcn)>
<cfelse>
<cfset lasamount = val(getitem.sumtotal)>
</cfif>
<cfquery name="updatedata" datasource="#dts#">
UPDATE salesmonthreport SET 
p#getitem.operiod# = <cfqueryparam cfsqltype="cf_sql_double" value="#val(lasamount)#">
WHERE subject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
and uuid = "#uuid#"
</cfquery>
</cfloop>
<cfquery name="updatetabletotal" datasource="#dts#">
UPDATE salesmonthreport SET totalrow = 
<cfif form.period eq "1">
P01 + P02 + P03 + P04 + P05 + P06
<cfelseif form.period eq "2">
P07 + P08 + P09 + P10 + P11 + P12
<cfelseif form.period eq "3">
P13 + P14 + P15 + P16 + P17 + P18
<cfelseif form.period eq "4">
P01 + P02 + P03 + P04 + P05 + P06 + P07 + P08 + P09 + P10 + P11 + P12 + P13 + P14 + P15 + P16 + P17 + P18
<cfelseif form.period eq "5">
P#numberformat(form.poption,'00')#
<cfelseif form.period eq "6">
<cfset startloop = form.periodfrom>
<cfset endloop = form.periodto>
<cfloop from="#startloop#" to="#endloop#" index="i">
P#numberformat(i,'00')#<cfif i neq endloop>+</cfif>
</cfloop>
</cfif>
WHERE uuid = "#uuid#"
</cfquery>

<cfquery name="getdata" datasource="#dts#">
SELECT * FROM salesmonthreport WHERE uuid = "#uuid#"
<cfif isdefined('form.include0')>
<cfelse>
and totalrow <> 0
</cfif>
order by subject
</cfquery>
    
    <!--- ---->
<cfelse>
	<!--- ---->
        
<cfquery name="getitem" datasource="#dts#">
SELECT * FROM (

SELECT itemno,fperiod FROM ictran 
WHERE type in("INV","CS"<cfif isdefined('form.include')>,"DN","CN"</cfif>)
and (void = '' or void is null) 
and wos_date > "#getgeneral.lastaccyear#"
and (linecode = "" or linecode is null)
<cfif form.period eq "1">
and fperiod between "01" and "06"
<cfelseif form.period eq "2">
and fperiod between "07" and "12"
<cfelseif form.period eq "3">
and fperiod between "13" and "18"
<cfelseif form.period eq "4">
and fperiod between "01" and "18"
<cfelseif form.period eq "5">
and fperiod = "#form.poption#"
<cfelseif form.period eq "6">
and fperiod between "#numberformat(form.periodfrom,'00')#" and "#numberformat(form.periodto,'00')#"
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and custno in (select custno from #target_arcust# where area between "#form.areafrom#" and "#form.areato#" group by custno)
</cfif>
<cfif form.userfrom neq "" and form.userto neq "">
and van between "#form.userfrom#" and "#form.userto#"
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and category between "#form.catefrom#" and "#form.cateto#"
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
<cfif form.itemfrom neq "" and form.itemto neq "">
and itemno between '#form.itemfrom#' and '#form.itemto#' 
</cfif>

<!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
        <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
<cfelse>
       <!---Agent from Bill--->
<cfif form.agentfrom neq "" and form.agentto neq "">
and agenno between "#form.agentfrom#" and "#form.agentto#"
</cfif>
<cfif form.teamfrom neq "" and form.teamto neq "">
and agenno in(select agent from #target_icagent# where  team >= '#form.teamfrom#' and  <= '#form.teamto#')
</cfif>
<cfif url.alown eq "1">
<cfif getgeneral.agentlistuserid eq "Y">
and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
<cfelse>
and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
</cfif>
<cfelse>
<cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
<cfelse>
<cfif Huserloc neq "All_loc">
and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
</cfif>
</cfif>
</cfif>
</cfif>
group by itemno,fperiod order by fperiod)
as g

left join (

SELECT 
<cfif form.label eq "salesqty">
sum(qty)
<cfelse>
sum(amt)
</cfif>
as sumtotal
,itemno,fperiod FROM ictran 
WHERE type in("INV","CS"<cfif isdefined('form.include')>,"DN"</cfif>)
and (void = '' or void is null) 
and wos_date > "#getgeneral.lastaccyear#"
and (linecode = "" or linecode is null)
<cfif form.period eq "1">
and fperiod between "01" and "06"
<cfelseif form.period eq "2">
and fperiod between "07" and "12"
<cfelseif form.period eq "3">
and fperiod between "13" and "18"
<cfelseif form.period eq "4">
and fperiod between "01" and "18"
<cfelseif form.period eq "5">
and fperiod = "#form.poption#"
<cfelseif form.period eq "6">
and fperiod between "#numberformat(form.periodfrom,'00')#" and "#numberformat(form.periodto,'00')#"
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and custno in (select custno from #target_arcust# where area between "#form.areafrom#" and "#form.areato#" group by custno)
</cfif>
<cfif form.userfrom neq "" and form.userto neq "">
and van between "#form.userfrom#" and "#form.userto#"
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and category between "#form.catefrom#" and "#form.cateto#"
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
<cfif form.itemfrom neq "" and form.itemto neq "">
and itemno between '#form.itemfrom#' and '#form.itemto#' 
</cfif>

<!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
        <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
<cfelse>
       <!---Agent from Bill--->
<cfif form.agentfrom neq "" and form.agentto neq "">
and agenno between "#form.agentfrom#" and "#form.agentto#"
</cfif>
<cfif form.teamfrom neq "" and form.teamto neq "">
and agenno in(select agent from #target_icagent# where  team >= '#form.teamfrom#' and  <= '#form.teamto#')
</cfif>
<cfif url.alown eq "1">
<cfif getgeneral.agentlistuserid eq "Y">
and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
<cfelse>
and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
</cfif>
<cfelse>
<cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
<cfelse>
<cfif Huserloc neq "All_loc">
and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
</cfif>
</cfif>
</cfif>
</cfif>
group by itemno,fperiod order by fperiod)
as a
ON a.itemno = g.itemno and a.fperiod = g.fperiod
<cfif isdefined('form.include')>
LEFT JOIN 
(
SELECT 
<cfif form.label eq "salesqty">
sum(qty)
<cfelse>
sum(amt)
</cfif>
as sumtotalcn
,itemno as itemnocn,fperiod as fperiodcn FROM ictran 
WHERE type = "CN"
and (void = '' or void is null) 
and wos_date > "#getgeneral.lastaccyear#"
and (linecode = "" or linecode is null)
<cfif form.period eq "1">
and fperiod between "01" and "06"
<cfelseif form.period eq "2">
and fperiod between "07" and "12"
<cfelseif form.period eq "3">
and fperiod between "13" and "18"
<cfelseif form.period eq "4">
and fperiod between "01" and "18"
<cfelseif form.period eq "5">
and fperiod = "#form.poption#"
<cfelseif form.period eq "6">
and fperiod between "#numberformat(form.periodfrom,'00')#" and "#numberformat(form.periodto,'00')#"
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and custno in (select custno from #target_arcust# where area between "#form.areafrom#" and "#form.areato#" group by custno)
</cfif>
<cfif form.userfrom neq "" and form.userto neq "">
and van between "#form.userfrom#" and "#form.userto#"
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and category between "#form.catefrom#" and "#form.cateto#"
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
<cfif form.itemfrom neq "" and form.itemto neq "">
and itemno between '#form.itemfrom#' and '#form.itemto#' 
</cfif>

<!---Agent from Customer Profile--->
<cfif isdefined('form.agentbycust')>
            <cfif form.agentfrom neq "" and form.agentto neq "">
				and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#agentlist#">)
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
            and custno in ( <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#teamlist#">)
				</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and custno in ( select custno from #target_arcust# where agent in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%"))
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or custno in ( select custno from #target_arcust# where agent='#ucase(huserid)#'))  
			</cfif>
		<cfelse>
        <cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
<cfelse>
       <!---Agent from Bill--->
<cfif form.agentfrom neq "" and form.agentto neq "">
and agenno between "#form.agentfrom#" and "#form.agentto#"
</cfif>
<cfif form.teamfrom neq "" and form.teamto neq "">
and agenno in(select agent from #target_icagent# where  team >= '#form.teamfrom#' and  <= '#form.teamto#')
</cfif>
<cfif url.alown eq "1">
<cfif getgeneral.agentlistuserid eq "Y">
and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
<cfelse>
and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#' or (ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
</cfif>
<cfelse>
<cfif lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i">
<cfelse>
<cfif Huserloc neq "All_loc">
and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
</cfif>
</cfif>
</cfif>
</cfif>
group by itemno,fperiod order by fperiod)
as b
ON g.itemno = b.itemnocn and g.fperiod = b.fperiodcn
</cfif>
</cfquery>


<cfquery name="emptyold" datasource="#dts#">
DELETE from salesmonthreport WHERE reportime < "#dateformat(dateadd('d','-1',now()),'YYYY-MM-DD')#"
</cfquery>

<cfquery name="insertitem" datasource="#dts#">
INSERT INTO salesmonthreport (subject,uuid,desp) select itemno,"#uuid#" as uuid,concat(desp,' ',despa) as desp from icitem WHERE 1=1
<cfif form.itemfrom neq "" and form.itemto neq "">
and itemno between '#form.itemfrom#' and '#form.itemto#' 
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and category between "#form.catefrom#" and "#form.cateto#"
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
</cfquery>

<cfloop query="getitem">
<cfif isdefined('form.include')>
<cfset lasamount = val(getitem.sumtotal) - val(getitem.sumtotalcn)>
<cfelse>
<cfset lasamount = val(getitem.sumtotal)>
</cfif>
<cfquery name="updatedata" datasource="#dts#">
UPDATE salesmonthreport SET 
p#getitem.fperiod# = <cfqueryparam cfsqltype="cf_sql_double" value="#val(lasamount)#">
WHERE subject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.itemno#">
and uuid = "#uuid#"
</cfquery>
</cfloop>
<cfquery name="updatetabletotal" datasource="#dts#">
UPDATE salesmonthreport SET totalrow = 
<cfif form.period eq "1">
P01 + P02 + P03 + P04 + P05 + P06
<cfelseif form.period eq "2">
P07 + P08 + P09 + P10 + P11 + P12
<cfelseif form.period eq "3">
P13 + P14 + P15 + P16 + P17 + P18
<cfelseif form.period eq "4">
P01 + P02 + P03 + P04 + P05 + P06 + P07 + P08 + P09 + P10 + P11 + P12 + P13 + P14 + P15 + P16 + P17 + P18
<cfelseif form.period eq "5">
P#numberformat(form.poption,'00')#
<cfelseif form.period eq "6">
<cfset startloop = form.periodfrom>
<cfset endloop = form.periodto>
<cfloop from="#startloop#" to="#endloop#" index="i">
P#numberformat(i,'00')#<cfif i neq endloop>+</cfif>
</cfloop>
</cfif>
WHERE uuid = "#uuid#"
</cfquery>

<cfquery name="getdata" datasource="#dts#">
SELECT * FROM salesmonthreport WHERE uuid = "#uuid#"
<cfif isdefined('form.include0')>
<cfelse>
and totalrow <> 0
</cfif>
order by subject
</cfquery>

</cfif>
<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">

<cfxml variable="data">
			<?xml version="1.0"?>
			<?mso-application progid="Excel.Sheet"?>
			<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
			<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
				<Author>Netiquette Technology</Author>
				<LastAuthor>Netiquette Technology</LastAuthor>
				<Company>Netiquette Technology</Company>
			</DocumentProperties>
			<Styles>
		  		<Style ss:ID="Default" ss:Name="Normal">
			   		<Alignment ss:Vertical="Bottom"/>
			   		<Borders/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>
			   		<Interior/>
			   		<NumberFormat/>
			   		<Protection/>
		  		</Style>
		  		<Style ss:ID="s22">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
		  		</Style>
			 	<Style ss:ID="s24">
			   		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
			  	</Style>
		  		<Style ss:ID="s26">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
		  		<Style ss:ID="s27">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
		  		<Style ss:ID="s30">
		   			<NumberFormat ss:Format="dd-mm-yy;@"/>
		  		</Style>
		  		<Style ss:ID="s31">
		  			<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
		  		<Style ss:ID="s32">
		  	 		<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s33">
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s34">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="dd/mm/yyyy;@"/>
		  		</Style>
		  		<Style ss:ID="s35">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0"/>
		  		</Style>
		  		<Style ss:ID="s36">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s37">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s38">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		  		<Style ss:ID="s39">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
                
                   <Style ss:ID="s50">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
                <Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
				   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>

		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Sales By Month Report">
            
            <Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="100.25"/>
					<Column ss:Width="200.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:Width="100.75"/>
					<Column ss:Width="100.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
					<cfset c="12">
					<cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_brand eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_category eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_group eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_sizeid eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_colorid eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_costcode eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_shelf eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
						<Column ss:AutoFitWidth="0" ss:Width="100.75"/>
						<cfset c=c+1>
   
   <cfoutput>                     
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfif isdefined("form.include")>
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#trantype# SALES BY MONTH REPORT (Included DN/CN)</Data></Cell>
    		<cfelse>
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#trantype# SALES BY MONTH REPORT (Excluded DN/CN)</Data></Cell>
	</cfif>
	</Row>
    
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText3">
        
      	<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">
	  		<cfswitch expression="#form.period#">
				<cfcase value="1">PERIOD 1 - 6</cfcase>
				<cfcase value="2">PERIOD 7 - 12</cfcase>
				<cfcase value="3">PERIOD 13 - 18</cfcase>
                <cfcase value="5">PERIOD #form.Poption#</cfcase>
                <cfcase value="6">PERIOD #wddxText3#</cfcase>
				<cfdefaultcase>ONE YEAR</cfdefaultcase>
			</cfswitch>
	  	</Data></Cell>
    </Row>
    
    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#form.catefrom# - #form.cateto#" output = "wddxText5">
          			<Cell ss:StyleID="s26"><Data ss:Type="String">CATEGORY: #wddxText5#</Data></Cell>
        </Row>
    </cfif>
    <cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                    	<cfwddx action = "cfml2wddx" input = "#form.itemfrom# - #form.itemto#" output = "wddxText6">
          				<Cell ss:StyleID="s26"><Data ss:Type="String">ITEM NO: #wddxText6#</Data></Cell>
        </Row>
    </cfif>
    <cfif form.agentfrom neq "" and form.agentto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                       <cfwddx action = "cfml2wddx" input = "#form.agentfrom# - #form.agentto#" output = "wddxText7">
          				<Cell ss:StyleID="s26"><Data ss:Type="String">AGENT: #wddxText7#</Data></Cell>
        </Row>
    </cfif>
    
    <cfif form.teamfrom neq "" and form.teamto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                       <cfwddx action = "cfml2wddx" input = "#form.teamfrom# - #form.teamto#" output = "wddxText8">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">: #wddxText8#</Data></Cell>
        </Row>
    </cfif>
    
    <cfif form.areafrom neq "" and form.areato neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                       <cfwddx action = "cfml2wddx" input = "#form.areafrom# - #form.areato#" output = "wddxText9">
          				<Cell ss:StyleID="s26"><Data ss:Type="String">AREA: #wddxText9#</Data></Cell>
        </Row>
    </cfif>
    <cfif form.userfrom neq "" and form.userto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                       <cfwddx action = "cfml2wddx" input = "#form.userfrom# - #form.userto#" output = "wddxText10">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">END USER: #wddxText10#</Data></Cell>
        </Row>
    </cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                       <cfwddx action = "cfml2wddx" input = "#form.groupfrom# - #form.groupto#" output = "wddxText11">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">GROUP: #wddxText11#</Data></Cell>
        </Row>
    </cfif>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
        <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText12">
        <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText13">
      	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
    </Row>
    
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">

		<Cell ss:StyleID="s50"><Data ss:Type="String">NO</Data></Cell>
      	<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
        <Cell ss:StyleID="s50"><Data ss:Type="String">Product Code.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_brand eq 'Y'>
        <Cell ss:StyleID="s50"><Data ss:Type="String">#getgsetup..lbrand#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_category eq 'Y'>
        <Cell ss:StyleID="s50"><Data ss:Type="String">#getgsetup..lcategory#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_group eq 'Y'>
        <Cell ss:StyleID="s50"><Data ss:Type="String">#getgsetup..lgroup#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_sizeid eq 'Y'>
        <Cell ss:StyleID="s50"><Data ss:Type="String">#getgsetup..lsize#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_colorid eq 'Y'>
        <Cell ss:StyleID="s50"><Data ss:Type="String">#getgsetup..lmaterial#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_costcode eq 'Y'>
        <Cell ss:StyleID="s50"><Data ss:Type="String">#getgsetup..lrating#.</Data></Cell>
        </cfif>
        <cfif getdisplaydetail.report_shelf eq 'Y'>
        <Cell ss:StyleID="s50"><Data ss:Type="String">#getgsetup..lmodel#.</Data></Cell>
        </cfif>
        
	  	<Cell ss:StyleID="s50"><Data ss:Type="String">DESP</Data></Cell>
        <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
        <cfswitch expression="#form.period#">
			<cfcase value="1">
				<cfloop index="l" from="1" to="6">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getdate.LastAccDate),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
			<cfcase value="2">
				<cfloop index="l" from="7" to="12">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getdate.LastAccDate),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
			<cfcase value="3">
				<cfloop index="l" from="13" to="18">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getdate.LastAccDate),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
            <cfcase value="5">
				<cfloop index="l" from="#form.poption#" to="#form.poption#">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getdate.LastAccDate),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
            <cfcase value="6">
				<cfloop index="l" from="#form.periodfrom#" to="#form.periodto#">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getdate.LastAccDate),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
			<cfdefaultcase>
				<cfloop index="l" from="1" to="18">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getdate.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
        <cfelse>
		<cfswitch expression="#form.period#">
			<cfcase value="1">
				<cfloop index="l" from="1" to="6">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
			<cfcase value="2">
				<cfloop index="l" from="7" to="12">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
			<cfcase value="3">
				<cfloop index="l" from="13" to="18">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
            <cfcase value="5">
				<cfloop index="l" from="#form.poption#" to="#form.poption#">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
            <cfcase value="6">
				<cfloop index="l" from="#form.periodfrom#" to="#form.periodto#">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
			<cfdefaultcase>
				<cfloop index="l" from="1" to="18">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
        </cfif>
	  	<Cell ss:StyleID="s50"><Data ss:Type="String">TOTAL</Data></Cell>
    </Row>
    
    
	<cfif form.period eq "1">
            <cfset startloop = "1">
            <cfset endloop = "6">
            <cfelseif form.period eq "2">
            <cfset startloop = "7">
            <cfset endloop = "12">
            <cfelseif form.period eq "3">
            <cfset startloop = "13">
            <cfset endloop = "18">
            <cfelseif form.period eq "4">
           <cfset startloop = "1">
            <cfset endloop = "18">
            <cfelseif form.period eq "5">
            <cfset startloop = form.poption>
            <cfset endloop = form.poption>
            <cfelseif form.period eq "6">
            <cfset startloop = form.periodfrom>
            <cfset endloop = form.periodto>
            </cfif>
            <cfloop index="a" from="#startloop#" to="#endloop#">
			<cfset monthtotal[a] = 0>
			</cfloop>
	<cfloop query="getdata">
    <cfquery name="getproductcode" datasource="#dts#">
            select aitemno,brand,category,wos_group,costcode,sizeid,colorid,shelf from icitem where itemno='#getdata.subject#'
            </cfquery>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
        <cfwddx action = "cfml2wddx" input = "#getdata.currentrow#" output = "wddxText27">
        <cfwddx action = "cfml2wddx" input = "#getdata.subject#" output = "wddxText28">
        <cfwddx action = "cfml2wddx" input = "#getdata.desp#" output = "wddxText30">
      

			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText27#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText28#</Data></Cell>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            	<cfwddx action = "cfml2wddx" input = "#getproductcode.aitemno#" output = "wddxText">
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_brand eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getproductcode.brand#" output = "wddxText">
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_category eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getproductcode.category#" output = "wddxText">
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_group eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getproductcode.wos_group#" output = "wddxText">
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_sizeid eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getproductcode.sizeid#" output = "wddxText">
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_colorid eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getproductcode.colorid#" output = "wddxText">
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_costcode eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getproductcode.costcode#" output = "wddxText">
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_shelf eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getproductcode.shelf#" output = "wddxText">
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText30#</Data></Cell>
			
            <cfloop from="#startloop#" to="#endloop#" index="i">
            <cfset columvalue = evaluate('getdata.p#numberformat(i,'00')#')>
         	<Cell ss:StyleID="s26"><Data ss:Type="String">
			<cfif form.label eq "salesqty" >#columvalue#
			<cfelse>#numberformat(columvalue,stDecl_UPrice)#
			</cfif>
            </Data></Cell>
            <cfset monthtotal[i] = monthtotal[i] + columvalue>
            </cfloop>
        <Cell ss:StyleID="s26"><Data ss:Type="String"><cfif form.label eq "salesqty" >#getdata.totalrow#<cfelse>#numberformat(getdata.totalrow,stDecl_UPrice)#</cfif></Data></Cell>
            <cfset grandtotal = grandtotal + getdata.totalrow>
		</Row>
	</cfloop>

        <Row ss:AutoFitHeight="0" ss:Height="20.0625">

			<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <Cell ss:StyleID="s51"/>
            </cfif>
            <cfif getdisplaydetail.report_brand eq 'Y'>
            <Cell ss:StyleID="s51"/>
            </cfif>
            <cfif getdisplaydetail.report_category eq 'Y'>
            <Cell ss:StyleID="s51"/>
            </cfif>
            <cfif getdisplaydetail.report_group eq 'Y'>
            <Cell ss:StyleID="s51"/>
            </cfif>
            <cfif getdisplaydetail.report_sizeid eq 'Y'>
            <Cell ss:StyleID="s51"/>
            </cfif>
            <cfif getdisplaydetail.report_colorid eq 'Y'>
            <Cell ss:StyleID="s51"/>
            </cfif>
            <cfif getdisplaydetail.report_costcode eq 'Y'>
            <Cell ss:StyleID="s51"/>
            </cfif>
            <cfif getdisplaydetail.report_shelf eq 'Y'>
            <Cell ss:StyleID="s51"/>
            </cfif>
        
    	<Cell ss:StyleID="s51"><Data ss:Type="String">TOTAL:</Data></Cell>
        <cfloop from="#startloop#" to="#endloop#" index="i">
         <Cell ss:StyleID="s51"><Data ss:Type="String"><cfif form.label eq "salesqty" >#val(monthtotal[i])#<cfelse>#numberformat(monthtotal[i],stDecl_UPrice)#</cfif></Data></Cell>
        </cfloop>
		
		<Cell ss:StyleID="s51"><Data ss:Type="String"><cfif form.label eq "salesqty" >#val(grandtotal)#<cfelse>#numberformat(grandtotal,stDecl_UPrice)#</cfif></Data></Cell>
	</Row>

</cfoutput>
</Table>
<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
		   	<Unsynced/>
		   	<Print>
				<ValidPrinterInfo/>
				<Scale>60</Scale>
				<HorizontalResolution>600</HorizontalResolution>
				<VerticalResolution>600</VerticalResolution>
		   	</Print>
		   	<Selected/>
		   	<Panes>
				<Pane>
					<Number>3</Number>
			 		<ActiveRow>20</ActiveRow>
			 		<ActiveCol>3</ActiveCol>
				</Pane>
		   	</Panes>
		   	<ProtectObjects>False</ProtectObjects>
		   	<ProtectScenarios>False</ProtectScenarios>
		  	</WorksheetOptions>
		 	</Worksheet>
			</Workbook>
		</cfxml>

		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls" output="#tostring(data)#" charset="utf-8">
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>

 
    <cfcase value="HTML">


<html>
<head>
<title>Product Sales By Month Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr>
	<cfif isdefined("form.include")>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#trantype# SALES BY MONTH REPORT (Included DN/CN)</strong></font></div></td>
    <cfelse>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#trantype# SALES BY MONTH REPORT (Excluded DN/CN)</strong></font></div></td>
	</cfif>
	</tr>
    <tr>
      	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">
	  		<cfswitch expression="#form.period#">
				<cfcase value="1">PERIOD 1 - 6</cfcase>
				<cfcase value="2">PERIOD 7 - 12</cfcase>
				<cfcase value="3">PERIOD 13 - 18</cfcase>
                <cfcase value="5">PERIOD #form.Poption#</cfcase>
                <cfcase value="6">PERIOD #form.periodfrom# - #form.periodto#</cfcase>
				<cfdefaultcase>ONE YEAR</cfdefaultcase>
			</cfswitch>
	  	</font></div>
	  	</td>
    </tr>
    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.catefrom# - #form.cateto#</font></div></td>
        </tr>
    </cfif>
    <cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #form.itemfrom# - #form.itemto#</font></div></td>
        </tr>
    </cfif>
    <cfif form.agentfrom neq "" and form.agentto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
        </tr>
    </cfif>
    
    <cfif form.teamfrom neq "" and form.teamto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">: #form.teamfrom# - #form.teamto#</font></div></td>
        </tr>
    </cfif>
    
    <cfif form.areafrom neq "" and form.areato neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
        </tr>
    </cfif>
    <cfif form.userfrom neq "" and form.userto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">END USER: #form.userfrom# - #form.userto#</font></div></td>
        </tr>
    </cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
        </tr>
    </cfif>
    <tr>
      	<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="19"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td><font size="2" face="Times New Roman, Times, serif">NO</font></td>
      	<td><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></td>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">PRODUCT CODE.</font></div></td>
        </cfif>
        	<cfif getdisplaydetail.report_brand eq 'Y'>
            <td><font size="2" face="Arial, Helvetica, sans-serif">#getgsetup.lbrand#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_category eq 'Y'>
            <td><font size="2" face="Arial, Helvetica, sans-serif">#getgsetup.lcategory#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_group eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgsetup.lgroup#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_sizeid eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgsetup.lsize#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_colorid eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgsetup.lmaterial#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_costcode eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgsetup.lrating#</font></td>
            </cfif>
            <cfif getdisplaydetail.report_shelf eq 'Y'>
            <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgsetup.lmodel#</font></td>
            </cfif>
	  	<td><font size="2" face="Times New Roman, Times, serif">DESP</font></td>
        <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
        <cfswitch expression="#form.period#">
			<cfcase value="1">
				<cfloop index="l" from="1" to="6">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getdate.LastAccDate),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfcase value="2">
				<cfloop index="l" from="7" to="12">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getdate.LastAccDate),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfcase value="3">
				<cfloop index="l" from="13" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getdate.LastAccDate),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
            <cfcase value="5">
				<cfloop index="l" from="#form.poption#" to="#form.poption#">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getdate.LastAccDate),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
            <cfcase value="6">
				<cfloop index="l" from="#form.periodfrom#" to="#form.periodto#">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getdate.LastAccDate),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfdefaultcase>
				<cfloop index="l" from="1" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getdate.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
        <cfelse>
		<cfswitch expression="#form.period#">
			<cfcase value="1">
				<cfloop index="l" from="1" to="6">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfcase value="2">
				<cfloop index="l" from="7" to="12">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfcase value="3">
				<cfloop index="l" from="13" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
            <cfcase value="5">
				<cfloop index="l" from="#form.poption#" to="#form.poption#">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
            <cfcase value="6">
				<cfloop index="l" from="#form.periodfrom#" to="#form.periodto#">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfdefaultcase>
				<cfloop index="l" from="1" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
        </cfif>
	  	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
			<cfif form.period eq "1">
            <cfset startloop = "1">
            <cfset endloop = "6">
            <cfelseif form.period eq "2">
            <cfset startloop = "7">
            <cfset endloop = "12">
            <cfelseif form.period eq "3">
            <cfset startloop = "13">
            <cfset endloop = "18">
            <cfelseif form.period eq "4">
           <cfset startloop = "1">
            <cfset endloop = "18">
            <cfelseif form.period eq "5">
            <cfset startloop = form.poption>
            <cfset endloop = form.poption>
            <cfelseif form.period eq "6">
            <cfset startloop = form.periodfrom>
            <cfset endloop = form.periodto>
            </cfif>
            <cfloop index="a" from="#startloop#" to="#endloop#">
			<cfset monthtotal[a] = 0>
			</cfloop>
	<cfloop query="getdata">
    <cfquery name="getproductcode" datasource="#dts#">
            select aitemno,brand,category,wos_group,costcode,sizeid,colorid,shelf from icitem where itemno='#getdata.subject#'
            </cfquery>
    	
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getdata.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getdata.subject#</font></td>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
        			<td><font size="2" face="Times New Roman, Times, serif">#getproductcode.aitemno#</font></td>
        			</cfif>
                    <cfif getdisplaydetail.report_brand eq 'Y'>
                                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.brand#</font></div></td>
                                </cfif>
                                <cfif getdisplaydetail.report_category eq 'Y'>
                                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.category#</font></div></td>
                                </cfif>
                                <cfif getdisplaydetail.report_group eq 'Y'>
                                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.wos_group#</font></div></td>
                                </cfif>
                                <cfif getdisplaydetail.report_sizeid eq 'Y'>
                                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.sizeid#</font></div></td>
                                </cfif>
                                <cfif getdisplaydetail.report_colorid eq 'Y'>
                                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.colorid#</font></div></td>
                                </cfif>
                                <cfif getdisplaydetail.report_costcode eq 'Y'>
                                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.costcode#</font></div></td>
                                </cfif>
                                <cfif getdisplaydetail.report_shelf eq 'Y'>
                                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getproductcode.shelf#</font></div></td>
                                </cfif>
            
			<td><font size="2" face="Times New Roman, Times, serif">#getdata.desp#</font></td>
			
            <cfloop from="#startloop#" to="#endloop#" index="i">
            <cfset columvalue = evaluate('getdata.p#numberformat(i,'00')#')>
            <td><div align="right">
            <font size="2" face="Times New Roman, Times, serif">
			<cfif form.label eq "salesqty" >#columvalue#
			<cfelse>
            #numberformat(columvalue,stDecl_UPrice)#
			</cfif>
            </font></div></td>
            <cfset monthtotal[i] = monthtotal[i] + columvalue>
            </cfloop>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif form.label eq "salesqty" >#getdata.totalrow#<cfelse>#numberformat(getdata.totalrow,stDecl_UPrice)#</cfif></font></div></td>
            <cfset grandtotal = grandtotal + getdata.totalrow>
		</tr>
	</cfloop>
	<tr>
    	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td></td>
		<td></td>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_brand eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_category eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_group eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_sizeid eq 'Y'>
               <td></td>
                </cfif>
                <cfif getdisplaydetail.report_colorid eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_costcode eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_shelf eq 'Y'>
                <td></td>
                </cfif>
        
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
        <cfloop from="#startloop#" to="#endloop#" index="i">
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif form.label eq "salesqty" >#val(monthtotal[i])#<cfelse>#numberformat(monthtotal[i],stDecl_UPrice)#</cfif><strong></strong></font></div></td>
        </cfloop>
		
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfif form.label eq "salesqty" >#val(grandtotal)#<cfelse>#numberformat(grandtotal,stDecl_UPrice)#</cfif></strong></font></div></td>
	</tr>
</table>
</cfoutput>
<cfquery name="emptyall" datasource="#dts#">
DELETE from salesmonthreport WHERE uuid = "#uuid#" 
</cfquery>

<cfif getdata.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
	<cfabort>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>

</cfcase>
</cfswitch>