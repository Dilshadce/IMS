


<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid,ddllocation from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>


<cfif isdefined('form.locationFrom') and isdefined('form.locationTo')>
<cfif form.locationFrom neq "" and form.locationTo neq "">
<cfquery name="getalllocation" datasource='#dts#'>
select refno from ictran where location >='#form.locationFrom#' and location <= '#form.locationTo#'
</cfquery>
<cfset billlocation = valuelist(getalllocation.refno)>
			</cfif>
</cfif>

    
<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>
	<cfif dd greater than '12'>
		<cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>
    
  
<cfset grouptotal=0>
<cfset catetotal=0>
<cfset itemtotal=0>
<cfset billtotal=0>
<cfset agenttotal=0>

<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">

 <cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  <cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

	<cfquery name="gettotal" datasource="#dts#">
			select sum(invgross) as invgross,sum(roundadj) as roundadj,sum(m_charge1) as m_charge1,sum(discount) as discount,sum(net) as net,sum(tax) as tax,sum(grand) as grand,sum(CS_PM_cash) as CS_PM_cash,sum(CS_PM_crcd)+sum(CS_PM_crc2) as CS_PM_crcd,sum(CS_PM_cheq) as CS_PM_cheq,sum(CS_PM_vouc) as CS_PM_vouc,sum(CS_PM_dbcd) as CS_PM_dbcd,sum(CS_PM_cashcd) as CS_PM_cashcd,sum(deposit) as deposit, taxincl from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
		</cfquery>
        
        <cfquery name="getvisa" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype1='VISA')
		</cfquery>
        
        <cfquery name="getvisa2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype2='VISA')
		</cfquery>
        
        <cfquery name="getmaster" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype1='MASTER')
		</cfquery>
        
        <cfquery name="getmaster2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype2='MASTER')
		</cfquery>
        
        <cfquery name="getamex" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype1='AMEX')
		</cfquery>
        
        <cfquery name="getamex2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype2='AMEX')
		</cfquery>
        
        
        
        <cfquery name="getcup" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype1='CUP')
		</cfquery>
        
        <cfquery name="getcup2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype2='CUP')
		</cfquery>
        
         <cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  <cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>
        
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
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                
                 <Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
                <Style ss:ID="s52">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                
                <Style ss:ID="s53">
                <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
                
                <Style ss:ID="s54">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Daily Checkout Report">
            <Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="180.5"/>
					<Column ss:Width="60.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="27.75"/>
					<Column ss:Width="47.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
                        
        <cfoutput>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#getgeneral.ddllocation#" output = "wddxText">
        <Cell ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
         </Row>
         
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		 <Cell ss:StyleID="s22"><Data ss:Type="String">Daily Checkout Report</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<cfwddx action = "cfml2wddx" input = "#dateformat(now(),'DD/MM/YYYY')# #timeformat(now(),'HH:MM')#" output = "wddxText1">
				<Cell ss:StyleID="s22"><Data ss:Type="String">Printing : #wddxText1#</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
               <cfwddx action = "cfml2wddx" input = "#getgeneral.ddllocation#" output = "wddxText2">
			<Cell ss:StyleID="s24"><Data ss:Type="String">Counter : #wddxText2#</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
               <cfwddx action = "cfml2wddx" input = "#huserid#" output = "wddxText3">
			<Cell ss:StyleID="s22"><Data ss:Type="String">Casher : #wddxText3#</Data></Cell>
			</Row>
            
			<cfif form.datefrom neq "" and form.dateto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
             <cfwddx action = "cfml2wddx" input = "#form.datefrom# - #form.dateto#" output = "wddxText4">
			<Cell ss:StyleID="s24"><Data ss:Type="String">#wddxText4#</Data></Cell>
				</Row>
			</cfif>

		<cfif gettotal.taxincl EQ "T">
        	<cfset gettotal.net = Val(gettotal.grand) - Val(gettotal.M_charge1) - Val(gettotal.roundadj) - Val(gettotal.tax)>
        </cfif>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s50"><Data ss:Type="String">Sales Record</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
			</Row>
		
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.invgross,',_.__')#" output = "wddxText5">
           <Cell ss:StyleID="s26"><Data ss:Type="String">Gross Total :</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
           <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.discount,',_.__')#" output = "wddxText6">
           <Cell ss:StyleID="s26"><Data ss:Type="String">Discount Total :</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.net,',_.__')#" output = "wddxText7">
           <Cell ss:StyleID="s26"><Data ss:Type="String">Net Total :</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.tax,',_.__')#" output = "wddxText8">
            <Cell ss:StyleID="s26"><Data ss:Type="String">Tax Total :</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.roundadj,',_.__')#" output = "wddxText9">
            <Cell ss:StyleID="s26"><Data ss:Type="String">Rounding Adjustment :</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.M_charge1,',_.__')#" output = "wddxText10">
            <Cell ss:StyleID="s26"><Data ss:Type="String">Misc Charges Total :</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.grand,',_.__')#" output = "wddxText11">
            <Cell ss:StyleID="s26"><Data ss:Type="String">Grand Total :</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
			</Row>

        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s50"><Data ss:Type="String">Cash Sales Detail</Data></Cell>
			<Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
			</Row>
			
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:StyleID="s52"><Data ss:Type="String">Mode of Payment</Data></Cell>
			<Cell ss:StyleID="s52"><Data ss:Type="String">Amount</Data></Cell>
			</Row>
          
<cfif val(gettotal.grand) eq 0>
<cfset gettotal.grand=1>
</cfif>
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.CS_PM_Cash,',_.__')#" output = "wddxText12">
            <Cell ss:StyleID="s26"><Data ss:Type="String">Cash :</Data></Cell>
			 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.CS_PM_dbcd,',_.__')#" output = "wddxText13">
            <Cell ss:StyleID="s26"><Data ss:Type="String">Nets :</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crcd),',_.__')#" output = "wddxText14">
            <Cell ss:StyleID="s26"><Data ss:Type="String"><cfif lcase(hcomid) eq "kjpe_i">Visa<cfelse>Cash Card</cfif> :</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif lcase(hcomid) eq "kjpe_i">#wddxText14#<cfelse>#numberformat(gettotal.CS_PM_Cashcd,',_.__')#</cfif></Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crcd),',_.__')#" output = "wddxText15">
            	<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif lcase(hcomid) eq "kjpe_i">Master<cfelse>Credit Card</cfif> :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif lcase(hcomid) eq "kjpe_i">#wddxText15#<cfelse>#numberformat(gettotal.CS_PM_crcd,',_.__')#</cfif></Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(val(getamex.CS_PM_crcd)+val(getamex2.CS_PM_crcd),',_.__')#" output = "wddxText16">
            	<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif lcase(hcomid) eq "kjpe_i">Amex<cfelse>Cheque</cfif> :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String"><cfif lcase(hcomid) eq "kjpe_i">#wddxText16#<cfelse>#numberformat(gettotal.CS_PM_cheq,',_.__')#</cfif></Data></Cell>
			</Row>
            
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.CS_PM_vouc,',_.__')#" output = "wddxText17">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">Voucher :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText17#</Data></Cell>
			</Row>
            
            <cfif lcase(hcomid) neq "kjpe_i">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
    <cfwddx action = "cfml2wddx" input = "#numberformat(val(gettotal.CS_PM_Cash)+val(gettotal.CS_PM_vouc)+val(gettotal.CS_PM_crcd)+val(gettotal.CS_PM_cheq),',_.__')#" output = "wddxText18">
            <Cell ss:StyleID="s52"><Data ss:Type="String">Total Payment:</Data></Cell>
			<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText18#</Data></Cell>
			</Row>
            </cfif>
            
             <cfoutput>
               
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s26"><Data ss:Type="String">Credit Card Detail</Data></Cell>
			</Row>
            
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s52"><Data ss:Type="String">Card Details</Data></Cell>
			<Cell ss:StyleID="s52"><Data ss:Type="String">Amount</Data></Cell>
			</Row>
            
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crcd),',_.__')#" output = "wddxText35">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">Visa</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText35#</Data></Cell>
			</Row>
            
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crcd),',_.__')#" output = "wddxText36">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">Master</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText36#</Data></Cell>
			</Row>
            
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(val(getamex.CS_PM_crcd)+val(getamex2.CS_PM_crcd),',_.__')#" output = "wddxText37">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">Amex</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText37#</Data></Cell>
			</Row>
            </cfoutput>
            
            <cfquery name="getcashsalesno" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
			
		</cfquery>
        
        <cfquery name="getinvoiceno" datasource="#dts#">
			select refno from artran
			where type='INV' and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
			
		</cfquery>
        
        <cfquery name="getSOno" datasource="#dts#">
			select refno from artran
			where type='SO' and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
			
		</cfquery>
        
        <cfquery name="getvoidno" datasource="#dts#">
			select refno from artran
			where type in ('INV','CS') and void='Y'
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
			
		</cfquery>
            
            <cfquery name="getdeposit" datasource="#dts#">
			select refno from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            and deposit<>0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
			
		</cfquery>
        
        
                     
            
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s53"><Data ss:Type="String">Bills Record</Data></Cell>
			</Row>
            
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(getcashsalesno.recordcount,',_.__')#" output = "wddxText19">
           <Cell ss:StyleID="s26"><Data ss:Type="String">No of Cash Sales :</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText19#</Data></Cell>
			</Row>
            
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getvoidno.recordcount,',_.__')#" output = "wddxText20">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">No of VOID :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText20#</Data></Cell>
			</Row>
            
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getinvoiceno.recordcount,',_.__')#" output = "wddxText21">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">No of Invoice :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText21#</Data></Cell>
			</Row>
            
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getSOno.recordcount,',_.__')#" output = "wddxText22">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">No of Sales Order :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText22#</Data></Cell>
			</Row>
            
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getdeposit.recordcount,',_.__')#" output = "wddxText23">
            	<Cell ss:StyleID="s26"><Data ss:Type="String">No of Deposit :</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText23#</Data></Cell>
			</Row>
            
            <cfquery name="getopening" datasource="#dts#">
			select openning from dailycounter
			where type='Opening'
			<cfif form.counter neq "">
			and counterid ='#form.counter#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date = '#ndatefrom#'
            </cfif>
			</cfquery>
            
            <cfquery name="getcashin" datasource="#dts#">
			select sum(openning) as cashin from dailycounter
			where type='cashin'
			<cfif form.counter neq "">
			and counterid ='#form.counter#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date = '#ndatefrom#'
            </cfif>
			</cfquery>
            
            <cfquery name="getcashout" datasource="#dts#">

			select sum(openning) as cashout from dailycounter
			where type='cashin'
			<cfif form.counter neq "">
			and counterid ='#form.counter#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date = '#ndatefrom#'
            </cfif>
			</cfquery>
            
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s53"><Data ss:Type="String">Cash In Drawer</Data></Cell>
			</Row>
            
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(getopening.openning,',_.__')#" output = "wddxText24">
            <Cell ss:StyleID="s26"><Data ss:Type="String">Opening</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText24#</Data></Cell>
			</Row>
            
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(getcashin.cashin,',_.__')#" output = "wddxText25">
           <Cell ss:StyleID="s26"><Data ss:Type="String">Total Cash In</Data></Cell>
		   <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText25#</Data></Cell>
			</Row>
            
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(getcashout.cashout,',_.__')#" output = "wddxText26">
            <Cell ss:StyleID="s26"><Data ss:Type="String">Total Cash Out</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText26#</Data></Cell>
			</Row>
            
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(gettotal.grand,',_.__')#" output = "wddxText27">
            <Cell ss:StyleID="s26"><Data ss:Type="String">Collection</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText27#</Data></Cell>
			</Row>
            
             <cfquery name="getcategorytran" datasource="#dts#">
			select sum(amt) as amt,category from ictran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and location >='#form.locationFrom#' and location <= '#form.locationTo#'
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and refno in(select refno from artran where counter='#form.counter#' and (type='CS' or type='INV'))
			</cfif>
            
			group by category
		</cfquery>
		
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s54"><Data ss:Type="String">Transaction Detail : Category</Data></Cell>
			</Row>
            
            <cfloop query="getcategorytran">
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#getcategorytran.category#" output = "wddxText28">
            <cfwddx action = "cfml2wddx" input = "#numberformat(getcategorytran.amt,',_.__')#" output = "wddxText29">
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText28#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText29#</Data></Cell>
			</Row>
            <cfset catetotal=catetotal+getcategorytran.amt>

            </cfloop>
           
            <cfif lcase(hcomid) neq "kjpe_i">
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(catetotal,',_.__')#" output = "wddxText30">
            	<Cell ss:StyleID="s51"><Data ss:Type="String">Total :</Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText30#</Data></Cell>
			</Row>
            </cfif>
            
            <cfquery name="getgrouptran" datasource="#dts#">
			select sum(amt) as amt,wos_group from ictran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and location >='#form.locationFrom#' and location <= '#form.locationTo#'
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and refno in(select refno from artran where counter='#form.counter#' and (type='CS' or type='INV'))
			</cfif>
			group by wos_group
		</cfquery>
	
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s54"><Data ss:Type="String">Transaction Detail : Group</Data></Cell>
			</Row>
            
            <cfloop query="getgrouptran">
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#getgrouptran.wos_group#" output = "wddxText31">
            <cfwddx action = "cfml2wddx" input = "#numberformat(getgrouptran.amt,',_.__')#" output = "wddxText32">
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText31#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText32#</Data></Cell>
			</Row>
			<cfset grouptotal=grouptotal+getgrouptran.amt>

            </cfloop>
            <cfif lcase(hcomid) neq "kjpe_i">
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <cfwddx action = "cfml2wddx" input = "#numberformat(grouptotal,',_.__')#" output = "wddxText33">
            <Cell ss:StyleID="s51"><Data ss:Type="String">Total :</Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText33#</Data></Cell>
			</Row>
            </cfif>
           
		
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
		<title>Cash Sales Summary Report</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>

		<body>
		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  <cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<cfquery name="gettotal" datasource="#dts#">
			select sum(invgross) as invgross,sum(roundadj) as roundadj,sum(m_charge1) as m_charge1,sum(discount) as discount,sum(net) as net,sum(tax) as tax,sum(grand) as grand,sum(CS_PM_cash) as CS_PM_cash,sum(CS_PM_crcd)+sum(CS_PM_crc2) as CS_PM_crcd,sum(CS_PM_cheq) as CS_PM_cheq,sum(CS_PM_vouc) as CS_PM_vouc,sum(CS_PM_dbcd) as CS_PM_dbcd,sum(CS_PM_cashcd) as CS_PM_cashcd,sum(permitno) as permitno,sum(rem5) as rem5,sum(deposit) as deposit, taxincl from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
		</cfquery>
        
        <cfquery name="getvisa" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype1='VISA')
		</cfquery>
        
        <cfquery name="getvisa2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype2='VISA')
		</cfquery>
        
        <cfquery name="getmaster" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype1='MASTER')
		</cfquery>
        
        <cfquery name="getmaster2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype2='MASTER')
		</cfquery>
        
        <cfquery name="getamex" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype1='AMEX')
		</cfquery>
        
        <cfquery name="getamex2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype2='AMEX')
		</cfquery>
        
        <cfquery name="getcup" datasource="#dts#">
			select sum(CS_PM_crcd) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype1='CUP')
		</cfquery>
        
        <cfquery name="getcup2" datasource="#dts#">
			select sum(CS_PM_crc2) as CS_PM_crcd from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            and (creditcardtype2='CUP')
		</cfquery>

		<cfoutput>
		<table width="230px" style="font-size:11px; border-width:thin;" cellpadding="0" cellspacing="0" >
        	<tr>
				<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#getgeneral.ddllocation#</strong></font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Daily Checkout Report</strong></font></div></td>
			</tr>
            <tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Printing : #dateformat(now(),'DD/MM/YYYY')# #timeformat(now(),'HH:MM')#</font></div></td>
			</tr>
            <tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Counter : #getgeneral.ddllocation#</font></div></td>
			</tr>
            <tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Casher : #huserid#</font></div></td>
			</tr>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
			
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
            
            <cfif gettotal.taxincl EQ "T">
        		<cfset gettotal.net = Val(gettotal.grand) - Val(gettotal.M_charge1) - Val(gettotal.roundadj) - Val(gettotal.tax)>
        	</cfif>
            
            <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Sales Record</strong></font></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
            
			<tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Gross Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.invgross,',_.__')#</font></td>
			</tr>
            <cfif lcase(hcomid) eq "tcds_i">

            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Voucher Discount :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(gettotal.permitno),',_.__')#</font></td>
              
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">VIP $ Discount :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(gettotal.rem5),',_.__')#</font></td>
              
			</tr>
           	<cfelse>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Discount Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.discount,',_.__')#</font></td>
			</tr>
            </cfif>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Net Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.net,',_.__')#</font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Tax Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.tax,',_.__')#</font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Rounding Adjustment :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.roundadj,',_.__')#</font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Misc Charges Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.M_charge1,',_.__')#</font></td>
			</tr>
          
            
            <cfif lcase(hcomid) eq "tcds_i">
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Deposit Amount :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(gettotal.deposit),',_.__')#</font></td>
			</tr>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Grand Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(val(gettotal.grand)-val(gettotal.deposit),',_.__')#</font></td>
			</tr>
            <cfelse>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Grand Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.grand,',_.__')#</font></td>
			</tr>
            </cfif>
            
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
				<td colspan="100%"><br></td>
			</tr>
            <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Cash Sales Detail</strong></font></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Mode of Payment</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">Amount</font></td>
                
			</tr>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
            
<cfif val(gettotal.grand) eq 0>
<cfset gettotal.grand=1>
</cfif>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Cash :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.CS_PM_Cash,',_.__')#</font></td>
                
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Nets :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.CS_PM_dbcd,',_.__')#</font></td>
                
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "kjpe_i">Visa<cfelse>Cash Card</cfif> :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "kjpe_i">#numberformat(val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crcd),',_.__')#<cfelse>#numberformat(gettotal.CS_PM_Cashcd,',_.__')#</cfif></font></td>
                
			</tr>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "kjpe_i">Master<cfelse>Credit Card</cfif> :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "kjpe_i">#numberformat(val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crcd),',_.__')#<cfelse>#numberformat(gettotal.CS_PM_crcd,',_.__')#</cfif></font></td>
               
			</tr>
            <cfif lcase(hcomid) neq "tcds_i">
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "kjpe_i">Amex<cfelse>Cheque</cfif> :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "kjpe_i">#numberformat(val(getamex.CS_PM_crcd)+val(getamex2.CS_PM_crcd),',_.__')#<cfelse>#numberformat(gettotal.CS_PM_cheq,',_.__')#</cfif></font></td>
              
			</tr>
            </cfif>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Voucher :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.CS_PM_vouc,',_.__')#</font></td>
               
			</tr>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
            <cfif lcase(hcomid) neq "kjpe_i">
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Total Payment:</font></td>
				<td><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "tcds_i">#numberformat(val(gettotal.CS_PM_Cash)+val(gettotal.CS_PM_vouc)+val(gettotal.CS_PM_crcd)+val(gettotal.CS_PM_dbcd),',_.__')#<cfelse>#numberformat(val(gettotal.CS_PM_Cash)+val(gettotal.CS_PM_vouc)+val(gettotal.CS_PM_crcd)+val(gettotal.CS_PM_cheq)+val(gettotal.CS_PM_dbcd),',_.__')#</cfif></font></td>
                
			</tr>
            </cfif>
            
           <tr>
				<td colspan="100%"><br></td>
			</tr>
              <cfoutput>
               
            <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Credit Card Detail</strong></font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Card Details</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">Amount</font></td>
                
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Visa</font></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getvisa.CS_PM_crcd)+val(getvisa2.CS_PM_crcd),',_.__')#</font></div></td>
                
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Master</font></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getmaster.CS_PM_crcd)+val(getmaster2.CS_PM_crcd),',_.__')#</font></div></td>
                
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Amex</font></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getamex.CS_PM_crcd)+val(getamex2.CS_PM_crcd),',_.__')#</font></div></td>
                
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Cup</font></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getcup.CS_PM_crcd)+val(getcup2.CS_PM_crcd),',_.__')#</font></div></td>
                
			</tr>
            </cfoutput>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
            
			<tr>
				<td colspan="100%"><br></td>
			</tr>
          
            
            <cfquery name="getcashsalesno" datasource="#dts#">
			select refno from artran
			where type='CS' and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
			
		</cfquery>
        
        <cfquery name="getinvoiceno" datasource="#dts#">
			select refno from artran
			where type='INV' and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
			
		</cfquery>
        
        <cfquery name="getSOno" datasource="#dts#">
			select refno from artran
			where type='SO' and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
			
		</cfquery>
        
        <cfquery name="getvoidno" datasource="#dts#">
			select refno from artran
			where type in ('INV','CS') and void='Y'
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
			<cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
            
		</cfquery>
            
            <cfquery name="getdeposit" datasource="#dts#">
			select refno from artran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
            and deposit<>0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and counter ='#form.counter#'
			</cfif>
            <cfif form.cashier neq "">
			and cashier ='#form.cashier#'
			</cfif>
			
		</cfquery>
            
            <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Bills Record</strong></font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">No of Cash Sales :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getcashsalesno.recordcount,',_.__')#</font></td>
                
			</tr>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">No of VOID :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getvoidno.recordcount,',_.__')#</font></td>
                
			</tr>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">No of Invoice :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getinvoiceno.recordcount,',_.__')#</font></td>
                
			</tr>
            
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">No of Sales Order :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getSOno.recordcount,',_.__')#</font></td>
                
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">No of Deposit :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getdeposit.recordcount,',_.__')#</font></td>
                
			</tr>
            
            
			 <tr>
				<td colspan="100%"><br></td>
			</tr>
            
            <cfquery name="getopening" datasource="#dts#">
			select sum(openning) as openning from dailycounter
			where type='Opening'
			<cfif form.counter neq "">
			and counterid ='#form.counter#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and location between '#form.locationFrom#' and  '#form.locationTo#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date = '#ndatefrom#'
            </cfif>
			</cfquery>
            
            <cfquery name="getcashin" datasource="#dts#">
			select sum(openning) as cashin from dailycounter
			where type='cashin'
			<cfif form.counter neq "">
			and counterid ='#form.counter#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date = '#ndatefrom#'
            </cfif>
			</cfquery>
            
            <cfquery name="getcashout" datasource="#dts#">
			select sum(openning) as cashout from dailycounter
			where type='cashin'
			<cfif form.counter neq "">
			and counterid ='#form.counter#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date = '#ndatefrom#'
            </cfif>
			</cfquery>
            
        	<tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Cash In Drawer</strong></font></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Opening</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getopening.openning,',_.__')#</font></td>
                
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Total Cash In</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getcashin.cashin,',_.__')#</font></td>
                
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Total Cash Out</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getcashout.cashout,',_.__')#</font></td>
                
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Collection</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(gettotal.grand,',_.__')#</font></td>
                
			</tr>
           
            
            
             <cfquery name="getcategorytran" datasource="#dts#">
			select sum(amt) as amt,category from ictran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and location >='#form.locationFrom#' and location <= '#form.locationTo#'
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and refno in(select refno from artran where counter='#form.counter#' and (type='CS' or type='INV'))
			</cfif>
            
			group by category
		</cfquery>
		<tr>
				<td colspan="100%"><br></td>
			</tr>
        <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Transaction Detail : Category</strong></font></td>
			</tr>
            <cfloop query="getcategorytran">
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">#getcategorytran.category#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getcategorytran.amt,',_.__')#</font></td>
                
			</tr>
            <cfset catetotal=catetotal+getcategorytran.amt>

            </cfloop>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
            <cfif lcase(hcomid) neq "kjpe_i">
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(catetotal,',_.__')#</font></td>
                
			</tr>
            </cfif>
            
            <cfquery name="getgrouptran" datasource="#dts#">
			select sum(amt) as amt,wos_group from ictran
			where type in ('CS'<cfif lcase(hcomid) neq 'mika_i'>,'INV'</cfif>) and (void = '' or void is null)
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.locationFrom neq "" and form.locationTo neq "">
			and location >='#form.locationFrom#' and location <= '#form.locationTo#'
			</cfif>
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
            <cfif form.counter neq "">
			and refno in(select refno from artran where counter='#form.counter#' and (type='CS' or type='INV'))
			</cfif>
			group by wos_group
		</cfquery>
		<tr>
				<td colspan="100%"><br></td>
			</tr>
        <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Transaction Detail : Group</strong></font></td>
			</tr>
            <cfloop query="getgrouptran">
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">#getgrouptran.wos_group#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(getgrouptran.amt,',_.__')#</font></td>
                
			</tr>
			<cfset grouptotal=grouptotal+getgrouptran.amt>

            </cfloop>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
            <cfif lcase(hcomid) neq "kjpe_i">
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Total :</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#numberformat(grouptotal,',_.__')#</font></td>
                
			</tr>
            </cfif>
           
		  </table>
		</cfoutput>

		
		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>
        </cfcase>
        </cfswitch>