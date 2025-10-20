<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
</head>

<!---cfquery name="getgeneral" datasource="#dts#">
	select invoneset from gsetup
</cfquery--->
<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,poapproval,rqapproval,
	po_oneset,so_oneset, quo_oneset, assm_oneset, tr_oneset, oai_oneset, oar_oneset, sam_oneset,updatetopo,rem5,negstk
	from gsetup
</cfquery>

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>

<body>
<!--- t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV --->
<cfif url.t2 eq "INV">
	<h1>Update to <cfoutput>#gettranname.lINV#</cfoutput></h1>
	
	<cfset ptype = "Customer">
	
	<cfif url.t1 eq "DO">
		<cfset type = gettranname.lDO>
	<cfelseif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	<cfelseif url.t1 eq "QUO">
		<cfset type = "Quotation">
	<cfelseif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
		<cfset ptype = "Supplier">
	</cfif>
	
<!--- t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO --->
<cfelseif url.t2 eq "DO">
	<h1>Update to <cfoutput>#gettranname.lDO#</cfoutput></h1>

	<cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>
	<cfif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	</cfif>
    <cfif url.t1 eq "SAM">
		<cfset type = gettranname.lSAM>
	</cfif>

	<cfset ptype = "Customer">
<!--- t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC --->
<cfelseif url.t2 eq "RC">
	<h1>Update to <cfoutput>#gettranname.lRC#</cfoutput></h1>

	<cfif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
	</cfif>
    <cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>

	<cfset ptype = "Supplier">
<!--- t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ --->
<cfelseif url.t2 eq "RQ">
	<h1>Update to <cfoutput>#gettranname.lRQ#</cfoutput></h1>

    <cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>

	<cfset ptype = "Supplier">
<!--- t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO --->
<cfelseif url.t2 eq "PO">
	<h1>Update to <cfoutput>#gettranname.lPO#</cfoutput></h1>

	<cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>
	
	<cfif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	</cfif>
    
    <cfif url.t1 eq "RQ">
		<cfset type = gettranname.lRQ>
	</cfif>

	<cfset ptype = "Customer">
<!--- t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO --->
<cfelseif url.t2 eq "SO">
	<h1>Update to <cfoutput>#gettranname.lSO#</cfoutput></h1>

	<cfif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	</cfif>
    
    <cfif url.t1 eq "SAM">
		<cfset type = gettranname.lSAM>
	</cfif>

	<cfset ptype = "Customer">
<!--- t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS --->
<cfelseif url.t2 eq "CS">
	<h1>Update to <cfoutput>#gettranname.lCS#</cfoutput></h1>

	<cfif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	</cfif>
    
    <cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>

	<cfset ptype = "Customer">
<cfelseif url.t2 eq "QUO">
<h1>Update to <cfoutput>#gettranname.lQUO#</cfoutput></h1>

	<cfif url.t1 eq "SAMM">
		<cfset type = "Sales Order">
	</cfif>

	<cfset ptype = "Customer">
</cfif>

<cfif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">
<cfoutput>
	<cfform action="" method="post">
	<table align="center" class="data" width="70%">
    <tr>
    <th>Delivery Date</th><td><cfinput type="text" id="deliverdate" name="deliverdate" value="#dateformat(now(),'dd/mm/yyyy')#"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(deliverdate);"></td>
    </tr>
    <tr>
    
    <td colspan="2"><div align="center"><input type="button" id="subbtn" name="subbtn" value="Submit" onClick="window.location.href='updateA.cfm?rem5='+document.getElementById('deliverdate').value+'&custno=&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#'" ></div></td>
    </tr>
    
    </table>
	</cfform>
</cfoutput>
<cfelse>

<cfoutput>
	<form action="update.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#" method="post">
		<h1>Search By :
		<select name="searchType">
        	<option value="all">All</option>
			<option value="custno">#ptype# No</option>
			<option value="name">#ptype# Name</option>
            <option value="source" <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">selected</cfif>>Project</option>
			<option value="rem5">#getgeneral.rem5#</option>
			<!--- <option value="wos_date">Invoice Date</option> --->
		</select>
		Search for
		<input type="text" name="searchStr" value="">
        <input type="submit" id="submit" name="submit" value="Search">
		</h1>
        
	</form>
</cfoutput>

<cfif  t1 eq 'QUO'and t2 eq 'INV'>
	<cfif getgeneral.negstk NEQ '1'>
        <table border="5">
        <tr>
        <td>
        <b><font size="+1" color="#FF0000">Negative stock is not allow!<br>Please update to SO instead for proper stock control.</font></b>
        </td>
        </tr>
        </table>
    </cfif>
</cfif>

<br>
This page will show all customer with outstanding bills<br><hr>
<!--- t2 = "PO" and t1 = "SO" t2 = "PO" and t1 = "SO" t2 = "PO" and t1 = "SO" t2 = "PO" and t1 = "SO" t2 = "PO" and t1 = "SO" --->
<cfif url.t2 eq "PO" and url.t1 eq "SO">
	<cfquery datasource="#dts#" name="getupdate">
		Select count(refno) as cnt, lower(custno) as custno, lower(name) as name, userid,refno,source,lower(rem5) as rem5,permitno from artran where type = '#t1#'
		and exported = '' and (void = '' or void is null) <cfif getgeneral.updatetopo neq 'Y'>and order_cl = ""</cfif><cfif (hcomid eq "asiasoft_i" or hcomid eq "asaiki_i") and url.t1 eq "SO"> and printstatus = "a3"</cfif> group by custno order by custno
	</cfquery>
<!--- t2 = "RC" and t1 = "SO" t2 = "RC" and t1 = "SO" t2 = "RC" and t1 = "SO" t2 = "RC" and t1 = "SO" t2 = "RC" and t1 = "SO" --->    
<cfelseif url.t2 eq "RC" and url.t1 eq "SO">
	<cfquery datasource="#dts#" name="getupdate">
		Select count(refno) as cnt, lower(custno) as custno, lower(name) as name, userid,refno,source,lower(rem5) as rem5,permitno from artran where type = '#t1#'
		and exported = '' and (void = '' or void is null) <cfif getgeneral.updatetopo neq 'Y'>and order_cl = ""</cfif><cfif hcomid eq "asiasoft_i" and url.t1 eq "SO"> and printstatus = "a3"</cfif> group by custno order by custno
	</cfquery>
<cfelseif url.t2 eq "RC" and url.t1 eq "PO">
	<cfquery datasource="#dts#" name="getupdate">
		Select count(a.refno) as cnt, lower(custno) as custno,lower(b.rem5) as rem5,lower(name) as name,b.permitno as permitno, userid,a.refno,source from ictran AS a left join (select rem5,permitno,printstatus,refno,type from artran where type='#t1#')as b on a.refno=b.refno and a.type=b.type where a.type = '#t1#'
		and a.toinv = '' and (a.void = '' or a.void is null) <cfif lcase(hcomid) eq "hunting_i" and t1 eq "Sam">and printstatus = "a3"</cfif><cfif getgeneral.poapproval eq 'Y'>and printstatus = "a3"</cfif> group by a.custno order by a.custno
	</cfquery>
<!--- t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO --->
<cfelseif t1 eq "DO">
	<cfquery datasource="#dts#" name="getupdate">
		select count(refno) as cnt,lower(custno) as custno,lower(rem5) as rem5,lower(name) as name,permitno as permitno, userid,refno,source FROM(
        Select lower(custno) as custno,lower(b.rem5) as rem5,lower(name) as name,b.permitno as permitno, b.userid,a.refno,source from ictran AS a left join (select userid,rem5,permitno,printstatus,refno,type from artran where type='#t1#')as b on a.refno=b.refno and a.type=b.type where a.type = '#t1#'
		and a.toinv = '' and (a.void = '' or a.void is null) group by a.refno
        ) as aa
        group by aa.custno order by aa.custno
	</cfquery>
<!--- t1=PO to t2=INV ---->	
<cfelseif url.t2 eq "INV" and url.t1 eq "PO">
	<cfquery datasource="#dts#" name="getupdate">
		Select count(refno) as cnt, lower(custno) as custno, lower(name) as name, userid,refno,source,lower(rem5) as rem5,permitno from artran where type = '#t1#'
		and exported = '' and order_cl = '' and (void = '' or void is null) group by custno order by custno
	</cfquery>
<!--- t1=INV,DO,SO,CS to t2=QUO ---->	
<cfelseif (url.t2 eq "INV" or url.t2 eq "DO" or url.t2 eq "SO" or url.t2 eq "CS") and url.t1 eq "QUO">
	<cfquery datasource="#dts#" name="getupdate">
		Select count(refno) as cnt,lower(rem5) as rem5, lower(custno) as custno, lower(name) as name, userid,refno,source,permitno from artran where type = '#t1#'
		and toinv = ''  and (void = '' or void is null) and order_cl='' group by custno order by custno
	</cfquery>
<cfelseif url.t2 eq "PO" and url.t1 eq "QUO">
    <cfquery datasource="#dts#" name="getupdate">
		Select count(refno) as cnt, lower(custno) as custno,lower(rem5) as rem5, lower(name) as name, userid,refno,source,permitno from artran where type = '#t1#'
		<cfif getgeneral.updatetopo neq 'Y'>and order_cl = ""</cfif> and exported = '' and (void = '' or void is null) group by custno order by custno
	</cfquery>
<cfelseif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">
    <cfquery datasource="#dts#" name="getupdate">
		Select count(refno) as cnt, lower(custno) as custno,lower(rem5) as rem5, lower(name) as name, userid,refno,source,permitno from artran where type = '#t1#'
		and order_cl = '' and (void = '' or void is null) group by rem5 order by rem5
	</cfquery>

<cfelse>

<cfif left(dts,6) eq "asaiki">
<cfquery name="getoutlist" datasource="#dts#">
Select refno from ictran
			where type='#t1#' and (shipped+writeoff) < qty  and (void = '' or void is null)  and refno <> "" and refno is not null
			group by refno
</cfquery>
</cfif>

	<cfquery datasource="#dts#" name="getupdate">
		Select count(refno) as cnt, lower(custno) as custno,lower(rem5) as rem5, lower(name) as name, userid,refno,source,permitno from artran where type = '#t1#'
		<cfif left(dts,6) eq "asaiki"> and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getoutlist.refno)#" list="yes" separator=",">)<cfelse>and order_cl = ''</cfif> and (void = '' or void is null) <cfif lcase(hcomid) eq "hunting_i" and t1 eq "Sam">and printstatus = "a3"</cfif><cfif lcase(hcomid) eq "ltm_i"> and (rem45='' or rem45 is null or rem45='A')</cfif> <cfif getgeneral.rqapproval eq 'Y' and url.t1 eq "RQ">and printstatus = "a3"</cfif> group by custno order by custno
	</cfquery>
</cfif>

<cfif isdefined("form.searchStr")>
	<cfquery dbtype="query" name="exactResult">
		SELECT * 
        FROM getupdate 
        WHERE 
			 <cfif searchType eq 'all'>
                custno='#LCASE(form.searchStr)#' 
                OR name='#LCASE(form.searchStr)#' 
                OR permitno='#LCASE(form.searchStr)#' 
                OR refno='#LCASE(form.searchStr)#' 
                OR rem5='#LCASE(form.searchStr)#' 
                ORDER BY custno
            <cfelse>
                #form.searchType# = '#LCASE(form.searchStr)#' 
                ORDER BY #form.searchType#
            </cfif>
	</cfquery>

	<cfquery dbtype="query" name="similarResult">
		SELECT * 
        FROM getupdate 
        WHERE <cfif searchType eq 'all'>custno LIKE '%#LCASE(form.searchStr)#%' or name LIKE '%#LCASE(form.searchStr)#%' or permitno LIKE '%#LCASE(form.searchStr)#%' or rem5 LIKE '%#LCASE(form.searchStr)#%' or refno LIKE '%#LCASE(form.searchStr)#%' order by custno<cfelse>#form.searchType# LIKE '%#LCASE(form.searchStr)#%' order by #form.searchType#</cfif>
	</cfquery>

	<h2>Exact Result</h2>

	<cfif exactResult.recordCount neq 0>
		<table align="center" class="data" width="70%">
			<tr>
				<td colspan="6"><div align="center"><strong><cfoutput>#type#</cfoutput></strong></div></td>
			</tr>
			<tr>
				<th>No.s of Items</th>
				<th><cfif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">Delivery Date<cfelse><cfoutput>#ptype# Name</cfoutput></cfif></th>
                <cfif getmodule.auto eq "1">
                <th>Car No</th>
                </cfif>
				<th>Curr.Code</th>
				<th>User</th>
				<th>Action</th>
			</tr>

			<cfoutput query="exactresult">
				<cfif t1 eq "PO">
					<cfquery name="getcust" datasource="#dts#">
						select name,currcode from #target_apvend# where custno = '#custno#'
					</cfquery>
				<cfelse>
					<cfquery name="getcust" datasource="#dts#">
						select name,currcode from #target_arcust# where custno = '#custno#'
					</cfquery>
                    <cfif hcomid eq "asiasoft_i" and getcust.recordcount eq 0>	
            <cfquery name="getcust" datasource="#dts#">
            SELECT leadname as name, "" as currcode,accountno FROM asiasoft_c.lead WHERE id = '#custno#'
            </cfquery>
            
            <cfif getcust.accountno neq "">
            <cfquery name="getcust" datasource="#dts#">
				select name,currcode from #target_arcust# where custno = '#getcust.accountno#'
			</cfquery>
            </cfif>
            
			</cfif>
				</cfif>

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td>#exactresult.cnt#</td>
					<td nowrap><cfif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">#exactresult.rem5#<cfelse>#ucase(exactresult.custno)# - #getcust.name#</cfif></td>
                    <cfif getmodule.auto eq "1">
                    <td>#exactresult.rem5#</td>
                    </cfif>
					<td>#getcust.currcode#</td>
					<td>#exactresult.userid#</td>

					<!--- <cfif t2 eq 'INV' and getgeneral.invoneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelse>
						<td><a href="updateA.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					</cfif> --->
                    <cfif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">
                    <td><a href="updateA.cfm?rem5=#rem5#&custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
                    <cfelse>
					<cfif t2 eq 'INV' and getgeneral.invoneset neq '1'>
			  			<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'RC' and getgeneral.rc_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'PR' and getgeneral.pr_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'DO' and getgeneral.do_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'CS' and getgeneral.cs_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'CN' and getgeneral.cn_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'DN' and getgeneral.dn_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'ISS' and getgeneral.iss_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'PO' and getgeneral.po_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'SO' and getgeneral.so_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'QUO' and getgeneral.quo_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'ASSM' and getgeneral.assm_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'TR' and getgeneral.tr_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'OAI' and getgeneral.oai_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'OAR' and getgeneral.oar_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
					<cfelseif t2 eq 'SAM' and getgeneral.sam_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
			  		<cfelse>
			  			<td><a href="updateA.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
			  		</cfif>
                    </cfif>
				</tr>
			</cfoutput>
		</table>
		<hr>
	<cfelse>
    <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
    <cfelse>
		<h3>No Exact Records were found.</h3>
    </cfif>
	</cfif>

	<h2>Similar Result</h2>

	<cfif similarResult.recordCount neq 0>
		<table align="center" class="data" width="70%">
			<tr>
  			  	<td colspan="6"><div align="center"><strong><cfoutput>#type#</cfoutput></strong></div></td>
 			</tr>
 			<tr>
 			   	<th>No.s of Items</th>
				<th><cfif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">Delivery Date<cfelse><cfoutput>#ptype# Name</cfoutput></cfif></th>
                <cfif getmodule.auto eq "1">
                <th>Car No</th>
                </cfif>
			   	<th>Curr.Code</th>
 			   	<th>User</th>
 			   	<th>Action</th>
			</tr>

			<cfoutput query="similarResult">
  				<cfif t1 eq "PO">
					<cfquery name="getcust" datasource="#dts#">
						select name,currcode from #target_apvend# where custno = '#custno#'
					</cfquery>
				<cfelse>
					<cfquery name="getcust" datasource="#dts#">
						select name,currcode from #target_arcust# where custno = '#custno#'
					</cfquery>
                    <cfif hcomid eq "asiasoft_i" and getcust.recordcount eq 0>	
            <cfquery name="getcust" datasource="#dts#">
            SELECT leadname as name, "" as currcode,accountno FROM asiasoft_c.lead WHERE id = '#custno#'
            </cfquery>
            
            <cfif getcust.accountno neq "">
            <cfquery name="getcust" datasource="#dts#">
				select name,currcode from #target_arcust# where custno = '#getcust.accountno#'
			</cfquery>
            </cfif>
            
			</cfif>
				</cfif>

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    			  	<td>#similarResult.cnt#</td>
    			  	<td nowrap><cfif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">#similarResult.rem5#<cfelse>#ucase(similarResult.custno)# - #getcust.name#</cfif></td>
                    <cfif getmodule.auto eq "1">
                    <td>#similarResult.rem5#</td>
                    </cfif>
				  	<td>#getcust.currcode#</td>
    			  	<td>#similarResult.userid#</td>

					<!--- <cfif t2 eq 'INV' and getgeneral.invoneset neq '1'>
				  		<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
				  	<cfelse>
				  		<td><a href="updateA.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
				  	</cfif> --->
                    <cfif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">
                    <td><a href="updateA.cfm?rem5=#rem5#&custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
                    <cfelse>
				  	<cfif t2 eq 'INV' and getgeneral.invoneset neq '1'>
			  			<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'RC' and getgeneral.rc_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'PR' and getgeneral.pr_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'DO' and getgeneral.do_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'CS' and getgeneral.cs_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'CN' and getgeneral.cn_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'DN' and getgeneral.dn_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'ISS' and getgeneral.iss_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'PO' and getgeneral.po_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'SO' and getgeneral.so_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'QUO' and getgeneral.quo_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'ASSM' and getgeneral.assm_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'TR' and getgeneral.tr_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'OAI' and getgeneral.oai_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'OAR' and getgeneral.oar_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
					<cfelseif t2 eq 'SAM' and getgeneral.sam_oneset neq '1'>
						<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
			  		<cfelse>
			  			<td><a href="updateA.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
			  		</cfif>
                    </cfif>
				</tr>
			</cfoutput>
		</table>
		<hr>
	<cfelse>
    <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
    <cfelse>
		<h3>No Similar Records were found.</h3>
    </cfif>
	</cfif>
</cfif>

<table align="center" class="data" width="70%">
	<tr>
    	<td colspan="6"><div align="center"><strong><cfoutput>#type#</cfoutput></strong></div></td>
  	</tr>
  	<tr>
    	<th>No.s of Items</th>
		<th><cfif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">Delivery Date<cfelse><cfoutput>#ptype# Name</cfoutput></cfif></th>
        <cfif getmodule.auto eq "1">
        <th>Car No</th>
        </cfif>
		<th>Curr.Code</th>
    	<th>User</th>
    	<th>Action</th>
  	</tr>

	<cfoutput query="getupdate" startrow="1">
  		<cfif t1 eq "PO">
			<cfquery name="getcust" datasource="#dts#">
				select name,currcode from #target_apvend# where custno = '#custno#'
			</cfquery>
		<cfelse>
			<cfquery name="getcust" datasource="#dts#">
				select name,currcode from #target_arcust# where custno = '#custno#'
			</cfquery>
            <cfif hcomid eq "asiasoft_i" and getcust.recordcount eq 0>	
            <cfquery name="getcust" datasource="#dts#">
            SELECT leadname as name, "" as currcode,accountno FROM asiasoft_c.lead WHERE id = '#custno#'
            </cfquery>
            
            <cfif getcust.accountno neq "">
            <cfquery name="getcust" datasource="#dts#">
				select name,currcode from #target_arcust# where custno = '#getcust.accountno#'
			</cfquery>
            </cfif>
            
			</cfif>
		</cfif>

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      		<td>#getupdate.cnt#</td>
      		<td nowrap><cfif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">#getupdate.rem5#<cfelse>#ucase(getupdate.custno)# - #getcust.name#</cfif></td>
            <cfif getmodule.auto eq "1">
            <td nowrap>#getupdate.rem5#</td>
            </cfif>
	  		<td>#getcust.currcode#</td>
      		<td>#getupdate.userid#</td>
			
            <cfif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">
                    <td><a href="updateA.cfm?rem5=#rem5#&custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
						&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
                    <cfelse>
			<cfif t2 eq 'INV' and getgeneral.invoneset neq '1'>
	  			<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'RC' and getgeneral.rc_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'PR' and getgeneral.pr_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'DO' and getgeneral.do_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'CS' and getgeneral.cs_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'CN' and getgeneral.cn_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'DN' and getgeneral.dn_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'ISS' and getgeneral.iss_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'PO' and getgeneral.po_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'SO' and getgeneral.so_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'QUO' and getgeneral.quo_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'ASSM' and getgeneral.assm_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'TR' and getgeneral.tr_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'OAI' and getgeneral.oai_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'OAR' and getgeneral.oar_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
			<cfelseif t2 eq 'SAM' and getgeneral.sam_oneset neq '1'>
				<td><a href="update1.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
	  		<cfelse>
	  			<td><a href="updateA.cfm?custno=#URLEncodedFormat(custno)#&t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#
				&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
	  		</cfif>
            </cfif>
		</tr>
	</cfoutput>
</table>
</cfif>

</body>
</html>