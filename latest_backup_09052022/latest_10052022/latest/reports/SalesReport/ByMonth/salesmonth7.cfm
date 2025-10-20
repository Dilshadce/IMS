<cfset uuid = CreateUUID()>
<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,date_format(a.lastaccyear,'%Y-%m-%d') as lastaccyear,concat(',.',repeat('_',b.decl_uprice))as decl_uprice,agentlistuserid
	from gsetup as a, gsetup2 as b;
</cfquery>

<cfset grandtotal = 0>
<cfset monthtotal = arraynew(1)>

<cfswitch expression="#form.label#">
	<cfcase value="salesqty">
		<cfset stDecl_UPrice = ".__">
	</cfcase>
	<cfdefaultcase>
		<cfset stDecl_UPrice = getgeneral.decl_uprice>
	</cfdefaultcase>
</cfswitch>

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

<cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
	<cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = #form.thislastaccdate#
		limit 1
	</cfquery>
    <cfquery name="getitem" datasource="#dts#">
select a.brand,b.desp,a.itemno,sum(c.sumtotal) as sumtotal<cfif isdefined('form.include')>,sum(d.sumtotalcn) as sumtotalcn</cfif>,c.operiod from icitem as a
				left join
				(select brand,desp from brand) as b on a.brand=b.brand left join (

SELECT 
<cfif form.label eq "salesqty">
sum(qty)
<cfelse>
sum(amt)
</cfif>
as sumtotal
,itemno,wos_group,operiod FROM ictran 
WHERE type in("INV","CS"<cfif isdefined('form.include')>,"DN"</cfif>)
and (void = '' or void is null) 
and wos_date > #getdate.LastAccDate#
and wos_date <= #getdate.ThisAccDate#
and (linecode = "" or linecode is null)
<cfif form.periodfrom neq "" and form.periodto neq "">
    and operiod between "#numberformat(form.periodfrom,'00')#" and "#numberformat(form.periodto,'00')#"
<cfelse>
    and operiod between "01" and "18"
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and custno in (select custno from #target_arcust# where area between "#form.areafrom#" and "#form.areato#" group by custno)
</cfif>
<cfif form.enduserfrom neq "" and form.enduserto neq "">
and van between "#form.enduserfrom#" and "#form.enduserto#"
</cfif>
<cfif form.categoryfrom neq "" and form.categoryto neq "">
and category between "#form.categoryfrom#" and "#form.categoryto#"'
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
<cfif form.productfrom neq "" and form.productto neq "">
and itemno between '#form.productfrom#' and '#form.productto#' 
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
as c on a.itemno = c.itemno
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
,itemno,wos_group as groupcn,operiod as operiodcn FROM ictran 
WHERE type = "CN"
and (void = '' or void is null) 
and wos_date > #getdate.LastAccDate#
and wos_date <= #getdate.ThisAccDate#
and (linecode = "" or linecode is null)
<cfif form.periodfrom neq "" and form.periodto neq "">
	and operiod between "#numberformat(form.periodfrom,'00')#" and "#numberformat(form.periodto,'00')#"
<cfelse>
	and operiod between "01" and "18"
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and custno in (select custno from #target_arcust# where area between "#form.areafrom#" and "#form.areato#" group by custno)
</cfif>
<cfif form.enduserfrom neq "" and form.enduserto neq "">
and van between "#form.enduserfrom#" and "#form.enduserto#"
</cfif>
<cfif form.categoryfrom neq "" and form.categoryto neq "">
and category between "#form.categoryfrom#" and "#form.categoryto#"'
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
<cfif form.productfrom neq "" and form.productto neq "">
and itemno between '#form.productfrom#' and '#form.productto#' 
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
as d
ON a.itemno = d.itemno and c.operiod = d.operiodcn
</cfif>

where c.operiod !='' and c.operiod is not null

group by a.brand,c.operiod
</cfquery>


<cfquery name="emptyold" datasource="#dts#">
DELETE from salesmonthreport WHERE reportime < "#dateformat(dateadd('d','-1',now()),'YYYY-MM-DD')#"
</cfquery>

<cfquery name="insertitem" datasource="#dts#">
INSERT INTO salesmonthreport (subject,uuid,desp) select brand,"#uuid#" as uuid,desp from brand WHERE 1=1
<cfif form.groupfrom neq "" and form.groupto neq "">
and brand between "#form.brandfrom#" and "#form.brandto#"
</cfif>
</cfquery>
<cfquery name="insertitem" datasource="#dts#">
INSERT INTO salesmonthreport (subject,uuid,desp) values("","#uuid#" ,"No Brand")
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
WHERE subject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.brand#">
and uuid = "#uuid#"
</cfquery>
</cfloop>
<cfquery name="updatetabletotal" datasource="#dts#">
    UPDATE salesmonthreport SET totalrow = 
	<cfif form.periodfrom neq "" and form.periodto neq "">
		<cfset startloop = form.periodfrom>
        <cfset endloop = form.periodto>
        <cfloop from="#startloop#" to="#endloop#" index="i">
            P#numberformat(i,'00')#<cfif i neq endloop>+</cfif>
        </cfloop>
    <cfelse>
		<cfset startloop = 01>
        <cfset endloop = 18>
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

    <!--- --->
    <cfelse>
    <!--- --->
        
<cfquery name="getitem" datasource="#dts#">
select a.brand,b.desp,a.itemno,sum(c.sumtotal) as sumtotal<cfif isdefined('form.include')>,sum(d.sumtotalcn) as sumtotalcn</cfif>,c.fperiod from icitem as a
				left join
				(select brand,desp from brand) as b on a.brand=b.brand left join (

SELECT 
<cfif form.label eq "salesqty">
sum(qty)
<cfelse>
sum(amt)
</cfif>
as sumtotal
,itemno,wos_group,fperiod FROM ictran 
WHERE type in("INV","CS"<cfif isdefined('form.include')>,"DN"</cfif>)
and (void = '' or void is null) 
and wos_date > "#getgeneral.lastaccyear#"
and (linecode = "" or linecode is null)
<cfif form.periodfrom neq "" and form.periodto neq "">
	and fperiod between "#numberformat(form.periodfrom,'00')#" and "#numberformat(form.periodto,'00')#"
<cfelse>
	and fperiod between "01" and "18"
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and custno in (select custno from #target_arcust# where area between "#form.areafrom#" and "#form.areato#" group by custno)
</cfif>
<cfif form.enduserfrom neq "" and form.enduserto neq "">
and van between "#form.enduserfrom#" and "#form.enduserto#"
</cfif>
<cfif form.categoryfrom neq "" and form.categoryto neq "">
and category between "#form.categoryfrom#" and "#form.categoryto#"'
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
<cfif form.productfrom neq "" and form.productto neq "">
and itemno between '#form.productfrom#' and '#form.productto#' 
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
as c on a.itemno = c.itemno
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
,itemno,wos_group as groupcn,fperiod as fperiodcn FROM ictran 
WHERE type = "CN"
and (void = '' or void is null) 
and wos_date > "#getgeneral.lastaccyear#"
and (linecode = "" or linecode is null)
<cfif form.periodfrom neq "" and form.periodto neq "">
	and fperiod between "#numberformat(form.periodfrom,'00')#" and "#numberformat(form.periodto,'00')#"
<cfelse>
	and fperiod between "01" and "18"
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and custno in (select custno from #target_arcust# where area between "#form.areafrom#" and "#form.areato#" group by custno)
</cfif>
<cfif form.enduserfrom neq "" and form.enduserto neq "">
and van between "#form.enduserfrom#" and "#form.enduserto#"
</cfif>
<cfif form.categoryfrom neq "" and form.categoryto neq "">
and category between "#form.categoryfrom#" and "#form.categoryto#"'
</cfif>
<cfif form.groupfrom neq "" and form.groupto neq "">
and wos_group between "#form.groupfrom#" and "#form.groupto#"
</cfif>
<cfif form.productfrom neq "" and form.productto neq "">
and itemno between '#form.productfrom#' and '#form.productto#' 
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
as d
ON a.itemno = d.itemno and c.fperiod = d.fperiodcn
</cfif>

where c.fperiod !='' and c.fperiod is not null

group by a.brand,c.fperiod
</cfquery>


<cfquery name="emptyold" datasource="#dts#">
DELETE from salesmonthreport WHERE reportime < "#dateformat(dateadd('d','-1',now()),'YYYY-MM-DD')#"
</cfquery>

<cfquery name="insertitem" datasource="#dts#">
INSERT INTO salesmonthreport (subject,uuid,desp) select brand,"#uuid#" as uuid,desp from brand WHERE 1=1
<cfif form.groupfrom neq "" and form.groupto neq "">
and brand between "#form.brandfrom#" and "#form.brandto#"
</cfif>
</cfquery>
<cfquery name="insertitem" datasource="#dts#">
INSERT INTO salesmonthreport (subject,uuid,desp) values("","#uuid#" ,"No Brand")
</cfquery>
<cfloop query="getitem">
<cfif isdefined('form.include')>
<cfset lasamount = val(getitem.sumtotal) - val(getitem.sumtotalcn)>
<cfelse>
<cfset lasamount = val(getitem.sumtotal)>
</cfif>
<cfquery name="updatedata" datasource="#dts#">
UPDATE salesmonthreport SET 
p#numberformat(getitem.fperiod,'00')# = <cfqueryparam cfsqltype="cf_sql_double" value="#val(lasamount)#">
WHERE subject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.brand#">
and uuid = "#uuid#"
</cfquery>
</cfloop>
<cfquery name="updatetabletotal" datasource="#dts#">
    UPDATE salesmonthreport SET totalrow = 
    <cfif form.periodfrom neq "" and form.periodto neq "">
		<cfset startloop = form.periodfrom>
        <cfset endloop = form.periodto>
        <cfloop from="#startloop#" to="#endloop#" index="i">
            P#numberformat(i,'00')#<cfif i neq endloop>+</cfif>
        </cfloop>
    <cfelse>
		<cfset startloop = 01>
        <cfset endloop = 18>
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
	<cfcase value="EXCEL">
    
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
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" />
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
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
				<Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
				</Style>

		 	</Styles>    

			<Worksheet ss:Name="Print Profit Margin Report">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="80.25"/>
					<Column ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:Width="80.75"/>
					<Column ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
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
     <cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText2">
      	<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">
	  		<cfif form.periodfrom neq "" and form.periodto neq "">
                PERIOD #wddxText2#
			<cfelse>
            	ONE YEAR			
            </cfif>
</Data></Cell>
    </Row>
    
    <cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.categoryfrom# - #form.categoryto#" output = "wddxText3">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">CATEGORY: #wddxText3#</Data></Cell>
        </Row>
    </cfif>
    
    <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.productfrom# - #form.productto#" output = "wddxText4">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">PRODUCT NO: #wddxText4#</Data></Cell>
        </Row>
    </cfif>
    <cfif form.agentfrom neq "" and form.agentto neq "">
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.agentfrom# - #form.agentto#" output = "wddxText5">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">AGENT: #wddxText5#</Data></Cell>
        </Row>
    </cfif>
    
    <cfif form.teamfrom neq "" and form.teamto neq "">
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.teamfrom# - #form.teamto#" output = "wddxText6">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">: #wddxText6#</Data></Cell>
        </Row>
    </cfif>
    
    <cfif form.areafrom neq "" and form.areato neq "">
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.areafrom# - #form.areato#" output = "wddxText7">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">AREA: #wddxText7#</Data></Cell>
        </Row>
    </cfif>
    <cfif form.enduserfrom neq "" and form.enduserto neq "">
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.enduserfrom# - #form.enduserto#" output = "wddxText8">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">END USER: #wddxText8#</Data></Cell>
        </Row>
    </cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.groupfrom# - #form.groupto#" output = "wddxText9">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">GROUP: #wddxText9#</Data></Cell>
        </Row>
    </cfif>
    <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.brandfrom# - #form.brandto#" output = "wddxText10">
          	<Cell ss:StyleID="s26"><Data ss:Type="String">BRAND: #wddxText10#</Data></Cell>
        </Row>
    </cfif>
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText11">
     		<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText12">
      
      	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
    </Row>
    
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:StyleID="s50"><Data ss:Type="String">NO</Data></Cell>
      	<Cell ss:StyleID="s50"><Data ss:Type="String">PRODUCT NO.</Data></Cell>
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
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<cfloop index="l" from="#form.periodfrom#" to="#form.periodto#">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			<cfelse>
				<cfloop index="l" from="1" to="18">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfif>
        </cfif>
	  	<Cell ss:StyleID="s50"><Data ss:Type="String">TOTAL</Data></Cell>
    </Row>
    
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<cfset startloop = form.periodfrom>
                <cfset endloop = form.periodto>
            <cfelse>
            	<cfset startloop = 01>
                <cfset endloop = 18>
            </cfif>
            <cfloop index="a" from="#startloop#" to="#endloop#">
			<cfset monthtotal[a] = 0>
			</cfloop>
	<cfloop query="getdata">
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     		<cfwddx action = "cfml2wddx" input = "#getdata.currentrow#" output = "wddxText13">
     		<cfwddx action = "cfml2wddx" input = "#getdata.subject#" output = "wddxText14">
     		<cfwddx action = "cfml2wddx" input = "#getdata.desp#" output = "wddxText15">
            
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText14#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText15#</Data></Cell>
			
            <cfloop from="#startloop#" to="#endloop#" index="i">
            <cfset columvalue = evaluate('getdata.p#numberformat(i,'00')#')>
            <Cell ss:StyleID="s26"><Data ss:Type="String">
			<cfif form.label eq "salesqty" >#columvalue#
			<cfelse>
            #numberformat(columvalue,stDecl_UPrice)#
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
	  	<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
 		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
	  	<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
	  	<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
	  	<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
        </Row>
        
        
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
    	<Cell ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
        <cfloop from="#startloop#" to="#endloop#" index="i">
        <Cell ss:StyleID="s26"><Data ss:Type="String"><cfif form.label eq "salesqty" >#val(monthtotal[i])#<cfelse>#numberformat(monthtotal[i],stDecl_UPrice)#</cfif></Data></Cell>
        </cfloop>
		
		<Cell ss:StyleID="s38"><Data ss:Type="String"><cfif form.label eq "salesqty" >#val(grandtotal)#<cfelse>#numberformat(grandtotal,stDecl_UPrice)#</cfif></Data></Cell>
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
<title>Brand Sales By Month Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
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
	  		<cfif form.periodfrom neq "" and form.periodto neq "">
            	PERIOD #form.periodfrom# - #form.periodto#
			<cfelse>
            	ONE YEAR
            </cfif>
	  	</font></div>
	  	</td>
    </tr>
    <cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.categoryfrom# - #form.categoryto#</font></div></td>
        </tr>
    </cfif>
    <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">PRODUCT NO: #form.productfrom# - #form.productto#</font></div></td>
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
    <cfif form.enduserfrom neq "" and form.enduserto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">END USER: #form.enduserfrom# - #form.enduserto#</font></div></td>
        </tr>
    </cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
        </tr>
    </cfif>
    <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">BRAND: #form.brandfrom# - #form.brandto#</font></div></td>
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
      	<td><font size="2" face="Times New Roman, Times, serif">PRODUCT NO.</font></td>
	  	<td><font size="2" face="Times New Roman, Times, serif">DESP</font></td>
        <cfif isdefined("form.thislastaccdate") and form.thislastaccdate neq "">
        	<cfif form.periodfrom neq "" and form.periodto neq "">
				<cfloop index="l" from="#form.periodfrom#" to="#form.periodto#">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getdate.LastAccDate),"mmm yy")#</font></div></td>
				</cfloop>
			<cfelse>]
				<cfloop index="l" from="1" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getdate.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfif>
        <cfelse>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<cfloop index="l" from="#form.periodfrom#" to="#form.periodto#">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			<cfelse>
				<cfloop index="l" from="1" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfif>
        </cfif>
	  	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<cfset startloop = form.periodfrom>
                <cfset endloop = form.periodto>
            <cfelse>
            	<cfset startloop = 01>
                <cfset endloop = 18>
            </cfif>
            <cfloop index="a" from="#startloop#" to="#endloop#">
			<cfset monthtotal[a] = 0>
			</cfloop>
	<cfloop query="getdata">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getdata.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getdata.subject#</font></td>
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