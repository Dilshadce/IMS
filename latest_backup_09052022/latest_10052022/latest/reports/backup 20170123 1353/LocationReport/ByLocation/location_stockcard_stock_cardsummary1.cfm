

<cfif getpin2.h4G00 eq "T">
<script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>
<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfif isdefined('form.dodate')>
<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	and itemno between '#form.productfrom#' and '#form.productto#'
</cfif> group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>
</cfif> 

<cfquery name="getnonactivelocation" datasource="#dts#">
select location from iclocation where noactivelocation='Y'
</cfquery>
<cfset nonactivelocation=valuelist(getnonactivelocation.location)>

<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandbalanceqty" default="0">

<cfparam name="subqtybf" default="0">
<cfparam name="subqtyin" default="0">
<cfparam name="subqtyout" default="0">
<cfparam name="subbalanceqty" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select 
	cost,
	compro,
	lastaccyear,
    singlelocation
	from gsetup;
</cfquery>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>
	
	<cfif dd greater than "12">
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>
	
	<cfif dd greater than "12">
		<cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

<cfquery name="insert_new_location_item" datasource="#dts#">
	insert ignore into locqdbf 
	(
		itemno,
		location
	)
	(
		select 
		itemno,
		location 
		from ictran 
		where location<>''
		and (linecode <> 'SV' or linecode is null)
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif> 
        <cfif getgeneral.singlelocation eq 'Y'>
        <cfif form.locationfrom neq "">
			and location = '#form.locationfrom#'
		</cfif>
        <cfelse>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
        </cfif>
		group by location,itemno
		order by location,itemno
	)
</cfquery>


<!---<cfquery name="getlocation" datasource="#dts#">
	select itemno,desp from icitem where 0=0
    <cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
		and category between '#form.categoryfrom#' and '#form.categoryto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group between '#form.groupfrom#' and '#form.groupto#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
        <cfif (lcase(hcomid) eq "swisspost_i"  or lcase(hcomid) eq "swisspostdemo_i") and husergrpid eq "luser">
		<cfset wos_group = HUserid >
        and wos_group = "#wos_group#"
        </cfif>
		order by itemno
</cfquery>
---->

 <cfif thislastaccdate neq "">
<cfquery name="getdate" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year
		where LastAccDate = "#thislastaccdate#"
		limit 1
	</cfquery>

<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
            <cfif isdefined('form.groupitem')>substring_index(a.location,'-',1) as location<cfelse>a.location</cfif>,
			aa.desp,
            aa.despa,
            aa.aitemno,
            aa.unit,
            aa.photo,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			(ifnull(sum(a.locqfield),0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			(ifnull(sum(a.locqfield),0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,ifnull(f.soqty,0) as soqty
			from <cfif isdefined('form.groupitem')>(select sum(locqfield) as locqfield,itemno,location from locqdbf_last_year group by substring_index(location,'-',1),itemno order by itemno)<cfelse>(SELECT locqfield,itemno,location from locqdbf_last_year WHERE LastAccDate = "#thislastaccdate#")</cfif> as a 
			
			right join 
			(
				select 
				itemno,
                unit,
                photo,
                aitemno,
				desp,
                despa
				from icitem 
				where itemno<>'' 
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
				and category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
                
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
                <cfif (lcase(hcomid) eq "swisspost_i"  or lcase(hcomid) eq "swisspostdemo_i") and husergrpid eq "luser">
				<cfset wos_group = huserid >
                and wos_group = "#wos_group#"
                </cfif>
				order by itemno
			) as aa on a.itemno=aa.itemno 
			
			left join
			(
				select 
				<cfif isdefined('form.groupitem')>substring_index(location,'-',1) as </cfif>location,
				itemno,
				sum(qty) as getlastin 
				from ictran
				where type in ('RC','CN','OAI','TRIN') 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and operiod+0 < '#form.periodfrom#' 
				</cfif>
				and fperiod='99'
                and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date < '#ndatefrom#' 
<!--- 				<cfelse>
					and wos_date < #getdate.LastAccDate# --->
				</cfif>
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				<cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif> 
				group by itemno
				order by itemno
			) as b on a.itemno=b.itemno
		
			left join
			(
				select 
				<cfif isdefined('form.groupitem')>substring_index(location,'-',1) as </cfif>location,
				itemno,
				sum(qty) as getlastout 
				from ictran
				where 
                <cfif isdefined('form.dodate')>
                (type in ('PR','CS','DN','ISS','OAR','TROU','DO')  or 
				(type='INV' and (dono = "" or dono is null or dono not in (
                <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">
				))))
				<cfelse>
                type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
                and (toinv='' or toinv is null) 
				</cfif>
                and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate# 
				<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date < '#ndatefrom#' 
<!--- 				<cfelse>
					and wos_date < #getdate.LastAccDate# --->
	    		</cfif> 
				and fperiod='99'
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and operiod+0 < '#form.periodfrom#' 
				</cfif>
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null) 
				<cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date < '#ndatefrom#'
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
				order by itemno
			) as c on a.itemno=c.itemno 
		
			left join
			(
				select 
				<cfif isdefined('form.groupitem')>substring_index(location,'-',1) as </cfif>location,
				itemno,
				sum(qty) as qin 
				from ictran 
				where type in ('RC','CN','OAI','TRIN')
				and fperiod='99' 
                and operiod between '#form.periodfrom#' and '#form.periodto#' 
				and (void = '' or void is null)  
				and (linecode <> 'SV' or linecode is null)
				<cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate#  
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
				order by itemno
			) as d on a.itemno=d.itemno
		
			left join
			(
				select 
				<cfif isdefined('form.groupitem')>substring_index(location,'-',1) as </cfif>location,
				itemno,
				sum(qty) as qout 
				from ictran 
				where 
                <cfif isdefined('form.dodate')>
                (type in ('PR','CS','DN','ISS','OAR','TROU','DO')  or 
				(type='INV' and (dono = "" or dono is null or dono not in (
                <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">
				))))
				<cfelse>
                type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
                and (toinv='' or toinv is null) 
				</cfif>
                
				and fperiod='99' 
                and operiod between '#form.periodfrom#' and '#form.periodto#'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate#  
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
				order by itemno
			) as e on a.itemno=e.itemno
            
            
            left join
			(
				select 
				<cfif isdefined('form.groupitem')>substring_index(location,'-',1) as </cfif>location,
				itemno,
				sum(qty-writeoff-shipped) as soqty 
				from ictran 
				where 
                
                type ='SO'
                and (toinv='' or toinv is null) 

                
				and fperiod='99' 
                and operiod between '#form.periodfrom#' and '#form.periodto#' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
				and wos_date > #getdate.LastAccDate#
				and wos_date <= #getdate.ThisAccDate#  
	    		<cfif form.datefrom neq "" and form.dateto neq "">
	    			and wos_date between '#ndatefrom#' and '#ndateto#'
	    		</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
				order by itemno
			) as f on a.itemno=f.itemno
			
			where a.location<>''

			<cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
            <!---and a.location not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#nonactivelocation#">)--->
			group by itemno
            order by a.itemno
		</cfquery>


<cfelse>

        
        
        
		<cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
            aa.despa,
            aa.unit,
            aa.aitemno,
            <cfif isdefined('form.groupitem')>substring_index(a.location,'-',1) as location<cfelse>a.location</cfif>,
			aa.desp,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			(ifnull(sum(a.locqfield),0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf,
			(ifnull(sum(a.locqfield),0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
            ifnull(f.soqty,0) as soqty
			from <cfif isdefined('form.groupitem')>(select sum(locqfield) as locqfield,itemno,location from locqdbf group by substring_index(location,'-',1),itemno order by itemno)<cfelse>locqdbf</cfif> as a 
			
			right join 
			(
				select 
				itemno,
                unit,
                aitemno,
				desp,despa
				from icitem 
				where itemno<>'' 
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
				and category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
                
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
                <cfif (lcase(hcomid) eq "swisspost_i"  or lcase(hcomid) eq "swisspostdemo_i") and husergrpid eq "luser">
				<cfset wos_group = huserid >
                and wos_group = "#wos_group#"
                </cfif>
				order by itemno
			) as aa on a.itemno=aa.itemno 
			
			left join
			(
				select 
				<cfif isdefined('form.groupitem')>substring_index(location,'-',1) as </cfif>location,
				itemno,
				sum(qty) as getlastin 
				from ictran
				where type in ('RC','CN','OAI','TRIN') 
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod < '#form.periodfrom#' 
				</cfif>
				and fperiod<>'99'
				and (void = '' or void is null) 
				and (linecode <> 'SV' or linecode is null)
				<cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date < '#ndatefrom#' 
				</cfif>

				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif> 
				group by itemno
				order by itemno
			) as b on a.itemno=b.itemno
		
			left join
			(
				select 
				<cfif isdefined('form.groupitem')>substring_index(location,'-',1) as </cfif>location,
				itemno,
				sum(qty) as getlastout 
				from ictran
				where 
                <cfif isdefined('form.dodate')>
                (type in ('PR','CS','DN','ISS','OAR','TROU','DO')  or 
				(type='INV' and (dono = "" or dono is null or dono not in (
                <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">
				))))
				<cfelse>
                type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
                and (toinv='' or toinv is null) 
				</cfif>
                <cfif form.datefrom neq "" and form.dateto neq ""><cfelse>
				and fperiod < '#form.periodfrom#' 
                </cfif>
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null) 
				<cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date < '#ndatefrom#'
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
				order by itemno
			) as c on a.itemno=c.itemno 
		
			left join
			(
				select 
				<cfif isdefined('form.groupitem')>substring_index(location,'-',1) as </cfif>location,
				itemno,
				sum(qty) as qin 
				from ictran 
				where type in ('RC','CN','OAI','TRIN')
				and fperiod<>'99' 
				and (void = '' or void is null)  
				and (linecode <> 'SV' or linecode is null)
				<cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
				order by itemno
			) as d on a.itemno=d.itemno 
		
			left join
			(
				select 
				<cfif isdefined('form.groupitem')>substring_index(location,'-',1) as </cfif>location,
				itemno,
				sum(qty) as qout 
				from ictran 
				where 
                <cfif isdefined('form.dodate')>
                (type in ('PR','CS','DN','ISS','OAR','TROU','DO')  or 
				(type='INV' and (dono = "" or dono is null or dono not in (
                <cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">
				))))
				<cfelse>
                type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
                and (toinv='' or toinv is null) 
				</cfif>
                
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
				order by itemno
			) as e on a.itemno=e.itemno 
            
            
            left join
			(
				select 
				<cfif isdefined('form.groupitem')>substring_index(location,'-',1) as </cfif>location,
				itemno,
				sum(qty-writeoff-shipped) as soqty 
				from ictran 
				where 
                type ='SO' 
                and (toinv='' or toinv is null) 
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date between '#ndatefrom#' and '#ndateto#'
				</cfif> 
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				group by itemno
				order by itemno
			) as f on a.itemno=f.itemno
            
            
			
			where a.location<>''

			<cfif form.locationfrom neq "" and form.locationto neq "">
                    and a.location between '#form.locationfrom#' and '#form.locationto#'
            </cfif>
            <!---and a.location not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#nonactivelocation#">)--->
			group by itemno
            order by a.location,a.itemno
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
		  			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
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

		 	</Styles>
			
			<Worksheet ss:Name="Stock Card Summary Report">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="60.25"/>
					<Column ss:Width="200.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:Width="60.75"/>
					<Column ss:Width="60.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
				<cfoutput>

                
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String"><cfif hcomid eq "pnp_i">LOCATION STOCK CARD DETAILS<cfelse><cfif lcase(hcomid) eq "mhca_i">MARKETER<cfelse>LOCATION</cfif> STOCK CARD SUMMARY</cfif></Data></Cell>
					</Row>
                    
                    
	<cfif form.periodfrom neq "" and form.periodto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">PERIOD: #wddxText#</Data></Cell>
      	</Row>
        
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
     		<cfwddx action = "cfml2wddx" input = "#dateformat(dateadd('m',form.periodfrom,getgeneral.lastaccyear),"mmm yy")# - #dateformat(dateadd('m',form.periodto,getgeneral.lastaccyear),"mmm yy")#" output = "wddxText1">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText1#</Data></Cell>
      	</Row>
	</cfif>
    
    <cfif form.locationfrom neq "" and form.locationto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.locationfrom# - #form.locationto#" output = "wddxText2">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Location: #wddxText2#</Data></Cell>
      	</Row>
	</cfif>
    
        <cfif form.productfrom neq "" and form.productto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.productfrom# - #form.productto#" output = "wddxText3">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Product: #wddxText3#</Data></Cell>
      	</Row>
	</cfif>
    
    <cfif form.datefrom neq "" and form.dateto neq "">
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
     		<cfwddx action = "cfml2wddx" input = "#form.datefrom# - #form.dateto#" output = "wddxText4">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Date: #wddxText4#</Data></Cell>
      	</Row>
	</cfif>
    
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
     		<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText5">
     		<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText6">
		<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      		<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
    	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
	</Row>
    
	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s50"><Data ss:Type="String">NO.</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
         <cfif getdisplaydetail.report_aitemno eq 'Y'>

         <Cell ss:StyleID="s50"><Data ss:Type="String">Product Code</Data></Cell>
         </cfif>
		<Cell ss:StyleID="s50"><Data ss:Type="String">DESPCRIPTION</Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String">UOM</Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String">QTYBF</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">IN</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">OUT</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">BALANCE</Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String">PHOTO</Data></Cell>
	</Row>
		<cfloop query="getitem">
      
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s26"><Data ss:Type="String">#getitem.currentrow#.</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#getitem.itemno#</Data></Cell>
                 <cfif getdisplaydetail.report_aitemno eq 'Y'><Cell ss:StyleID="s26"><Data ss:Type="String">#getitem.aitemno#</Data></Cell>
</cfif>
        
                <Cell ss:StyleID="s26"><Data ss:Type="String">#getitem.DESP#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#getitem.unit#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#getitem.qtybf#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#getitem.qin#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#getitem.qout#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#getitem.balance#</Data></Cell>
                <!---<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif getitem.photo neq ''><img src="/images/#dts#/#getitem.photo#" width="100" height="100"></cfif></Data></Cell>--->
                <cfset grandqtybf=grandqtybf+val(getitem.qtybf)>
				<cfset grandqtyin=grandqtyin+val(getitem.qin)>
                <cfset grandqtyout=grandqtyout+val(getitem.qout)>
                <cfset grandbalanceqty=grandbalanceqty+val(getitem.balance)>

			</Row>
		</cfloop>
	  	
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
        </cfif>
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
        <Cell ss:StyleID="s31"><Data ss:Type="String">TOTAL:</Data></Cell>
        <Cell ss:StyleID="s31"><Data ss:Type="String">#numberformat(grandqtybf,"0")#</Data></Cell>
        <Cell ss:StyleID="s31"><Data ss:Type="String">#numberformat(grandqtyin,"0")#</Data></Cell>
        <Cell ss:StyleID="s31"><Data ss:Type="String">#numberformat(grandqtyout,"0")#</Data></Cell>
        <Cell ss:StyleID="s31"><Data ss:Type="String">#numberformat(grandbalanceqty,"0")#</Data></Cell>
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
<title><cfif hcomid eq "pnp_i">View Location Stock Card Details<cfelse>View <cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> Stock Card Summary</cfif></title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandbalanceqty" default="0">

<cfparam name="subqtybf" default="0">
<cfparam name="subqtyin" default="0">
<cfparam name="subqtyout" default="0">
<cfparam name="subbalanceqty" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select 
	cost,
	compro,
	lastaccyear,
    singlelocation
	from gsetup;
</cfquery>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>
	
	<cfif dd greater than "12">
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>
	
	<cfif dd greater than "12">
		<cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>


<body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>>

<table align="center" border="0" width="100%">
	<tr>
		<td colspan="100%"><div align="center"><font size="3" face="Times New Roman,Times,serif"><strong><cfif hcomid eq "pnp_i">LOCATION STOCK CARD DETAILS<cfelse><cfif lcase(hcomid) eq "mhca_i">MARKETER<cfelse>LOCATION</cfif> STOCK CARD SUMMARY</cfif></strong></font></div></td>
	</tr>
	<cfoutput>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">
				#dateformat(dateadd('m',form.periodfrom,getgeneral.lastaccyear),"mmm yy")# - #dateformat(dateadd('m',form.periodto,getgeneral.lastaccyear),"mmm yy")#
			</font></div></td>		
		</tr>
	</cfif>
    <cfif form.locationfrom neq "" and form.locationto neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Location: #form.locationfrom# - #form.locationto#</font></div></td>
		</tr>
	</cfif>
        <cfif form.productfrom neq "" and form.productto neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Product: #form.productfrom# - #form.productto#</font></div></td>
		</tr>
	</cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date: #form.datefrom# - #form.dateto#</font></div></td>
		</tr>
	</cfif>
	<tr>
		<td colspan="3"><div align="left"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></div></td>
    	<td colspan="5"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
	</tr>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">NO.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM NO.</font></div></td>
         <cfif getdisplaydetail.report_aitemno eq 'Y'>



         <td><div align="left"><font size="2" face="Times New Roman,Times,serif">Product Code</font></div></td>
         </cfif>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">DESPCRIPTION</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">UOM</font></div></td>
       
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">QTYBF</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">IN</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">OUT</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">BALANCE</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman,Times,serif">PHOTO</font></div></td>
    </tr>
	<tr>
      	<td colspan="100%"><hr></td>
    </tr>
		<cfloop query="getitem">
      
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getitem.currentrow#.</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getitem.itemno#</font></div></td>
                 <cfif getdisplaydetail.report_aitemno eq 'Y'>
<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getitem.aitemno#</font></div></td>

</cfif>
        
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getitem.DESP#</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getitem.unit#</font></div></td>
                

				
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getitem.qtybf#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getitem.qin#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getitem.qout#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getitem.balance#</font></div></td>
                <td><!---<cfif getitem.photo neq ''><img src="/images/#dts#/#getitem.photo#" width="100" height="100"></cfif>---></td>
                <cfset grandqtybf=grandqtybf+val(getitem.qtybf)>
				<cfset grandqtyin=grandqtyin+val(getitem.qin)>
                <cfset grandqtyout=grandqtyout+val(getitem.qout)>
                <cfset grandbalanceqty=grandbalanceqty+val(getitem.balance)>

			</tr>
		</cfloop>
     <tr>
        <td></td>
        <td></td>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
        <td></td>
        </cfif>
        <td></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(grandqtybf,"0")#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(grandqtyin,"0")#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(grandqtyout,"0")#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(grandbalanceqty,"0")#</font></div></td>
    </tr>
</cfoutput>

</table>

<cfif getitem.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>
</cfcase>
</cfswitch>