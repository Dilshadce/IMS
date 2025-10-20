
<cfif getpin2.h4G00 eq "T">
	<script language="JavaScript">
var popup="Sorry, right-click is disabled.";
 function noway(go) { if
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers)
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers)
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>
<cfset form.customerFrom=trim(form.customerFrom)>
<cfset form.customerTo=trim(form.customerTo)>
<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>
<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>
<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>
<cfparam name="ndatefrom" default="">
<cfparam name="ndateto" default="">
<cfparam name="totalamt" default="0">
<cfparam name="totaldisc" default="0">
<cfparam name="totalnet" default="0">
<cfparam name="totaltax" default="0">
<cfparam name="totalgrand" default="0">
<cfparam name="totalfcamt" default="0">
<cfparam name="totaldeposit" default="0">
<cfparam name="totalbalance" default="0">
<cfset tranname=''>
<cfif url.trancode eq 'INV'>
	<cfset tranname = getgeneral.linv>
<cfelseif url.trancode eq 'CS'>
	<cfset tranname = getgeneral.lCS>
<cfelseif url.trancode eq 'DO'>
	<cfset tranname = getgeneral.lDO>
<cfelseif url.trancode eq 'PO'>
	<cfset tranname = getgeneral.lPO>
<cfelseif url.trancode eq 'SO'>
	<cfset tranname = getgeneral.lSO>
<cfelseif url.trancode eq 'QUO'>
	<cfset tranname = getgeneral.lQUO>
<cfelseif url.trancode eq 'DN'>
	<cfset tranname = getgeneral.lDN>
<cfelseif url.trancode eq 'CN'>
	<cfset tranname = getgeneral.lCN>
<cfelseif url.trancode eq 'SAM'>
	<cfset tranname = getgeneral.lSAM>
<cfelseif url.trancode eq 'RC'>
	<cfset tranname = getgeneral.lRC>
<cfelseif url.trancode eq 'PR'>
	<cfset tranname = getgeneral.lPR>
<cfelseif url.trancode eq 'TR'>
	<cfset tranname = 'Transfer'>
<cfelseif url.trancode eq 'ISS'>
	<cfset tranname = 'Issue'>
<cfelseif url.trancode eq 'OAI'>
	<cfset tranname = 'Adjustment Increase'>
<cfelseif url.trancode eq 'OAR'>
	<cfset tranname = 'Adjustment Reduce'>
</cfif>
<cfset title1 = iif(form.title eq "Customer",DE(target_arcust),DE(target_apvend))>
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
<cfif isdefined('form.cbdetail') and (form.result eq 'HTML' or form.result eq 'EXCEL')>
	<cfquery datasource="#dts#" name="gettran">
<cfif hcomid eq "taftc_i" and url.trancode eq "INV">
SELECT * FROM (
</cfif>
	select
	a.* 
	from artran as a, ictran as b <cfif url.trancode eq "TR">, ictran as c</cfif>
	where
	a.type='#url.trancode#'
	and (a.void='' or a.void is null)

		<cfif url.trancode neq "TR">
			and a.type=b.type
<cfelse>
			and b.type ='TROU'
            and c.type ='TRIN'
            <cfif url.consignment neq ''>
            and b.consignment ='#url.consignment#'
            and c.consignment ='#url.consignment#'
            </cfif>
		</cfif>
		and a.refno=b.refno
        <cfif url.trancode eq "TR">and a.refno=c.refno</cfif>

	<cfif url.trancode eq "CS" and lcase(Hcomid) eq "ovas_i" and isdefined("form.refnoprefix") and form.refnoprefix neq "">
		and a.refno like '#form.refnoprefix#%'
	</cfif>
	<cfif ndatefrom neq "" and ndateto neq "">
		and a.wos_date between '#ndatefrom#' and '#ndateto#'
<cfelse>
    <cfif lcase(hcomid) neq "taftc_i">
		and a.wos_date > #getgeneral.lastaccyear#
    </cfif>
	</cfif>
	<cfif form.agentfrom neq "" and form.agentto neq "">
		and a.agenno between '#form.agentfrom#' and '#form.agentto#'
	</cfif>
    <cfif IsDefined('form.customerFrom') AND IsDefined('form.customerTo')>
		<cfif form.customerFrom NEQ '' and form.customerTo NEQ ''>
            <cfif url.trancode eq "ISS">
           		and a.rem0 between '#form.customerFrom#' and '#form.customerTo#'
            <cfelse>
            	and a.custno between '#form.customerFrom#' and '#form.customerTo#'
            </cfif>
        </cfif>
    </cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
	</cfif>
	<cfif form.refNoFrom neq "" and form.refNoTo neq "">
		and a.refno between '#form.refNoFrom#' and '#form.refNoTo#' and a.refno <> '99'
	</cfif>
    <cfif form.driverFrom neq "" and form.userTo neq "">
		and a.van >='#form.driverFrom#' and a.van <='#form.userTo#'
		</cfif>
    <cfif form.productfrom neq "" and form.productto neq "">
		and b.itemno >='#form.productfrom#' and b.itemno <='#form.productto#'
	</cfif>

	<cfif url.type NEQ "consignment" AND url.trancode NEQ "TR" AND url.consignment NEQ "out">
		<cfif form.locationfrom neq "" and form.locationto neq "">
            and b.location between '#form.locationfrom#' and '#form.locationto#'
        </cfif>
    </cfif>
    <cfif isdefined('form.transferstatus')>
    <cfif url.trancode eq "TR" and form.transferstatus neq "" and (lcase(hcomid) eq "centraltruss_i"  or lcase(hcomid) eq "demoindo_i" or lcase(hcomid) eq "amgworld_i")>
    	and a.rem14="#form.transferstatus#"
    </cfif>
    </cfif>
    <cfif dts eq "simplysiti_i">
    <cfif form.useridfrom neq "" and form.useridto neq "">
    and a.created_by between '#form.useridfrom#' and '#form.useridto#'
    </cfif>
    </cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>

    <cfif form.Daddressfrom neq "" and form.Daddressto neq "">
		and a.rem1 between "#form.Daddressfrom#" and "#form.Daddressto#"
	</cfif>
    <cfif form.projectfrom neq "" and form.projectto neq "">
		and a.source between "#form.projectfrom#" and "#form.projectto#"
	</cfif>
	<cfif form.jobfrom neq "" and form.jobto neq "">
    	and a.job between "#form.jobfrom#" and "#form.jobto#"
    </cfif>
    <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">
            	and ucase(a.agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
<cfelse>
            	and (ucase(a.userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')
			</cfif>
<cfelse>
        <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
        <cfelse>
			<cfif Huserloc neq "All_loc">
				and (a.userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
        <cfif url.trancode eq "TR">
    <cfif IsDefined ('form.locationFrom') and IsDefined ('form.locationTo')>
    <cfif form.locationfrom neq "" and form.locationto neq "">
    and b.location = "#form.locationFrom#" and c.location ="#form.locationTo#"
    </cfif>
    </cfif>
    </cfif>
    group by a.refno
    <cfif isdefined('form.cbdate')>
    order by a.wos_date
    <cfelse>
	order by a.custno,a.refno
    </cfif>
    <cfif hcomid eq "taftc_i" and url.trancode eq "INV">
) as a
LEFT JOIN
(SELECT count(if(brem1 = "" or brem1 is null,1,null)) as cgrant,refno as ref FROM ictran where type = "INV" group by refno)
as b on a.refno = b.ref
LEFT JOIN
(
select source as psource,project,cprice,cdispec,camt,grantacc from project
WHERE porj = "P"
) as c
on a.source = c.psource
</cfif>
</cfquery>
<cfelseif IsDefined('form.result') AND form.result eq 'PDF'>
	<cfquery datasource="#dts#" name="gettran">

	select
	a.*,d.custno,d.add1,d.add2,d.add3,d.add4,d.name2
	<cfif lcase(hcomid) eq "elitez_i">,a.comm0,a.comm1,a.comm2,a.comm3,a.rem14</cfif> from artran as a<cfif (form.locationfrom neq "" and form.locationto neq "") or url.trancode eq "TR" or (form.groupfrom neq "" and form.groupto neq "")  or (form.productfrom neq "" and form.productto neq "")>, ictran as b </cfif><cfif url.trancode eq "TR">, ictran as c</cfif>,<cfif form.title eq 'Customer'>#target_arcust# as d<cfelse>#target_apvend# as d</cfif>
	where
    d.custno=a.custno and
	a.type='#url.trancode#'
	and (a.void='' or a.void is null)
	<cfif (form.locationfrom neq "" and form.locationto neq "") or url.trancode eq "TR" or (form.groupfrom neq "" and form.groupto neq "")>
		<cfif url.trancode neq "TR">
			and a.type=b.type
<cfelse>
			and b.type ='TROU'
            and c.type ='TRIN'
            <cfif url.consignment neq ''>
            and b.consignment ='#url.consignment#'
            and c.consignment ='#url.consignment#'
            </cfif>
		</cfif>
		and a.refno=b.refno
        <cfif url.trancode eq "TR">and a.refno=c.refno</cfif>
	</cfif>
	<cfif url.trancode eq "CS" and lcase(Hcomid) eq "ovas_i" and isdefined("form.refnoprefix") and form.refnoprefix neq "">
		and a.refno like '#form.refnoprefix#%'
	</cfif>
	<cfif ndatefrom neq "" and ndateto neq "">
		and a.wos_date between '#ndatefrom#' and '#ndateto#'
<cfelse>
    <cfif lcase(hcomid) neq "taftc_i">
		and a.wos_date > #getgeneral.lastaccyear#
    </cfif>
    <cfif isdefined('form.transferstatus')>
    <cfif url.trancode eq "TR"  and form.transferstatus neq "" and (lcase(hcomid) eq "centraltruss_i"  or lcase(hcomid) eq "demoindo_i" or lcase(hcomid) eq "amgworld_i")>
    	and a.rem14="#form.transferstatus#"
    </cfif>
    </cfif>
	<cfif dts eq "simplysiti_i">
    <cfif form.useridfrom neq "" and form.useridto neq "">
    and a.created_by between '#form.useridfrom#' and '#form.useridto#'
    </cfif>
    </cfif>
	</cfif>
	<cfif form.agentfrom neq "" and form.agentto neq "">
		and a.agenno between '#form.agentfrom#' and '#form.agentto#'
	</cfif>
	<cfif IsDefined('form.customerFrom') AND IsDefined('form.customerTo')>
    	<cfif form.customerFrom NEQ '' and form.customerTo NEQ ''>
			<cfif url.trancode eq "ISS">
            	and a.rem0 between '#form.customerFrom#' and '#form.customerTo#'
            <cfelse>
            	and a.custno between '#form.customerFrom#' and '#form.customerTo#'
            </cfif>
        </cfif>
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
	</cfif>
	<cfif form.refNoFrom neq "" and form.refNoTo neq "">
		and a.refno between '#form.refNoFrom#' and '#form.refNoTo#' and a.refno <> '99'
	</cfif>
    <cfif form.driverFrom neq "" and form.userTo neq "">
		and a.van >='#form.driverFrom#' and a.van <='#form.userTo#'
		</cfif>
	<cfif url.type NEQ "consignment" AND url.trancode NEQ "TR" AND url.consignment NEQ "out">
		<cfif form.locationfrom neq "" and form.locationto neq "">
            and b.location between '#form.locationfrom#' and '#form.locationto#'
        </cfif>
    </cfif>
    <cfif form.productfrom neq "" and form.productto neq "">
		and b.itemno >='#form.productfrom#' and b.itemno <='#form.productto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>

    <cfif form.Daddressfrom neq "" and form.Daddressto neq "">
			and a.rem1 between "#form.Daddressfrom#" and "#form.Daddressto#"
	</cfif>
    <cfif form.projectfrom neq "" and form.projectto neq "">
			and a.source between "#form.projectfrom#" and "#form.projectto#"
	</cfif>
	<cfif form.jobfrom neq "" and form.jobto neq "">
    and a.job between "#form.jobfrom#" and "#form.jobto#"
    </cfif>
    <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
<cfelse>
            and (ucase(a.userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')
			</cfif>
<cfelse>
        <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
        <cfelse>
			<cfif Huserloc neq "All_loc">
				and (a.userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
        <cfif url.trancode eq "TR">
    <cfif IsDefined ('form.locationFrom') and IsDefined ('form.locationTo')>
    <cfif form.locationfrom neq "" and form.locationto neq "">
    and b.location = "#form.locationFrom#" and c.location ="#form.locationTo#"
    </cfif>
    </cfif>
    </cfif>
	group by a.type,a.refno
    <cfif isdefined('form.cbdate')>
    order by a.wos_date
    <cfelse>
	order by a.refno
    </cfif>
</cfquery>
<cfelse>
	<cfquery datasource="#dts#" name="gettran">
<cfif hcomid eq "taftc_i" and url.trancode eq "INV">
SELECT * FROM (
</cfif>
	select
	a.*
	from artran as a<cfif (form.locationfrom neq "" and form.locationto neq "") or url.trancode eq "TR" or (form.groupfrom neq "" and form.groupto neq "") or (form.productfrom neq "" and form.productto neq "")>, ictran as b </cfif><cfif url.trancode eq "TR">, ictran as c</cfif>
	where
	a.type='#url.trancode#'
	and (a.void='' or a.void is null)
	<cfif (form.locationfrom neq "" and form.locationto neq "") or url.trancode eq "TR" or (form.groupfrom neq "" and form.groupto neq "")  or (form.productfrom neq "" and form.productto neq "")>
		<cfif url.trancode neq "TR">
			and a.type=b.type
<cfelse>
			and b.type ='TROU'
            and c.type ='TRIN'
            <cfif url.consignment neq ''>
            and b.consignment ='#url.consignment#'
            and c.consignment ='#url.consignment#'
            </cfif>
		</cfif>
		and a.refno=b.refno
        <cfif url.trancode eq "TR">and a.refno=c.refno</cfif>
	</cfif>
	<cfif url.trancode eq "CS" and lcase(Hcomid) eq "ovas_i" and isdefined("form.refnoprefix") and form.refnoprefix neq "">
		and a.refno like '#form.refnoprefix#%'
	</cfif>

    <cfif lcase(hcomid) eq "neohmobile_i">
    <cfif form.taxbilltype eq "taxincluded">
    	and a.taxincl = "T"
    <cfelseif form.taxbilltype eq "taxexcluded">
    	and a.taxincl <> "T"
    </cfif>
    </cfif>

    <cfif isdefined('form.transferstatus')>
    <cfif url.trancode eq "TR" and form.transferstatus neq "" and (lcase(hcomid) eq "centraltruss_i"  or lcase(hcomid) eq "demoindo_i" or lcase(hcomid) eq "amgworld_i")>
    	and a.rem14="#form.transferstatus#"
    </cfif>
    </cfif>

    <cfif lcase(HcomID) eq "simplysiti_i">
    <cfif form.rem11from neq '' and form.rem11to neq ''>
        and concat(
SUBSTRING_INDEX(trim(a.rem11), '/', -1),
if(length(
substring(
trim(a.rem11)
FROM
length(SUBSTRING_INDEX(trim(a.rem11), '/', 1))+2
for
length(trim(a.rem11))-(
length(SUBSTRING_INDEX(trim(a.rem11), '/', 1))+1 +
length(SUBSTRING_INDEX(trim(a.rem11), '/', -1))+1)
)) = 1,concat(0,substring(
trim(a.rem11)
FROM
length(SUBSTRING_INDEX(trim(a.rem11), '/', 1))+2
for
length(trim(a.rem11))-(
length(SUBSTRING_INDEX(trim(a.rem11), '/', 1))+1 +
length(SUBSTRING_INDEX(trim(a.rem11), '/', -1))+1)
)),substring(
trim(a.rem11)
FROM
length(SUBSTRING_INDEX(trim(a.rem11), '/', 1))+2
for
length(trim(a.rem11))-(
length(SUBSTRING_INDEX(trim(a.rem11), '/', 1))+1 +
length(SUBSTRING_INDEX(trim(a.rem11), '/', -1))+1)
)),
SUBSTRING_INDEX(trim(a.rem11), '/', 1)) between '#right(form.rem11from,4)##mid(form.rem11from,4,2)##left(form.rem11from,2)#' and '#right(form.rem11to,4)##mid(form.rem11to,4,2)##left(form.rem11to,2)#'
        </cfif>
    </cfif>
	<cfif ndatefrom neq "" and ndateto neq "">
		and a.wos_date between '#ndatefrom#' and '#ndateto#'
<cfelse>
		<cfif lcase(hcomid) neq "taftc_i">
		and a.wos_date > #getgeneral.lastaccyear#
    </cfif>
	</cfif>
    <cfif dts eq "simplysiti_i">
		<cfif form.useridfrom neq "" and form.useridto neq "">
            and a.created_by between '#form.useridfrom#' and '#form.useridto#'
        </cfif>
    </cfif>
	<cfif form.agentfrom neq "" and form.agentto neq "">
		and a.agenno between '#form.agentfrom#' and '#form.agentto#'
	</cfif>
    <cfif IsDefined('form.customerFrom') AND IsDefined('form.customerTo')>
		<cfif form.customerFrom NEQ '' and form.customerTo NEQ ''>
            <cfif url.trancode eq "ISS">
            	and a.rem0 between '#form.customerFrom#' and '#form.customerTo#'
            <cfelse>
            	and a.custno between '#form.customerFrom#' and '#form.customerTo#'
            </cfif>
        </cfif>
    </cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
	</cfif>
	<cfif form.refNoFrom neq "" and form.refNoTo neq "">
		and a.refno between '#form.refNoFrom#' and '#form.refNoTo#' and a.refno <> '99'
	</cfif>
    <cfif form.driverFrom neq "" and form.userTo neq "">
		and a.van >='#form.driverFrom#' and a.van <='#form.userTo#'
		</cfif>
	<cfif url.type NEQ "consignment" AND url.trancode NEQ "TR" AND url.consignment NEQ "out">
		<cfif form.locationfrom neq "" and form.locationto neq "">
            and b.location between '#form.locationfrom#' and '#form.locationto#'
        </cfif>
    </cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif form.productfrom neq "" and form.productto neq "">
		and b.itemno >='#form.productfrom#' and b.itemno <='#form.productto#'
	</cfif>
    <cfif form.Daddressfrom neq "" and form.Daddressto neq "">
			and a.rem1 between "#form.Daddressfrom#" and "#form.Daddressto#"
	</cfif>
    <cfif form.projectfrom neq "" and form.projectto neq "">
			and a.source between "#form.projectfrom#" and "#form.projectto#"
	</cfif>
	<cfif form.jobfrom neq "" and form.jobto neq "">
    	and a.job between "#form.jobfrom#" and "#form.jobto#"
    </cfif>
    <cfif url.alown eq 1>
			<!---<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
<cfelse>
            and (ucase(a.userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')
			</cfif>--->
<cfelse>
        <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
        <cfelse>
			<cfif Huserloc neq "All_loc">
				and (a.userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
        </cfif>
		</cfif>
        <cfif url.trancode eq "TR">
    <cfif IsDefined ('form.locationFrom') and IsDefined ('form.locationTo')>
    <cfif form.locationfrom neq "" and form.locationto neq "">
    	and b.location = "#form.locationFrom#" and c.location ="#form.locationTo#"
    </cfif>
    </cfif>
    </cfif>
	group by a.type,a.refno
    <cfif isdefined('form.cbdate')>
    order by a.wos_date
    <cfelse>
	order by a.refno
    </cfif>
        <cfif hcomid eq "taftc_i" and url.trancode eq "INV">
) as a
LEFT JOIN
(SELECT count(if(brem1 = "" or brem1 is null,1,null)) as cgrant,refno as ref FROM ictran where type = "INV" group by refno)
as b on a.refno = b.ref
LEFT JOIN
(
select source as psource,project,cprice,cdispec,camt,grantacc from project
WHERE porj = "P"
) as c
on a.source = c.psource
</cfif>
</cfquery>
</cfif>

<cfif form.result eq 'EXCEL (Enhanced)'>
    
<cfquery name="getComp_qry" datasource="payroll_main">
SELECT * FROM gsetup WHERE comp_id = "#replace(HcomID,'_i','')#"
</cfquery>

<cfquery name="gettran" datasource="#dts#">
SELECT art.*,cust.arrem5,inv.sstno,inv.gstno,cust.arrem6,cust.invoiceformat,inv.shortcode as branch,assign.batches,art.name,cust.arrem1 as location,
    p.po_no,cust.business,pms.name as empname,ict.brem3,case when hm.username='0' then '' else hm.username end as hrmgr,cust.attn
FROM artran art
LEFT JOIN arcust cust
ON art.custno=cust.custno
LEFT JOIN (SELECT * FROM ictran WHERE fperiod<>99 AND (void='' or void is null) AND brem3<>'' and type='#url.trancode#' GROUP BY refno,brem1) ict
ON art.refno=ict.refno
LEFT JOIN (
    SELECT refno,placementno,branch,batches,custname,invoiceno 
    FROM assignmentslip 
    WHERE 1=1
    AND assignmentslipdate > #getgeneral.lastaccyear#
    ) assign
ON ict.brem6=assign.refno
LEFT JOIN placement p
ON p.placementno=ict.brem1
LEFT JOIN #replace(dts,'_i','_p')#.pmast pms
ON pms.empno=ict.brem5
LEFT JOIN bo_jobtypeinv jointype
ON jointype.officecode = p.location and jointype.jobtype = p.jobpostype
LEFT JOIN invaddress inv
ON jointype.invnogroup=inv.invnogroup
LEFT JOIN payroll_main.hmusers hm 
ON hm.entryid=p.hrmgr
WHERE
    art.type='#url.trancode#'
	AND (art.void='' or art.void is null)
    AND grand_bil<>0
    <cfif ndatefrom neq "" and ndateto neq "">
		and art.wos_date between '#ndatefrom#' and '#ndateto#'
    <cfelse>
            and art.wos_date > #getgeneral.lastaccyear#
	</cfif>
    <cfif form.periodfrom neq "" and form.periodto neq "">
		and art.fperiod between '#form.periodfrom#' and '#form.periodto#'
	</cfif>
    <cfif IsDefined('form.customerFrom') AND IsDefined('form.customerTo')>
		<cfif form.customerFrom NEQ '' and form.customerTo NEQ ''>
            and art.custno between '#form.customerFrom#' and '#form.customerTo#'
        <cfelseif form.customerFrom NEQ ''>
            and art.custno = '#form.customerFrom#'
        <cfelseif form.customerTo NEQ ''>
            and art.custno = '#form.customerTo#'
        </cfif>
    </cfif>
ORDER BY art.refno
</cfquery>
        
<cfquery name="getgstdetails" datasource="#dts#">
SELECT gstno,shortcode
    <cfif getComp_qry.myear gt 2018 or (getComp_qry.myear eq 2018 and getComp_qry.mmonth gte 9)>
        ,sstno
    </cfif>
    FROM invaddress
GROUP BY shortcode
</cfquery>
            
</cfif>
                
<cfswitch expression="#form.result#">
    <cfcase value="EXCEL (Enhanced)">
        <cfset iDecl_UPrice=getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice="">
		<cfset stDecl_UPrice2 = ",.">
		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice=stDecl_UPrice&"0">
			<cfset stDecl_UPrice2 = stDecl_UPrice2 & "_">
		</cfloop>
        <!-- ============ SETTING table headers for excel file ==================== --->
        
        <cfif getComp_qry.myear gt 2018 or (getComp_qry.myear eq 2018 and getComp_qry.mmonth gte 9)>
            <cfif isdefined('form.checkbox1')>
                <cfset headerFields = [
                "Batch No", "Branch Code", "Invoice No","Refno 2", "ClientID",
                "Client Name","PO number","Dept","Candidate Name","Service Period","Hiring Manager", "Billing Name", "Total", "Taxable", "%", "Tax Amount",
                "Total w Tax", "Invoice Format", "Invoice Date", "Invoice Due Date", "Entity", "SST NO",
                "VAT"
                ] /> 
            <cfelse>
                <cfset headerFields = [
                    "Batch No", "Branch Code", "Invoice No", "ClientID",
                    "Client Name","PO number","Dept","Candidate Name","Service Period","Hiring Manager", "Billing Name", "Total", "Taxable", "%", "Tax Amount",
                    "Total w Tax", "Invoice Format", "Invoice Date", "Invoice Due Date", "Entity", "SST NO",
                    "VAT"
                    ] />
            </cfif>
        <cfelse>
            <cfif isdefined('form.checkbox1')>
                <cfset headerFields = [
                "Batch No", "Branch Code", "Invoice No","Refno 2", "ClientID",
                "Client Name","PO number","Dept","Candidate Name","Service Period","Hiring Manager", "Billing Name", "Total", "Taxable", "%", "Tax Amount",
                "Total w Tax", "Invoice Format", "Invoice Date", "Invoice Due Date", "Entity", "GST NO",
                "VAT"
                ] /> 
            <cfelse>
                <cfset headerFields = [
                    "Batch No", "Branch Code", "Invoice No", "ClientID",
                    "Client Name","PO number","Dept","Candidate Name","Service Period","Hiring Manager", "Billing Name", "Total", "Taxable", "%", "Tax Amount",
                    "Total w Tax", "Invoice Format", "Invoice Date", "Invoice Due Date", "Entity", "GST NO",
                    "VAT"
                    ] />
            </cfif>
        </cfif>
        <cfxml variable="data">
            <cfinclude template="/excel_template/excel_header.cfm">
            <Worksheet ss:Name="Enhanced Bill Listing">
            <Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
                <Column ss:Width="64.5"/>
                <Column ss:Width="60.25"/>
                <Column ss:Width="183.75"/>
                <Column ss:AutoFitWidth="0" ss:Width="60"/>
                <Column ss:Width="47.25"/>
                <Column ss:AutoFitWidth="0" ss:Width="75.75"/>
                <Column ss:AutoFitWidth="0" ss:Width="63.75"/>
                <Column ss:AutoFitWidth="0" ss:Width="75.75"/>
                <Column ss:AutoFitWidth="0" ss:Width="63.75"/>
                <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                    <cfloop array="#headerFields#" index="field" >
                        <Cell ss:StyleID="s24">
                            <Data ss:Type="String">
                                <cfoutput>
                                    #field#
                                </cfoutput>
                            </Data>
                        </Cell>
                    </cfloop>
                </Row>
                <cfset grosstotal = 0.00>
                <cfset taxtotal = 0.00>
                <cfset grandtotal = 0.00>
                <cfoutput>
                <cfloop query="gettran">
                    <cfwddx action = "cfml2wddx" input = "#gettran.name#" output = "wddxText">
                    <Row ss:AutoFitHeight="0">
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#gettran.batches#</Data>
                        </Cell>
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#gettran.location#</Data>
                        </Cell>
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#gettran.refno#</Data>
                        </Cell>
                        <cfif isdefined('form.checkbox1')>
                            <Cell ss:StyleID="s32">
                                <Data ss:Type="String">#gettran.refno2#</Data>
                            </Cell>
                        </cfif>
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#gettran.custno#</Data>
                        </Cell>
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#wddxText#</Data>
                        </Cell>
                        <cfwddx action = "cfml2wddx" input = "#gettran.po_no#" output = "wddxText7">
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#wddxText7#</Data>
                        </Cell>
                        <cfwddx action = "cfml2wddx" input = "#gettran.business#" output = "wddxText2">
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#wddxText2#</Data>
                        </Cell>
                        <cfwddx action = "cfml2wddx" input = "#gettran.empname#" output = "wddxText3">
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#wddxText3#</Data>
                        </Cell>
                        <cfwddx action = "cfml2wddx" input = "#gettran.brem3#" output = "wddxText4">
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#wddxText4#</Data>
                        </Cell>
                        <cfwddx action = "cfml2wddx" input = "#gettran.hrmgr#" output = "wddxText5">
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#wddxText5#</Data>
                        </Cell>
                        <cfwddx action = "cfml2wddx" input = "#gettran.attn#" output = "wddxText6">
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#wddxText6#</Data>
                        </Cell>
                        <cfif gettran.refno neq gettran.refno[gettran.currentrow-1]>
                            <Cell ss:StyleID="s33">
                                <Data ss:Type="Number">#gettran.gross_bil#</Data>
                            </Cell>
                            <Cell ss:StyleID="s32">
                                <Data ss:Type="String"><cfif gettran.taxp1 gt 0>True<cfelse>False</cfif></Data>
                            </Cell>
                            <Cell ss:StyleID="s32">
                                <Data ss:Type="String">#gettran.taxp1#</Data>
                            </Cell>
                            <Cell ss:StyleID="s33">
                                <Data ss:Type="Number">#gettran.tax_bil#</Data>
                            </Cell>
                            <Cell ss:StyleID="s33">
                                <Data ss:Type="Number">#gettran.grand_bil#</Data>
                            </Cell>
                        <cfelse>
                            <Cell ss:StyleID="s32">
                                <Data ss:Type="String"></Data>
                            </Cell>
                            <Cell ss:StyleID="s32">
                                <Data ss:Type="String"></Data>
                            </Cell>
                            <Cell ss:StyleID="s32">
                                <Data ss:Type="String"></Data>
                            </Cell>
                            <Cell ss:StyleID="s32">
                                <Data ss:Type="String"></Data>
                            </Cell>
                            <Cell ss:StyleID="s32">
                                <Data ss:Type="String"></Data>
                            </Cell>
                        </cfif>
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String"><cfif gettran.invoiceformat eq 1>Standard<cfelseif gettran.invoiceformat eq 2>Amex<cfelseif gettran.invoiceformat eq 3>Outsource<cfelseif gettran.invoiceformat eq 4>Lumpsum<cfelseif gettran.invoiceformat eq 5>Motorola<cfelseif gettran.invoiceformat eq 6>Standard (Group Item)<cfelseif gettran.invoiceformat eq 7>Citicorp<cfelseif gettran.invoiceformat eq 8>Intel<cfelseif gettran.invoiceformat eq 9>TechPower<cfelseif gettran.invoiceformat eq 11>Techpower Standard<cfelseif gettran.invoiceformat eq 12>Perm Invoice w/o Candidate Name<cfelse></cfif></Data>
                        </Cell>
                        <Cell ss:StyleID="s32">
                            <Data ss:Type="String">#dateformat(gettran.wos_date,'YYYY-MM-DD')#</Data>
                        </Cell> 
                        <Cell>
                            <Data ss:Type="String">#dateformat(dateadd("d",gettran.arrem6,"#gettran.wos_date#"),'YYYY-MM-DD')#</Data>
                        </Cell> 
                        <Cell>
                            <Data ss:Type="String"><cfif gettran.branch eq ''><cfif left(gettran.refno,1) eq 5>MSS<cfelseif left(gettran.refno,1) eq 6>MBS<cfelseif left(gettran.refno,1) eq 2>TC<cfelse>APMR</cfif><cfelse>#gettran.branch#</cfif></Data>
                        </Cell>
                        <cfif gettran.branch eq ''>
                            <cfquery name="getgstno" dbtype="query">
                                SELECT gstno
                                <cfif getComp_qry.myear gt 2018 or (getComp_qry.myear eq 2018 and getComp_qry.mmonth gte 9)>
                                    ,sstno
                                </cfif>
                                FROM getgstdetails
                                WHERE shortcode='<cfif left(gettran.refno,1) eq 5>MSS<cfelseif left(gettran.refno,1) eq 6>MBS<cfelseif left(gettran.refno,1) eq 2>TC<cfelse>APMR</cfif>'
                            </cfquery>
                        </cfif>
                        <cfif getComp_qry.myear gt 2018 or (getComp_qry.myear eq 2018 and getComp_qry.mmonth gte 9)>
                            <Cell>
                                <Data ss:Type="String"><cfif gettran.branch eq ''>#getgstno.sstno#<cfelse>#gettran.sstno#</cfif></Data>
                            </Cell>
                        <cfelse>
                            <Cell>
                                <Data ss:Type="String"><cfif gettran.branch eq ''>#getgstno.gstno#<cfelse>#gettran.gstno#</cfif></Data>
                            </Cell>
                        </cfif>
                        <Cell>
                            <Data ss:Type="String">#gettran.arrem5#</Data>
                        </Cell>
                    </Row>
                    <cfif gettran.refno neq gettran.refno[gettran.currentrow-1]>
                        <cfset grosstotal += val(gettran.gross_bil)>
                        <cfset taxtotal += val(gettran.tax_bil)>
                        <cfset grandtotal += val(gettran.grand_bil)>
                    </cfif>
                </cfloop>
                <Row ss:AutoFitHeight="0">
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String">TOTAL: </Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <cfif isdefined('form.checkbox1')>
                            <Cell ss:StyleID="s27">
                                <Data ss:Type="String"></Data>
                            </Cell>
                        </cfif>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s50">
                            <Data ss:Type="Number">#grosstotal#</Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s50">
                            <Data ss:Type="Number">#taxtotal#</Data>
                        </Cell>
                        <Cell ss:StyleID="s50">
                            <Data ss:Type="Number">#grandtotal#</Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell> 
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell> 
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                        <Cell ss:StyleID="s27">
                            <Data ss:Type="String"></Data>
                        </Cell>
                    </Row>
                </cfoutput>
            </Table>
            <cfinclude template="/excel_template/excel_footer.cfm">
        </cfxml>

        <cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\EnhancedBillListing.xls" output="#tostring(data)#" charset="utf-8">
            
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_NewBL_#huserid#.xls">
        <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\EnhancedBillListing.xls">
    </cfcase>
	<cfcase value="EXCEL">
		<cfset iDecl_UPrice=getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice="">
		<cfset stDecl_UPrice2 = ",.">
		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice=stDecl_UPrice&"0">
			<cfset stDecl_UPrice2 = stDecl_UPrice2 & "_">
		</cfloop>
		<cfif isdefined('form.cbdetail')>
			<cfxml variable="data">
				<?xml version="1.0"?>
				<?mso-application progid="Excel.Sheet"?>
				<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
					<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
						<Author>
							Netiquette Technology
						</Author>
						<LastAuthor>
							Netiquette Technology
						</LastAuthor>
						<Company>
							Netiquette Technology
						</Company>
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
							<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
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
							<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
						</Style>
						<Style ss:ID="s38">
							<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
						</Style>
						<Style ss:ID="s39">
							<Borders>
								<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
							</Borders>
							<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
						</Style>
						<Style ss:ID="s41">
							<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
							<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
						</Style>
					</Styles>
					<Worksheet ss:Name="View Bill Listing Report">
						<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
							<Column ss:Width="64.5"/>
							<Column ss:Width="60.25"/>
							<Column ss:Width="60.75"/>
							<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
							<Column ss:Width="47.25"/>
							<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
							<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
							<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
							<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
							<cfset c="14">
							<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
							<cfset c=c+1>
							<cfoutput>
								<cfwddx action = "cfml2wddx" input = "View Bill Listing Report" output = "wddxText">
								<Row ss:AutoFitHeight="0" ss:Height="23.0625">
									<Cell ss:MergeAcross="#c#" ss:StyleID="s22">
										<Data ss:Type="String">
											#wddxText#
										</Data>
									</Cell>
								</Row>
								<cfif form.refNoFrom neq "" and form.refNoTo neq "">
									<cfwddx action = "cfml2wddx" input = "Ref No From #form.refNoFrom# To #form.refNoTo#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif ndatefrom neq "" and ndateto neq "">
									<cfwddx action = "cfml2wddx" input = "#form.datefrom# - #form.dateto#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									<cfwddx action = "cfml2wddx" input = "Period From #form.periodfrom# To #form.periodto#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif form.agentfrom neq "" and form.agentto neq "">
									<cfwddx action = "cfml2wddx" input = "#getgeneral.lAGENT# From #form.agentfrom# To #form.agentto#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif form.locationfrom neq "" and form.locationto neq "">
									<cfwddx action = "cfml2wddx" input = "Location From #form.locationfrom# To #form.locationto#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif form.projectfrom neq "" and form.projectto neq "">
									<cfwddx action = "cfml2wddx" input = "Project From #form.projectfrom# To #form.projectto#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif form.jobfrom neq "" and form.jobto neq "">
									<cfwddx action = "cfml2wddx" input = "Job From #form.Jobfrom# To #form.Jobto#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif form.driverFrom neq "" and form.userTo neq "">
									<cfwddx action = "cfml2wddx" input = "#getgeneral.lDriver# From #form.driverFrom# To #form.userTo#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif form.Daddressfrom neq "" and form.Daddressto neq "">
									<cfwddx action = "cfml2wddx" input = "Delivery Address Code From #form.Daddressfrom# To #form.Daddressto#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
								<Row ss:AutoFitHeight="0" ss:Height="20.0625">
									<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26">
										<Data ss:Type="String">
											#wddxText#
										</Data>
									</Cell>
									<Cell ss:StyleID="s26">
										<Data ss:Type="String">
											<cfif (lcase(hcomid) eq "baronad_i" or lcase(hcomid) eq "baronconnect_i") and  form.periodfrom neq "" and form.periodto neq "">
												<cfinclude template="/CFC/LastDayOfMonth.cfm">
												<cfset date2 = DateAdd('m', form.periodto, "#getgeneral.LastAccYear#")>
												<cfset date2a = LastDayOfMonth(month(date2),year(date2))>
												#dateformat(date2a,"dd/mm/yyyy")#
											<cfelse>
												#dateformat(now(),"dd/mm/yyyy")#
											</cfif>
										</Data>
									</Cell>
								</Row>
							</cfoutput>
							<Row ss:AutoFitHeight="0" ss:Height="23.0625">
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										Date.
									</Data>
								</Cell>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										<cfif url.trancode eq "TR">
											Transfer No
										<cfelse>
											Invoice No.
										</cfif>
									</Data>
								</Cell>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										<cfif url.trancode eq "TR">
											Authorised by
										<cfelse>
											Account No.
										</cfif>
									</Data>
								</Cell>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										<cfif url.trancode eq "TR">
											Reason for transfer
										<cfelse>
											Account Name.
										</cfif>
									</Data>
								</Cell>
								<!---<cfif url.trancode eq "TR">
									<Cell ss:StyleID="s27">
									<Data ss:Type="String">Transfer From
									</Data>
									</Cell>
									<Cell ss:StyleID="s27">
									<Data ss:Type="String">Transfer To
									</Data>
									</Cell>
									</cfif>  --->
								<cfif isdefined('form.checkbox3')>
									<Cell ss:StyleID="s27">
										<Data ss:Type="String">
											PO/SO NO
										</Data>
									</Cell>
								</cfif>
								<cfif isdefined('form.cbso')>
									<Cell ss:StyleID="s27">
										<Data ss:Type="String">
											SO NO
										</Data>
									</Cell>
								</cfif>
								<cfif isdefined('form.cbproject')>
									<Cell ss:StyleID="s27">
										<Data ss:Type="String">
											Project NO
										</Data>
									</Cell>
								</cfif>
								<cfif isdefined('form.cbjob')>
									<Cell ss:StyleID="s27">
										<Data ss:Type="String">
											Job NO
										</Data>
									</Cell>
								</cfif>
								<cfif isdefined('form.cbagent')>
									<Cell ss:StyleID="s27">
										<Data ss:Type="String">
											Agent NO
										</Data>
									</Cell>
								</cfif>
								<cfif isdefined('form.checkbox4')>
									<Cell ss:StyleID="s27">
										<Data ss:Type="String">
											DO NO
										</Data>
									</Cell>
								</cfif>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										Product No
									</Data>
								</Cell>
								<cfif getdisplaydetail.report_aitemno eq 'Y'>
									<Cell ss:StyleID="s27">
										<Data ss:Type="String">
											Product Code
										</Data>
									</Cell>
								</cfif>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										Product Name
									</Data>
								</Cell>
								<cfif url.trancode eq "TR">
									<Cell ss:StyleID="s27">
										<Data ss:Type="String">
											Location From
										</Data>
									</Cell>
									<Cell ss:StyleID="s27">
										<Data ss:Type="String">
											Location To
										</Data>
									</Cell>
								<cfelse>
									<Cell ss:StyleID="s27">
										<Data ss:Type="String">
											Location
										</Data>
									</Cell>
								</cfif>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										Qty
									</Data>
								</Cell>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										GST
									</Data>
								</Cell>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										Price
									</Data>
								</Cell>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										Disc %
									</Data>
								</Cell>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										Amount
									</Data>
								</Cell>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										Project
									</Data>
								</Cell>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										Job
									</Data>
								</Cell>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										Grand Foreign Rate
									</Data>
								</Cell>
								<Cell ss:StyleID="s27">
									<Data ss:Type="String">
										Grand Foreign Amount
									</Data>
								</Cell>
							</Row>
							<cfset count=1>
							<cfloop query="gettran">
								<cfif hcomid eq "taftc_i" and url.trancode eq "INV">
									<cfif gettran.cdispec neq 0>
										<cfset gettran.discount = val(gettran.cgrant) * val(gettran.cdispec)>
										<cfset gettran.invgross = val(gettran.invgross) + val(gettran.discount)>
									</cfif>
								</cfif>
								<cfif currrate neq "">
									<cfset xcurrrate = currrate>
								<cfelse>
									<cfset xcurrrate = 1>
								</cfif>
								<cfwddx action = "cfml2wddx" input = "#gettran.custno#" output = "wddxText">
								<cfquery datasource="#dts#" name="getcust">
						Select name, currcode from #title1# where custno='#custno#'
					</cfquery>
								<cfwddx action = "cfml2wddx" input = "#name#" output = "wddxText2">
								<cfwddx action = "cfml2wddx" input = "#gettran.refno#" output = "wddxText3">
								<cfwddx action = "cfml2wddx" input = "#dateformat(gettran.wos_date,'dd-mm-yyyy')#" output = "wddxText4">
								<cfwddx action = "cfml2wddx" input = "#gettran.PONO#" output = "wddxText5">
								<cfwddx action = "cfml2wddx" input = "#gettran.DONO#" output = "wddxText6">
								<cfwddx action = "cfml2wddx" input = "#gettran.sONO#" output = "wddxText7">
								<cfwddx action = "cfml2wddx" input = "#gettran.source#" output = "wddxText8">
								<cfwddx action = "cfml2wddx" input = "#gettran.job#" output = "wddxText9">
								<cfwddx action = "cfml2wddx" input = "#gettran.agenno#" output = "wddxText10">
								<cfoutput>
									<Row ss:AutoFitHeight="0">
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
												#wddxText4#
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
												#wddxText3#
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
												#wddxText2#
											</Data>
										</Cell>
										<!---<cfif url.trancode eq "TR">
											<Cell ss:StyleID="s32"><Data ss:Type="String">#gettran.rem1#</Data></Cell>
											<Cell ss:StyleID="s32"><Data ss:Type="String">#gettran.rem2#</Data></Cell>
											</cfif>--->
										<cfif isdefined('form.checkbox3')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
													#wddxText5#
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbso')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
													#wddxText7#
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbproject')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
													#wddxText8#
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbjob')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
													#wddxText9#
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbagent')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
													#wddxText10#
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.checkbox4')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
													#wddxText6#
												</Data>
											</Cell>
										</cfif>
									</Row>
									<cfquery name="getbodydetail" datasource="#dts#">
                                    select * from ictran where refno='#gettran.refno#' and type=<cfif url.trancode eq 'TR'>'TROU'<cfelse>'#gettran.type#'</cfif>
                                    </cfquery>
									<cfloop query="getbodydetail">
										<cfwddx action = "cfml2wddx" input = "#getbodydetail.itemno# - #getbodydetail.source#" output = "wddxText">
										<cfwddx action = "cfml2wddx" input = "#getbodydetail.desp# #getbodydetail.despa# #tostring(getbodydetail.comment)#" output = "wddxText2">
										<cfwddx action = "cfml2wddx" input = "#getbodydetail.location#" output = "wddxText3">
										<cfif getdisplaydetail.report_aitemno eq 'Y'>
                                            <cfquery name="getproductcode" datasource="#dts#">
                                            select aitemno from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbodydetail.itemno#">
                                            </cfquery>
                                            <cfwddx action = "cfml2wddx" input = "#getproductcode.aitemno#" output = "wddxText4">
                                        <cfelse>
                                            <cfwddx action = "cfml2wddx" input = "" output = "wddxText4">
                                        </cfif>
										<cfwddx action = "cfml2wddx" input = "#gettran.rem1#" output = "wddxText5">
										<cfwddx action = "cfml2wddx" input = "#gettran.rem2#" output = "wddxText6">
										<Row ss:AutoFitHeight="0">
											<cfif isdefined('form.checkbox3')>
												<Cell ss:StyleID="s32">
													<Data ss:Type="String">
													</Data>
												</Cell>
											</cfif>
											<cfif isdefined('form.cbso')>
												<Cell ss:StyleID="s32">
													<Data ss:Type="String">
													</Data>
												</Cell>
											</cfif>
											<cfif isdefined('form.cbproject')>
												<Cell ss:StyleID="s32">
													<Data ss:Type="String">
													</Data>
												</Cell>
											</cfif>
											<cfif isdefined('form.cbjob')>
												<Cell ss:StyleID="s32">
													<Data ss:Type="String">
													</Data>
												</Cell>
											</cfif>
											<cfif isdefined('form.cbagent')>
												<Cell ss:StyleID="s32">
													<Data ss:Type="String">
													</Data>
												</Cell>
											</cfif>
											<cfif isdefined('form.checkbox4')>
												<Cell ss:StyleID="s32">
													<Data ss:Type="String">
													</Data>
												</Cell>
											</cfif>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
													#wddxText#
												</Data>
											</Cell>
											<cfif getdisplaydetail.report_aitemno eq 'Y'>
												<Cell ss:StyleID="s32">
													<Data ss:Type="String">
														#wddxText4#
													</Data>
												</Cell>
											</cfif>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
													#wddxText2#
												</Data>
											</Cell>
											<cfif url.trancode eq "TR">
												<Cell ss:StyleID="s32">
													<Data ss:Type="String">
														#wddxText5#
													</Data>
												</Cell>
												<Cell ss:StyleID="s32">
													<Data ss:Type="String">
														#wddxText6#
													</Data>
												</Cell>
											<cfelse>
												<Cell ss:StyleID="s32">
													<Data ss:Type="String">
														#wddxText3#
													</Data>
												</Cell>
											</cfif>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
													#getbodydetail.qty#
												</Data>
											</Cell>
											<Cell ss:StyleID="s33">
												<Data ss:Type="Number">#getbodydetail.taxpec1#</Data>
											</Cell>
											<Cell ss:StyleID="s33">
												<Data ss:Type="Number">#getbodydetail.price#</Data>
											</Cell>
											<Cell ss:StyleID="s33">
												<Data ss:Type="Number">#getbodydetail.dispec1#</Data>
											</Cell>
											<Cell ss:StyleID="s33">
												<Data ss:Type="Number">#getbodydetail.amt#</Data>
											</Cell>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
													#wddxText8#
												</Data>
											</Cell>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
													#wddxText9#
												</Data>
											</Cell>
											<Cell ss:StyleID="s33">
												<Data ss:Type="Number">#gettran.currrate#</Data>
											</Cell>
											<Cell ss:StyleID="s33">
												<Data ss:Type="Number">#getbodydetail.amt_bil#</Data>
											</Cell>
										</Row>
									</cfloop>
								</cfoutput>
								<cfoutput>
									<Row ss:AutoFitHeight="0">
										<cfif isdefined('form.checkbox3')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbso')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif url.trancode eq "TR">
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbproject')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbjob')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbagent')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.checkbox4')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
                                        <cfif getdisplaydetail.report_aitemno eq 'Y'>
                                            <Cell ss:StyleID="s32">
                                                <Data ss:Type="String">
                                                </Data>
                                            </Cell>
                                        </cfif>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
												Total Discount
											</Data>
										</Cell>
										<Cell ss:StyleID="s37">
											<Data ss:Type="Number">#gettran.discount#</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s37">
											<Data ss:Type="Number">#gettran.disc_bil#</Data>
										</Cell>
									</Row>
									<Row ss:AutoFitHeight="0">
										<cfif isdefined('form.checkbox3')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif url.trancode eq "TR">
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbso')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbproject')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbjob')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbagent')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.checkbox4')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<cfif getdisplaydetail.report_aitemno eq 'Y'>
                                            <Cell ss:StyleID="s32">
                                                <Data ss:Type="String">
                                                </Data>
                                            </Cell>
                                        </cfif>
										<Cell ss:StyleID="s37">
											<Data ss:Type="Number">#gettran.net#</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s37">
											<Data ss:Type="Number">#gettran.net_bil#</Data>
										</Cell>
									</Row>
									<Row ss:AutoFitHeight="0">
										<cfif isdefined('form.checkbox3')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif url.trancode eq "TR">
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbso')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbproject')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbjob')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbagent')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.checkbox4')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<cfif getdisplaydetail.report_aitemno eq 'Y'>
                                            <Cell ss:StyleID="s32">
                                                <Data ss:Type="String">
                                                </Data>
                                            </Cell>
                                        </cfif>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
												GST
											</Data>
										</Cell>
										<Cell ss:StyleID="s37">
											<Data ss:Type="Number">#gettran.tax#</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s37">
											<Data ss:Type="Number">#gettran.tax_bil#</Data>
										</Cell>
									</Row>
									<Row ss:AutoFitHeight="0">
										<cfif isdefined('form.checkbox3')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif url.trancode eq "TR">
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbso')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbproject')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbjob')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.cbagent')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<cfif isdefined('form.checkbox4')>
											<Cell ss:StyleID="s32">
												<Data ss:Type="String">
												</Data>
											</Cell>
										</cfif>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<cfif getdisplaydetail.report_aitemno eq 'Y'>
                                            <Cell ss:StyleID="s32">
                                                <Data ss:Type="String">
                                                </Data>
                                            </Cell>
                                        </cfif>
										<Cell ss:StyleID="s39">
											<Data ss:Type="Number">#gettran.grand#</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s32">
											<Data ss:Type="String">
											</Data>
										</Cell>
										<Cell ss:StyleID="s37">
											<Data ss:Type="Number">#gettran.grand_bil#</Data>
										</Cell>
									</Row>
									<Row ss:AutoFitHeight="0" ss:Height="12"/>
								</cfoutput>
							</cfloop>
							<Row ss:AutoFitHeight="0" ss:Height="12"/>
						</Table>
						<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
							<Unsynced/>
							<Print>
								<ValidPrinterInfo/>
								<Scale>
									60
								</Scale>
								<HorizontalResolution>
									600
								</HorizontalResolution>
								<VerticalResolution>
									600
								</VerticalResolution>
							</Print>
							<Selected/>
							<Panes>
								<Pane>
									<Number>
										3
									</Number>
									<ActiveRow>
										20
									</ActiveRow>
									<ActiveCol>
										3
									</ActiveCol>
								</Pane>
							</Panes>
							<ProtectObjects>
								False
							</ProtectObjects>
							<ProtectScenarios>
								False
							</ProtectScenarios>
						</WorksheetOptions>
					</Worksheet>
				</Workbook>
			</cfxml>
			<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls" output="#tostring(data)#" charset="utf-8">
			<cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
			<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
		<cfelse>
			<cfxml variable="data">
				<?xml version="1.0"?>
				<?mso-application progid="Excel.Sheet"?>
				<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
					<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
						<Author>
							Netiquette Technology
						</Author>
						<LastAuthor>
							Netiquette Technology
						</LastAuthor>
						<Company>
							Netiquette Technology
						</Company>
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
							<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
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
							<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
						</Style>
						<Style ss:ID="s38">
							<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
						</Style>
						<Style ss:ID="s39">
							<Borders>
								<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
							</Borders>
							<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
						</Style>
						<Style ss:ID="s41">
							<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
							<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
						</Style>
					</Styles>
					<Worksheet ss:Name="Bills Listing">
						<cfoutput>
							<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
								<Column ss:Width="64.5"/>
								<Column ss:Width="60.25"/>
								<Column ss:Width="60.75"/>
								<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
								<Column ss:Width="330.75"/>
								<Column ss:Width="47.25"/>
								<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
								<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
								<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
								<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
								<cfset c="9">
								<cfif lcase(HcomID) eq "topsteel_i" or lcase(Hcomid) eq "topsteelhol_i">
									<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
									<cfset c=c+1>
								</cfif>
								<cfwddx action = "cfml2wddx" input = "#url.type# Listing Report" output = "wddxText">
								<Row ss:AutoFitHeight="0" ss:Height="23.0625">
									<Cell ss:MergeAcross="#c#" ss:StyleID="s22">
										<Data ss:Type="String">
											#wddxText#
										</Data>
									</Cell>
								</Row>
								<cfif form.refNoFrom neq "" and form.refNoTo neq "">
									<cfwddx action = "cfml2wddx" input = "Ref No From #form.refNoFrom# To #form.refNoTo#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif ndatefrom neq "" and ndateto neq "">
									<cfwddx action = "cfml2wddx" input = "#form.datefrom# - #form.dateto#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif form.periodfrom neq "" and form.periodto neq "">
									<cfwddx action = "cfml2wddx" input = "Period From #form.periodfrom# To #form.periodto#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif form.agentfrom neq "" and form.agentto neq "">
									<cfwddx action = "cfml2wddx" input = "#getgeneral.lAGENT# From #form.agentfrom# To #form.agentto#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfif form.locationfrom neq "" and form.locationto neq "">
									<cfwddx action = "cfml2wddx" input = "Location From #form.locationfrom# To #form.locationto#" output = "wddxText">
									<Row ss:AutoFitHeight="0" ss:Height="20.0625">
										<Cell ss:MergeAcross="#c#" ss:StyleID="s24">
											<Data ss:Type="String">
												#wddxText#
											</Data>
										</Cell>
									</Row>
								</cfif>
								<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
								<Row ss:AutoFitHeight="0" ss:Height="20.0625">
									<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26">
										<Data ss:Type="String">
											#wddxText#
										</Data>
									</Cell>
									<Cell ss:StyleID="s26">
										<Data ss:Type="String">
											<cfif (lcase(hcomid) eq "baronad_i" or lcase(hcomid) eq "baronconnect_i") and  form.periodfrom neq "" and form.periodto neq "">
												<cfinclude template="/CFC/LastDayOfMonth.cfm">
												<cfset date2 = DateAdd('m', form.periodto, "#getgeneral.LastAccYear#")>
												<cfset date2a = LastDayOfMonth(month(date2),year(date2))>
												#dateformat(date2a,"dd/mm/yyyy")#
											<cfelse>
												#dateformat(now(),"dd/mm/yyyy")#
											</cfif>
										</Data>
									</Cell>
								</Row>
						</cfoutput>
						<Row ss:AutoFitHeight="0" ss:Height="23.0625"> <Cell ss:StyleID="s27"><Data ss:Type="String">Date</Data></Cell> <Cell ss:StyleID="s27"><Data ss:Type="String">Refno</Data></Cell> <Cell ss:StyleID="s27"><Data ss:Type="String"><cfif url.trancode eq "TR">Authorised by<cfelse>Cust./Supp.</cfif></Data></Cell> <Cell ss:StyleID="s27"><Data ss:Type="String"><cfif url.trancode eq "TR">Reason for transfer<cfelse>Name</cfif></Data></Cell> <cfif url.trancode eq "TR"> <Cell ss:StyleID="s27"><Data ss:Type="String">Transfer From</Data></Cell> <Cell ss:StyleID="s27"><Data ss:Type="String">Transfer To</Data></Cell> </cfif> <cfif lcase(hcomid) eq "elitez_i"> <Cell ss:StyleID="s27"><Data ss:Type="String">Delivery Address</Data></Cell> </cfif> <cfif lcase(HcomID) eq "powernas_i"> <Cell ss:StyleID="s27"><Data ss:Type="String">Policy No</Data></Cell> </cfif> <cfif isdefined('form.checkbox1')> <Cell ss:StyleID="s27"><Data ss:Type="String">Ref No 2</Data></Cell> </cfif> <cfif isdefined('form.checkbox2')> <Cell ss:StyleID="s27"><Data ss:Type="String">Status</Data></Cell> </cfif> <cfif isdefined('form.checkbox3')> <Cell ss:StyleID="s27"><Data ss:Type="String">PO/SO NO</Data></Cell> </cfif> <cfif isdefined('form.checkbox4')> <Cell ss:StyleID="s27"><Data ss:Type="String">DO NO</Data></Cell> </cfif> <cfif isdefined('form.cbso')> <Cell ss:StyleID="s27"><Data ss:Type="String">SO NO</Data></Cell> </cfif> <cfif isdefined('form.cbproject')> <Cell ss:StyleID="s27"><Data ss:Type="String">Project NO</Data></Cell> </cfif> <cfif isdefined('form.cbjob')> <Cell ss:StyleID="s27"><Data ss:Type="String">Job NO</Data></Cell> </cfif> <cfif isdefined('form.cbagent')> <Cell ss:StyleID="s27"><Data ss:Type="String">Agent NO</Data></Cell> </cfif> <cfif lcase(HcomID) eq "manhattan_i" or lcase(Hcomid) eq "elmanhattan_i"> <Cell ss:StyleID="s27"><Data ss:Type="String">Agent No</Data></Cell> <Cell ss:StyleID="s27"><Data ss:Type="String">Est. Delivery Date</Data></Cell> </cfif> <Cell ss:StyleID="s27"><Data ss:Type="String">Amount</Data></Cell> <Cell ss:StyleID="s27"><Data ss:Type="String">Discount</Data></Cell> <Cell ss:StyleID="s27"><Data ss:Type="String">Net</Data></Cell> <cfif isdefined('form.cbgst')> <Cell ss:StyleID="s27"><Data ss:Type="String">GST CODE</Data></Cell> </cfif> <Cell ss:StyleID="s27"><Data ss:Type="String">Tax</Data></Cell> <Cell ss:StyleID="s27"><Data ss:Type="String">Grand Total</Data></Cell> <cfif lcase(HcomID) eq "mhca_i"><Cell ss:StyleID="s27"><Data ss:Type="String">Currency Rate</Data></Cell></cfif> <cfif url.trancode neq 'ISS'> <Cell ss:StyleID="s27"><Data ss:Type="String">Grand Foreign</Data></Cell></cfif> <cfif lcase(HcomID) eq "manhattan_i" or lcase(Hcomid) eq "elmanhattan_i"> <Cell ss:StyleID="s27"><Data ss:Type="String">Paid By</Data></Cell> <Cell ss:StyleID="s27"><Data ss:Type="String">Balance</Data></Cell> </cfif> <Cell ss:StyleID="s27"><Data ss:Type="String"> <cfif url.trancode eq "CS" and lcase(Hcomid) eq "ovas_i"> Agent <cfelse> Created By </cfif> </Data></Cell> 
						<cfif #url.trancode# EQ "INV">
						<Cell ss:StyleID="s27"><Data ss:Type="String">Batch</Data></Cell>
						</cfif>
                            
                        <Cell ss:StyleID="s27"><Data ss:Type="String">Return Reasons</Data></Cell>
                        
						<cfif lcase(HcomID) eq "topsteel_i" or lcase(Hcomid) eq "topsteelhol_i"> <Cell ss:StyleID="s27"><Data ss:Type="String">Agent</Data></Cell> </cfif> </Row> <cfoutput query="gettran"> <cfif hcomid eq "taftc_i" and url.trancode eq "INV"> <cfif gettran.cdispec neq 0> <cfset gettran.disc_bil = val(gettran.cgrant) * val(gettran.cdispec)> <cfset gettran.gross_bil = val(gettran.gross_bil) + val(gettran.disc_bil)> </cfif> </cfif> <cfif currrate neq ""> <cfset xcurrrate = currrate> <cfelse> <cfset xcurrrate = 1> </cfif> <cfquery datasource="#dts#" name="getcust">
						Select name, currcode
                        from #title1# where custno='#custno#'
					</cfquery> <cfwddx action = "cfml2wddx" input = "#gettran.refno#" output = "wddxText"><cfwddx action = "cfml2wddx" input = "#gettran.rem15#" output = "wddx_rem15"><cfwddx action = "cfml2wddx" input = "#custno#" output = "wddxText2"> <cfwddx action = "cfml2wddx" input = "#name#" output = "wddxText3"> <cfif url.trancode eq "CS" and lcase(Hcomid) eq "ovas_i"> <cfwddx action = "cfml2wddx" input = "#agenno#" output = "wddxText4"> <cfelse> <cfwddx action = "cfml2wddx" input = "#userid#" output = "wddxText4"> </cfif> <cfif lcase(HcomID) eq "topsteel_i" or lcase(Hcomid) eq "topsteelhol_i"> <cfwddx action = "cfml2wddx" input = "#agenno#" output = "wddxText5"> </cfif> <cfwddx action = "cfml2wddx" input = "#gettran.refno2#" output = "wddxText6"> <cfwddx action = "cfml2wddx" input = "#gettran.PONO#" output = "wddxText7"> <cfwddx action = "cfml2wddx" input = "#gettran.DONO#" output = "wddxText8"> <cfwddx action = "cfml2wddx" input = "#gettran.sONO#" output = "wddxText10"> <cfwddx action = "cfml2wddx" input = "#gettran.source#" output = "wddxText11"> <cfwddx action = "cfml2wddx" input = "#gettran.job#" output = "wddxText12"> <cfwddx action = "cfml2wddx" input = "#gettran.agenno#" output = "wddxText13"> <cfwddx action = "cfml2wddx" input = "#gettran.rem5#" output = "wddxText14"> <cfwddx action = "cfml2wddx" input = "#gettran.note#" output = "wddxText15"> <cfif lcase(hcomid) eq "elitez_i"> <cfwddx action = "cfml2wddx" input = "#gettran.comm0#" output = "wddxText16"> <cfwddx action = "cfml2wddx" input = "#gettran.comm1#" output = "wddxText17"> <cfwddx action = "cfml2wddx" input = "#gettran.comm2#" output = "wddxText18"> <cfwddx action = "cfml2wddx" input = "#gettran.comm3#" output = "wddxText19"> <cfwddx action = "cfml2wddx" input = "#gettran.rem14#" output = "wddxText20"> </cfif> <cfif url.trancode neq "TR"> <cfset xamt = val(gettran.gross_bil)> <cfset xdisc = val(gettran.discount)> <cfif gettran.taxincl eq 'T'> <cfset xnet = val(gettran.net_bil)-val(gettran.tax_bil)> <cfelse> <cfset xnet = val(gettran.net_bil)> </cfif> <cfset xtax = val(gettran.tax_bil)> <!---<cfset xgrand =numberformat(xnet,'.__')+numberformat(xtax,'.__')+val(gettran.m_charge1)+val(gettran.m_charge2)+val(gettran.m_charge3)+val(gettran.m_charge4)+val(gettran.m_charge5)+val(gettran.m_charge6)+val(gettran.m_charge7) <!--- val(gettran.grand) --->> ---> <cfset xgrand =numberformat(gettran.grand_bil,'.__')> <cfelse> <cfset xamt = val(gettran.gross_bil) / 2> <cfset xdisc = val(gettran.discount) / 2> <cfset xnet = val(gettran.net_bil) / 2> <cfset xtax = val(gettran.tax_bil) / 2> <cfset xgrand = val(gettran.grand_bil) / 2> </cfif> <Row ss:AutoFitHeight="0"> <Cell ss:StyleID="s32"><Data ss:Type="String">#dateformat(wos_date,"dd-mm-yy")#</Data></Cell> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell> <cfif lcase(hcomid) eq "elitez_i"> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText16# #wddxText17# #wddxText18# #wddxText19# #wddxText20#</Data></Cell> </cfif> <cfif lcase(HcomID) eq "manhattan_i" or lcase(Hcomid) eq "elmanhattan_i"> <cfwddx action = "cfml2wddx" input = "#gettran.agenno#" output = "wddxText13"> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText13#</Data></Cell> <cfwddx action = "cfml2wddx" input = "#gettran.rem5#" output = "wddxText13"> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText14#</Data></Cell> </cfif> <cfif lcase(HcomID) eq "powernas_i"> <cfquery name='getpolicy' datasource='#dts#'>
		    					select brem2 from ictran where refno='#gettran.refno#' and type='#gettran.type#'
		    				</cfquery> <cfwddx action = "cfml2wddx" input = "#getpolicy.brem2#" output = "wddxText9"> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText9#</Data></Cell> </cfif> <cfif url.trancode eq "TR"> <Cell ss:StyleID="s32"><Data ss:Type="String">#gettran.rem1#</Data></Cell> <Cell ss:StyleID="s32"><Data ss:Type="String">#gettran.rem2#</Data></Cell> </cfif> <cfif isdefined('form.checkbox1')> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText6#</Data></Cell> </cfif> <cfif isdefined('form.checkbox2')> <Cell ss:StyleID="s32"><Data ss:Type="String"><cfif toinv neq ''>Y</cfif> <cfif posted eq 'P'>P</cfif> <cfif void neq ''><font color="red"><strong>Void</strong></font></cfif></Data></Cell> </cfif> <cfif isdefined('form.checkbox3')> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText7#</Data></Cell> </cfif> <cfif isdefined('form.checkbox4')> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText8#</Data></Cell> </cfif> <cfif isdefined('form.cbso')> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText10#</Data></Cell> </cfif> <cfif isdefined('form.cbproject')> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText11#</Data></Cell> </cfif> <cfif isdefined('form.cbjob')> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText12#</Data></Cell> </cfif> <cfif isdefined('form.cbagent')> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText13#</Data></Cell> </cfif> <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(xamt,",.__")#</Data></Cell> <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(xdisc,",.__")#</Data></Cell> <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(xnet,",.__")#</Data></Cell> <cfif isdefined('form.cbgst')> <cfif getgeneral.wpitemtax NEQ ''> <cfquery name="getIctranTaxCode" datasource="#dts#">
                                    SELECT DISTINCT note_a
                                    FROM ictran
                                    WHERE refno = '#gettran.refno#'
                                    AND type = '#gettran.type#'
                                    ORDER BY note_a
                                </cfquery> <cfset taxCodeList=valuelist(getIctranTaxCode.note_a)> <Cell ss:StyleID="s32"><Data ss:Type="String">#taxCodeList#</Data></Cell> <cfelse> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText15#</Data></Cell> </cfif> </cfif> <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(xtax,",.__")#</Data></Cell> <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(xgrand,",.__")#</Data></Cell> <cfif lcase(HcomID) eq "mhca_i"><Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(xcurrrate,",.______")#</Data></Cell></cfif> <cfif xcurrrate eq "1"> <Cell ss:StyleID="s31"><Data ss:Type="String">-</Data></Cell> <cfelse> <cfif gettran.grand_bil neq ""> <cfif url.trancode neq "TR"> <cfset xfcamt = val(gettran.grand)> <cfelse> <cfset xfcamt = val(gettran.grand) / 2> </cfif> </cfif> <cfwddx action = "cfml2wddx" input = "#getcust.currcode# #numberformat(xfcamt,stDecl_UPrice2)#" output = "wddxText3"> <Cell ss:StyleID="s31"><Data ss:Type="String">#wddxText3#</Data></Cell> <cfset totalfcamt = totalfcamt + xfcamt> </cfif> <cfif lcase(HcomID) eq "manhattan_i" or lcase(Hcomid) eq "elmanhattan_i"> <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(gettran.cs_pm_cash+gettran.cs_pm_cheq+gettran.cs_pm_crcd+gettran.cs_pm_crc2+gettran.cs_pm_dbcd+gettran.cs_pm_vouc+gettran.deposit,",.__")#</Data></Cell> <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(xgrand-(gettran.cs_pm_cash+gettran.cs_pm_cheq+gettran.cs_pm_crcd+gettran.cs_pm_crc2+gettran.cs_pm_dbcd+gettran.cs_pm_vouc+gettran.deposit),",.__")#</Data></Cell> <cfset totaldeposit = totaldeposit+ gettran.cs_pm_cash+gettran.cs_pm_cheq+gettran.cs_pm_crcd+gettran.cs_pm_crc2+gettran.cs_pm_dbcd+gettran.cs_pm_vouc+gettran.deposit> <cfset totalbalance = totalbalance + xgrand-(gettran.cs_pm_cash+gettran.cs_pm_cheq+gettran.cs_pm_crcd+gettran.cs_pm_crc2+gettran.cs_pm_dbcd+gettran.cs_pm_vouc+gettran.deposit)> </cfif> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell> <cfif lcase(HcomID) eq "topsteel_i" or lcase(Hcomid) eq "topsteelhol_i"> <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell> </cfif> <cfset batches = ""> <cfif url.trancode EQ "INV"> <cftry> <cfset assignmentslipNumbers=ListToArray(#gettran.rem15#)/> <cfif ArrayLen(assignmentslipNumbers) GT 0 AND isNull(assignmentslipNumbers) EQ false> <cfloop from="1" to="#arrayLen(assignmentslipNumbers)#" index="i"> <cfquery name="getBatch" datasource="#dts#">
											SELECT batches FROM assignmentslip WHERE refno = "#assignmentslipNumbers[i]#"
										</cfquery> <cfloop query="getBatch"> <cfset batches=batches &" , "& getBatch.batches> </cfloop> </cfloop> </cfif> <cfcatch></cfcatch> </cftry> <Cell ss:StyleID="s32"> <Data ss:Type="String">#batches#</Data> </Cell> </cfif> </Row> <cfset totalamt = totalamt + numberformat(xamt,".__")> <cfset totaldisc = totaldisc + numberformat(xdisc,".__")> <cfset totalnet = totalnet + numberformat(xnet,".__")> <cfset totaltax = totaltax + numberformat(xtax,".__")> <cfset totalgrand = totalgrand + numberformat(xgrand,".__")> </cfoutput> <Row ss:AutoFitHeight="0" ss:Height="12"/> <cfoutput> <Row ss:AutoFitHeight="0" ss:Height="12"> <cfif lcase(hcomid) eq "elitez_i"> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <cfif lcase(HcomID) eq "powernas_i"> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <Cell ss:StyleID="s38"><Data ss:Type="String">Grand Total</Data></Cell> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> <cfif url.trancode eq "TR"> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <cfif isdefined('form.checkbox1')> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <cfif isdefined('form.checkbox2')> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <cfif isdefined('form.checkbox3')> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <cfif isdefined('form.checkbox4')> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <cfif isdefined('form.cbso')> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <cfif isdefined('form.cbproject')> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <cfif isdefined('form.cbjob')> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <cfif isdefined('form.cbagent')> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(totalamt,",.__")#</Data></Cell> <Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(totaldisc,",.__")#</Data></Cell> <Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(totalnet,",.__")#</Data></Cell> <cfif isdefined('form.cbgst')> <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell> </cfif> <Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(totaltax,",.__")#</Data></Cell> <Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(totalgrand,",.__")#</Data></Cell> <cfif lcase(HcomID) eq "mhca_i"><Cell ss:StyleID="s39"></Cell></cfif> <Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(totalfcamt,",.__")#</Data></Cell> <cfif lcase(HcomID) eq "manhattan_i" or lcase(Hcomid) eq "elmanhattan_i"> <Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(totaldeposit,",.__")#</Data></Cell> <Cell ss:StyleID="s39"><Data ss:Type="Number">#numberformat(totalbalance,",.__")#</Data></Cell> </cfif> <Cell ss:StyleID="s38"/> <cfif lcase(HcomID) eq "topsteel_i" or lcase(Hcomid) eq "topsteelhol_i"><Cell ss:StyleID="s38"/></cfif> </Row> </cfoutput> <Row ss:AutoFitHeight="0" ss:Height="12"/> </Table>
						<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
							<Unsynced/>
							<Print>
								<ValidPrinterInfo/>
								<Scale>
									60
								</Scale>
								<HorizontalResolution>
									600
								</HorizontalResolution>
								<VerticalResolution>
									600
								</VerticalResolution>
							</Print>
							<Selected/>
							<Panes>
								<Pane>
									<Number>
										3
									</Number>
									<ActiveRow>
										20
									</ActiveRow>
									<ActiveCol>
										3
									</ActiveCol>
								</Pane>
							</Panes>
							<ProtectObjects>
								False
							</ProtectObjects>
							<ProtectScenarios>
								False
							</ProtectScenarios>
						</WorksheetOptions>
					</Worksheet>
				</Workbook>
			</cfxml>
			<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls" output="#tostring(data)#">
			<cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
			<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
		</cfif>
	</cfcase>
	<!--- PDF report---->
	<cfcase value="PDF2">
		<cfreport template="reportbilling.cfr" format="PDF" query="gettran">
			<!--- or "FlashPaper" or "Excel" or "RTF" --->
			<cfreportparam name="compro" value="#getgeneral.compro#">
			<cfreportparam name="compro2" value="#getgeneral.compro2#">
			<cfreportparam name="compro3" value="#getgeneral.compro3#">
			<cfreportparam name="compro4" value="#getgeneral.compro4#">
			<cfreportparam name="compro5" value="#getgeneral.compro5#">
			<cfreportparam name="compro6" value="#getgeneral.compro6#">
			<cfreportparam name="compro7" value="#getgeneral.compro7#">
			<cfreportparam name="title" value="#title#">
			<cfreportparam name="periodfrom" value="#periodfrom#">
			<cfreportparam name="periodto" value="#periodto#">
			<cfreportparam name="datefrom" value="#ndatefrom#">
			<cfreportparam name="dateto" value="#ndateto#">
			<cfreportparam name="target_arcust" value="#target_arcust#">
			<cfreportparam name="target_apvend" value="#target_apvend#">
			<cfreportparam name="dts" value="#dts#">
			<cfif IsDefined('form.customerFrom')>
				<cfreportparam name="custfrom" value="#form.customerFrom#">
			<cfelse>
				<cfreportparam name="custfrom" value="">
			</cfif>
			<cfif IsDefined('form.customerTo')>
				<cfreportparam name="custto" value="#form.customerTo#">
			<cfelse>
				<cfreportparam name="custto" value="">
			</cfif>
			<cfreportparam name="gstno" value="#getgeneral.gstno#">
			<cfreportparam name="tranname" value="#tranname#">
		</cfreport>
	</cfcase>
	<!---- End PDF report --->
	<!--- PDF report2---->
	<cfcase value="PDF">
		<cfreport template="reportbilling2.cfr" format="PDF" query="gettran">
			<!--- or "FlashPaper" or "Excel" or "RTF" --->
			<cfreportparam name="compro" value="#getgeneral.compro#">
			<cfreportparam name="compro7" value="#getgeneral.compro7#">
			<cfreportparam name="refno" value="#gettran.refno#">
			<cfreportparam name="title" value="#title#">
			<cfreportparam name="periodfrom" value="#periodfrom#">
			<cfreportparam name="periodto" value="#periodto#">
			<cfreportparam name="datefrom" value="#ndatefrom#">
			<cfreportparam name="dateto" value="#ndateto#">
			<cfreportparam name="dts" value="#dts#">
			<cfif IsDefined('form.customerFrom')>
				<cfreportparam name="custfrom" value="#form.customerFrom#">
			<cfelse>
				<cfreportparam name="custfrom" value="">
			</cfif>
			<cfif IsDefined('form.customerTo')>
				<cfreportparam name="custto" value="#form.customerTo#">
			<cfelse>
				<cfreportparam name="custto" value="">
			</cfif>
			<cfreportparam name="gstno" value="#getgeneral.gstno#">
			<cfreportparam name="tranname" value="#tranname#">
			<cfif (lcase(hcomid) eq "baronad_i" or lcase(hcomid) eq "baronconnect_i") and  form.periodfrom neq "" and form.periodto neq "">
				<cfinclude template="/CFC/LastDayOfMonth.cfm">
				<cfset date2 = DateAdd('m', form.periodto, "#getgeneral.LastAccYear#")>
				<cfset date2a = LastDayOfMonth(month(date2),year(date2))>
				<cfreportparam name="accdate" value="#dateformat(date2a,'dd/mm/yyyy')#">
			<cfelse>
				<cfreportparam name="accdate" value="#dateformat(now(),'dd/mm/yyyy')#">
			</cfif>
		</cfreport>
	</cfcase>
	<!---- End PDF report --->
	<cfcase value="HTML">
		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",.">
		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>
		<cfif isdefined('form.cbdetail')>
			<html>
				<head>
					<title>
						<cfoutput>
							#url.type# Listing Report
						</cfoutput>
					</title>
					<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
					<link href = "../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
					<style type="text/css" media="print">
						.noprint { display: none; }
					</style>
				</head>
				<body
				<cfif getpin2.h4G00 eq "T">
					onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"
				</cfif>
				>
				<table align="center" cellpadding="3" cellspacing="0" width="100%">
					<cfoutput>
						<tr>
							<td colspan="100%">
								<div align="center">
									<font size="3" face="Arial, Helvetica, sans-serif">
										<strong>
											#url.type# Listing Report
										</strong>
									</font>
								</div>
							</td>
						</tr>
						<cfif form.refNoFrom neq "" and form.refNoTo neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Ref No From #form.refNoFrom# To #form.refNoTo#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif ndatefrom neq "" and ndateto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#form.datefrom# - #form.dateto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Period From #form.periodfrom# To #form.periodto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.agentfrom neq "" and form.agentto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#getgeneral.lAGENT# From #form.agentfrom# To #form.agentto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.locationfrom neq "" and form.locationto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Location From #form.locationfrom# To #form.locationto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.projectfrom neq "" and form.projectto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Project From #form.projectfrom# To #form.projectto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.jobfrom neq "" and form.jobto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Job From #form.Jobfrom# To #form.Jobto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.driverFrom neq "" and form.userTo neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#getgeneral.lDriver# From #form.driverFrom# To #form.userTo#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.Daddressfrom neq "" and form.Daddressto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Delivery Address Code From #form.Daddressfrom# To #form.Daddressto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<tr>
							<td colspan="80%">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									#getgeneral.compro#
								</font>
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
							<td colspan="20%">
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<cfif (lcase(hcomid) eq "baronad_i" or lcase(hcomid) eq "baronconnect_i") and  form.periodfrom neq "" and form.periodto neq "">
											<cfinclude template="/CFC/LastDayOfMonth.cfm">
											<cfset date2 = DateAdd('m', form.periodto, "#getgeneral.LastAccYear#")>
											<cfset date2a = LastDayOfMonth(month(date2),year(date2))>
											#dateformat(date2a,"dd/mm/yyyy")#
										<cfelse>
											#dateformat(now(),"dd/mm/yyyy")#
										</cfif>
									</font>
								</div>
							</td>
						</tr>
					</cfoutput>
					<tr>
						<td colspan="100%">
							<hr>
						</td>
					</tr>
					<tr>
						<td>
							<div align="left">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										<cfif url.trancode eq "TR">
											Authorised by.
											<br>
											Transfer No.
										<cfelse>
											Account No.
											<br>
											Bill No.
										</cfif>
									</strong>
								</font>
							</div>
						</td>
						<td>
							<div align="left">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										<cfif url.trancode eq "TR">
											Reason for transfer.
											<br>
											Date.
										<cfelse>
											Account Name.
											<br>
											Date
										</cfif>
									</strong>
								</font>
							</div>
						</td>
						<cfif isdefined('form.checkbox1')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Ref No 2
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.checkbox3')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											PO/SO NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.checkbox4')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											DO NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.cbso')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											SO NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.cbproject')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Project NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.cbjob')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Job NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.cbagent')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Agent NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<td>
							<div align="left">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										Product No
									</strong>
								</font>
							</div>
						</td>
						<cfif getdisplaydetail.report_aitemno eq 'Y'>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Product Code
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<td>
							<div align="left">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										Product Name
									</strong>
								</font>
							</div>
						</td>
						<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
							<cfif url.trancode eq "TR">
								<td>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												Location From
											</strong>
										</font>
									</div>
								</td>
								<td>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												Location To
											</strong>
										</font>
									</div>
								</td>
							<cfelse>
								<td>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												Location
											</strong>
										</font>
									</div>
								</td>
							</cfif>
						</cfif>
						<td>
							<div align="left">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										Qty
									</strong>
								</font>
							</div>
						</td>
						<td>
							<div align="right">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										GST
									</strong>
								</font>
							</div>
						</td>
						<td>
							<div align="right">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										Price
									</strong>
								</font>
							</div>
						</td>
						<td>
							<div align="right">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										Disc %
									</strong>
								</font>
							</div>
						</td>
						<td>
							<div align="right">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										Amount
									</strong>
								</font>
							</div>
						</td>
						<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Project
										</strong>
									</font>
								</div>
							</td>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Job
										</strong>
									</font>
								</div>
							</td>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Grand Foreign Rate
										</strong>
									</font>
								</div>
							</td>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Grand Foreign Amount
										</strong>
									</font>
								</div>
							</td>
						</cfif>
					</tr>
					<tr>
						<td colspan="100%">
							<hr>
						</td>
					</tr>
					<cfset count=1>
					<cfset detailtotalgrand = 0>
					<cfset detailforeigntotalgrand = 0>
					<cfoutput query="gettran">
						<cfif hcomid eq "taftc_i" and url.trancode eq "INV">
							<cfif gettran.cdispec neq 0>
								<cfset gettran.discount = val(gettran.cgrant) * val(gettran.cdispec)>
								<cfset gettran.invgross = val(gettran.invgross) + val(gettran.discount)>
							</cfif>
						</cfif>
						<cfif currrate neq "">
							<cfset xcurrrate = currrate>
						<cfelse>
							<cfset xcurrrate = 1>
						</cfif>
						<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
							<td nowrap>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#gettran.custno#
									</font>
								</div>
							</td>
							<cfquery datasource="#dts#" name="getcust">
						Select name, currcode from #title1# where custno='#custno#'
					</cfquery>
							<td colspan="3" nowrap>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#name#
									</font>
								</div>
							</td>
						</tr>
						<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
							<td nowrap>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#gettran.refno#
									</font>
								</div>
							</td>
							<td nowrap>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#dateformat(gettran.wos_date,'dd-mm-yyyy')#
									</font>
								</div>
							</td>
							<cfif isdefined('form.checkbox1')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.refno2#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox3')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.PONO#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox4')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.DONO#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbso')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.sONO#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbproject')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.source#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbjob')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.job#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbagent')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.agenno#
										</font>
									</div>
								</td>
							</cfif>
						</tr>
						<cfquery name="getbodydetail" datasource="#dts#">
                select * from ictran where refno='#gettran.refno#' and type=<cfif url.trancode eq 'TR'>'TROU'<cfelse>'#gettran.type#'</cfif>
                </cfquery>
						<cfloop query="getbodydetail">
							<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
								<cfif isdefined('form.checkbox1')>
									<td nowrap>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
											</font>
										</div>
									</td>
								</cfif>
								<cfif isdefined('form.checkbox3')>
									<td nowrap>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
											</font>
										</div>
									</td>
								</cfif>
								<cfif isdefined('form.checkbox4')>
									<td nowrap>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
											</font>
										</div>
									</td>
								</cfif>
								<cfif isdefined('form.cbso')>
									<td nowrap>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
											</font>
										</div>
									</td>
								</cfif>
								<cfif isdefined('form.cbproject')>
									<td nowrap>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
											</font>
										</div>
									</td>
								</cfif>
								<cfif isdefined('form.cbjob')>
									<td nowrap>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
											</font>
										</div>
									</td>
								</cfif>
								<cfif isdefined('form.cbagent')>
									<td nowrap>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
											</font>
										</div>
									</td>
								</cfif>
								<td nowrap>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
								<td nowrap>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
								<cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i")>
									<td>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#getbodydetail.itemno#
											</font>
										</div>
									</td>
									<cfif getdisplaydetail.report_aitemno eq 'Y'>
										<cfquery name="getproductcode" datasource="#dts#">
                    select aitemno from icitem where itemno='#getbodydetail.itemno#'
                    </cfquery>
										<td>
											<div align="left">
												<font size="1.5" face="Arial, Helvetica, sans-serif">
													#getproductcode.aitemno#
												</font>
											</div>
										</td>
									</cfif>
									<td>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#getbodydetail.desp#
												<cfif getbodydetail.despa neq ''>
													<br>
													#getbodydetail.despa#
												</cfif>
												<cfif tostring(getbodydetail.comment) neq ''>
													<br>
													#tostring(getbodydetail.comment)#
												</cfif>
											</font>
										</div>
									</td>
								<cfelse>
									<td nowrap>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#getbodydetail.itemno#
												<cfif lcase(hcomid) eq "bestform_i">
													<br>
													#getbodydetail.batchcode#
												</cfif>
											</font>
										</div>
									</td>
									<cfif getdisplaydetail.report_aitemno eq 'Y'>
										<cfquery name="getproductcode" datasource="#dts#">
                    select aitemno from icitem where itemno='#getbodydetail.itemno#'
                    </cfquery>
										<td>
											<div align="left">
												<font size="1.5" face="Arial, Helvetica, sans-serif">
													#getproductcode.aitemno#
												</font>
											</div>
										</td>
									</cfif>
									<td nowrap>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#getbodydetail.desp#
												<cfif getbodydetail.despa neq ''>
													<br>
													#getbodydetail.despa#
												</cfif>
												<cfif tostring(getbodydetail.comment) neq ''>
													<br>
													#tostring(getbodydetail.comment)#
												</cfif>
											</font>
										</div>
									</td>
								</cfif>
								<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
									<cfif url.trancode eq "TR">
										<td>
											<div align="left">
												<font size="1.5" face="Arial, Helvetica, sans-serif">
													#gettran.rem1#
												</font>
											</div>
										</td>
										<td>
											<div align="left">
												<font size="1.5" face="Arial, Helvetica, sans-serif">
													#gettran.rem2#
												</font>
											</div>
										</td>
									<cfelse>
										<td>
											<div align="left">
												<font size="1.5" face="Arial, Helvetica, sans-serif">
													#getbodydetail.location#
												</font>
											</div>
										</td>
									</cfif>
								</cfif>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#getbodydetail.qty#
										</font>
									</div>
								</td>
								<td nowrap>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#numberformat(getbodydetail.taxpec1,'.__')#
										</font>
									</div>
								</td>
								<td nowrap>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#numberformat(getbodydetail.price,',_.__')#
										</font>
									</div>
								</td>
								<td nowrap>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#numberformat(getbodydetail.dispec1,'.__')#
										</font>
									</div>
								</td>
								<td nowrap>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#numberformat(getbodydetail.amt,',_.__')#
										</font>
									</div>
								</td>
								<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
									<td nowrap>
										<div align="right">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#gettran.source#
											</font>
										</div>
									</td>
									<td nowrap>
										<div align="right">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#gettran.job#
											</font>
										</div>
									</td>
									<td nowrap>
										<div align="right">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#gettran.currrate#
											</font>
										</div>
									</td>
									<td nowrap>
										<div align="right">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#numberformat(getbodydetail.amt_bil,',_.__')#
											</font>
										</div>
									</td>
								</cfif>
							</tr>
						</cfloop>
						<tr>
							<td colspan="6">
								<cfif isdefined('form.checkbox3')>
							<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td> </cfif>
							<cfif url.trancode eq "TR">
								<td>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox4')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbso')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbproject')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbjob')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbagent')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<cfif getdisplaydetail.report_aitemno eq 'Y'>
									<td>
									</td>
								</cfif>
								<td>
								</td>
							</cfif>
							<td colspan="2">
							</td>
							<td nowrap>
								<hr>
							</td>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<td>
								</td>
								<td>
								</td>
								<td>
								</td>
								<td>
									<hr>
								</td>
							</cfif>
						</tr>
						<cfif url.trancode eq 'TR'>
							<cfset gettran.invgross=gettran.invgross/2>
							<cfset gettran.gross_bil=gettran.gross_bil/2>
							<cfset gettran.discount=gettran.discount/2>
							<cfset gettran.disc_bil=gettran.disc_bil/2>
							<cfset gettran.net=gettran.net/2>
							<cfset gettran.net_bil=gettran.net_bil/2>
							<cfset gettran.tax=gettran.tax/2>
							<cfset gettran.tax_bil=gettran.tax_bil/2>
							<cfset gettran.grand=gettran.grand/2>
							<cfset gettran.grand_bil=gettran.grand_bil/2>
						</cfif>
						<tr>
							<td colspan="6">
								<cfif isdefined('form.checkbox3')>
							<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td> </cfif>
							<cfif url.trancode eq "TR">
								<td>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox4')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbso')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbproject')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbjob')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbagent')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<cfif getdisplaydetail.report_aitemno eq 'Y'>
									<td>
									</td>
								</cfif>
								<td>
								</td>
							</cfif>
							<td colspan="2">
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
									</font>
								</div>
							</td>
							<td nowrap>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#numberformat(gettran.invgross,',_.__')#
									</font>
								</div>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#numberformat(gettran.gross_bil,',_.__')#
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<cfif isdefined('form.checkbox3')>
							<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td> </cfif>
							<cfif url.trancode eq "TR">
								<td>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox4')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbso')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbproject')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbjob')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbagent')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<cfif getdisplaydetail.report_aitemno eq 'Y'>
									<td>
									</td>
								</cfif>
								<td>
								</td>
							</cfif>
							<td colspan="2">
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										Total Discount
									</font>
								</div>
							</td>
							<td nowrap>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#numberformat(gettran.discount,',_.__')#
									</font>
								</div>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#numberformat(gettran.disc_bil,',_.__')#
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="8">
								<cfif isdefined('form.checkbox3')>
							<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td> </cfif>
							<cfif url.trancode eq "TR">
								<td>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox4')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbso')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbproject')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbjob')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbagent')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<cfif getdisplaydetail.report_aitemno eq 'Y'>
									<td>
									</td>
								</cfif>
								<td>
								</td>
							</cfif>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
							</cfif>
							<td nowrap>
								<hr>
							</td>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<td>
								</td>
								<td>
								</td>
								<td>
								</td>
								<td>
									<hr>
								</td>
							</cfif>
						</tr>
						<tr>
							<td colspan="8">
								<cfif isdefined('form.checkbox3')>
							<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td> </cfif>
							<cfif url.trancode eq "TR">
								<td>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox4')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbso')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbproject')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbjob')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbagent')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<cfif getdisplaydetail.report_aitemno eq 'Y'>
									<td>
									</td>
								</cfif>
								<td>
								</td>
							</cfif>
							<td nowrap>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#numberformat(gettran.net,',_.__')#
									</font>
								</div>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#numberformat(gettran.net_bil,',_.__')#
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<cfif isdefined('form.checkbox3')>
							<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td> </cfif>
							<cfif url.trancode eq "TR">
								<td>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox4')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbso')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbproject')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbjob')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbagent')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<cfif getdisplaydetail.report_aitemno eq 'Y'>
									<td>
									</td>
								</cfif>
								<td>
								</td>
							</cfif>
							<td colspan="2">
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										GST
									</font>
								</div>
							</td>
							<td nowrap>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#numberformat(gettran.tax,',_.__')#
									</font>
								</div>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#numberformat(gettran.tax_bil,',_.__')#
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="8">
								<cfif isdefined('form.checkbox3')>
							<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td> </cfif>
							<cfif url.trancode eq "TR">
								<td>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox4')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbso')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbproject')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbjob')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbagent')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<cfif getdisplaydetail.report_aitemno eq 'Y'>
									<td>
									</td>
								</cfif>
								<td>
								</td>
							</cfif>
							<td nowrap>
								<hr>
							</td>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<td>
								</td>
								<td>
								</td>
								<td>
								</td>
								<td>
									<hr>
								</td>
							</cfif>
						</tr>
						<tr>
							<td colspan="8">
								<cfif isdefined('form.checkbox3')>
							<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td> </cfif>
							<cfif url.trancode eq "TR">
								<td>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox4')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbso')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbproject')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbjob')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbagent')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<cfif getdisplaydetail.report_aitemno eq 'Y'>
									<td>
									</td>
								</cfif>
								<td>
								</td>
							</cfif>
							<td nowrap>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<b>
											#numberformat(gettran.grand,',_.__')#
										</b>
									</font>
								</div>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#numberformat(gettran.grand_bil,',_.__')#
									</font>
								</div>
							</td>
						</tr>
						<cfset detailtotalgrand = detailtotalgrand + val(numberformat(gettran.grand,".__"))>
						<cfset detailforeigntotalgrand = detailforeigntotalgrand + val(numberformat(gettran.grand_bil,".__"))>
						<tr>
							<td colspan="8">
								<cfif isdefined('form.checkbox3')>
							<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td> </cfif>
							<cfif url.trancode eq "TR">
								<td>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox4')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbso')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbproject')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbjob')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbagent')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbdetail') and form.result eq 'HTML'>
								<cfif getdisplaydetail.report_aitemno eq 'Y'>
									<td>
									</td>
								</cfif>
								<td>
								</td>
							</cfif>
							<td nowrap>
								<hr>
							</td>
						</tr>
						<tr>
						<tr>
							<td>
							</td>
						</tr>
					</cfoutput>
					<tr>
						<td colspan="100%">
							<hr>
						</td>
					</tr>
					<cfoutput>
						<tr>
							<td>
								<b>
									Total
								</b>
							</td>
							<cfif url.trancode eq "TR">
								<td>
								</td>
							</cfif>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
								<b>
									#numberformat(detailtotalgrand,",_.__")#
								</b>
							</td>
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<td>
								<b>
									#numberformat(detailforeigntotalgrand,",_.__")#
								</b>
							</td>
						</tr>
						<tr>
							<td>
							</td>
						</tr>
					</cfoutput>
					<tr>
						<td colspan="100%">
							<hr>
						</td>
					</tr>
				</table>
				<br>
				<br>
				<div align="right">
					<font size="1" face="Arial, Helvetica, sans-serif">
						<a href="javascript:print()" class="noprint">
							<u>
								Print
							</u>
						</a>
					</font>
				</div>
				<p class="noprint">
					<font size="2">
						Please print in Landscape format. Go to File - Page Setup, select "Landscape".
					</font>
				</p>
				</body>
			</html>
		<cfelse>
			<html>
				<head>
					<title>
						<cfoutput>
							#url.type# Listing Report
						</cfoutput>
					</title>
					<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
					<link href = "../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
					<style type="text/css" media="print">
						.noprint { display: none; }
					</style>
				</head>
				<body
				<cfif getpin2.h4G00 eq "T">
					onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"
				</cfif>
				>
				<table align="center" cellpadding="3" cellspacing="0" width="100%">
					<cfoutput>
						<tr>
							<td colspan="100%">
								<div align="center">
									<font size="3" face="Arial, Helvetica, sans-serif">
										<strong>
											#url.type# Listing Report
										</strong>
									</font>
								</div>
							</td>
						</tr>
						<cfif form.refNoFrom neq "" and form.refNoTo neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Ref No From #form.refNoFrom# To #form.refNoTo#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif ndatefrom neq "" and ndateto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#form.datefrom# - #form.dateto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.periodfrom neq "" and form.periodto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Period From #form.periodfrom# To #form.periodto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.agentfrom neq "" and form.agentto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#getgeneral.lAGENT# From #form.agentfrom# To #form.agentto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.locationfrom neq "" and form.locationto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Location From #form.locationfrom# To #form.locationto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.projectfrom neq "" and form.projectto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Project From #form.projectfrom# To #form.projectto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.jobfrom neq "" and form.jobto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Job From #form.Jobfrom# To #form.Jobto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.driverFrom neq "" and form.userTo neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#getgeneral.lDriver# From #form.driverFrom# To #form.userTo#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif form.Daddressfrom neq "" and form.Daddressto neq "">
							<tr>
								<td colspan="100%">
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											Delivery Address Code From #form.Daddressfrom# To #form.Daddressto#
										</font>
									</div>
								</td>
							</tr>
						</cfif>
						<cfif IsDefined('form.customerFrom') AND IsDefined('form.customerTo')>
							<cfif form.customerFrom NEQ '' and form.customerTo NEQ ''>
								<tr>
									<td colspan="100%">
										<div align="center">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												Customer From #form.customerFrom# To #form.customerTo#
											</font>
										</div>
									</td>
								</tr>
							</cfif>
						</cfif>
						<cfif IsDefined('form.customerFrom') eq IsDefined('form.customerTo')>
							<cfif form.customerFrom NEQ '' and form.customerTo NEQ ''>
								<cfif form.title eq "Customer">
									<cfquery name="getcustadd" datasource="#dts#">
                        select *
                        from #target_arcust#
                        where custno='#form.customerFrom#'
                    </cfquery>
								<cfelse>
									<cfquery name="getcustadd" datasource="#dts#">
                        select *
                        from #target_apvend#
                        where custno='#IsDefined("form.customerFrom")#'
                    </cfquery>
								</cfif>
								<tr>
									<td colspan="100%">
										<div align="center">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												Address : #getcustadd.add1# #getcustadd.add2# #getcustadd.add3# #getcustadd.add4#
											</font>
										</div>
									</td>
								</tr>
							</cfif>
						</cfif>
						<tr>
							<td colspan="80%">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									#getgeneral.compro#
								</font>
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
							<td colspan="20%">
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<cfif (lcase(hcomid) eq "baronad_i" or lcase(hcomid) eq "baronconnect_i") and  form.periodfrom neq "" and form.periodto neq "">
											<cfinclude template="/CFC/LastDayOfMonth.cfm">
											<cfset date2 = DateAdd('m', form.periodto, "#getgeneral.LastAccYear#")>
											<cfset date2a = LastDayOfMonth(month(date2),year(date2))>
											#dateformat(date2a,"dd/mm/yyyy")#
										<cfelse>
											#dateformat(now(),"dd/mm/yyyy")#
										</cfif>
									</font>
								</div>
							</td>
						</tr>
					</cfoutput>
					<tr>
						<td colspan="100%">
							<hr>
						</td>
					</tr>
					<tr>
						<cfif lcase(HcomID) eq "winbells_i">
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											No
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<td>
							<div align="left">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										Refno
									</strong>
								</font>
							</div>
						</td>
						<cfif isdefined('form.checkbox1')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Refno 2
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.checkbox2')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Status
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif lcase(HcomID) eq "mphcranes_i">
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Project No
										</strong>
									</font>
								</div>
							</td>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											<cfif url.trancode eq 'INV'>
												Service Report No.
											<cfelse>
												Refno 2
											</cfif>
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.checkbox3')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											PO/SO NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.checkbox4')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											DO NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.cbso')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											SO NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.cbproject')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Project NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.cbjob')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Job NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif isdefined('form.cbagent')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Agent NO
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<td>
							<div align="left">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										Date
									</strong>
								</font>
							</div>
						</td>
						<td>
							<div align="left">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										<cfif url.trancode eq "TR">
											Authorised by
										<cfelse>
											Cust No
										</cfif>
									</strong>
								</font>
							</div>
						</td>
						<td>
							<div align="left">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										<cfif url.trancode eq "TR">
											Reason for transfer
										<cfelse>
											Name
										</cfif>
									</strong>
								</font>
							</div>
						</td>
						<cfif lcase(hcomid) eq "elitez_i">
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Delivery Address
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif lcase(HcomID) eq "pengwang_i" or lcase(HcomID) eq "pingwang_i" or lcase(HcomID) eq "huanhong_i" or lcase(HcomID) eq "prawn_i" or lcase(HcomID) eq "hhsf_i">
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Salesman
										</strong>
									</font>
								</div>
							</td>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Driver
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif lcase(HcomID) eq "powernas_i">
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Policy No
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif url.trancode eq "TR">
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Transfer From
										</strong>
									</font>
								</div>
							</td>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Transfer To
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif lcase(HcomID) eq "simplysiti_i">
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Courier Type
										</strong>
									</font>
								</div>
							</td>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Courier Ref No
										</strong>
									</font>
								</div>
							</td>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Deliver Out Date
										</strong>
									</font>
								</div>
							</td>
							<cfif url.trancode eq "TR">
								<td>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												Cost
											</strong>
										</font>
									</div>
								</td>
							</cfif>
						</cfif>
						<cfif lcase(HcomID) neq "atc2005_i">
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Amount
										</strong>
									</font>
								</div>
							</td>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											<cfif lcase(HcomID) eq "taftc_i">
												Grant
											<cfelse>
												Discount
											</cfif>
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<td>
							<div align="right">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										NET
									</strong>
								</font>
							</div>
						</td>
						<cfif isdefined('form.cbgst')>
							<td>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											GST CODE
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif lcase(HcomID) neq "sdc_i">
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Tax
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<td>
							<div align="right">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										Grand Total
									</strong>
								</font>
							</div>
						</td>
						<cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "bestform_i">
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Currency Rate
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif lcase(HcomID) eq "bestform_i">
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Currency Code
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif url.trancode neq 'ISS'>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Grand Foreign
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<cfif lcase(HcomID) eq "atc2005_i">
							<td>
								<div align="center">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Delivery Date
										</strong>
									</font>
								</div>
							</td>
						</cfif>
						<td>
							<div align="center">
								<font size="1.5" face="Arial, Helvetica, sans-serif">
									<strong>
										<cfif url.trancode eq "CS" and lcase(Hcomid) eq "ovas_i">
											Agent
										<cfelse>
											Created By
										</cfif>
									</strong>
								</font>
							</div>
						</td>
						<cfif lcase(Hcomid) eq "topsteel_i" or lcase(Hcomid) eq "topsteelhol_i">
							<td>
								<div align="center">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Agent
										</strong>
									</font>
								</div>
							</td>
						</cfif>
					</tr>
					<tr>
						<td colspan="100%">
							<hr>
						</td>
					</tr>
					<cfset count=1>
					<cfoutput query="gettran">
						<cfif hcomid eq "taftc_i" and url.trancode eq "INV">
							<cfif gettran.cdispec neq 0>
								<cfset gettran.discount = val(gettran.cgrant) * val(gettran.cdispec)>
								<cfset gettran.invgross = val(gettran.invgross) + val(gettran.discount)>
							</cfif>
						</cfif>
						<cfif currrate neq "">
							<cfset xcurrrate = currrate>
						<cfelse>
							<cfset xcurrrate = 1>
						</cfif>
						<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
							<cfif lcase(HcomID) eq "winbells_i">
								<td>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												#count#
											</strong>
										</font>
									</div>
								</td>
							</cfif>
							<td nowrap>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<cfif url.trancode eq "rc" or url.trancode eq "DO" or url.trancode eq "INV" or url.trancode eq "CS" or url.trancode eq "QUO" or url.trancode eq "PO" or url.trancode eq "CN" or url.trancode eq "DN" or url.trancode eq "PR" or url.trancode eq "SAM">
											<a href="bill_listingreport2.cfm?type=#url.trancode#&refno=#gettran.refno#">
												#gettran.refno#
											</a>
										<cfelse>
											#gettran.refno#
										</cfif>
									</font>
								</div>
							</td>
							<cfif isdefined('form.checkbox1')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.refno2#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox2')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<cfif toinv neq ''>
												Y
											</cfif>
											<cfif posted eq 'P'>
												P
											</cfif>
											<cfif void neq ''>
												<font color="red">
													<strong>
														Void
													</strong>
												</font>
											</cfif>
										</font>
									</div>
								</td>
							</cfif>
							<cfif lcase(HcomID) eq "mphcranes_i">
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#source#
										</font>
									</div>
								</td>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<cfif url.trancode eq 'INV'>
												#rem6#
											<cfelse>
												#refno2#
											</cfif>
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox3')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.PONO#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.checkbox4')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.DONO#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbso')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.sONO#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbproject')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.source#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbjob')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.job#
										</font>
									</div>
								</td>
							</cfif>
							<cfif isdefined('form.cbagent')>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.agenno#
										</font>
									</div>
								</td>
							</cfif>
							<td nowrap>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#dateformat(wos_date,"dd-mm-yy")#
									</font>
								</div>
							</td>
							<td nowrap>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#custno#
									</font>
								</div>
							</td>
							<cfquery datasource="#dts#" name="getcust">
						Select name, currcode from #title1# where custno='#custno#'
					</cfquery>
							<td nowrap>
								<div align="left">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#name#
									</font>
								</div>
							</td>
							<cfif lcase(hcomid) eq "elitez_i">
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#gettran.comm0# #gettran.comm1# #gettran.comm2# #gettran.comm3# #gettran.rem14#
										</font>
									</div>
								</td>
							</cfif>
							<cfif lcase(HcomID) eq "pengwang_i" or lcase(HcomID) eq "pingwang_i" or lcase(HcomID) eq "huanhong_i" or lcase(HcomID) eq "prawn_i" or lcase(HcomID) eq "hhsf_i">
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#agenno#
										</font>
									</div>
								</td>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#van#
										</font>
									</div>
								</td>
							</cfif>
							<cfif lcase(HcomID) eq "powernas_i">
								<cfquery name='getpolicy' datasource='#dts#'>
		    select brem2 from ictran where refno='#gettran.refno#' and type='#gettran.type#'
		    </cfquery>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#getpolicy.brem2#
										</font>
									</div>
								</td>
							</cfif>
							<cfif url.trancode neq "TR">
								<cfset xamt = val(gettran.invgross)>
								<cfset xdisc = val(gettran.discount)>
								<cfif gettran.taxincl eq 'T'>
									<cfset xnet = val(gettran.net)-val(gettran.tax)>
								<cfelse>
									<cfset xnet = val(gettran.net)>
								</cfif>
								<cfset xtax = val(gettran.tax)>
								<cfset xgrand =numberformat(gettran.grand,'.__')>
								<cfset xcurrrate = val(gettran.currrate)>
							<cfelse>
								<cfset xamt = val(gettran.invgross) / 2>
								<cfset xdisc = val(gettran.discount) / 2>
								<cfset xnet = val(gettran.net) / 2>
								<cfset xtax = val(gettran.tax) / 2>
								<cfset xgrand = val(gettran.grand) / 2>
								<cfset xcurrrate = val(gettran.currrate)>
							</cfif>
							<cfif url.trancode eq "TR">
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#rem1#
										</font>
									</div>
								</td>
								<td nowrap>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#rem2#
										</font>
									</div>
								</td>
							</cfif>
							<cfif lcase(HcomID) eq "simplysiti_i">
								<td>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												#rem8#
											</strong>
										</font>
									</div>
								</td>
								<td>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												#rem9#
											</strong>
										</font>
									</div>
								</td>
								<td>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												#rem11#
											</strong>
										</font>
									</div>
								</td>
								<cfif url.trancode eq "TR">
									<cfquery name="getsimplysiticost" datasource="#dts#">
                select sum(ucost*qty) as ucost from(
                select (select ucost from icitem where itemno=a.itemno) as ucost,qty from ictran as a where refno='#refno#' and type='TRIN')as b
                </cfquery>
									<td>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#getsimplysiticost.ucost#
											</font>
										</div>
									</td>
								</cfif>
							</cfif>
							<cfif lcase(HcomID) neq "atc2005_i">
								<td nowrap>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#numberformat(xamt,",.__")#
										</font>
									</div>
								</td>
								<td nowrap>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#numberformat(xdisc,",.__")#
										</font>
									</div>
								</td>
							</cfif>
							<td nowrap>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#numberformat(xnet,",.__")#
									</font>
								</div>
							</td>
							<cfif isdefined('form.cbgst')>
								<cfif getgeneral.wpitemtax NEQ ''>
									<cfquery name="getIctranTaxCode" datasource="#dts#">
                            	SELECT DISTINCT note_a
                                FROM ictran
                                WHERE refno = '#gettran.refno#'
                                AND type = '#gettran.type#'
                                ORDER BY note_a
                            </cfquery>
									<cfset taxCodeList=valuelist(getIctranTaxCode.note_a)>
									<td nowrap>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#taxCodeList#
											</font>
										</div>
									</td>
								<cfelse>
									<td nowrap>
										<div align="left">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#gettran.note#
											</font>
										</div>
									</td>
								</cfif>
							</cfif>
							<cfif lcase(HcomID) neq "sdc_i">
								<td nowrap>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#numberformat(xtax,",.__")#
										</font>
									</div>
								</td>
							</cfif>
							<td nowrap>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										#numberformat(xgrand,",.__")#
									</font>
								</div>
							</td>
							<cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "bestform_i">
								<td nowrap>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#numberformat(xcurrrate,",.______")#
										</font>
									</div>
								</td>
							</cfif>
							<cfif lcase(HcomID) eq "bestform_i">
								<td nowrap>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#currcode#
										</font>
									</div>
								</td>
							</cfif>
							<cfif url.trancode neq 'ISS'>
								<cfif xcurrrate eq "1">
									<cfif lcase(HcomID) eq "powernas_i">
										<cfquery name="getictranqty4" datasource="#dts#">
                            select qty4 from ictran where refno='#gettran.refno#' and type='#gettran.type#'
                            </cfquery>
										<cfif getictranqty4.recordcount neq 0>
											<cfset xfcamt = val(gettran.grand_bil/getictranqty4.qty4)>
										<cfelse>
											<cfset xfcamt = val(gettran.grand_bil)>
										</cfif>
										<td>
											<div align="right">
												<font size="1.5" face="Arial, Helvetica, sans-serif">
													SGD #numberformat(xfcamt,stDecl_UPrice)#
												</font>
											</div>
										</td>
									<cfelse>
										<td>
											<div align="right">
												<font size="1.5" face="Arial, Helvetica, sans-serif">
													-
												</font>
											</div>
										</td>
									</cfif>
								<cfelse>
									<cfif gettran.grand_bil neq "">
										<cfif url.trancode neq "TR">
											<cfif lcase(HcomID) eq "powernas_i">
												<cfquery name="getictranqty4" datasource="#dts#">
                            select qty4 from ictran where refno='#gettran.refno#' and type='#gettran.type#'
                            </cfquery>
												<cfif getictranqty4.recordcount neq 0>
													<cfset xfcamt = val(gettran.grand_bil/getictranqty4.qty4)>
												<cfelse>
													<cfset xfcamt = val(gettran.grand_bil)>
												</cfif>
											<cfelse>
												<cfset xfcamt = val(gettran.grand_bil)>
											</cfif>
										<cfelse>
											<cfset xfcamt = val(gettran.grand_bil) / 2>
										</cfif>
									</cfif>
									<td nowrap>
										<div align="right">
											<font size="1.5" face="Arial, Helvetica, sans-serif">
												#getcust.currcode# #numberformat(xfcamt,stDecl_UPrice)#
											</font>
										</div>
									</td>
									<cfif xcurrrate eq "1" or xcurrrate eq "0">
									<cfelse>
										<cfset totalfcamt = totalfcamt + xfcamt>
									</cfif>
								</cfif>
							</cfif>
							<cfif lcase(HcomID) eq "atc2005_i">
								<td>
									<div align="center">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#rem5#
										</font>
									</div>
								</td>
							</cfif>
							<td>
								<div align="center">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<cfif url.trancode eq "CS" and lcase(Hcomid) eq "ovas_i">
											#agenno#
										<cfelse>
											#userid#
										</cfif>
									</font>
								</div>
							</td>
							<cfif lcase(Hcomid) eq "topsteel_i" or lcase(Hcomid) eq "topsteelhol_i">
								<td>
									<div align="left">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											#agenno#
										</font>
									</div>
								</td>
							</cfif>
						</tr>
						<cfset totalamt = totalamt + numberformat(xamt,".__")>
						<cfset totaldisc = totaldisc + numberformat(xdisc,".__")>
						<cfset totalnet = totalnet + numberformat(xnet,".__")>
						<cfif lcase(HcomID) neq "sdc_i">
							<cfset totaltax = totaltax + numberformat(xtax,".__")>
						</cfif>
						<cfset totalgrand = totalgrand + numberformat(xgrand,".__")>
						<cfset count=count+1>
					</cfoutput>
					<tr>
						<td colspan="100%">
							<hr>
						</td>
					</tr>
					<tr>
						<td>
						</td>
						<td>
						</td>
						<td>
						</td>
						<cfif isdefined('form.checkbox1')>
							<td>
							</td>
						</cfif>
						<cfif isdefined('form.checkbox2')>
							<td>
							</td>
						</cfif>
						<cfif isdefined('form.checkbox4')>
							<td>
							</td>
						</cfif>
						<cfif isdefined('form.checkbox3')>
							<td>
							</td>
						</cfif>
						<cfif isdefined('form.cbso')>
							<td>
							</td>
						</cfif>
						<cfif isdefined('form.cbproject')>
							<td>
							</td>
						</cfif>
						<cfif isdefined('form.cbjob')>
							<td>
							</td>
						</cfif>
						<cfif isdefined('form.cbagent')>
							<td>
							</td>
						</cfif>
						<cfif lcase(HcomID) eq "powernas_i">
							<td>
							</td>
						</cfif>
						<cfif url.trancode eq "TR">
							<td>
							</td>
							<td>
							</td>
						</cfif>
						<cfif lcase(HcomID) eq "simplysiti_i">
							<td>
							</td>
							<td>
							</td>
							<td>
							</td>
							<cfif url.trancode eq "TR">
								<td>
								</td>
							</cfif>
						</cfif>
						<cfif lcase(HcomID) eq "mphcranes_i">
							<td>
							</td>
							<td>
							</td>
						</cfif>
						<cfoutput>
							<cfif lcase(hcomid) eq "elitez_i">
								<td>
								</td>
							</cfif>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											Total:
										</strong>
									</font>
								</div>
							</td>
							<cfif lcase(HcomID) neq "atc2005_i">
								<td>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												#numberformat(totalamt,",.__")#
											</strong>
										</font>
									</div>
								</td>
								<td>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												#numberformat(totaldisc,",.__")#
											</strong>
										</font>
									</div>
								</td>
							</cfif>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											#numberformat(totalnet,",.__")#
										</strong>
									</font>
								</div>
							</td>
							<cfif isdefined('form.cbgst')>
								<td>
								</td>
							</cfif>
							<cfif lcase(HcomID) neq "sdc_i">
								<td>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												#numberformat(totaltax,",.__")#
											</strong>
										</font>
									</div>
								</td>
							</cfif>
							<td>
								<div align="right">
									<font size="1.5" face="Arial, Helvetica, sans-serif">
										<strong>
											#numberformat(totalgrand,",.__")#
										</strong>
									</font>
								</div>
							</td>
							<cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "bestform_i">
								<td>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif lcase(HcomID) eq "bestform_i">
								<td>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
										</font>
									</div>
								</td>
							</cfif>
							<cfif url.trancode neq 'ISS'>
								<td>
									<div align="right">
										<font size="1.5" face="Arial, Helvetica, sans-serif">
											<strong>
												<cfif totalfcamt neq 0>
													#numberformat(totalfcamt,",.__")#
												</cfif>
											</strong>
										</font>
									</div>
								</td>
							</cfif>
						</cfoutput>
						<td>
						</td>
						<cfif lcase(Hcomid) eq "topsteel_i" or lcase(Hcomid) eq "topsteelhol_i">
							<td>
							</td>
						</cfif>
					</tr>
				</table>
				<br>
				<br>
				<div align="right">
					<font size="1" face="Arial, Helvetica, sans-serif">
						<a href="javascript:print()" class="noprint">
							<u>
								Print
							</u>
						</a>
					</font>
				</div>
				<p class="noprint">
					<font size="2">
						Please print in Landscape format. Go to File - Page Setup, select "Landscape".
					</font>
				</p>
				</body>
			</html>
		</cfif>
	</cfcase>
</cfswitch>
