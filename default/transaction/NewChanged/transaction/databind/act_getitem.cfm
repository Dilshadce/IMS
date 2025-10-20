<cfsetting showdebugoutput="false"><cfsilent>
<cfset value = "">
<cfset tabchr = Chr(13) & Chr(10)> 
<cfset text = URLDECODE(url.text)>
<cfif text neq "">
<cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "maven_i" or lcase(HcomID) eq "uniq_i">
	<cfquery name="getitem" datasource="#dts#">
		select itemno, concat(desp,' ',despa) as desp
		from icitem 
		where (nonstkitem<>'T' or nonstkitem is null) 
		<cfif searchtype neq "" and text neq "">
			<cfif searchtype eq "itemno">
				and upper(itemno) like '%#ucase(text)#%'
			<cfelseif searchtype eq "desp">
                <cfloop list="#text#" index="i" delimiters=" ">
                and (upper(desp) like '%#ucase(i)#%' or upper(despa) LIKE '%#ucase(i)#%')
                </cfloop>
			<cfelseif searchtype eq "category">
				and upper(category) like '%#ucase(text)#%'
                <cfelseif searchtype eq "aitemno">
				and upper(aitemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "wos_group">
				and upper(wos_group) like '%#ucase(text)#%'
			<cfelseif searchtype eq "brand">
				and upper(brand) like '%#ucase(text)#%'
            <cfelseif searchtype eq "sizeid">
				and upper(sizeid) like '%#ucase(text)#%'
            <cfelseif searchtype eq "colorid">
				and upper(colorid) like '%#ucase(text)#%'
			</cfif>
		</cfif>
        <cfif Hitemgroup neq ''>
            and wos_group='#Hitemgroup#'
            </cfif>
		order by itemno
	</cfquery>
<cfelseif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
<cfquery name="getitem" datasource="#dts#">
		select itemno, concat(aitemno,' - ',desp) as desp
		from icitem 
		where (nonstkitem<>'T' or nonstkitem is null) 
		<cfif searchtype neq "" and text neq "">
			<cfif searchtype eq "itemno">
				and upper(itemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "desp">
				and (upper(desp) like '#ucase(text)#%' or upper(despa) LIKE '%#ucase(text)#%')
			<cfelseif searchtype eq "category">
				and upper(category) like '#ucase(text)#%'
            <cfelseif searchtype eq "aitemno">
				and upper(aitemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "wos_group">
				and upper(wos_group) like '#ucase(text)#%'
			<cfelseif searchtype eq "brand">
				and upper(brand) like '#ucase(text)#%'
            <cfelseif searchtype eq "sizeid">
				and upper(sizeid) like '%#ucase(text)#%'
            <cfelseif searchtype eq "colorid">
				and upper(colorid) like '%#ucase(text)#%'
			</cfif>
		</cfif>
        <cfif Hitemgroup neq ''>
            and wos_group='#Hitemgroup#'
            </cfif>
		order by itemno
	</cfquery>
    
<cfelseif lcase(hcomid) eq "sdc_i">
<cfquery name="getitem" datasource="#dts#">
		select itemno, concat(desp,' - ',fcurrcode) as desp
		from icitem 
		where (nonstkitem<>'T' or nonstkitem is null) 
		<cfif searchtype neq "" and text neq "">
			<cfif searchtype eq "itemno">
				and upper(itemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "desp">
				and (upper(desp) like '#ucase(text)#%' or upper(despa) LIKE '%#ucase(text)#%')
			<cfelseif searchtype eq "category">
				and upper(category) like '#ucase(text)#%'
                <cfelseif searchtype eq "aitemno">
				and upper(aitemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "wos_group">
				and upper(wos_group) like '#ucase(text)#%'
			<cfelseif searchtype eq "brand">
				and upper(brand) like '#ucase(text)#%'
            <cfelseif searchtype eq "sizeid">
				and upper(sizeid) like '%#ucase(text)#%'
            <cfelseif searchtype eq "colorid">
				and upper(colorid) like '%#ucase(text)#%'
			</cfif>
		</cfif>
        <cfif Hitemgroup neq ''>
            and wos_group='#Hitemgroup#'
            </cfif>
		order by itemno
	</cfquery>
    
<cfelseif lcase(hcomid) eq "laihock_i" and isdefined('url.tran')>

<cfif url.tran eq 'DO'>
<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>

<cfquery name="getitem" datasource="#dts#">
		select a.itemno, a.desp
		from icitem as a
        
        left join 
        (
            select itemno,sum(qty) as sumtotalin 
            from ictran 
            where type in ('RC','CN','OAI','TRIN') 
            and fperiod<>'99'
            and (void = '' or void is null)
            group by itemno
        ) as b on a.itemno=b.itemno
        
        left join 
        (
            select itemno,sum(qty) as sumtotalout 
            from ictran 
            where
            (type in ('DO','DN','CS','OAR','PR','ISS','TROU') or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
            and fperiod<>'99'
            and (void = '' or void is null)
            
            group by itemno
        ) as c on a.itemno=c.itemno
        
        
		where (a.nonstkitem<>'T' or a.nonstkitem is null) 
		<cfif searchtype neq "" and text neq "">
			<cfif searchtype eq "itemno">
				and upper(a.itemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "desp">
				and (upper(a.desp) like '#ucase(text)#%' or upper(a.despa) LIKE '%#ucase(text)#%')
			<cfelseif searchtype eq "category">
				and upper(a.category) like '#ucase(text)#%'
                <cfelseif searchtype eq "aitemno">
				and upper(a.aitemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "wos_group">
				and upper(a.wos_group) like '#ucase(text)#%'
			<cfelseif searchtype eq "brand">
				and upper(a.hbrand) like '#ucase(text)#%'
            
			</cfif>
		</cfif>
        <cfif Hitemgroup neq ''>
            and a.wos_group='#Hitemgroup#'
            </cfif>
        and ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0) <> 0
		order by a.itemno
	</cfquery>
    <cfelse>
    <cfquery name="getitem" datasource="#dts#">
		select itemno, desp 
		from icitem 
		where (nonstkitem<>'T' or nonstkitem is null) 
		<cfif searchtype neq "" and text neq "">
			<cfif searchtype eq "itemno">
				and upper(itemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "desp">
				and (upper(desp) like '#ucase(text)#%' or upper(despa) LIKE '%#ucase(text)#%')
                <cfelseif searchtype eq "aitemno">
				and upper(aitemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "category">
				and upper(category) like '#ucase(text)#%'
			<cfelseif searchtype eq "wos_group">
				and upper(wos_group) like '#ucase(text)#%'
			<cfelseif searchtype eq "brand">
				and upper(brand) like '#ucase(text)#%'
            <cfelseif searchtype eq "sizeid">
				and upper(sizeid) like '%#ucase(text)#%'
            <cfelseif searchtype eq "colorid">
				and upper(colorid) like '%#ucase(text)#%'
			</cfif>
		</cfif>
        <cfif Hitemgroup neq ''>
            and wos_group='#Hitemgroup#'
            </cfif>
		order by itemno
	</cfquery>
    
    </cfif>
    
<cfelseif lcase(hcomid) eq "excelhw_i">

<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>

<cfquery name="getitem" datasource="#dts#">
		select a.itemno, concat(a.desp,' - ',round(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0))) as desp
		from icitem as a
        
        left join 
        (
            select itemno,sum(qty) as sumtotalin 
            from ictran 
            where type in ('RC','CN','OAI','TRIN') 
            and fperiod<>'99'
            and (void = '' or void is null)
            group by itemno
        ) as b on a.itemno=b.itemno
        
        left join 
        (
            select itemno,sum(qty) as sumtotalout 
            from ictran 
            where
            (type in ('DO','DN','CS','OAR','PR','ISS','TROU') or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
            and fperiod<>'99'
            and (void = '' or void is null)
            
            group by itemno
        ) as c on a.itemno=c.itemno
        
        
		where (a.nonstkitem<>'T' or a.nonstkitem is null) 
		<cfif searchtype neq "" and text neq "">
			<cfif searchtype eq "itemno">
				and upper(a.itemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "desp">
				and (upper(a.desp) like '#ucase(text)#%' or upper(a.despa) LIKE '%#ucase(text)#%')
			<cfelseif searchtype eq "category">
				and upper(a.category) like '#ucase(text)#%'
                <cfelseif searchtype eq "aitemno">
				and upper(a.aitemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "wos_group">
				and upper(a.wos_group) like '#ucase(text)#%'
			<cfelseif searchtype eq "brand">
				and upper(a.hbrand) like '#ucase(text)#%'
            
			</cfif>
		</cfif>
        <cfif Hitemgroup neq ''>
            and a.wos_group='#Hitemgroup#'
            </cfif>
		order by a.itemno
	</cfquery>
    
<cfelse>
<cfquery name="getitem" datasource="#dts#">
		select itemno, desp 
		from icitem 
		where (nonstkitem<>'T' or nonstkitem is null) 
		<cfif searchtype neq "" and text neq "">
			<cfif searchtype eq "itemno">
				and upper(itemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "desp">
				and (upper(desp) like '#ucase(text)#%' or upper(despa) LIKE '%#ucase(text)#%')
                <cfelseif searchtype eq "aitemno">
				and upper(aitemno) like '#ucase(text)#%'
			<cfelseif searchtype eq "category">
				and upper(category) like '#ucase(text)#%'
			<cfelseif searchtype eq "wos_group">
				and upper(wos_group) like '#ucase(text)#%'
			<cfelseif searchtype eq "brand">
				and upper(brand) like '#ucase(text)#%'
            <cfelseif searchtype eq "sizeid">
				and upper(sizeid) like '%#ucase(text)#%'
            <cfelseif searchtype eq "colorid">
				and upper(colorid) like '%#ucase(text)#%'
			</cfif>
		</cfif>
        <cfif Hitemgroup neq ''>
            and wos_group='#Hitemgroup#'
            </cfif>
		order by itemno
	</cfquery>


</cfif>
	<cfif getitem.recordcount neq 0>
		<cfset itemnolist = valuelist(getitem.itemno,";;")>
		<cfset itemdesclist = valuelist(getitem.desp,";;")>
	<cfelse>
		<cfset itemnolist = "-1">
		<cfset itemdesclist = "No Record Found">
	</cfif>
<cfelse>
	<cfset itemnolist = "-1">
	<cfset itemdesclist = "Please Filter The Item">
</cfif>

<cfset header = "count|error|msg|itemnolist|itemdesclist">
<cfset value = "1|0|0|#URLEncodedFormat(itemnolist)#|#URLEncodedFormat(itemdesclist)##tabchr#">	
</cfsilent><cfif isdefined('url.new') eq false><cfoutput>#header##tabchr##value#</cfoutput><cfelse><cfsetting showdebugoutput="no"><cfoutput>
<select id="itemno" name='itemno' onChange="showImage(this.value);change_picture(this.value);">
<cfif itemnolist eq "-1">
<option value="-1">#itemdesclist#</option>
<cfelse>
<cfloop query="getitem">
<option value="#getitem.itemno#">#getitem.itemno# - #getitem.desp#</option>
</cfloop>
</cfif>
</select>
</cfoutput></cfif>